import java.util.Random;

class Title extends ScreenState implements Common {
  void displayScreen() {
    textSize(64);
    textAlign(CENTER);
    text("RPG", width/2, height/3);
    textSize(24);
    text("press space key!", width/2, height/3*2);
  }

  ScreenState decideScreen() {
    if (keyPressed && key == ' ') {
      return new GameWmap();
    }
    return this;
  }

  int isScreenNo() {
    return TITLE;
  }
}

class GameWmap extends ScreenState implements Common {

  private Random rand = new Random();

  void displayScreen() {
    int offsetX = WIDTH / 2 - hero.getPx();
    offsetX = Math.min(offsetX, 0);
    offsetX = Math.max(offsetX, WIDTH - wmap.getWidth());
    int offsetY = HEIGHT / 2 - hero.getPy();
    offsetY = Math.min(offsetY, 0);
    offsetY = Math.max(offsetY, HEIGHT - wmap.getHeight());

    checkInput();

    playerMove();
    charaMove();

    wmap.MapDraw(offsetX, offsetY);
  }

  void playerMove() {
    if (hero.isMoving()) {
      if (hero.move()) {
      }
    }
  }

  void charaMove() {
    Vector charas = wmap.getCharas();
    for (int i=0; i<charas.size(); i++) {
      Chara chara = (Chara)charas.get(i);
      if (chara.getMoveType() == 1) {
        if (chara.isMoving()) { 
          chara.move();
        } else if (rand.nextDouble() < Chara.PROB_MOVE) {
          chara.setDirection(rand.nextInt(4));
          chara.setMoving(true);
        }
      }
    }
  }

  ScreenState decideScreen() {
    if (key == 'q') {
      return new Menu();
    }
    return this;
  }

  int isScreenNo() {
    return WMAP;
  }
}

class Menu extends ScreenState implements Common {
  private static final int startX = 15;  
  private static final int startY = 15;
  private String menu[] = new String [2];

  void displayScreen() {
    menu[0]="ITEM";
    menu[1]="STATE";
    MenuWindow(startX, startY, width/3, height-100, 2, menu);
  }

  void MenuWindow(int x, int y, int Width, int Height, int roop, String str[]) {
    fill(0);
    stroke(255);
    strokeWeight(2);
    strokeJoin(ROUND);
    rect(x, y, Width, Height);

    fill(255);
    textSize(25);
    textAlign(CENTER);
    for (int i=0; i<roop; i++) {
      text(str[i], x+70, y+(i+1)*25+10);
    }
  }

  ScreenState decideScreen() {
    if (keyPressed && key == 'z') {
      return new GameWmap();
    }
    return this;
  }

  int isScreenNo() {
    return MENU;
  }
}