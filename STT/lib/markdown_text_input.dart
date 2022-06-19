import 'package:flutter/material.dart';
import '/format_markdown.dart';
import 'package:expandable/expandable.dart';

/// Widget with markdown buttons
class MarkdownTextInput extends StatefulWidget {
  /// Callback called when text changed
  final Function onTextChanged;

  /// Initial value you want to display
  final String initialValue;

  /// Validator for the TextFormField
  final String? Function(String? value)? validators;

  /// String displayed at hintText in TextFormField
  final String? label;

  /// Change the text direction of the input (RTL / LTR)
  final TextDirection? textDirection;

  /// The maximum of lines that can be display in the input
  final int? maxLines;

  /// List of action the component can handle
  final List<MarkdownType> actions;

  /// Optionnal controller to manage the input
  final TextEditingController? controller;

  /// Constructor for [MarkdownTextInput]
  MarkdownTextInput(
      this.onTextChanged,
      this.initialValue, {
        this.label = '',
        this.validators,
        this.textDirection = TextDirection.ltr,
        this.maxLines = 10,
        this.actions = const [
          MarkdownType.key_tag,
          MarkdownType.negative,
          MarkdownType.customer_address,
          MarkdownType.customer_name,
          MarkdownType.customer_call
        ],
        this.controller,
      });

  @override
  _MarkdownTextInputState createState() => _MarkdownTextInputState(controller ?? TextEditingController());
}

class _MarkdownTextInputState extends State<MarkdownTextInput> {
  final TextEditingController _controller;
  TextSelection textSelection = const TextSelection(baseOffset: 0, extentOffset: 0);

  _MarkdownTextInputState(this._controller);

  void onTap(MarkdownType type, {int titleSize = 1}) {
    final basePosition = textSelection.baseOffset;
    var noTextSelected = (textSelection.baseOffset - textSelection.extentOffset) == 0;

    final result = FormatMarkdown.convertToMarkdown(
        type, _controller.text, textSelection.baseOffset, textSelection.extentOffset,
        titleSize: titleSize);

    _controller.value = _controller.value
        .copyWith(text: result.data, selection: TextSelection.collapsed(offset: basePosition + result.cursorIndex));

    if (noTextSelected) {
      _controller.selection = TextSelection.collapsed(offset: _controller.selection.end - result.replaceCursorIndex);
    }
  }

  @override
  void initState() {
    _controller.text = widget.initialValue;
    _controller.addListener(() {
      if (_controller.selection.baseOffset != -1) textSelection = _controller.selection;
      widget.onTextChanged(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 44,
            child: Material(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.actions.map((type) {
                  return InkWell(
                    key: Key(type.key),
                    onTap: () => onTap(type),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(type.icon),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.newline,
            maxLines: widget.maxLines,
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) => widget.validators!(value),
            cursorColor: Theme.of(context).primaryColor,
            cursorWidth: 3.5,
            textDirection: widget.textDirection,
            decoration: InputDecoration(
              enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
              focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
              hintText: widget.label,
              hintStyle: const TextStyle(color: Color.fromRGBO(63, 61, 86, 0.5)),
              contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            ),
          ),
          SizedBox(
            height: 44,
            child: Material(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.actions.map((type) {
                  return InkWell(
                    key: Key(type.key),
                    onTap: () => onTap(type),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(type.icon),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}