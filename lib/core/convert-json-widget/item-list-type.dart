import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'item-widget-custom/index.dart';

/* 
sử dùng để show nội dung theo [type]
 type=:

 --> image -> show hình (nếu hình bị lỗi hay không có hình thì nên dùng background ** hay hình nào đó)

 --> header -> show 1 tiêu đề

 --> paragraph -> show nội dung html

 --> không phù hợp với loại nào -> đưa vô html

 */
class ItemTypeWidget extends StatelessWidget {
  final String type;
  final dynamic data;

  ItemTypeWidget({Key key, this.type, this.data}) : super(key: key);

  buildItem(context) {
    switch (this.type) {
      // 1.header
      case "header":
        return HeaderItem(data: data);
        break;

      // 2.paragraph
      case 'paragraph':
        return ParaGraphItemWidget(data: data);
        break;

      // 3.image`
      case 'image':
        return ImageItemWidget(data: data);
        break;

      // 4.delimiter
      case 'delimiter':
        return DelimiterItemWidget();
        break;

      // 5.quote
      case 'quote':
        return QuoteItemWidget(data: data);
        break;

      // 6.rawTool
      case 'rawTool':
        return RawToolItemWidget(data: data);
        break;

      // 7.linkTool
      case 'linkTool':
        return LinkToolWidget(data: data);
        break;

      // 8.code
      case 'code':
        return CodeItemWidget(data: data);
        break;

      // 9.list
      case 'list':
        return ListItemWidget(
          data: data,
        );
        break;

      // 10. table
      case 'table':
        return TableItemWidget(
          data: data,
        );
        break;
      // 11. ember
      case 'embed':
        return YoutubeItemWidget(
          data: data,
        );
        break;

      default:
        return Html(
          defaultTextStyle: TextStyle(fontSize: 13),
          data: "${data.toString() ?? ''}",
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildItem(context);
  }
}
