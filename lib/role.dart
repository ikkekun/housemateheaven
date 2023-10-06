import 'package:flutter/material.dart';
import 'package:housemateheaven/pages_student/homepage.dart';
import 'package:housemateheaven/pages_studentrent/homepage2.dart';
import 'package:housemateheaven/widget/navdrawer2.dart';

import 'widget/navdrawer.dart';

class Role extends StatefulWidget {
  const Role({Key? key}) : super(key: key);

  @override
  State <Role> createState() =>  RoleState();
}

class  RoleState extends State <Role> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage('assests/image/logowhite.jpeg'), height: height * 0.3),
            Column(
              children: [
                Text(
                  "Welcome to HousemateHeaven Application",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "Please Choose Your Role for Us to Determine Which Functionlity You Want To Use",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),);
                    }, 
                    child: Text('Find Housemate')
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage2()),);
                    }, 
                    child: Text('Looking For A House To Share')
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