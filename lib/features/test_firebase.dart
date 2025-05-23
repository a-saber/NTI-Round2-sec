import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                ElevatedButton(
                    onPressed: ()async
                    {
                      try {
                        await FirebaseAuth.instance.setLanguageCode("ar");
                        await FirebaseAuth.instance.currentUser?.sendEmailVerification();
                      } on FirebaseAuthException catch (e) {
                        print("Firebase Error in Verify ${e.message.toString()}");
                      } catch (e) {
                        print("Error in Verify ${e.toString()}");
                      }
                    },
                    child: Text('Verify If Can')
                ),
                SizedBox(height: 20,),
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
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: ()async
                    {
                      if(!formKey.currentState!.validate()) return ;
                      try {
                        await FirebaseAuth.instance.setLanguageCode("ar");
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: emailController.text);
                      } on FirebaseAuthException catch (e) {
                        print('Firebase Error: ${e.message}');
                      }
                    },
                    child: Text('sendPasswordResetEmail')
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: ()async
                    {
                      try {
                        await FirebaseAuth.instance.signOut();
                      } on FirebaseAuthException catch (e) {
                        print('Firebase Error: ${e.message}');
                      }
                    },
                    child: Text('Logout')
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: ()async
                    {
                      try {
                        // Trigger the authentication flow
                        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                        // Obtain the auth details from the request
                        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                        // Create a new credential
                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth?.accessToken,
                          idToken: googleAuth?.idToken,
                        );

                        // Once signed in, return the UserCredential
                        await FirebaseAuth.instance.signInWithCredential(credential);

                      } on FirebaseAuthException catch (e) {
                        print('Firebase Error: ${e.message}');
                      }
                    },
                    child: Text('Google Login')
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: ()async
                    {
                      try {
                        // Trigger the authentication flow
                        await GoogleSignIn().signOut();
                        await FirebaseAuth.instance.signOut();

                      } on FirebaseAuthException catch (e) {
                        print('Firebase Error: ${e.message}');
                      }
                    },
                    child: Text('Google Logout')
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: ()async
                    {
                      try {
                        await FirebaseFirestore.instance.collection('users')
                            .add({
                          'email': FirebaseAuth.instance.currentUser?.email??"test",
                          'uid': FirebaseAuth.instance.currentUser?.uid??"uid"
                        });
                      } on FirebaseAuthException catch (e) {
                        print("Error in firestore ${e.message.toString()}");
                      } catch (e) {
                        print("Error in firestore ${e.toString()}");
                      }
                    },
                    child: Text('add to firestore')
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: ()async
                    {
                      try {
                        await FirebaseFirestore.instance.collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get().then((value) {
                          print('hot');
                          print(value.data());
                        });
                      } on FirebaseAuthException catch (e) {
                        print("Error in firestore ${e.message.toString()}");
                      } catch (e) {
                        print("Error in firestore ${e.toString()}");
                      }
                    },
                    child: Text('get from firestore')
                ),


              ],
            ),
          ),
        )
      ),
    );
  }
}
