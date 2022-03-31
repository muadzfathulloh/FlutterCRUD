import 'package:flutter_3/views/detail_screen.dart';
import 'package:flutter_3/views/form_screen.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/';

  MainScreen({Key? key}) : super(key: key);

  final CollectionReference _wisata =
      FirebaseFirestore.instance.collection('wisata');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wisata Indonesia")),
      body: StreamBuilder(
        stream: _wisata.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final DocumentSnapshot place = streamSnapshot.data!.docs[index];
                return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, DetailScreen.routeName,
                          arguments: place);
                    },
                    child: listItem(place));
              },
              itemCount: streamSnapshot.data!.docs.length,
            );
          } else {
            return const Text("Data Gagal Diambil");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, FormScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget listItem(DocumentSnapshot place) {
    return Card(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(flex: 1, child: Image.network(place['image'])),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    place['name'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(place['location']),
                ],
              ),
            )),
      ]),
    );
  }
}
