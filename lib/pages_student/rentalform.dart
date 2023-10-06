import 'package:flutter/material.dart';
import 'package:housemateheaven/pages_student/shootout.dart';
import 'package:housemateheaven/pages_student/post.dart';  
  
class RentalForm extends StatefulWidget {
  const RentalForm({Key? key}) : super(key: key);

  @override
  State<RentalForm> createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm>{
  final PostService _postService = PostService();

  String house = '';
  String address = '';
  String amount = '';
  String money = '';
  String phoneno = '';
  String usercaller = '';

  var _houseController, _addressController, _amountController, _moneyController, _phonenoController, _usercallerController;


  void _updateText(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Rental Form"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              onChanged: (val) {
                setState(() {
                  house = val;
                });
              },
              controller: _houseController,
              decoration: InputDecoration(
                labelText: 'House',
                prefixIcon: Icon(Icons.house_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  address = val;
                });
              },
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.house),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  amount = val;
                });
              },
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount Housemate Needed',
                prefixIcon: Icon(Icons.supervised_user_circle),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  money = val;
                });
              },
              controller: _moneyController,
              decoration: InputDecoration(
                labelText: 'Rental Amount for Each Person(RM)',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  usercaller = val;
                });
              },
              controller: _usercallerController,
              decoration: InputDecoration(
                labelText: 'Posted by',
                prefixIcon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  phoneno = val;
                });
              },
              controller: _phonenoController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.contact_phone_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40.0,),
            myBtn(context),
          ],
        ),
      )
    );
  }

  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
        onPressed: (){
          _postService.savePost(house, address, amount, money, phoneno, usercaller);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return ShootOut();
            })
          );
        },
        child: Text(
          "Submit Form".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
  }
}