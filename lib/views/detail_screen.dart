import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_3/views/edit_screen.dart';
import 'package:flutter_3/views/form_screen.dart';
import "package:flutter/material.dart";

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail-screen';
  DetailScreen({Key? key}) : super(key: key);

  final CollectionReference _wisata =
      FirebaseFirestore.instance.collection('wisata');
  // Deleteing a wisata by id

  @override
  Widget build(BuildContext context) {
    final place =
        ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;

    Future<void> _deleteProduct(String productId) async {
      await _wisata.doc(productId).delete();

      Navigator.of(context).pop();
      // Show a snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Berhasil delete data!')));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(place['name']),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditScreen.routeName,
                    arguments: place);
              },
              icon: Icon(Icons.edit),
              tooltip: "Edit Data",
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _deleteProduct(place.id);
          },
          child: Icon(Icons.delete),
          tooltip: "Delete Data",
        ),
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Image.network(place['image']),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                place['name'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        const Icon(Icons.access_time),
                        SizedBox(
                          height: 5,
                        ),
                        Text(place['time']),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        const Icon(Icons.attach_money),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Rp." + place['entrance'].toString() + ("0")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              child: Text(
                place['desc'],
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ]),
        ));
  }
}
