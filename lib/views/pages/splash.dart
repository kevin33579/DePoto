part of 'pages.dart';

class Splash extends StatefulWidget {
  static const String routeName = "/splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  _loadSplash() async {
    var _duration = Duration(seconds: 1);
    return Timer(_duration, checkAuth);
  }

  void checkAuth() async {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return MainMenu(); // Replace 'MainMenu' with the actual name of your destination view.
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          var opacityTween = Tween(begin: begin, end: end);
          var opacityAnimation = animation.drive(opacityTween);
          return FadeTransition(
            opacity: opacityAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xfffff4f4),
        child: Image.asset("assets/images/LogoO.png", height: 100));
  }
}
