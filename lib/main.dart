import 'dart:async';
import 'dart:io'; // Add this line
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this line


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Members Page',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),
      home: SplashScreen(), // Start with the splash screen
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after 5 seconds
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/company_logo.jpeg', width: 200, height: 200),
            Text(
              'HomeSync',
              style: TextStyle(
                fontFamily: 'DancingScript',
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'By XCoders',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_large.jpg', width: 150, height: 150),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform login authentication
                // If login is successful, navigate to the MembersPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MembersPage()),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewUserPage()),
                );
              },
              child: Text('New User?'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New User Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'New User Registration',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement registration logic
                // Display success message upon successful registration
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Success'),
                      content: Text('Successfully registered!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  List<Member> members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            return MemberCard(
              member: members[index],
              onDelete: () {
                setState(() {
                  members.removeAt(index);
                });
              },
              onSettings: () {
                // Open the SettingsPage when settings button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newMember = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationPage()),
          );
          if (newMember != null) {
            setState(() {
              members.add(newMember);
            });
          }
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Member {
  final String name;
  final String imageUrl;

  Member({required this.name, required this.imageUrl});
}

class MemberCard extends StatelessWidget {
  final Member member;
  final VoidCallback onDelete;
  final VoidCallback onSettings;

  const MemberCard({
    Key? key,
    required this.member,
    required this.onDelete,
    required this.onSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[800],
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(member.imageUrl),
        ),
        title: Text(
          member.name,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: onSettings,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SettingBlock(
            imageAsset: 'assets/bulb.jpeg',
            name: 'Bulb One',
            hasSlider: true,
          ),
          SettingBlock(
            imageAsset: 'assets/bulb.jpeg',
            name: 'Bulb Two',
            hasSlider: true,
          ),
          SettingBlock(
            imageAsset: 'assets/fan.jpg',
            name: 'AC',
            hasSlider: true,
          ),
          SettingBlock(
            imageAsset: 'assets/speakers.jpeg',
            name: 'Speaker',
            hasSlider: true,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Changes saved'),
                ),
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

class SettingBlock extends StatefulWidget {
  final String imageAsset;
  final String name;
  final bool hasSlider;

  const SettingBlock({
    Key? key,
    required this.imageAsset,
    required this.name,
    this.hasSlider = false,
  }) : super(key: key);

  @override
  _SettingBlockState createState() => _SettingBlockState();
}

class _SettingBlockState extends State<SettingBlock> {
  bool _switchValue = false;
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  widget.imageAsset,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 16.0),
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Switch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ],
            ),
            if (widget.hasSlider)
              Slider(
                value: _sliderValue,
                onChanged: _switchValue
                    ? (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                }
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  DateTime? selectedDate;
  String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New User',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Date of Birth',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: selectedDate == null
                    ? 'Select your date of birth'
                    : '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Photo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                // Add logic to pick photo
                final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    photoUrl = pickedFile.path;
                  });
                }
              },
              child: Text('Pick Photo'),
            ),
            SizedBox(height: 16),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text;
                final newMember = Member(
                  name: name,
                  imageUrl: photoUrl ??
                      'https://img.freepik.com/premium-photo/blue-circle-with-man-s-head-circle-with-white-background_745528-3499.jpg',
                );
                Navigator.pop(context, newMember);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

