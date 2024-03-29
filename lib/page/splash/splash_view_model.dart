part of 'splash_view.dart';

abstract class _SplashViewModel extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkFirstLogin();
  }

  Future<void> _checkFirstLogin() async {
    await _setShared();
    _getData();
    bool isFirst = _isFirstLogin();
    if (isFirst) {
      _goToOnboarding();
    } else {
      _goToBase();
    }
  }

  bool _isFirstLogin() {
    return Provider.of<UserModel>(
      context,
      listen: false,
    ).isFirstLogin();
  }

  Future<void> _setShared() async {
    await Provider.of<UserModel>(
      context,
      listen: false,
    ).setShared();
  }

  void _getData() {
    Provider.of<UserModel>(
      context,
      listen: false,
    ).getSavedUser();
  }

  void _goToBase() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, anim, secondAnim) {
          return const BaseView();
        },
      ),
    );
  }

  void _goToOnboarding() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, anim, secondAnim) {
          return const OnboardingBaseView();
        },
      ),
    );
  }
}
