public class Enemy implements Common {
  PImage img;

  private int No;
  private int lv;
  private int hp;
  private int speed;
  private int diffence;
  private int attack;
  private String name;

  //コンストラクタ
  public Enemy(int lv, int No) {
    this.No=No;
    this.lv=lv;
    hp=int(0.70*lv*lv+1.5*lv+25.3);
    speed=int(lv*lv/4+15);
    diffence=int((0.25*lv*lv+1.2*lv+10.35)/20);
    attack=int((0.85*lv*lv+1.5*lv+32.07)/9);
    loadImages();
  }

  //equalsメソッドオーバーライド
  public boolean equals(Object o) {
    if (o==this) return true;
    if (o==null) return false;    
    if (o instanceof Enemy) return false;

    return true;
  }

  //敵描画関数
  public void drawEnemy(int x, int y) {
    image(img, x-50, y, 100, 100);
    fill(0);
    textSize(15);
    textAlign(CENTER);
    text(name, x, y);
    text("Lv:"+lv+" HP:"+hp, x, y+15);
  }

  private void loadImages() {
    img=new PImage();
    img=loadImage("./data/Image/enemy.png");
    img=img.get((No-1)*200, 0, 200, 200);
    switch(No) {
    case 1:
      name = "SRIME";
      break;
    case 2:
      name = "GOBLIN";
      break;
    case 3:
      name = "BAT";
      break;
    }
  }

  /* getter と　setter の実装（processingだと意味ない？）*/

  public void setNo(int no) {
    this.No=no;
  }

  public int getNo() {
    return this.No;
  }

  public void setHp(int hp) {
    this.hp=hp;
  }

  public int getHp() {
    return this.hp;
  }

  public void setSpeed(int speed) {
    this.speed=speed;
  }

  public int getSpeed() {
    return this.speed;
  }

  public void setLv(int lv) {
    this.lv=lv;
  }

  public int getLv() {
    return this.lv;
  }

  public void setDiffence(int diffence) {
    this.diffence=diffence;
  }

  public int getDiffence() {
    return this.diffence;
  }

  public void setAttack(int attack) {
    this.attack=attack;
  }

  public int getAttack() {
    return this.attack;
  }

  public void setMyName(String name) {
    this.name=name;
  }

  public String getMyName() {
    return this.name;
  }
}