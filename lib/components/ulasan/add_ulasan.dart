import 'dart:io';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/provider/ulasan/ulasan.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddUlasanScreen extends StatefulWidget {
  const AddUlasanScreen({super.key});

  @override
  _AddUlasanScreenState createState() => _AddUlasanScreenState();
}

class _AddUlasanScreenState extends State<AddUlasanScreen> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0;
  File? _selectedImage;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitUlasan() async {
    if (_commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Komentar wajib diisi!')),
      );
      return;
    }

    final comment = _commentController.text.trim();
    final ulasanProvider = Provider.of<UlasanProvider>(context, listen: false);

    try {
      await ulasanProvider.addUlasan(
        rating: _rating,
        comment: comment,
        imageFile: _selectedImage,
        context: context, // **Tambahkan context agar user_id bisa diambil**
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ulasan berhasil dikirim!')),
      );

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim ulasan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          "Tambah Ulasan",
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: Consumer<UlasanProvider>(
        builder: (context, ulasanProvider, _) {
          if (ulasanProvider.addUlasanState!.status == StateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      TextField(
                        controller: _commentController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Tulis ulasan Anda...',
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
                  Center(
                    child: RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding:
                      const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _submitUlasan();
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
