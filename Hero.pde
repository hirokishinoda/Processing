public class Hero extends Chara implements Common {

  private int lv;
  private int exp;
  private int lastexp;
  private int hp;
  private int speed;
  private int attack;
  private int diffence;
  private String name;
  private PImage playerImage;
  public ArrayList<Item> items;

  //コンストラクタ
  public Hero(int x, int y, int charaNo, int direction, int moveType, Map map) {
    super(x, y, charaNo, direction, moveType, map);
    playerImage = new PImage();
    items = new ArrayList<Item>();
    readData();
  }

  public Hero(int x, int y, int charaNo, int direction, int moveType, Map map, int firstLv) {
    super(x, y, charaNo, direction, moveType, map);
    playerImage = new PImage();
    items = new ArrayList<Item>();
    this.lv=firstLv;
    this.exp=0;
    this.lastexp=0;
    calcStatus();
  }

  //プレイヤー歩行アニメーション
  public void Image(int x, int y) {
    playerImage=super.img.get(super.count*CS, 0, CS, CS);
    image(playerImage, x, y, CS*3, CS*3);
  }

  //マップ全体表示時のプレイヤー位置表示
  public void MiniMapPoint() {
    fill(255, 0, 0);
    rect(px/CS*5+5, py/CS*5+5, 5, 5);
  }

  //アイテム追加関数
  public void addItem(String name, int num) {
    boolean flag=true;
    for (int i=0; i<items.size(); i++) {
      Item item = items.get(i);
      if (item.getMyName()==name) {
        item.setNum(item.getNum()+1);
        flag=false;
        break;
      }
    }
    if (flag) {
      items.add(new Item(name, num));
    }
  }

  //キャラクターのステータス設定関数
  private void calcStatus() {
    hp=int(0.85*lv*lv+1.5*lv+32.07);
    speed=int(lv*lv/4+15);
    attack=int((0.7*lv*lv+1.5*lv+25.3)/5);
    diffence=int((0.25*lv*lv+1.2*lv+10.35)/8);
  }

  //レベルＵＰ計算
  public void lvUp(int ex) {
    int expmax;

    if (lv==1) {
      expmax=10;
    } else {
      expmax=needExp(lv);
    }

    exp+=ex;
    if (lv<99) {
      while (exp>=expmax) {
        if (lv+1>=99) {
          exp=0;
          lv=99;
          break;
        }
        exp-=expmax;
        lv++;
        lastexp=expmax;
      }
    } else {
      exp=0;
    }

    calcStatus();
  }

  public int needExp(int a) {
    int val = int(lastexp*1.1+a*15)/2;
    return val;
  }

  //データ書き込み
  private void writeData() {
    try {
      String pass =dataPath("Text/PlayerData.txt");
      File file = new File(pass);

      PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter(file)));

      pw.print(this.lv+",");
      pw.print(this.exp+",");
      pw.print(this.lastexp+",");
      pw.print(this.hp+",");
      pw.print(this.speed+",");
      pw.print(this.attack+",");
      pw.print(this.diffence+",");
      pw.print(this.name);
      
      pw.close();
    }
    catch(IOException e) {
      System.out.println(e);
    }
  }

  //データ読み込み
  private void readData() {
    try {
      String str;

      String pass =dataPath("Text/PlayerData.txt");
      File file = new File(pass);
      BufferedReader br = new BufferedReader(new FileReader(file));

      while ((str = br.readLine()) != null) {
        String str_array[] = str.split(",", 0);

        this.lv = Integer.valueOf(str_array[0]);
        this.exp = Integer.valueOf(str_array[1]);
        this.lastexp = Integer.valueOf(str_array[2]);
        this.hp = Integer.valueOf(str_array[3]);
        this.speed = Integer.valueOf(str_array[4]);
        this.attack = Integer.valueOf(str_array[5]);
        this.diffence = Integer.valueOf(str_array[6]);
        this.name = str_array[7];
      }
      br.close();
    } 
    catch (NumberFormatException e) {
      System.out.println(e);
    } 
    catch (FileNotFoundException e) {
      System.out.println(e);
    } 
    catch (IOException e) {
      System.out.println(e);
    }
  }

  /* getter と　setter の実装（processingだと意味ない？）*/

  public void setHp(int hp) {
    this.hp=hp;
  }

  public int getHp() {
    return this.hp;
  }

  public void setExp(int exp) {
    this.exp=exp;
  }

  public int getExp() {
    return this.exp;
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

  public void setAttack(int attack) {
    this.attack=attack;
  }

  public int getAttack() {
    return this.attack;
  }

  public void setDiffence(int diffence) {
    this.diffence=diffence;
  }

  public int getDiffence() {
    return this.diffence;
  }

  public void setMyName(String name) {
    this.name=name;
  }

  public String getMyName() {
    return this.name;
  }
}