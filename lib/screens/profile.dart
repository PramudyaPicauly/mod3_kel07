import 'package:flutter/material.dart';
import 'package:mod3_kel07/screens/home.dart';
import 'dart:convert'; 

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> avatar = <String>['naruto.jpg', 'sasuke.jpg', 'sakura.jpg', 'kakashi.jpg'];
  final List<String> nama = <String>['Pramudya Anggara P', 'Sayid Miqdad', 'Khairun Nisa M', 'Reyhan Chairul A'];
  final List<String> nim = <String>['21120119130061', '21120119130046', '21120119120006', '21120119140140'];
  final List<String> email = <String>['angga@email.com', 'sayid@email.com', 'nisa@email.com', 'reyhan@email.com'];

  int _selectedIndex = 1;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Person',
      style: optionStyle,
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Anggota')),
      backgroundColor: Colors.blue[100],
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
            itemCount: nama.length, // the length
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 220,
                    height: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
                      child: Image.asset(
                        avatar[index],
                        fit: BoxFit.cover,
                      ),
                      elevation: 55,
                      margin: EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(nama[index],
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Text('Kelompok 07',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: 200,
                    child: Divider(
                      color: Colors.blue,
                    ),
                  ),
                  Card(
                    color: Colors.blue[300],
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 75.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.badge,
                        color: Colors.blue[900],
                      ),
                      title: Text(nim[index]),
                    ),
                  ),
                  Card(
                    color: Colors.blue[300],
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 75.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.blue[900],
                      ),
                      title: Text(email[index]),
                    )
                  ),
                ],
              );
            }
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: (int index) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    ),
    );
  }
}