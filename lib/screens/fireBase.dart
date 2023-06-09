import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Fire extends StatelessWidget {
  const Fire({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
          child: Text('Connect to Firestore'),
          onPressed: () {
            connectToFirestore();
          },
        ),
        ),
      ),
    );
  }
  
  void  connectToFirestore () 
  async {
       //!get data

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('events').get();
    
    //!update a collection
      final events=    await FirebaseFirestore.instance.collection('events').doc('1');
     events.update({'eventAttendee':55});
   
    if (snapshot != null) {
      for (var doc in snapshot.docs) {
        print(doc.data());
        
      }
    }
  }
}