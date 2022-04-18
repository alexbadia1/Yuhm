import 'package:flutter/material.dart';
import 'package:yuhm/components/components.dart';
import 'package:yuhm/logic/logic.dart';

class RestaurantPinPage extends StatefulWidget {
  const RestaurantPinPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPinPage> createState() => _RestaurantPinPageState();
}

class _RestaurantPinPageState extends State<RestaurantPinPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _formKey.currentState!.validate();
      } // if
    });
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.deepOrangeAccent,
          // image: DecorationImage(
          //   image: AssetImage("assets/images/Bitmap.png"),
          //   fit: BoxFit.fill,
          // ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: _size.width * .03,
              top: _size.height * .125,
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  size: 48,
                ),
                onPressed: () {
                  BlocProvider.of<AppPageViewCubit>(context).jumpToHomePage();
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: RestaurantPinTextFormField(
                      formKey: _formKey,
                      focusNode: _focusNode,
                      textEditingController: _textEditingController,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: RoundedButton(
                    text: "Submit",
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      FocusScope.of(context).unfocus();
                      // TODO: Submit data to bloc _textEditingController.text.trim()
                      BlocProvider.of<AppPageViewCubit>(context)
                          .jumpToRestaurantPage();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantPinTextFormField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  final TextEditingController textEditingController;

  const RestaurantPinTextFormField({
    Key? key,
    required this.formKey,
    required this.focusNode,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        label: Text("Restaurant PIN"),
        errorStyle: TextStyle(color: Colors.black),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(255, 255, 255, .5),
          ),
        ),
      ),
      validator: (text) {
        if (!RegExp(
          r"[a-zA-Z0-9]+",
          caseSensitive: false,
          multiLine: false,
        ).hasMatch(text!)) {
          return "Only letters and numbers!";
        }
      },
    );
  }
}
