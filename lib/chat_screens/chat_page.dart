import 'package:chatApp/chat_screens/messanger.dart';
import 'package:chatApp/firebase_helper.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                signOut();
              })
        ],
        title: Text('Messanger'),
      ),
      body: Container(
    
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getAllChats(),
          builder: (context, snapshot) {
          
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text('No Users'),
              );
            } else if(snapshot.data != null){
              List<Map<String, dynamic>> data = snapshot.data;
              print(snapshot.data);
             
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Messanger(
                            myId: getUser(),
                            otherId: data[index]['userId'],
                          );
                        }));
                      },
                      title: Text(data[index]['userName']),
                      subtitle: Text(data[index]['email']),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
