//画面遷移用　抽象クラス
abstract class ScreenState {

  //コンストラクタ
  ScreenState() {
  }

  ScreenState isScreen() {
    displayScreen();
    return decideScreen();
  }

  abstract void displayScreen();
  abstract ScreenState decideScreen();
}