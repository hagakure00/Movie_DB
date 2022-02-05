import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moviedb/Pages/HomePage.dart';
import 'package:moviedb/Repository/DataRepository.dart';
import 'package:moviedb/Utils/colors.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {


  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async{
    // appel API
    final dataProvider = Provider.of<DataRepository>(context,listen: false);
    // initialisation des list de film
    await dataProvider.iniData();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background.withOpacity(0.5),
      body: SingleChildScrollView(
        child: Column(children: [

          Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 200),
            child:  SizedBox(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/logodb.png")),
            ),
          ),
          const SizedBox(height: 100),
          const SpinKitFadingCircle(color: primary,size: 40)



        ],),
      ),
    );
  }
}
