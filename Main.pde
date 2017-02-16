//import宣言
import java.io.*;
import java.util.*;
import java.applet.*;

//グローバル変数（整理したい。。。）
public static final int WIDTH = 480;
public static final int HEIGHT = 480;

public static final int MDOWN = 0;
public static final int MLEFT = 1;
public static final int MRIGHT = 2;
public static final int MUP = 3;

ActionKey leftKey;
ActionKey rightKey;
ActionKey upKey;
ActionKey downKey;
boolean up;
boolean down;
boolean left;
boolean right;
boolean close;
boolean open;
boolean input;
boolean delete;

Map map;
Map wmap;
Map tmap;

Hero hero;
ScreenState state;
Battle battle;

//準備（最初に一度だけ呼び出される）
void setup() {
  size(512, 512);
  background(0);

  leftKey = new ActionKey();
  rightKey = new ActionKey();
  upKey = new ActionKey();
  downKey = new ActionKey();
  wmap = new Map("Text/WorldMap", "Text/chara.txt");
  tmap = new Map("Text/WorldMap", "Text/chara.txt");
  map = wmap;
  hero = new Hero(55, 185, 0, MDOWN, 100, map, 3);
  state = new Title();
}

void draw() {
  state = state.isScreen();
}

//ｋｅｙが押された時一度だけ呼ばれる
void keyPressed() {
  if (state instanceof GameWmap) {
    if (keyCode == RIGHT) {
      rightKey.press();
      checkEnemy();
    }
    if (keyCode == LEFT) {
      leftKey.press();
      checkEnemy();
    }
    if (keyCode == UP) {
      upKey.press();
      checkEnemy();
    }
    if (keyCode == DOWN) {
      downKey.press();
      checkEnemy();
    }
    if (key == 'q') {
      open=checkKey(open);
    }
  } else {
    if (keyCode == UP) {
      up=checkKey(up);
    }
    if (keyCode == DOWN) {
      down=checkKey(down);
    }
    if (keyCode == LEFT) {
      left=checkKey(left);
    }
    if (keyCode == RIGHT) {
      right=checkKey(right);
    }
    if (state instanceof Menu || state instanceof GameBattle) {
      if (keyCode == ENTER) {
        open=checkKey(open);
      }
    } else if (state instanceof Title || state instanceof GameOver || state instanceof DesideName) {
      if (key == ' ') {
        open=checkKey(open);
      }
      if (state instanceof DesideName) {
        if (key == BACKSPACE) {
          delete=checkKey(delete);
        } else {
          input=checkKey(input);
        }
      }
    } else {
      if (key == 'q') {
        open=checkKey(open);
      }
    }
  }
}

//ｋｅｙが放された時呼ばれる
void keyReleased() {
  if (keyCode == LEFT) {
    leftKey.release();
    left=false;
  }
  if (keyCode == RIGHT) {
    rightKey.release();
    right=false;
  }
  if (keyCode == UP) {
    upKey.release();
    up=false;
  }
  if (keyCode == DOWN) {
    downKey.release();
    down=false;
  }
  if (keyCode == ENTER) {
    open=false;
  }
  if (key == 'q') {
    open=false;
  }
  if (key == ' ') {
    open=false;
  }
  if (state instanceof DesideName) {
    input=false;
  }
}

//敵がいるかの確認
void checkEnemy() {
  if (map.isEnemy()) {
    state = new GameBattle();
  }
}

boolean checkKey(boolean check) {
  if (!check) {
    return true;
  } 
  return false;
}

void whichMap(int mapNo) {
  mapNo=0;
  if (mapNo==1) {
    map=tmap;
    hero = new Hero(1, 1, 0, MDOWN, 100, map);
  } else {
    map=wmap;
  }
}

void debug() {
  println(frameRate);
}

void saveScreenImage() {
  String path  = "./data/Image/beforeImage.jpg";
  save(path);
}