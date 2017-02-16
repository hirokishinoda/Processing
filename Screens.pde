//タイトル画面
class Title extends ScreenState implements Common {
  private PImage title;
  private PImage back;

  public Title() {
    title = new PImage();
    back = new PImage();
    title = loadImage("./data/Image/Title.png");
    back = loadImage("./data/Image/Title_back.jpg");
  }

  void displayScreen() {
    background(0);
    image(back, 0, 0, width, height);
    image(title, 0, 0, width, height);
  }

  ScreenState decideScreen() {
    if (open) {
      open=false;
      return new DesideName();
    }
    return this;
  }
}

//名前決定画面
class DesideName extends ScreenState {
  Window window;
  String name;

  public DesideName() {
    window=new Window();
    window.addSentence("What's your Name?");
    name="";
  }

  void displayScreen() {
    background(0);
    textAlign(CENTER);
    window.displaySentence(255, 35, width/2, height*3/5-35);
    fill(0);
    stroke(255);
    rect(width/3, height*3/5, width/3, 30);
    fill(255); 
    textSize(25);
    textAlign(LEFT);
    text(name, width/3, height*3/5+25);

    if (input && !open) {
      input=false;
      if (name.length()<10 && key!=ENTER) {
        name+=key;
      }
    }
    if (delete) {
      delete=false;
      if (name.length()>0) {
        name = name.substring(0, name.length()-1);
      }
    }
    textAlign(CENTER);
    text("[press space key]", width/2, height/3*2+30);
  }

  ScreenState decideScreen() {
    if (open) {
      open=false;
      if (name=="" || name.length()<=0) {
        name="TAROU";
      }
      hero.setMyName(name);
      hero.writeData();
      hero.readData();
      return new GameWmap();
    }
    return this;
  }
}

//ゲームオーバー画面
class GameOver extends ScreenState implements Common {
  public GameOver() {
  }

  void displayScreen() {
    background(0);
    textSize(64);
    textAlign(CENTER);
    text("GAME OVER...", width/2, height/3);
    textSize(24);
    text("You died.", width/2, height/3*2);
    text("PRESS [SPACE].", width/2, height/3*2+25);
  }

  ScreenState decideScreen() {
    if (open) {
      open=false;
      exit();
    }
    return this;
  }
}

//ワールドマップ画面
class GameWmap extends ScreenState implements Common {

  void displayScreen() {
    int offsetX = WIDTH / 2 - hero.getPx();
    offsetX = Math.min(offsetX, 0);
    offsetX = Math.max(offsetX, WIDTH - wmap.getWidth());
    int offsetY = HEIGHT / 2 - hero.getPy();
    offsetY = Math.min(offsetY, 0);
    offsetY = Math.max(offsetY, HEIGHT - wmap.getHeight());

    checkInput();

    playerMove();

    map.MapDraw(offsetX, offsetY);
  }

  void playerMove() {
    if (hero.isMoving()) {
      if (hero.move()) {
        if (hero.getWalkCount() > 75) {
          hero.setWalkCount(75);
        } else {
          hero.setWalkCount(hero.getWalkCount()+1);
        }
        mapEvent();
      }
    }
  }

  ScreenState decideScreen() {
    if (open) {
      open=false;
      stopTime(0.50);
      saveScreenImage();
      stopTime(0.50);
      return new Menu();
    }
    return this;
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

  private void mapEvent() {
    if (hero.getPx()/CS == 10 && hero.getPy()/CS == 10) {
      whichMap(1);
    }
  }

  private void stopTime(double time) {
    long start = System.currentTimeMillis();
    long end = start;
    while ((end-start)<=time) {
      end = System.currentTimeMillis();
    }
  }
}

//メニュー画面
class Menu extends ScreenState implements Common {
  private int startX;  
  private int startY;
  private int Width;
  private int Height;
  private int point;
  private String[] menu=new String [4];
  private Window window;

  public Menu() {
    window = new Window(menu.length);
    this.startX=15;
    this.startY=15;
    this.Width=width/3;
    this.Height=height-50;
    point = 0;
    menu[0]="ITEM";
    menu[1]="STATE";
    menu[2]="MAP";
    menu[3]="EXIT";
    for (int i=0; i<menu.length; i++) {
      window.addSentence(menu[i]);
    }
  }

  void displayScreen() {
    MenuWindow();
  }

  private void MenuWindow() {
    window.displayWindow(startX, startY, Width, Height);
    textAlign(CENTER);
    window.displaySentence(255, 25, startX+70, startY+35);

    if (up && point>0) {
      point--;
      up=false;
    }
    if (down && point<menu.length-1) {
      point++;
      down=false;
    }
    noStroke();
    ellipse(startX+10, startY+(point+1)*25, 10, 10);
  }

  ScreenState decideScreen() {
    if (open) {
      open=false;
      switch(point) {
      case 0:
        return new Items();
      case 1:
        return new Status();
      case 2:
        return new OverallMap();
      case 3:
        return new GameWmap();
      }
    }
    return this;
  }
}

//バトル画面
class GameBattle extends ScreenState implements Common {
  private static final int NON = 0;
  private static final int ATTACK = 1;
  private static final int ESCAPE = 2;
  private static final int ITEM = 3;

  private int point;
  private int enemy;
  private String[] menu=new String[3];
  private int mode;

  public GameBattle() {
    battle = new Battle();
    hero.setWalkCount(0);
    point = 0;
    enemy = 0;
    menu[0]="ATTACK";
    menu[1]="ESCAPE";
    menu[2]="ITEM";
    mode=NON;
  }

  void displayScreen() {
    background(0);
    battle.drawBattle(menu, point, enemy);

    if (mode == ATTACK) {
      if (left && enemy>0) {
        enemy--;
        left=false;
      }
      if (right && enemy<battle.getEnemyNum()-1) {
        enemy++;
        right=false;
      }
      if (open) {
        open=false;
        mode = NON;
        battle.setState(NON);
        battle.attackOrder(enemy);
        enemy=0;
      }
    } else if (mode==ESCAPE) {
      battle.playerEscape();
      battle.setState(NON);
      mode=NON;
    } else {
      if (up && point>0) {
        point--;
        up=false;
      }
      if (down && point<menu.length-1) {
        point++;
        down=false;
      }
      if (open) {
        open=false;
        if (point==0) {
          mode=ATTACK;
          battle.setState(ATTACK);
        } else if (point==1) {
          mode=ESCAPE;
          battle.setState(ESCAPE);
        } else if (point==1) {
          mode=ITEM;
          battle.setState(ITEM);
        }
      }
    }
  }

  ScreenState decideScreen() {
    if (close) {
      close=false;
      return new GameWmap();
    }
    if (open) {
      open=false;
      return new GameOver();
    }
    return this;
  }
}

//ステータス画面
class Status extends ScreenState implements Common {
  private Window window;
  private PImage backImage;

  public Status() {
    window = new Window();
    backImage = new PImage();
    backImage = loadImage("./data/Image/beforeImage.jpg");
    window.addSentence("LV:"+hero.getLv());
    window.addSentence("EX:"+hero.getExp()+"(need:"+(hero.needExp(hero.getLv())-hero.getExp())+")");
    window.addSentence("HP:"+hero.getHp());
    window.addSentence("SPD:"+hero.getSpeed());
    window.addSentence("ATK:"+hero.getAttack());
    window.addSentence("DEF:"+hero.getDiffence());
  }

  void displayScreen() {
    image(backImage, 0, 0, width, height);
    window.displayWindow(5, 5, width-20, height-20);
    line(5, height/3, width-10, height/3);
    textSize(20);
    fill(255);
    text("NAME:"+hero.getMyName(), 60, 35);
    hero.Image(75, 40);
    textAlign(LEFT);
    window.displaySentence(255, 20, width/2, 40);
    text("SKILL", 20, height/3+45);
  }

  ScreenState decideScreen() {
    if (open) {
      open=false;
      return new GameWmap();
    }
    return this;
  }
}

//アイテム一覧画面
class Items extends ScreenState implements Common {
  Window window;
  private PImage backImage;

  public Items() {
    window=new Window();
    backImage = new PImage();
    backImage = loadImage("./data/Image/beforeImage.jpg");
    for (int i=0; i<hero.items.size(); i++) {
      Item item = hero.items.get(i);
      window.addSentence(item.getMyName()+" *"+item.getNum());
    }
  }

  void displayScreen() {
    image(backImage, 0, 0, width, height);
    window.displayWindow(10, 10, width-20, height-20);
    fill(0, 0, 255);
    textSize(35);
    text("ITEM", 25, 45);
    line(10, 50, width-10, 50);
    textAlign(LEFT);
    window.displaySentence(255, 25, 25, 80);
  }

  ScreenState decideScreen() {
    if (open) {
      open=false;
      return new GameWmap();
    }
    return this;
  }
}

//全体地図表示画面
class OverallMap extends ScreenState {
  public OverallMap() {
    changeWindowSize(1000, 1000);
  }

  void displayScreen() {
    map.MapDrawAll();
  }

  ScreenState decideScreen() {
    if (open) {
      open=false;
      changeWindowSize(480, 480);
      return new GameWmap();
    }
    return this;
  }

  void changeWindowSize(int w, int h) {
    frame.setSize( w + frame.getInsets().left + frame.getInsets().right, h + frame.getInsets().top + frame.getInsets().bottom );
    size(w, h);
  }
}