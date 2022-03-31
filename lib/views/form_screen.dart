import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  static const routeName = '/form';

  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Wisata"),
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
                  child: Text("Tambah Wisata"),
                  onPressed: () async {
                    final String? nama = _namaController.text;
                    final String? image = _imageController.text;
                    final String? deskripsi = _deskripsiController.text;
                    final String? jam = _jamController.text;
                    final String? lokasi = _lokasiController.text;
                    final double? harga = double.parse(_hargaController.text);

                    await _wisata.add({
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

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil create data!')));
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
