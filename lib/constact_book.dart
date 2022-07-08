import 'package:flutter/material.dart';
import 'package:state_management_starter/contact.dart';

class ContactBook extends ValueNotifier<List<Contact>>{
  ContactBook._sharedInstance():super([]);

  static final ContactBook _shared = ContactBook._sharedInstance();

  factory ContactBook() {
    return _shared;
  }


  int get contactLength => value.length;

  void addContact({required Contact contact}) {
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void removeContact({required Contact contact}) {
    final contacts = value;
    if(contacts.contains(contact)){
      contacts.remove(contact);
      notifyListeners();
    }
  }

  Contact? getContactFromIndex({required int index}) =>
      value.length >index? value[index] : null;
}
