import 'package:flutter/material.dart';
import 'package:state_management_starter/constact_book.dart';
import 'package:state_management_starter/contact.dart';

void main() {
  runApp(
    MaterialApp(home: const HomePage(), routes: {
      '/new-contact': (context) => const AddNewContact(),
    }),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: ValueListenableBuilder(
        builder: (context, value, child) {
          final contacts = value as List<Contact>;
          return ListView.builder(
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Dismissible(
                onDismissed: (direction){
                  ContactBook().removeContact(contact: contact);
                },
                key: ValueKey(contact.id),
                child: Material(
                  color: Colors.white,
                  elevation: 20.0,
                  child: ListTile(
                    title: Text(contact!.name),
                  ),
                ),
              );
            },
            itemCount: contacts.length,
          );
        },
        valueListenable: ContactBook(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/new-contact");
          },
          child: const Icon(Icons.add)),
    );
  }
}

class AddNewContact extends StatefulWidget {
  const AddNewContact({Key? key}) : super(key: key);

  @override
  State<AddNewContact> createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
      ),
      body: Column(children: [
        const Text("Add new contact"),
        TextFormField(
          controller: _textEditingController,
        ),
        TextButton(
          onPressed: () {
            final contactName = Contact(name: _textEditingController.text);
            ContactBook().addContact(contact: contactName);
            Navigator.pop(context);
          },
          child: const Text("Add"),
        )
      ]),
    );
  }
}
