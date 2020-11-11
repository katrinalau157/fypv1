import 'helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(),
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
              _home_btn_1(context),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
            ]),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar() {
    return new AppBar(
      centerTitle: true,
      elevation: 0.1,
      title: Text('Foodcithy',style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold,color: appBlackColor),),
      backgroundColor: appWhiteColor,
      bottom: PreferredSize(
          child: Container(
            color: Colors.black,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(4.0)),
    );
  }

  Widget _home_btn_1(BuildContext context) {
    return new ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 2.2,
        height: MediaQuery.of(context).size.height / 16.5,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: RaisedButton(
          onPressed: () {
            //set_selectedindex0_C();
            Navigator.of(context).pushNamed(mainScaffoldTag);
          },
          child: Text('Login',style: GoogleFonts.josefinSans(fontSize:18,fontWeight: FontWeight.bold,color: appBlackColor),),
          color: appPinkColor,
        ));
  }

}
