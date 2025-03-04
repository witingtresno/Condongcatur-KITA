import 'package:desa_gempol/model/forum/get_all_forum.dart';
import 'package:desa_gempol/provider/auth/auth_provider.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:desa_gempol/provider/forum/forum_provider.dart';
import 'package:photo_view/photo_view.dart';

class ForumDesaScreen extends StatefulWidget {
  const ForumDesaScreen({super.key});

  @override
  _ForumDesaScreenState createState() => _ForumDesaScreenState();
}

class _ForumDesaScreenState extends State<ForumDesaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final forumProvider =
            Provider.of<ForumProvider>(context, listen: false);
        forumProvider.fetchForums();
      }
    });
  }

  Future<void> _refreshData() async {
    final forumProvider = Provider.of<ForumProvider>(context, listen: false);
    await forumProvider.fetchForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Forum Aduan Warga',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer<ForumProvider>(
          builder: (context, forumProvider, _) {
            return dataStateHandler<GetAllForum>(
              status: forumProvider.fetchForumsState!,
              onSucces: (value) {
                if (value == null || value.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.info,
                            size: 50, color: Colors.blueGrey),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada Forum',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: forumProvider.fetchForumsState!.data!.data!.length,
                  itemBuilder: (context, index) {
                    final forum =
                        forumProvider.fetchForumsState!.data!.data![index];
                    return _buildForumCard(context, forum);
                  },
                );
              },
              onFailed: (err) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 50, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Gagal memuat data: $err',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Consumer2<AuthProvider, ForumProvider>(
        builder: (context, authProvider, forumProvider, _) {
          return FloatingActionButton(
            onPressed: () async {
              if (!authProvider.isLoggedIn) {
                final result = await Navigator.pushNamed(
                  context,
                  CustomRoute.loginScreen,
                );
                if (result != true) return; // Jika login dibatalkan
              }
              final result =
                  await Navigator.pushNamed(context, CustomRoute.createAjuan);
              if (result == true) {
                forumProvider.fetchForums(); // Refresh data setelah posting
              }
            },
            backgroundColor: Config.cardColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildForumCard(BuildContext context, dynamic forum) {
    DateTime? timestamp = forum.updatedAt != null
        ? DateTime.parse(forum.updatedAt!).toLocal()
        : (forum.createdAt != null
            ? DateTime.parse(forum.createdAt!).toLocal()
            : null);

    String formattedTimestamp = timestamp != null
        ? '${timestamp.day.toString().padLeft(2, '0')} ${_getMonthName(timestamp.month)} ${timestamp.year}, '
            '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')} WIB'
        : 'Waktu tidak tersedia';

    return Consumer2<AuthProvider, ForumProvider>(
      builder: (context, auth, forumProvider, _) {
        final isOwner = forum.user?.id == auth.userNow?.idUser;

        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      forum.user?.name ?? 'Anonim',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (isOwner)
                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'edit') {
                            final forumMap = {
                              'id': forum.id,
                              'description': forum.description,
                              'image': forum.image,
                            };

                            Navigator.pushNamed(
                              context,
                              CustomRoute.editForum,
                              arguments: forumMap,
                            ).then((value) {
                              if (value == true) {
                                forumProvider
                                    .fetchForums(); // Refresh data setelah edit
                              }
                            });
                          } else if (value == 'delete') {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Konfirmasi Hapus'),
                                content: const Text(
                                  'Apakah Anda yakin ingin menghapus aduan ini?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await forumProvider
                                  .deleteForum(forum.id.toString());
                              forumProvider.fetchForums();
                              Navigator.pop(context, true);
                            }
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Hapus'),
                            ),
                          ];
                        },
                        icon: const Icon(Icons.more_vert),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  forum.description ?? 'Tidak ada deskripsi.',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                if (forum.image != null && forum.image!.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Colors.black,
                              iconTheme:
                                  const IconThemeData(color: Colors.white),
                            ),
                            backgroundColor: Colors.black,
                            body: Center(
                              child: PhotoView(
                                imageProvider: NetworkImage(forum.image!),
                                backgroundDecoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        forum.image!,
                        width: 400,
                        height: 200,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text(
                            'Gagal memuat gambar.',
                            style: TextStyle(color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                Text(
                  formattedTimestamp,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
