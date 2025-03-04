import 'dart:io';

import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:desa_gempol/provider/forum/forum_provider.dart';

class CreateAduanScreen extends StatefulWidget {
  const CreateAduanScreen({super.key});

  @override
  State<CreateAduanScreen> createState() => _CreateAduanScreenState();
}

class _CreateAduanScreenState extends State<CreateAduanScreen> {
  final TextEditingController _deskripsiController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitAduan() async {
    if (_deskripsiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deskripsi wajib diisi!')),
      );
      return;
    }

    final description = _deskripsiController.text.trim();

    try {
      // Kirim deskripsi dan gambar (jika ada)
      await Provider.of<ForumProvider>(context, listen: false).addForum(
        description: description,
        imageFile: _selectedImage, // Tetap kirim gambar jika tersedia
      );

      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aduan berhasil dikirim!')),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      // Tangani error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim aduan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'Sampaikan Laporan Anda',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: Consumer<ForumProvider>(
        builder: (context, forumProvider, _) {
          // Pantau state dari addForum
          if (forumProvider.addForumState.status == StateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TextArea dengan tombol upload gambar
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      TextField(
                        controller: _deskripsiController,
                        maxLines: 8,
                        decoration: InputDecoration(
                          hintText: 'Tulis laporan Anda...',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_photo_alternate_sharp,
                            color: Config.cardColor),
                        onPressed: _pickImage,
                        tooltip: 'Tambahkan gambar',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Preview Gambar (jika ada)
                  if (_selectedImage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _selectedImage!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(Icons.cancel, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _selectedImage = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Tombol Kirim
                  ElevatedButton(
                    onPressed: () async {
                      await _submitAduan();

                      // Tampilkan pesan sukses/error berdasarkan state
                      if (forumProvider.addForumState.status ==
                          StateStatus.succes) {
                        // Tampilkan pesan sukses
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Aduan berhasil dikirim!')),
                        );

                        // Kembali ke halaman sebelumnya
                        Navigator.of(context).pushNamed(CustomRoute.forumWarga);
                      } else if (forumProvider.addForumState.status ==
                          StateStatus.error) {
                        // Tampilkan pesan error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              forumProvider.addForumState.errMessage ??
                                  'Terjadi kesalahan.',
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Config.cardColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Kirim',
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
