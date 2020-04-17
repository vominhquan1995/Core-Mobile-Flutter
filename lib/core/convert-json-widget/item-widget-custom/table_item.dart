import 'package:flutter/material.dart';

class TableItemWidget extends StatelessWidget {
  final dynamic data;

  const TableItemWidget({Key key, this.data}) : super(key: key);

  buildItem() {
    List<TableRow> listrow = new List<TableRow>();
    for (var row in data["content"]) {
      List<Container> listcolum = new List<Container>();
      for (var colum in row) {
        listcolum.add(
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
              colum,
            ),
          ),
        );
      }

      TableRow rowitem = TableRow(children: listcolum.toList());
      listrow.add(rowitem);
    }

    return Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: listrow.toList());
  }

  @override
  Widget build(BuildContext context) {
    return buildItem();
  }
}
