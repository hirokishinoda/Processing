public static final int WIDTH = 480;
public static final int HEIGHT = 480;

public static final int MDOWN = 0;
public static final int MLEFT = 1;
public static final int MRIGHT = 2;
public static final int MUP = 3;

public static final int TITLE = 0;
public static final int WMAP = 1;
public static final int MENU = 2;

private ActionKey leftKey;
private ActionKey rightKey;
private ActionKey upKey;
private ActionKey downKey;

private Map wmap;
private Chara hero;
private ScreenState state;

void setup() {
  size(480, 480);
  background(0);
  leftKey = new ActionKey();
  rightKey = new ActionKey();
  upKey = new ActionKey();
  downKey = new ActionKey();

  wmap = new Map("/Users/拓樹/Documents/Processing/SRPG/Main/date/WorldMapBase.txt", "/Users/拓樹/Documents/Processing/SRPG/Main/date/chara.txt");
  hero = new Chara(6, 6, 0, MDOWN, 100, wmap);
  wmap.addChara(hero);

  state = new Title();
}

void draw() {
  state = state.isScreen();
}

void keyPressed() {
  if (state.isScreenNo()==WMAP) {
    if (keyCode == RIGHT) {
      rightKey.press();
    }
    if (keyCode == LEFT) {
      leftKey.press();
    }
    if (keyCode == UP) {
      upKey.press();
    }
    if (keyCode == DOWN) {
      downKey.press();
    }
  }
}

void keyReleased() {
  if (state.isScreenNo()==WMAP) {
    if (keyCode == LEFT) {
      leftKey.release();
    }
    if (keyCode == RIGHT) {
      rightKey.release();
    }
    if (keyCode == UP) {
      upKey.release();
    }
    if (keyCode == DOWN) {
      downKey.release();
    }
  }
}

private void checkInput() {
  if (leftKey.isPressed()) {
    if (!hero.isMoving()) {
      hero.setDirection(MLEFT);
      hero.setMoving(true);
    }
  }
  if (rightKey.isPressed()) {
    if (!hero.isMoving()) {
      hero.setDirection(MRIGHT);
      hero.setMoving(true);
    }
  }
  if (upKey.isPressed()) {
    if (!hero.isMoving()) {
      hero.setDirection(MUP);
      hero.setMoving(true);
    }
  }
  if (downKey.isPressed()) {
    if (!hero.isMoving()) {
      hero.setDirection(MDOWN);
      hero.setMoving(true);
    }
  }
}