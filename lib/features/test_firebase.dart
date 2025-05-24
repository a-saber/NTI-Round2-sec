import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nti_r2/core/helper/my_navigator.dart';

class TestFirebaseView extends StatefulWidget {
  const TestFirebaseView({super.key});

  @override
  State<TestFirebaseView> createState() => _TestFirebaseViewState();
}

class _TestFirebaseViewState extends State<TestFirebaseView> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Firebase'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children:
              [
                TextFormField(
                  validator: (String? value)
                  {
                    if(value == null || value.isEmpty) return 'This field is required';
                    // var regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    // if( !regExp.hasMatch(value) ) return 'Enter a valid email';
                    return null;
                  },
                  controller: emailController,
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: passwordController,
                  validator: (String? value)
                  {
                    if(value == null || value.isEmpty) return 'This field is required';
                    return null;
                  },
                ),
                SizedBox(height: 40,),
                ElevatedButton(
                  onPressed: ()async
                  {
                    if(!formKey.currentState!.validate()) return;
                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      // verify email
                      await credential.user?.sendEmailVerification();
                      await FirebaseFirestore.instance.collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        'email': FirebaseAuth.instance.currentUser!.email,
                        'uid': FirebaseAuth.instance.currentUser!.uid
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                      print("Error in Register ${e.message.toString()}");
                    } catch (e) {
                      print("Error in Register ${e.toString()}");
                    }
                  },
                  child: Text('Register')
                ),
                SizedBox(height: 20,),
                // ElevatedButton(
                //     onPressed: ()async
                //     {
                //       try {
                //         await FirebaseAuth.instance.setLanguageCode("ar");
                //         await FirebaseAuth.instance.currentUser?.sendEmailVerification();
                //       } on FirebaseAuthException catch (e) {
                //         print("Firebase Error in Verify ${e.message.toString()}");
                //       } catch (e) {
                //         print("Error in Verify ${e.toString()}");
                //       }
                //     },
                //     child: Text('Verify If Can')
                // ),
                // SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: ()async
                    {
                      if(!formKey.currentState!.validate()) return ;
                      try {
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        );
                        if(!credential.user!.emailVerified)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You Must Verify')));
                        }
                        else
                        {
                          MyNavigator.goTo(screen:()=> HomeScreen(), isReplace: true);
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                        print('Firebase Error: ${e.message}');
                      }
                    },
                    child: Text('Login')
                ),
                // SizedBox(height: 20,),
                // ElevatedButton(
                //     onPressed: ()async
                //     {
                //       if(!formKey.currentState!.validate()) return ;
                //       try {
                //         await FirebaseAuth.instance.setLanguageCode("ar");
                //         await FirebaseAuth.instance
                //             .sendPasswordResetEmail(email: emailController.text);
                //       } on FirebaseAuthException catch (e) {
                //         print('Firebase Error: ${e.message}');
                //       }
                //     },
                //     child: Text('sendPasswordResetEmail')
                // ),
                // SizedBox(height: 20,),
                // ElevatedButton(
                //     onPressed: ()async
                //     {
                //       try {
                //         await FirebaseAuth.instance.signOut();
                //       } on FirebaseAuthException catch (e) {
                //         print('Firebase Error: ${e.message}');
                //       }
                //     },
                //     child: Text('Logout')
                // ),
                // SizedBox(height: 20,),
                // ElevatedButton(
                //     onPressed: ()async
                //     {
                //       try {
                //         // Trigger the authentication flow
                //         final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                //         // Obtain the auth details from the request
                //         final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                //
                //         // Create a new credential
                //         final credential = GoogleAuthProvider.credential(
                //           accessToken: googleAuth?.accessToken,
                //           idToken: googleAuth?.idToken,
                //         );
                //
                //         // Once signed in, return the UserCredential
                //         await FirebaseAuth.instance.signInWithCredential(credential);
                //
                //       } on FirebaseAuthException catch (e) {
                //         print('Firebase Error: ${e.message}');
                //       }
                //     },
                //     child: Text('Google Login')
                // ),
                // SizedBox(height: 20,),
                // ElevatedButton(
                //     onPressed: ()async
                //     {
                //       try {
                //         // Trigger the authentication flow
                //         await GoogleSignIn().signOut();
                //         await FirebaseAuth.instance.signOut();
                //
                //       } on FirebaseAuthException catch (e) {
                //         print('Firebase Error: ${e.message}');
                //       }
                //     },
                //     child: Text('Google Logout')
                // ),
                // SizedBox(height: 20,),
                // ElevatedButton(
                //     onPressed: ()async
                //     {
                //       try {
                //         await FirebaseFirestore.instance.collection('users')
                //             .add({
                //           'email': FirebaseAuth.instance.currentUser?.email??"test",
                //           'uid': FirebaseAuth.instance.currentUser?.uid??"uid"
                //         });
                //       } on FirebaseAuthException catch (e) {
                //         print("Error in firestore ${e.message.toString()}");
                //       } catch (e) {
                //         print("Error in firestore ${e.toString()}");
                //       }
                //     },
                //     child: Text('add to firestore')
                // ),
                // SizedBox(height: 20,),
                // ElevatedButton(
                //     onPressed: ()async
                //     {
                //       try {
                //         await FirebaseFirestore.instance.collection('users')
                //             .doc(FirebaseAuth.instance.currentUser!.uid)
                //         .get().then((value) {
                //           print('hot');
                //           print(value.data());
                //         });
                //       } on FirebaseAuthException catch (e) {
                //         print("Error in firestore ${e.message.toString()}");
                //       } catch (e) {
                //         print("Error in firestore ${e.toString()}");
                //       }
                //     },
                //     child: Text('get from firestore')
                // ),


              ],
            ),
          ),
        )
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()async
      {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNewTask()));
      }),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('tasks').orderBy('date', descending: true).limitToLast(15).snapshots(),
        builder: (context, snapshot)
        {
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError)
          {
            return Center(child: Text(snapshot.error.toString()),);
          }
          else if(snapshot.hasData)
          {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index)
                {
                  var item = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(item['title']??''),
                        Text(item['description']??''),
                      ],
                    ),
                  );
                }
            );
          }
          else {
            return Center(child: Text('No Data'),);
          }
        }),
    );
  }
}
class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async
            {
            try{
              await FirebaseFirestore.instance.collection('users').doc(
                  FirebaseAuth.instance.currentUser!.uid
              ).collection('tasks').add({
                'title': titleController.text,
                'description': descriptionController.text,
                'date': DateTime.now()
              });
              Navigator.pop(context, true);
            }
            catch(e){
              print("error ${e.toString()}");
            }
            }, child: Text('Add'))
          ],
        ),
      ),
    );
  }
}

