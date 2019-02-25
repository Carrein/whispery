import 'package:flutter/material.dart';
import 'package:whispery/widgets/components.dart';
import 'package:email_validator/email_validator.dart';
import 'package:whispery/globals/strings.dart';
import 'package:whispery/handler/login_handler.dart';
import 'package:whispery/editor_page.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPage();
}

// The two types of form in LoginPage.
enum FormType { login, register }

class _LoginPage extends State<LoginPage> {

  // GlobalKeys for LoginPage. 
  static final _loginFormKey = GlobalKey<FormState>();
  static final _loginScaffoldKey = GlobalKey<ScaffoldState>();

  // The set of controller to test validity of inputs.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _validPassController = TextEditingController();

  // Set inital form type to be login.
  FormType _formType = FormType.login;

  // String value for form fields.
  String _email;
  String _password;
  String _validPassword;
  Components components = new Components();

  // Boolean to disable button on empty fields.
  bool _enabled = true;

  // Instance of login handler to hangle form submission.
  LoginHandler _loginHandler = LoginHandler();

  // Submits all fields in the current form page to LoginHandler.
  void submit() {
    FormState form = _loginFormKey.currentState;
    if (form.validate()) {
      toggle();
      form.save();
      if (_formType == FormType.register) {
        print(_password);
        print(_validPassword);
        if (_password != _validPassword) {
          components.buildSnackbar( 
              _loginScaffoldKey.currentState, Strings.passwordMismatch);
          toggle();
        } else {
          _loginHandler.register(_email, _password).then((response) {
            if (response) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EditorPage()),
              );
            } else {
              components.buildSnackbar(
                  _loginScaffoldKey.currentState, Strings.emailExists);
              toggle();
            }
          });
        }
      } else {
        _loginHandler.login(_email, _password).then((response) {
          switch (response) {
            case 1:
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => EditorPage()),
              // );
              break;
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EditorPage()),
              );
              break;

            case -1:
              components.buildSnackbar(
                  _loginScaffoldKey.currentState, Strings.wrongLogin);
              toggle();
              break;
          }
        });
      }
    }
  }

  // Switch between login and register pages.
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

  void toggle() {
    setState(() {
      _enabled = !_enabled;
    });
  }

  Widget buttons() {
    List<Widget> buttonList;

    switch (_formType) {
      case FormType.login:
        buttonList = [
          components.longButton("login", "ORANGE", _enabled ? submit : null),
          components.longButton(
              "signup?", "ORANGE", _enabled ? moveToRegister : null),
        ];
        break;
      case FormType.register:
        buttonList = [
          components.longButton("register", "ORANGE", _enabled ? submit : null),
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
                savedInput: (e) => _email = e,
                hint: "email",
                validatorInput: (e) {
                  if (e.isEmpty) return Strings.emptyField;
                  if (!EmailValidator.validate(e)) return Strings.invalidEmail;
                },
              ),
              components.textfield(
                type: "Text",
                controller: _passController,
                savedInput: (e) => _password = e,
                hint: "passsword",
                obscure: true,
                validatorInput: (e) {
                  if (e.isEmpty) return Strings.emptyField;
                  if (e.length < 8) return Strings.invalidPassword;
                },
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
                savedInput: (e) => _email = e,
                hint: "email",
                validatorInput: (e) {
                  if (e.isEmpty) return Strings.emptyField;
                  if (!EmailValidator.validate(e)) return Strings.invalidEmail;
                },
              ),
              components.textfield(
                type: "Text",
                controller: _passController,
                savedInput: (e) => _password = e,
                hint: "passsword",
                obscure: true,
                validatorInput: (e) {
                  if (e.isEmpty) return Strings.emptyField;
                  if (e.length < 8) return Strings.invalidPassword;
                },
              ),
              components.textfield(
                type: "Text",
                controller: _validPassController,
                savedInput: (e) => _validPassword = e,
                hint: "reenter passsword",
                obscure: true,
                validatorInput: (e) {
                  if (e.isEmpty) return Strings.emptyField;
                  if (e.length < 8) return Strings.invalidPassword;
                },
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
              onPressed: () {},
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
