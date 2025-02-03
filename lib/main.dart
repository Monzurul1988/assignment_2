import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(git
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  List<Map<String, String>> contacts = [];

  void _addContact() {
    String name = _nameController.text;
    String phone = _phoneController.text;

    if (name.isNotEmpty && phone.isNotEmpty) {
      setState(() {
        contacts.add({'name': name, 'phone': phone});
      });

      _nameController.clear();
      _phoneController.clear();
    }
  }

  void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  Future<void> _showDeleteDialog(int index) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Contact'),
          content: const Text('Are you sure you want to delete this contact?'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.cancel,color: Colors.blue),
            ),

            IconButton(
              icon: const Icon(Icons.delete, color: Colors.blue),
              onPressed: () {
                _deleteContact(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Center(child: Text('Contacts List')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                ),
                labelText: 'Name',


              ),
            ),

            const SizedBox( height: 20),
            TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(

                  ),
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
              ),

            const SizedBox(height: 20),
            ElevatedButton(

              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 160.0, top: 2.0,right:160.0,bottom: 2.0),
                backgroundColor: Colors.blue.shade100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

              ),
                  onPressed: _addContact,
                  child: const Text( 'Add',style: TextStyle(fontSize: 25, color: Colors.blue)),
                ),

            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.grey, size: 50),
                      trailing: const Icon(Icons.phone, color: Colors.blue,),
                      title: Text(contacts[index]['name']!, style: TextStyle(color: Colors.red.shade400,fontSize: 20),),
                      subtitle: Text(contacts[index]['phone']!),
                      onLongPress: () {
                        _showDeleteDialog(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}