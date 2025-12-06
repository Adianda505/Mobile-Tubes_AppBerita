import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});


void login(){

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            //Background
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
              gradient: LinearGradient(
              colors: [
              Color.fromARGB(255, 67, 18, 89),
              Color.fromARGB(255, 0, 0, 0)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            Text(
              'Use your email and Password to log in',
              style: TextStyle(
              color: Colors.white,
              ),
            ),

            SizedBox(height: 50),
            //Form Login
            Form(
              child: Container(
                width: 323,
                height : 306,
              
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                  
                child: Column(
                  children: [
                  const SizedBox(height: 20),

              SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Email',
                          style: TextStyle(
                          color: Colors.white,
                ),
              ),
                  ],
              )
              )
              ),

              SizedBox(height: 2),

              SizedBox(
                width: 262,
                height: 55,      
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(50.0)
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 67, 18, 89),
                        width: 2,
                      )
                    ),
                    filled: false,
                    // border: Border.all( color:Color.fromARGB(255, 67, 18, 89)),
                  ),
                ),
              ),

             Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 125,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Password',
                          style: TextStyle(
                          color: Colors.white,
                ),
              ),
                    ],
                  ))
              
              ),

              const SizedBox(height: 5),

              SizedBox(
                width: 262,
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(50.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 67, 18, 89),
                       width: 2,
                      )
                    ),
                    filled: false,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 290,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Forgot Password?',
                          style: TextStyle(
                            fontSize: 12,
                          color: Colors.white,
                ),
              ),
                    ],
                  ))
              
              ),

                SizedBox(height: 25),
                  
                  SizedBox( 
                  width: 267,
                  height: 40,
                    
                  child: ElevatedButton(
                      // child: Ink(
                      //   decoration: const BoxDecoration(
                      //     gradient: LinearGradient(
                      //       colors: [
                      //         Color.fromARGB(255, 67, 18, 89),
                      //         Color.fromARGB(255, 0, 0, 0)
                      //       ]
                      //       )
                      //   ),
                      // child: Container(
                      //   constraints: const BoxConstraints(maxWidth: 267, minHeight: 40),
                         
                      // ),
                      // ),
                      // style: ElevatedButton(
                      //    child
                      //    ),
                  onPressed: login, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 67, 18, 89)
                  ),
                  child: const Text('Login',
                         textAlign: TextAlign.center,
                         style: TextStyle(
                          color: Colors.white,
                         ),
                  ),  
                  )
                  ),


                  SizedBox(height: 25),

                  

                 
                ],

                
                ),
              ),

              ),

                Padding(
                    padding: EdgeInsetsGeometry.only(top: 50),
                    //alignment: Alignment(0, 5.0),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                  Image.asset('assets/images/goggle.png', width: 50, height: 50),
                  ],
              ),
                )    
          ], 
        ),
      ),
      );
  }
}