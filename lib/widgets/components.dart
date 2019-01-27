import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:whispery/globals/strings.dart';
import 'package:flutter/services.dart';
import 'package:whispery/globals/colors.dart';

class Components {
  Map<String, TextInputType> fieldTypes = {
    "Text": TextInputType.text,
    "Email": TextInputType.emailAddress,
    "Multiline": TextInputType.multiline,
  };

  // WhitelistingTextInputFormatter formatter(e) {
  //   if (e) {
  //     return WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9!.-_]"));
  //   } else {
  //     return null;
  //   }
  // }

  Widget textDivider(text) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.black,
            height: 20,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
          ),
        ),
        Expanded(
          child: Divider(
            color: FCOLOR.color["D_GREY"],
            height: 20,
          ),
        ),
      ],
    );
  }

  Widget longButton(text, color, action) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          onPressed: action,
          child: Text(
            text,
            style: TextStyle(color: FCOLOR.color["D_GREY"]),
          ),
          // ),
          color: FCOLOR.color[color],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    );
  }

  Widget textfield(
      {type: "Text",
      controller,
      hint,
      obscure: false,
      validatorInput,
      savedInput,
      fontSize: 16.0}) {
    return TextFormField(
        keyboardType: fieldTypes[type],
        obscureText: obscure,
        autocorrect: false,
        controller: controller,
        validator: validatorInput,
        onSaved: savedInput,
        // inputFormatters: [formatter(limitFormat)],
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.all(10.0),
        ),
        style: TextStyle(
          fontSize: fontSize,
          color: FCOLOR.color["D_GREY"]
        ));
  }

  Widget title(titleText) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
          child: Text(
        titleText,
        style: TextStyle(fontSize: 50.0),
      )),
    );
  }

  void buildSnackbar(key, text) {
    key.showSnackBar(SnackBar(
      backgroundColor: FCOLOR.color["PEACH"],
      duration: new Duration(seconds: 4),
      content: Text(
        text,
        style: new TextStyle(
          color: FCOLOR.color["D_GREY"],
        ),
      ),
    ));
  }
}
