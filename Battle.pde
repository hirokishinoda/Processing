public class Battle implements Common {
  private static final int ATTACK = 1;

  private int number;
  private int state;
  private int total_enemy_lv;
  private int total_enemy_num;

  private ArrayList<Enemy> enemys = new ArrayList<Enemy>();
  private Window talk; 
  private PImage backImage;

  //コンストラクタ
  public Battle() {
    backImage=new PImage();
    backImage=loadImage("./data/Image/kougen_back.jpg");
    number=0;
    enemyInfoSet();
    talk=new Window(number);
  }

  //敵のステータス決定
  public void enemyInfoSet() {
    int No;
    int lv;

    if (map.placeLv(hero.getPx()/CS, hero.getPy()/CS) == 3) {
      number = int(random(1)+1);
    } else {
      number = int(random(3)+1);
    }
    total_enemy_num = number;

    for (int i = 0; i<number; i++) {
      No = int(random(3)+1);
      lv = int(random(map.placeLv(hero.getPx()/CS, hero.getPy()/CS))+1);
      total_enemy_lv += lv;
      Enemy enemy = new Enemy(lv, No);
      enemys.add(enemy);
    }
  }

  //戦闘画面描画
  public void drawBattle(String menu[], int point, int select) {
    image(backImage, 0, 0, width, height);
    for (int i=0; i<number; i++) {
      Enemy enemy = (Enemy) enemys.get(i);
      enemy.drawEnemy((width/(number+1)*(i+1)), 100);
    }

    battleWindow();
    for (int i=0; i<menu.length; i++) {
      text(menu[i], 50, height/3*2+90+(i*15));
    }
    talk.displaySentence(255, 15, (width-20)/5*2+20, height/3*2+30);

    noStroke();
    ellipse(40, height/3*2+85+(point*15), 10, 10);

    if (this.state==ATTACK) {
      ellipse((width/(number+1)*(select+1)), 80, 10, 10);
    }
  }

  //戦闘画面ウィンドウ表示
  private void battleWindow() {
    talk.displayWindow(10, height/3*2, width-20, height/3-10);
    line((width-20)/5*2, height/3*2, (width-20)/5*2, height/3*2+(height/3-10));
    textSize(15);
    fill(255);
    textAlign(LEFT);
    text(hero.getMyName(), 50, height/3*2+30);
    text("LV:"+hero.getLv(), 50, height/3*2+45);
    text("HP:"+hero.getHp(), 50, height/3*2+60);
  }

  //プレイヤー攻撃関数
  public void playerAttack(int select) {
    if (!enemys.isEmpty()) {
      //敵選択
      Enemy enemy = (Enemy) enemys.get(select);  
      //ダメージ計算
      int damage = int(random(hero.getAttack()))-int(random(enemy.getDiffence()));  
      if (damage<0) {
        damage=0;
      }
      enemy.setHp(enemy.getHp()-damage);
      talk.addSentence(enemy.getMyName()+" was "+damage+" damaged");
      //敵の体力が０以下だったら敵削除
      if (enemy.getHp()<=0) {
        enemys.remove(select);
        number--;
      }
      //敵がいるか調べる
      if (enemys.isEmpty()) {
        hero.lvUp(hero.needExp(total_enemy_lv/total_enemy_num));
        talk.addSentence(hero.getMyName()+" Victory!");
        close=true;
      }
    }
  }

  //プレイヤー逃げる処理
  public void playerEscape() {
    int select = int(random(number));
    Enemy enemy = (Enemy) enemys.get(select);

    if (random(hero.getSpeed())>random(enemy.getSpeed())) {
      talk.addSentence(hero.getMyName()+" escape!");
      close=true;
    } else {
      talk.clearSentence();
      talk.addSentence(hero.getMyName()+" can't escape!");
    }
  }

  //敵攻撃関数
  public void enemyAttack(Enemy enemy) {
    int damage = int(random(enemy.getAttack()))-int(random(hero.getDiffence()));
    if (damage<0) {
      damage=0;
    }
    talk.addSentence(hero.getMyName()+" was "+damage+" damaged");
    hero.setHp(hero.getHp()-damage);
    if (hero.getHp()<=0) {
      open=true;
    }
  }

  //攻撃順序決定関数
  public void attackOrder(int select) {
    ArrayList <Enemy> enemy = new ArrayList<Enemy>();

    enemy.add((Enemy) enemys.get(0));

    if (number>=2) {
      Enemy stead = (Enemy) enemys.get(1);
      if (enemy.get(0).getSpeed()<stead.getSpeed()) {
        enemy.add(0, stead);
      } else {
        enemy.add(stead);
      }
    }

    if (number==3) {
      Enemy stead = (Enemy) enemys.get(2);
      if (enemy.get(0).getSpeed()<stead.getSpeed()) {
        enemy.add(0, stead);
      } else if (enemy.get(1).getSpeed()<stead.getSpeed()) {
        enemy.add(1, stead);
      } else {
        enemy.add(stead);
      }
    }

    boolean attackflag = false;
    for (int i=0; i<enemy.size(); i++) {
      if (enemy.get(i).getSpeed()<hero.getSpeed() && !attackflag) {
        attackflag=true;
        playerAttack(select);
        enemyAttack(enemy.get(i));
      } else {
        enemyAttack(enemy.get(i));
      }
    }

    if (!attackflag) {
      playerAttack(select);
    }
  }

  /* getter と　setter の実装（processingだと意味ない？）*/

  public int getEnemyNum() {
    return number;
  }

  public void setState(int state) {
    this.state = state;
  }
}