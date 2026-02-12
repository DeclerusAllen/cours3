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
              "Allen Records",
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60), 
                Image.asset(
                  "assets/images/logo.png",
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 15),
                Text(
                  "Koneksyon",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25), 
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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

                SizedBox(height: 15), 
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
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

                SizedBox(height: 25), 
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

                SizedBox(height: 15), 

                TextButton(
                  child: Text("Ou pa gen kont? Enskri"),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                ),
                SizedBox(height: 40), 
              ]
            )
          )
        ),
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
      body: SingleChildScrollView( 
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40), 
                Text(
                  "Kreye Kont ou",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  keyboardType: TextInputType.text,
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
                  keyboardType: TextInputType.text,
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
                SizedBox(height: 40), 
              ],
            ),
          ),
        ),
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
        title: Text("Allen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Byenveni sou Allen Recors !",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Ou konekte avèk sisè."),
          ],
        ),
      ),
    );
  }
}