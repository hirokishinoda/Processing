public class Map implements Common {

  private int[][] mapBase;
  private int[][] mapCollision;
  private int[][] mapObject;
  private int[][] lvArea;

  private ArrayList<Chara> charas = new ArrayList<Chara>();

  private int Width;
  private int Height;

  private int row;
  private int col;

  /*整理したいな。。。*/
  private PImage img;
  private PImage img2;
  private PImage img3;
  private PImage img4;
  private PImage grass;
  private PImage ground;
  private PImage sea;
  private PImage rightup_corner;
  private PImage leftup_corner;
  private PImage rightdown_corner;
  private PImage leftdown_corner;
  private PImage upbar;
  private PImage downbar;
  private PImage leftbar;
  private PImage rightbar;
  private PImage leftup_depression;
  private PImage leftdown_depression;
  private PImage rightup_depression;
  private PImage rightdown_depression;
  private PImage ground_rightup_corner;
  private PImage ground_leftup_corner;
  private PImage ground_rightdown_corner;
  private PImage ground_leftdown_corner;
  private PImage ground_upbar;
  private PImage ground_downbar;
  private PImage ground_leftbar;
  private PImage ground_rightbar;
  private PImage bridge_up;
  private PImage bridge_down;
  private PImage village;
  private PImage castle_leftup;
  private PImage castle_centerup;
  private PImage castle_rightup;
  private PImage castle_leftcenter;
  private PImage castle_center;
  private PImage castle_rightcenter;
  private PImage castle_leftdown;
  private PImage castle_centerdown;
  private PImage castle_rightdown;


  //コンストラクタ
  public Map(String mapfile, String eventname) {
    col=0;
    row=0;
    checkMapSize(mapfile + "/Base.txt");
    loadMaptxt(mapfile + "/Base.txt", mapBase);
    loadMaptxt(mapfile + "/Collision.txt", mapCollision);
    loadMaptxt(mapfile + "/Object.txt", mapObject);
    loadMaptxt(mapfile + "/LvArea.txt", lvArea);
    //loadEvent(eventname); /*ほかのキャラを配置する用。今回は使用しない*/
    loadImages();
  }

  //マップ表示
  public void MapDraw( int offsetX, int offsetY) {

    int firstTileX = pixelsToTiles(-offsetX);
    int lastTileX = firstTileX + pixelsToTiles(WIDTH) + 1;
    lastTileX = Math.min(lastTileX, row);

    int firstTileY = pixelsToTiles(-offsetY);
    int lastTileY = firstTileY + pixelsToTiles(HEIGHT) + 1;
    lastTileY = Math.min(lastTileY, col);

    for (int i = firstTileY; i < lastTileY; i++) {
      for (int j = firstTileX; j < lastTileX; j++) {
        switch (mapBase[i][j]) {
        case 1 : //草地面
          image( grass, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 19:  //土地面
          image( ground, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 53 : //海
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 247:  // 草右上崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( rightup_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 245:  // 草左上崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( leftup_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 261:  // 草左下崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( leftdown_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 263:  // 草右下崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( rightdown_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 253:  // 草左崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( leftbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 255:  // 草右崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( rightbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 246:  // 草上崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( upbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 262:  // 草下崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( downbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 249:  // 草左下窪み崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( leftdown_depression, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 257:  // 草左上窪み崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( leftup_depression, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 256:  // 草右下窪み崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( rightdown_depression, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 248:  // 草右上窪み崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( rightup_depression, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 205:  // 土左上崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( ground_leftup_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 221:  // 土左下崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( ground_leftdown_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 207:  // 土右上崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( ground_rightup_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 223:  // 土右下崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( ground_rightdown_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 213:  // 土左崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( ground_leftbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 206:  // 土上崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( ground_upbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 222:  // 土下崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( ground_downbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 215:  // 土左崖
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( ground_rightbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        }

        switch(mapObject[i][j]) {
        case 468:  //橋上半分
          image( bridge_up, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 469:  //橋下半分
          image( bridge_down, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 485:
          image( village, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 576:
          image( castle_leftup, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 577:
          image( castle_centerup, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 578:
          image( castle_rightup, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 584:
          image( castle_leftcenter, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 585:
          image( castle_center, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 586:
          image( castle_rightcenter, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 592:
          image( castle_leftdown, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 593:
          image( castle_centerdown, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 594:
          image( castle_rightdown, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        }
        //勇者描画
        hero.CharaDraw(offsetX, offsetY);
        //脇役キャラクター描画
        for (int n = 0; n < charas.size(); n++) {
          Chara chara = (Chara) charas.get(n);
          chara.CharaDraw(offsetX, offsetY);
        }
      }
    }
  }

  //マップ全体表示
  public void MapDrawAll() {
    background(255);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        switch (mapBase[i][j]) {
        case 1 : //草地面
          image( grass, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 19:  //土地面
          image( ground, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 53 : //海
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 247:  // 草右上崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( rightup_corner, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 245:  // 草左上崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( leftup_corner, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 261:  // 草左下崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( leftdown_corner, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 263:  // 草右下崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( rightdown_corner, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 253:  // 草左崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( leftbar, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 255:  // 草右崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( rightbar, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 246:  // 草上崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( upbar, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 262:  // 草下崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( downbar, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 249:  // 草左下窪み崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( leftdown_depression, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 257:  // 草左上窪み崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( leftup_depression, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 256:  // 草右下窪み崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( rightdown_depression, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 248:  // 草右上窪み崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( rightup_depression, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 205:  // 土左上崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( ground_leftup_corner, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 221:  // 土左下崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( ground_leftdown_corner, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 207:  // 土右上崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( ground_rightup_corner, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 223:  // 土右下崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( ground_rightdown_corner, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 213:  // 土左崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( ground_leftbar, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 206:  // 土上崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( ground_upbar, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 222:  // 土下崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( ground_downbar, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 215:  // 土左崖
          image( sea, j*5 + 5, i*5 + 5, 5, 5);
          image( ground_rightbar, j*5 + 5, i*5 + 5, 5, 5);
          break;
        }

        switch(mapObject[i][j]) {
        case 468:  //橋上半分
          image( bridge_up, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 469:  //橋下半分
          image( bridge_down, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 485:
          image( village, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 576:
          image( castle_leftup, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 577:
          image( castle_centerup, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 578:
          image( castle_rightup, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 584:
          image( castle_leftcenter, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 585:
          image( castle_center, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 586:
          image( castle_rightcenter, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 592:
          image( castle_leftdown, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 593:
          image( castle_centerdown, j*5 + 5, i*5 + 5, 5, 5);
          break;
        case 594:
          image( castle_rightdown, j*5 + 5, i*5 + 5, 5, 5);
          break;
        }
        hero.MiniMapPoint();
      }
    }
  }

  //ファイルからマップのサイズを読み込む
  private void checkMapSize(String fileName) {
    try {
      String str;
      String pass =dataPath(fileName);
      File file = new File(pass);
      BufferedReader br = new BufferedReader(new FileReader(file));

      while ((str = br.readLine()) != null) {
        String[] str2 = str.split(" ", 0);
        row = str2.length;
        col++;
      }
      br.close();

      mapBase = new int[col][row];
      mapCollision = new int[col][row];
      mapObject = new int[col][row];
      lvArea = new int[col][row];
      this.Width = row * CS;
      this.Height = col * CS;
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

  //マップ用のテキストファイル読み込み
  private void loadMaptxt(String fileName, int array[][]) {
    try {
      String str;
      int y = 0;
      int x = 0;

      String pass =dataPath(fileName);
      File file = new File(pass);
      BufferedReader br = new BufferedReader(new FileReader(file));

      while ((str = br.readLine()) != null) {

        String[] str2 = str.split(" ", 0);

        for (x = 0; x < row; x++) {
          array[y][x] = Integer.valueOf(str2[x]);
        }
        y++;
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

  //画像読み込み関数
  private void loadImages() {
    //画像ファイル読み込み
    img = new PImage();
    img2 = new PImage();
    img3 = new PImage();
    img4 = new PImage();
    img = loadImage("./data/Image/pipoya_mcset1_at_water4b.png");
    img2 =loadImage("./data/Image/pipoya_mcset1_base01.png");
    img3 = loadImage("./data/Image/pipoya_mcset1_bridge03.png");
    img4 = loadImage("./data/Image/201303250202169ec.png");

    rightdown_corner = new PImage();
    leftdown_corner = new PImage();
    leftup_corner = new PImage();
    rightup_corner = new PImage();

    leftup_depression = new PImage();
    leftdown_depression = new PImage();
    rightup_depression = new PImage();
    rightdown_depression = new PImage();

    ground_upbar = new PImage();
    ground_downbar = new PImage();
    ground_rightbar = new PImage();
    ground_leftbar = new PImage();

    upbar = new PImage();
    rightbar =new PImage();
    leftbar =new PImage();
    downbar =new PImage();

    ground_rightup_corner = new PImage();
    ground_leftup_corner = new PImage();
    ground_rightdown_corner = new PImage();
    ground_leftdown_corner = new PImage();

    bridge_up = new PImage();
    bridge_down = new PImage();
    village = new PImage();
    castle_leftup = new PImage();
    castle_centerup = new PImage();
    castle_rightup = new PImage();
    castle_leftcenter = new PImage();
    castle_center = new PImage();
    castle_rightcenter = new PImage();
    castle_leftdown = new PImage();
    castle_centerdown = new PImage();
    castle_rightdown = new PImage();

    //基本地形画像
    grass = new PImage();
    sea = new PImage();
    ground = new PImage();
    grass = img2.get( 0, 0, 32, 32);
    sea = img.get( 0, 128, 31, 31);
    ground = img2.get(160, 0, 31, 31);

    //上下左右「草地面」の角崖画像
    rightup_corner = img2.get(63, 736, 32, 32);
    leftup_corner = img2.get(0, 736, 32, 32);
    leftdown_corner = img2.get(0, 800, 32, 32);
    rightdown_corner = img2.get(63, 800, 32, 32);

    //上下左右「草地面」の崖画像
    upbar = img2.get(33, 736, 32, 32);
    downbar = img2.get(33, 800, 32, 32);
    leftbar = img2.get(0, 768, 32, 32);
    rightbar = img2.get(64, 768, 32, 32);

    //「草地面」の崖窪み画像
    leftup_depression = img2.get(127, 767, 32, 32);
    leftdown_depression = img2.get(127, 736, 32, 32);
    rightup_depression = img2.get(96, 736, 32, 32);
    rightdown_depression = img2.get(96, 767, 32, 32);

    //「土地面の」角崖画像
    ground_rightup_corner = img2.get(63, 576, 32, 32);
    ground_rightdown_corner = img2.get(63, 640, 31, 31);
    ground_leftup_corner = img2.get(0, 576, 32, 32);
    ground_leftdown_corner = img2.get(0, 640, 31, 31);

    //「土地面の」崖画像
    ground_upbar = img2.get(32, 576, 31, 31);
    ground_downbar = img2.get(32, 640, 31, 31);
    ground_leftbar = img2.get(0, 608, 31, 31);
    ground_rightbar = img2.get(64, 608, 31, 31);

    //マップ上の配置物の画像

    //橋画像
    bridge_up = img3.get(171, 21, 73, 51);
    bridge_down = img3.get(171, 72, 73, 52);
    //村画像
    village = img4.get(3, 389, 25, 21);
    //城画像
    castle_leftup = img4.get(96, 353, 22, 21);
    castle_centerup = img4.get(118, 353, 22, 21);
    castle_rightup = img4.get(140, 353, 22, 21);
    castle_leftcenter = img4.get(96, 373, 22, 21);
    castle_center = img4.get(118, 373, 22, 21);
    castle_rightcenter =img4.get(140, 373, 22, 21);
    castle_leftdown = img4.get(96, 394, 22, 21);
    castle_centerdown =  img4.get(118, 394, 22, 21);
    castle_rightdown = img4.get(140, 394, 22, 21);
  }

  //キャラクターイベントファイル読み込み
  private void loadEvent(String filename) {
    try {
      File file = new File(filename);
      BufferedReader br = new BufferedReader(new FileReader(file));
      String line;
      while ((line = br.readLine()) != null) {
        if (line.equals("")) continue;
        if (line.startsWith("#")) continue;
        StringTokenizer st = new StringTokenizer(line, ",");
        String eventType = st.nextToken();
        if (eventType.equals("CHARA")) {
          makeCharacter(st);
        }
      }
      br.close();
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  //キャラクター作成関数
  private void makeCharacter(StringTokenizer st) {
    int x = Integer.parseInt(st.nextToken());
    int y = Integer.parseInt(st.nextToken());
    int charaNo = Integer.parseInt(st.nextToken());
    int dir = Integer.parseInt(st.nextToken());
    int moveType = Integer.parseInt(st.nextToken());
    String message = st.nextToken();
    Chara c = new Chara(x, y, charaNo, dir, moveType, this);
    c.setMessage(message);
    charas.add(c);
  }

  public void addChara(Chara chara) {
    charas.add(chara);
  }

  //マップ内当たり判定
  public boolean isHit(int x, int y) {
    if (mapCollision[y][x] == 1 ) {
      return true;
    }
    return false;
  }

  //指定場所のモンスターレベル調べる
  public int placeLv(int x, int y) {
    return lvArea[y][x];
  }

  //敵出現判定関数
  public boolean isEnemy() {
    int r =int(random(75-hero.getWalkCount()));
    if (r==0) {
      if (lvArea[hero.getPx()/CS][hero.getPy()/CS]==0) {
        hero.setWalkCount(75);
        return false;
      }
      return true;
    }
    return false;
  }

  public int pixelsToTiles(double pixels) {
    return (int)Math.floor(pixels / CS);
  }

  public int tilesToPixels(int tiles) {
    return tiles * CS;
  }

  public void show() {
    for (int i=0; i<col; i++) {
      for (int j=0; j<row; j++) {
        System.out.print(mapBase[i][j]);
      }
      System.out.println();
    }
  }

  /* getter と　setter の実装（processingだと意味ない？）*/

  public int getCol() {
    return col;
  }

  public int getMRow() {
    return row;
  }

  public int getWidth() {
    return this.Width;
  }

  public int getHeight() {
    return this.Height;
  }
}