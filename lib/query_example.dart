import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class querieExample extends StatelessWidget {
  const querieExample({Key? key});

  Future<List<DocumentSnapshot>> getExistingChats(String currentUserId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Chats')
          .where('Chatters', arrayContains: currentUserId)
          .get();

      List<DocumentSnapshot> documents = querySnapshot.docs;
      return documents;
    } catch (e) {
      print('Error retrieving existing chats: ${e.toString()}');
      return [];
    }
  }

  Future<void> sendDataToFirestore() async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('Chats');
      DocumentReference docRef = await collection.add({
        'CreatedDate': '20 nov 2023',
        'Chatters': ['User A', 'User B'],
        'lastModification': '30 nov 2023',
      });

      CollectionReference messagesCollectionRef = docRef.collection('Messages');
      await messagesCollectionRef.add({
        'Content': ['Hola', 'Mundo'],
        'SenderId': 'User A',
        'SenderName': 'Fauno',
        'CreatedDate': '21 nov 2023',
      });

      print('Data sent to Firestore successfully. Document ID: ${docRef.id}');
    } catch (e) {
      print('Error sending data to Firestore: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('addNewChat'),
              onPressed: sendDataToFirestore,
            ),
            ElevatedButton(
              child: Text('Get Existing Chats'),
              onPressed: () async {
                List<DocumentSnapshot> existingChats =
                    await getExistingChats('User A');
                for (DocumentSnapshot chatSnapshot in existingChats) {
                  Map<String, dynamic> chatData =
                      chatSnapshot.data() as Map<String, dynamic>;
                  String createdDate = chatData['CreatedDate'];
                  List<dynamic> chatters = chatData['Chatters'];
                  String lastModification = chatData['lastModification'];

                  print('Created Date: $createdDate');
                  print('Chatters: $chatters');
                  print('Last Modification: $lastModification');

                  CollectionReference messagesCollectionRef =
                      chatSnapshot.reference.collection('Messages');
                  QuerySnapshot messagesSnapshot =
                      await messagesCollectionRef.get();

                  for (DocumentSnapshot messageSnapshot
                      in messagesSnapshot.docs) {
                    Map<String, dynamic> messageData =
                        messageSnapshot.data() as Map<String, dynamic>;
                    List<dynamic> content = messageData['Content'];
                    String senderId = messageData['SenderId'];
                    String senderName = messageData['SenderName'];
                    String messageCreatedDate = messageData['CreatedDate'];

                    print('Message Content: $content');
                    print('Sender ID: $senderId');
                    print('Sender Name: $senderName');
                    print('Message Created Date: $messageCreatedDate');
                  }
                }
              },
            ),
            ElevatedButton(
              child: Text('Update Existing Chat'),
              onPressed: () async {
                DocumentReference chatDocumentRef = FirebaseFirestore.instance
                    .collection('Chats')
                    .doc('AlESQnmz0HcbPAQ3pCOz');
                CollectionReference messages =
                    chatDocumentRef.collection('Messages');
                await messages.doc('vJhWJ9Rs3Ei7n3WuGkB9').update({
                  'Content': FieldValue.arrayUnion(['Palabra'])
                });
                print('Chat actualizado con éxito');
              },
            ),
          ],
        ),
      ),
    );
  }
}
