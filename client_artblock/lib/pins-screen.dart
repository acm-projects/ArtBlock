import 'package:flutter/material.dart';

class Pins extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("MY PROFILE", style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 56,
              backgroundImage:
                NetworkImage('https://images.unsplash.com/photo-1517841905240-472988babdf9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80'),
                backgroundColor: Colors.transparent,
              ),
            SizedBox(
              height: 12.0,
            ),
        Text("John Doe",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
            ),
            Text(
              "@johndoe",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Divider(height: 18.0, thickness: 0.6, color: Colors.black
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ) ,
                      itemBuilder: (context, index){
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal:2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage('https://images.unsplash.com/photo-1453536693126-048a470d9b07?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80')
                            )
                          ),
                        );
                      }
                  ),
                )),
          ],
        )
      )
    );
  }
}
