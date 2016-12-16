abstract class ScreenState {
  ScreenState() {
  }

  ScreenState isScreen() {
    displayScreen();
    return decideScreen();
  }

  abstract void displayScreen();
  abstract ScreenState decideScreen();
  abstract int isScreenNo();
}