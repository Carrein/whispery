import 'package:flutter/material.dart';
import 'package:whispery/widgets/components.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPage();
}

//Two form types.
enum FormType { login, register }

class _LoginPage extends State<LoginPage> {
  static final _loginFormKey = GlobalKey<FormState>();
  static final _loginScaffoldKey = GlobalKey<ScaffoldState>();

  //Set of controllers to test validity of inputs.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _validPassController = TextEditingController();

  //Switch for form type.
  FormType _formType = FormType.login;

  //String value for form fields.
  String _email;
  String _password;
  String _validPassword;
  Components components = new Components();

  //Boolean to disable button on empty fields.
  bool _enabled = true;

  //Instance of login handler to hangle form submission.
  // LoginHandler _loginHandler = LoginHandler();

  void moveToRegister() {
    _loginFormKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    _loginFormKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  Widget buttons() {
    List<Widget> buttonList;

    switch (_formType) {
      case FormType.login:
        buttonList = [
          components.longButton("login", "ORANGE", _enabled ? null : null),
          components.longButton(
              "signup?", "ORANGE", _enabled ? moveToRegister : null),
        ];
        break;
      case FormType.register:
        buttonList = [
          components.longButton("register", "ORANGE", _enabled ? null : null),
          components.longButton(
              "login?", "ORANGE", _enabled ? moveToLogin : null),
        ];
        break;
    }
    return Container(
      child: Row(
        children: buttonList,
      ),
    );
  }

  Widget header() {
    String titleText;

    switch (_formType) {
      case FormType.login:
        titleText = "login";
        break;
      case FormType.register:
        titleText = "register";
        break;
    }
    return components.title(titleText);
  }

  Widget fields() {
    switch (_formType) {
      case FormType.login:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              components.textfield(
                type: "Email",
                controller: _emailController,
                savedValue: _email,
                hint: "email",
              ),
              components.textfield(
                type: "Text",
                controller: _passController,
                savedValue: _password,
                hint: "passsword",
                obscure: true,
              ),
            ],
          ),
        );
      case FormType.register:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              components.textfield(
                type: "Email",
                controller: _emailController,
                savedValue: _email,
                hint: "email",
              ),
              components.textfield(
                type: "Text",
                controller: _passController,
                savedValue: _password,
                hint: "passsword",
                obscure: true,
              ),
              components.textfield(
                type: "Text",
                controller: _validPassController,
                savedValue: _validPassword,
                hint: "reenter passsword",
                obscure: true,
              ),
            ],
          ),
        );
      default:
        return null;
    }
  }

  Widget anonField() {
    return Container(
      child: Column(
        children: <Widget>[
          components.textDivider("or go anon"),
          Row(
            children: <Widget>[
              components.longButton("phantom", "L_GREY", () => null),
            ],
          ),
          Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              "forget password?",
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            onPressed: (){
              print("clicked");
            },
          ),
        ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _loginScaffoldKey,
      body: Form(
        key: _loginFormKey,
        child: Container(
            padding: EdgeInsets.all(32.0),
            child: ListView(
              children: <Widget>[
                header(),
                fields(),
                buttons(),
                anonField(),
              ],
            )),
      ),
    );
  }
}
