import "dart:async";

import "package:flutter/material.dart";

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
    
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    
    });
    
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              "Dallbeat",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      )
    );
  }

}

class CustomVirtualKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  final Function() onBackspace;

  CustomVirtualKeyboard({required this.onKeyTap, required this.onBackspace});

  final lignes = [
    ["1","2","3","4","5","6","7","8","9","0"],
    ["q","w","e","r","t","y","u","i","o","p"],
    ["a","s","d","f","g","h","j","k","l"],
    ["z","x","c","v","b","n","m"],
  ];

  Widget _key(String k, {Color? bg}) => Expanded(
    child: Padding(
      padding: EdgeInsets.all(2),
      child: SizedBox(
        height: 40,
        child: ElevatedButton(
          onPressed: () => onKeyTap(k),
          style: ElevatedButton.styleFrom(backgroundColor: bg ?? Colors.grey[200], padding: EdgeInsets.zero),
          child: Text(k, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    ),
  );

  Widget _row(List<String> keys, {double pad = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: pad),
    child: Row(children: keys.map((k) => _key(k)).toList()),
  );

  //SafeArea pèmèt mwen jere kontni klavye a

  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
        color: Colors.grey[400],
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _row(lignes[0]),
          _row(lignes[1]),
          _row(lignes[2], pad: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(children: [
              ...lignes[3].map((k) => _key(k)),
              Expanded(child: Padding(
                padding: EdgeInsets.all(2),
                child: SizedBox(height: 40, child: ElevatedButton(
                  onPressed: onBackspace,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], padding: EdgeInsets.zero),
                  child: Icon(Icons.backspace, color: Colors.black, size: 20),
                )),
              )),
            ]),
          ),


          Row(children: [
            _key("@"),
            Expanded(flex: 4, child: Padding(
              padding: EdgeInsets.all(2),
              child: SizedBox(height: 40, child: ElevatedButton(
                onPressed: () => onKeyTap(" "),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Text("Space", style: TextStyle(color: Colors.black)),
              )),
            )),
            _key("."),
          ]),
        ]),
      ),
    );
  }
}

Map<String, String> users = {
  "allen20@gmail.com": "00000000",
};

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showKeyboard = false;  
  TextEditingController? activeController;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Text(
                        "Koneksyon",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      readOnly: true, //mwen sou yon tel fizik, mwen anpeche klavye natif la affiche
                      onTap: () {
                        setState(() {
                          showKeyboard = true;
                          activeController = emailController;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Imèl",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                      ),
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return "Tanpri antre imèl ou";
                        }
                        if (!value.contains("@")){
                          return "Tanpri antre yon imèl valab";
                        }
                        return null;
                      },
                      
                    ),

                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      readOnly: true, 
                      onTap: () {
                        setState(() {
                          showKeyboard = true;
                          activeController = passwordController;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Modpas",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      ),
                      obscureText: true,
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return "Tanpri antre modpas ou";
                        }
                        if (value.length < 8){
                          return "Modpas dwe gen omwen 8 karaktè";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text("Konekte"),
                        onPressed: (){
                          if (_formKey.currentState!.validate()){
                            String email = emailController.text;
                            String password = passwordController.text;

                            if (users.containsKey(email) && users[email]== password){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                                );
                            } else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Imèl oswa modpas pa kòrèk")),
                              );
                            }
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 20),

                    TextButton(
                      child: Text("Ou pa gen kont? Enskri"),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                    )

                  ]
                )
              )
            ),
          ),
          // Clavier virtuel en bas
          if (showKeyboard)
            CustomVirtualKeyboard(
              onKeyTap: (key) {
                setState(() {
                  if (activeController != null) {
                    activeController!.text += key;
                  }
                });
              },
              onBackspace: () {
                setState(() {
                  if (activeController != null && activeController!.text.isNotEmpty) {
                    activeController!.text = activeController!.text
                        .substring(0, activeController!.text.length - 1);
                  }
                });
              },
            ),
        ],
      ),
    );
  }

}

class SignupPage extends StatefulWidget {

  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showKeyboard = false;
  TextEditingController? activeController;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rejwenn Dallbeat")),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kreye Kont ou",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          showKeyboard = true;
                          activeController = emailController;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Imèl",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Antre yon imèl";
                        if (!value.contains("@")) return "Antre yon imèl valab";
                        if (users.containsKey(value)) return "Imèl sa a deja egziste";
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          showKeyboard = true;
                          activeController = passwordController;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Modpas",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Antre yon modpas";
                        if (value.length < 8) return "Omwen 8 karaktè";
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: confirmPasswordController,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          showKeyboard = true;
                          activeController = confirmPasswordController;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Konfime Modpas",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.blue),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Konfime modpas ou";
                        if (value != passwordController.text) return "Modpas yo pa menm";
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              users[emailController.text] = passwordController.text;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Kont kreye! Tanpri konekte.")),
                            );

                            Timer(Duration(seconds: 1), () {
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: Text("Enskri"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Clavier virtuel en bas
          if (showKeyboard)
            CustomVirtualKeyboard(
              onKeyTap: (key) {
                setState(() {
                  if (activeController != null) {
                    activeController!.text += key;
                  }
                });
              },
              onBackspace: () {
                setState(() {
                  if (activeController != null && activeController!.text.isNotEmpty) {
                    activeController!.text = activeController!.text
                        .substring(0, activeController!.text.length - 1);
                  }
                });
              },
            ),
        ],
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dallbeat"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Byenveni sou Dallbeat !",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Ou konekte avèk siksè."),
          ],
        ),
      ),
    );
  }
}