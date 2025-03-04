import 'dart:io';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/provider/forum/forum_provider.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditForum extends StatefulWidget {
  const EditForum({super.key});

  @override
  State<EditForum> createState() => _EditForumState();
}

class _EditForumState extends State<EditForum> {
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;

  Map<String, dynamic>? forum; // Data forum

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ambil data forum dari arguments Navigator
    forum = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (forum != null) {
      _descriptionController.text = forum!['description'] ?? '';
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateForum(BuildContext context) async {
    if (forum == null) return;

    final forumProvider = Provider.of<ForumProvider>(context, listen: false);

    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deskripsi tidak boleh kosong!')),
      );
      return;
    }

    try {
      // Panggil provider untuk mengupdate forum
      await forumProvider.updateForum(
        id: forum!['id'].toString(),
        description: _descriptionController.text,
        imageFile: _selectedImage, // Kirim gambar baru jika ada
      );

      if (forumProvider.updateForumState.status == StateStatus.succes) {
        Navigator.pop(context, true); // Kembali dan beri tanda berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Forum berhasil diperbarui!')),
        );
      } else {
        throw forumProvider.updateForumState.errMessage ?? 'Terjadi kesalahan.';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui forum: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Edit Forum',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: forum == null
              ? const Center(child: CircularProgressIndicator())
              : Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Deskripsi',
                            labelStyle: const TextStyle(color: Config.cardColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Config.cardColor, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (forum!['image'] != null &&
                            forum!['image'].isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Gambar saat ini:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Config.cardColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  forum!['image'],
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        if (_selectedImage != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Gambar baru:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Config.cardColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _selectedImage!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.image),
                            label: const Text('Pilih Gambar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Config.cardColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Consumer<ForumProvider>(
                          builder: (context, forumProvider, _) {
                            final isLoading =
                                forumProvider.updateForumState.status ==
                                    StateStatus.loading;

                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () => _updateForum(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Config.cardColor,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'Simpan Perubahan',
                                        style: TextStyle(fontSize: 16),
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
