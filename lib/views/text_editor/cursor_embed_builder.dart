import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:teia/views/text_editor/cursor_block_embed.dart';
import 'package:teia/views/text_editor/remote_cursor.dart';

class CursorEmbedBuilder implements EmbedBuilder {
  CursorEmbedBuilder();

  @override
  String get key => 'cursor';

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
  ) {
    RemoteCursor cursor = RemoteCursor.fromString(CursorBlockEmbed(node.value.data).data);
    return Material(
      color: Colors.transparent,
      child: /*VerticalDivider(
        thickness: 2.0,
        width: 2.0,
        color: Colors.red,
      ),*/
          Container(
        width: 5.0,
        height: 10.0,
        color: Colors.red,
      ),
    );
  }

  @override
  WidgetSpan buildWidgetSpan(Widget widget) {
    return WidgetSpan(child: widget);
  }

  @override
  bool get expanded => true;
}
