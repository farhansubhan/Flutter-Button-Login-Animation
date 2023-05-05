import 'package:flutter/material.dart';
import 'package:login/widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  bool passVis = false;

  late AnimationController btnController;
  late Animation btnAnimation;

  @override
  void initState() {
    super.initState();

    btnController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    btnAnimation = Tween(
      begin: 350.0,
      end: 140.0,
    ).animate(
      CurvedAnimation(
        parent: btnController,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  @override
  void dispose() {
    userCon.dispose();
    passCon.dispose();
    btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              sbh(100),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sbh(20),
              widUsername(),
              sbh(20),
              widPassword(),
              sbh(20),
              btnPrim(),
            ],
          ),
        ),
      ),
    );
  }

  void changeVis() {
    setState(() {
      passVis = !passVis;
    });
  }

  Widget widUsername() {
    return formLogin(
      controller: userCon,
      prefixIcon: const Icon(Icons.person),
      hint: "Username",
      validator: (value) {
        if(value!.isEmpty) {
          return "Username is Required";
        } else {
          return null;
        }
      },
    );
  }

  Widget widPassword() {
    return formLogin(
      controller: passCon,
      suffixIcon: IconButton(
        icon: Icon(passVis ? Icons.visibility_off : Icons.visibility),
        onPressed: () => changeVis(),
      ),
      hint: "Password",
      obscureText: !passVis,
      validator: (value) {
        if(value!.isEmpty) {
          return "Password is Required";
        } else {
          return null;
        }
      },
    );
  }

  Widget btnPrim() {
    return AnimatedBuilder(
      animation: btnController,
      builder: (BuildContext context, Widget? child) {
        return InkWell(
          onTap: () {
            _playAnimation();
          },
          child: Center(
            child: Container(
              width: btnAnimation.value,
              height: 50.0,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: (btnAnimation.value > 145.0)
                  ? const BorderRadius.all(Radius.circular(10.0))
                  : const BorderRadius.all(Radius.circular(30.0)),
              ),
              child: btnAnimation.value > 145.0
              ? const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: const [
                    CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _playAnimation() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if(!btnController.isAnimating) {
      await btnController.forward();
      await btnController.reverse();
    }
  }
}