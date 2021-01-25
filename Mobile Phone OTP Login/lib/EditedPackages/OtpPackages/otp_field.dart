import 'package:flutter/material.dart';
import 'style.dart';
import 'package:hexcolor/hexcolor.dart';


typedef otpListenerner(String value);

class OtpBlockController {
  VoidCallback myFunction;
  VoidCallback mySecondFunction;
  otpListenerner setOtp;

  void dispose() {
    //Remove any data that's will cause a memory leak/render errors in here
    myFunction = null;
    mySecondFunction = null;
    setOtp = null;
  }
}


class OTPTextField extends StatefulWidget {




  /// Number of the OTP Fields
  final int length;

  /// Total Width of the OTP Text Field
  final double width;

  /// Width of the single OTP Field
  final double fieldWidth;
  final double fieldheight;

  /// Manage the type of keyboard that shows up
  TextInputType keyboardType;

  /// The style to use for the text being edited.
  final TextStyle style;


  /// Text Field Alignment
  /// default: MainAxisAlignment.spaceBetween [MainAxisAlignment]
  final MainAxisAlignment textFieldAlignment;

  /// Obscure Text if data is sensitive
  final bool obscureText;

  /// Text Field Style for field shape.
  /// default FieldStyle.underline [FieldStyle]
  final FieldStyle fieldStyle;

  /// Callback function, called when a change is detected to the pin.
  final ValueChanged<String> onChanged;

  /// Callback function, called when pin is completed.
  final ValueChanged<String> onCompleted;
  final VoidCallback uncomplete;
    OtpBlockController controller;

  OTPTextField({Key key,
    this.length = 4,
    this.width = 10,
    this.fieldWidth = 30,
    this.fieldheight = 30,
    this.uncomplete,
    this.keyboardType = TextInputType.number,
    this.style = const TextStyle(),
    this.controller,
    this.textFieldAlignment = MainAxisAlignment.spaceBetween,
    this.obscureText = false,
    this.fieldStyle = FieldStyle.underline,
    this.onChanged,
    this.onCompleted})
      : assert(length > 1);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  List<Widget> _textFields;
  List<String> _pin;



  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode>(widget.length);
    _textControllers = List<TextEditingController>(widget.length);

    _pin = List.generate(widget.length, (int i) {
      return '';
    });
    _textFields = List.generate(widget.length, (int i) {
      return buildTextField(context, i);
    });

  }

  @override
  void dispose() {
    _textControllers
        .forEach((TextEditingController controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Container(
      width: widget.width,
      child: Row(
        mainAxisAlignment: widget.textFieldAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _textFields,
      ),
    );
  }

  /// This function Build and returns individual TextField item.
  ///
  /// * Requires a build context
  /// * Requires Int position of the field
  Widget buildTextField(BuildContext context, int i) {
    void setOtp(String otp){
      print("there is grp of $otp");
      setState(() {
        for(int i=0;i<_textControllers.length;i++){
          _textControllers[i].text=otp[i];
          _pin[i]=otp[i];
        }

      });
widget.onCompleted("$otp");
    }


    widget.controller.setOtp=setOtp;

    if (_focusNodes[i] == null) _focusNodes[i] = new FocusNode();

    if (_textControllers[i] == null)
      _textControllers[i] = new TextEditingController();

    return Container(
      color: HexColor("#F5F5F7"),
      width: widget.fieldWidth,
      height: widget.fieldheight,



      child: Center(
        child: TextField(
          controller: _textControllers[i],
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: widget.style,
          focusNode: _focusNodes[i],
          obscureText: widget.obscureText,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 10),
              counterText: "",
              enabledBorder:  OutlineInputBorder(
                borderSide:  BorderSide(color: HexColor("#F5F5F7"), width: 0.0),
              ),
              focusedBorder:  OutlineInputBorder(
                borderSide:  BorderSide(color: HexColor("#F5F5F7"), width: 0.0),
              ),
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: HexColor("#F5F5F7"), width: 0.0),
              )
          ),
          onChanged: (String str) {
            // Check if the current value at this position is empty
            // If it is move focus to previous text field.
            if (str.isEmpty) {
              if (i == 0) return;
              _focusNodes[i].unfocus();
              _focusNodes[i - 1 ].requestFocus();
            }

            // Update the current pin
            setState(() {
              _pin[i] = str;
            });
            // Remove focus
            if (str.isNotEmpty) _focusNodes[i].unfocus();
            // Set focus to the next field if available
            if (i + 1 != widget.length && str.isNotEmpty)
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);

            String currentPin = "";
            _pin.forEach((String value) {
              currentPin += value;
            });

            // if there are no null values that means otp is completed
            // Call the `onCompleted` callback function provided
            if (!_pin.contains(null) &&
                !_pin.contains('') &&
                currentPin.length == widget.length) {
              widget.onCompleted(currentPin);
           /*
           Important section
           _textControllers[0].text="6";
             _pin[0]="8"; */
            }

            if (_pin.contains(null) ||
                _pin.contains('') ||
                currentPin.length < widget.length) {
              widget.uncomplete();
            }

            // Call the `onChanged` callback function
            widget.onChanged(currentPin);
          },
        ),
      ),
    );
  }
}
