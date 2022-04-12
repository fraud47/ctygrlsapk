import 'package:city_girls/components/DocumentItem.dart';
import 'package:city_girls/providers/DocumentProvider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DocumentBarItem extends StatelessWidget {
  const DocumentBarItem({@required String this.name, @required String this.ey});

  final String name;
  final String ey;

  @override
  Widget build(BuildContext context) {
    DocumentProvider document = Provider.of<DocumentProvider>(context);
    var documents = document.documents;
    var length;
    length = documents.length;

    return Center(
        child: ListView.builder(
      key: PageStorageKey(ey),
      itemBuilder: (BuildContext context, int index) {
        return DocumentItem(
          document: documents[index],
        );
      },
      itemCount: length,
    ));
  }
}
