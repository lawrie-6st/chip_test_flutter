import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Woolha.com Flutter Tutorial',
      home: _InputChipExample(),
    );
  }
}

class _InputChipExample extends StatefulWidget {
  @override
  _InputChipExampleState createState() => _InputChipExampleState();
}

class _InputChipExampleState extends State<_InputChipExample> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _values = [];
  final List<String> _suggestion = [
    'guitar',
    'read book',
    'watch movie',
    'play game'
  ];
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _values.length; i++) {
      InputChip actionChip = InputChip(
        selected: false,
        label: Text(_values[i]),
        backgroundColor: Colors.blue[100],
        onDeleted: () {
          _values.removeAt(i);
          setState(() {
            _values = _values;
          });
        },
      );

      chips.add(actionChip);
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chip & Autocomplete'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
                child: buildChips(),
              ),
              Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return _suggestion.where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  _values.add(selection);
                  _textEditingController.clear();

                  setState(() {
                    _values = _values;
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onFieldSubmitted: (String value) {
                      _values.add(value);
                      textEditingController.clear();

                      setState(() {
                        _values = _values;
                        focusNode.requestFocus();
                      });
                    },
                  );
                },
              ),
            ],
          )),
    );
  }
}
