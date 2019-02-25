import 'package:flutter/material.dart';
import 'package:whispery/widgets/components.dart';
import 'package:whispery/globals/strings.dart';
import 'package:whispery/globals/colors.dart';
import 'package:whispery/handler/editor_handler.dart';

class EditorPage extends StatefulWidget {
  @override
  createState() => _EditorPage();
}

class _EditorPage extends State<EditorPage> {
  //GlobalKeys
  static final _editorFormKey = GlobalKey<FormState>();
  static final _editorScaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _headerController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  String _username;
  String _bio;
  String _currentFlair;
  List<DropdownMenuItem<String>> _flairOptions;

  bool _enabled = true;

  Components components = new Components();

  EditorHandler _editorHandler = EditorHandler();

  @override
  initState() {
    super.initState();
    _flairOptions = getOptions();
    _currentFlair = _flairOptions[0].value;
  }

  void switchFlair(String flair) {
    setState(() {
      _currentFlair = flair;
    });
  }

  void submit() {
    FormState form = _editorFormKey.currentState;
    if (form.validate()) {
      toggle();
      form.save();
      _editorHandler.submit(_username, _currentFlair, _bio).then((response) {
        if (response) {
          print("submited");
        } else {
          print("error");
        }
      });
    }
  }

  void toggle() {
    setState(() {
      _enabled = !_enabled;
    });
  }

  List<DropdownMenuItem<String>> getOptions() {
    List<DropdownMenuItem<String>> items = new List();
    FCOLOR.flairs.forEach((key, value) {
      items.add(new DropdownMenuItem(
        value: key,
        child: Text(key),
      ));
    });
    return items;
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: components.textfield(
        type: "Text",
        controller: _headerController,
        savedInput: (e) => _username = e,
        hint: "enter your username",
        validatorInput: (e) {
          if (e.isEmpty) return Strings.emptyField;
          if (e.length < 6) return Strings.usernameMinLength;
        },
        fontSize: 30.0,
      ),
    );
  }

  Widget flair() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("equip a flair"),
          DropdownButton(
            value: _currentFlair,
            items: _flairOptions,
            onChanged: switchFlair,
          )
        ],
      ),
    );
  }

  Widget bio() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: components.textfield(
        type: "Multiline",
        controller: _bioController,
        savedInput: (e) => _bio = e,
        hint: Strings.bioMessage,
        maxLines: 5,
        fontSize: 20.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _editorScaffoldKey,
      body: Form(
        key: _editorFormKey,
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: ListView(
            children: <Widget>[
              header(),
              flair(),
              bio(),
              components.circleButton(
                  Icon(Icons.save), _enabled ? submit : null),
            ],
          ),
        ),
      ),
    );
  }
}
