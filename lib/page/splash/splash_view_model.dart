part of 'splash_view.dart';

abstract class _SplashViewModel extends State<SplashView> {
  late final SharedManager _sharedManager;
  User? user;

  @override
  void initState() {
    super.initState();

    _checkFirstLogin();
  }

  Future<void> _checkFirstLogin() async {
    await _setShared();
    _getData();
    _goToBase();
  }

  void _goToBase() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, anim, secondAnim) => BaseView(
        user: user ??
            User(
              name: BaseString.username,
              balance: BaseSize.none,
              monthlyIncome: BaseSize.none,
              monthlyExpense: BaseSize.none,
              accounts: [
                Account(
                  name: BaseString.cash,
                  balance: BaseSize.none,
                  monthlyIncome: BaseSize.none,
                  monthlyExpense: BaseSize.none,
                  color: colorToString(BaseColor.colors.first),
                ),
              ],
              categories: [
                Category(
                  name: BaseString.general,
                ),
              ],
              changes: [],
            ),
        sharedManager: _sharedManager,
      ),
    ));
  }

  Future<void> _setShared() async {
    _sharedManager = SharedManager();
    await _sharedManager.init();
  }

  void _getData() {
    final data = _sharedManager.getString(SharedEnum.save);
    if (data != null) {
      user = User.fromJson(json.decode(data));
    }
  }
}
