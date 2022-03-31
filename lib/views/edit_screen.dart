import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_3/views/main_screen.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/form-edit';

  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _jamController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  final CollectionReference _wisata =
      FirebaseFirestore.instance.collection('wisata');

  @override
  Widget build(BuildContext context) {
    final place =
        ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;

    if (place != null) {
      _namaController.text = place["name"];
      _hargaController.text = place["entrance"].toString();
      _deskripsiController.text = place["desc"];
      _jamController.text = place["time"];
      _lokasiController.text = place["location"];
      _imageController.text = place["image"];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Update Wisata"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _namaController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Deskripsi Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _deskripsiController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lokasi Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _lokasiController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jam Operasional Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _jamController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Harga Tiket Masuk Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _hargaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Image Wisata (URL)"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _imageController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Update Wisata"),
                  onPressed: () async {
                    final String? nama = _namaController.text;
                    final String? image = _imageController.text;
                    final String? deskripsi = _deskripsiController.text;
                    final String? jam = _jamController.text;
                    final String? lokasi = _lokasiController.text;
                    final double? harga = double.parse(_hargaController.text);

                    await _wisata.doc(place.id).update({
                      "name": nama,
                      "image": image,
                      "desc": deskripsi,
                      "time": jam,
                      "location": lokasi,
                      "entrance": harga
                    });

                    _namaController.text = "";
                    _imageController.text = "";
                    _deskripsiController.text = "";
                    _jamController.text = "";
                    _lokasiController.text = "";
                    _hargaController.text = "";

                    Navigator.pushReplacementNamed(
                        context, MainScreen.routeName);

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil update data!')));
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(12),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
