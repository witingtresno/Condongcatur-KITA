import 'package:desa_gempol/model/potensi_desa/get_hamlet.dart';
import 'package:desa_gempol/provider/data_state.dart';
import 'package:desa_gempol/provider/potensi_desa/potensi_desa.dart';
import 'package:desa_gempol/utils/config.dart';
import 'package:desa_gempol/utils/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PotensiDesaScreen extends StatefulWidget {
  const PotensiDesaScreen({super.key});

  @override
  State<PotensiDesaScreen> createState() => _PotensiDesaScreenState();
}

class _PotensiDesaScreenState extends State<PotensiDesaScreen> {
  PotensiDesa? potensi;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      potensi = Provider.of(context, listen: false);
      await potensi!.getPotensi();
    });
  }

  Future<void>_refreshData()async{
    final potensiProvider = Provider.of<PotensiDesa>(context, listen: false);
    await Future.wait([
      potensiProvider.getPotensi(),
    ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'POTENSI DESA',
          style: GoogleFonts.roboto(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Consumer<PotensiDesa>(builder: (context, potensi, _) {
          return dataStateHandler<GetHamlet>(
            status: potensi.statePotensi!,
            onSucces: (value) {
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: value?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = value!.data![index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.image!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                      title: Text(
                        item.name!,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            CustomRoute.detaiPotensiDesa,
                            arguments: {'idHamlet': item.id.toString()},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Config.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'VIEW',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            onFailed: (err) {
              return Center(
                child: Text(
                  err.toString(),
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
