import 'helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

/*
class takePhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhiteColor,
      body: Container(

        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1000.0),
              ),

              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
            ]),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

}
*/


class takePhotoPage extends StatefulWidget {
  @override
  _takePhotoPageState createState() => _takePhotoPageState();
}

class _takePhotoPageState extends State<takePhotoPage> {
  List _outputs;
  File _image;
  bool _loading = false;
  String foodname = '';
  String totalFood = '';
  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
            child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _outputs != null
                  ? Text(
                "Total ingredients: \n"+"$totalFood",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  background: Paint()..color = Colors.white,
                ),
              )
                  : Text(
                "Choose image from gallery or take a photo of your ingredients :)",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  background: Paint()..color = Colors.white,
                ),
              ),
              _image == null ? Container() : Image.file(_image,width: 150, height: 150),
              SizedBox(
                height: 20,
              ),
              _outputs != null
                  ? Text(
                "$foodname",
                //"${_outputs[0]["label"]}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  background: Paint()..color = Colors.white,
                ),
              )
                  : Container()
            ],
        ),
      ),
          ),
      floatingActionButton:
      Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: pickImage,
              backgroundColor: appPinkColor,
              foregroundColor: appGreyColor,
              child: Icon(Icons.image),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: pickImageFromCamera,
              backgroundColor: appMintColor,
              foregroundColor: appGreyColor,
              child: Icon(Icons.camera_alt),
            ),
          ]
      ),
    );
  }
  pickImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
      RegExp exp = new RegExp(r"(\D+)");
      foodname = _outputs[0]["label"];
      Iterable<RegExpMatch> matches = exp.allMatches(foodname);
      foodname = matches.elementAt(0).group(0).trim();
      if(totalFood == ''){
        totalFood = foodname;
      }else{
        totalFood = totalFood +","+ foodname;
      }

    });
  }

  loadModel() async {
    await Tflite.loadModel(
//      model: "assets/tflite/model_unquant.tflite",
//      labels: "assets/tflite/labels.txt",
      model: "assets/tflite2/model.tflite",
      labels: "assets/tflite2/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
