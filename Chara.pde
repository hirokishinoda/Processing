public class Chara implements Common {

  protected static final int SPEED = 4;
  public static final double PROB_MOVE = 0.02;

  protected PImage img;
  protected PImage player;
  protected int x, y;   
  protected int px, py; 

  protected int direction;
  protected int count;

  protected boolean isMoving;
  protected int movingLength;
  protected int charaNo;
  protected int moveType;
  protected int walkCount;
  protected String message;

  protected Thread threadAnime;

  protected Map map;

  //コンストラクタ
  public Chara(int x, int y, int charaNo, int direction, int moveType, Map map) {
    this.x = x;
    this.y = y;

    px = x * CS;
    py = y * CS;

    this.charaNo = charaNo;
    this.direction = direction;
    count = 0;
    this.moveType = moveType;
    walkCount=0;

    this.map = map;

    if (img == null) {
      loadImages();
    }

    threadAnime = new Thread(new AnimationThread());
    threadAnime.start();
  }

  //equalsメソッドオーバーライド
  public boolean equals(Object o) {
    if (o==this) return true;
    if (o==null) return false;    
    if (o instanceof Chara) return false;

    return true;
  }

  //キャラクター描画関数
  public void CharaDraw( int offsetX, int offsetY) {
    int cx = charaNo * CS * 3;
    player = img.get(cx + count * CS, direction * CS, CS, CS);
    image(player, px + offsetX, py + offsetY, CS, CS);
  }

  //向きに応じた移動処理
  public boolean move() {
    switch (direction) {
    case LEFT:
      if (moveLeft()) {
        return true;
      }
      break;
    case RIGHT:
      if (moveRight()) {

        return true;
      }
      break;
    case UP:
      if (moveUp()) {

        return true;
      }
      break;
    case DOWN:
      if (moveDown()) {

        return true;
      }
      break;
    }

    return false;
  }

  //左向き移動処理
  protected boolean moveLeft() {

    int nextX = x - 1;
    int nextY = y;
    if (nextX < 0) nextX = 0;

    if (!map.isHit(nextX, nextY)) {
      px -= Chara.SPEED;
      if (px < 0) px = 0;

      movingLength += Chara.SPEED;
      if (movingLength >= CS) {
        x--;
        if (x < 0) x = 0;
        px = x * CS;
        isMoving = false;
        return true;
      }
    } else {
      isMoving = false;
      px = x * CS;
      py = y * CS;
    }

    return false;
  }

  //右向き移動処理
  protected boolean moveRight() {

    int nextX = x + 1;
    int nextY = y;
    if (nextX > map.row - 1) nextX = map.row - 1;

    if (!map.isHit(nextX, nextY)) {

      px += Chara.SPEED;
      if (px > map.getWidth() - CS)
        px = map.getWidth() - CS;

      movingLength += Chara.SPEED;

      if (movingLength >= CS) {

        x++;
        if (x > map.getMRow() - 1) x = map.getMRow() - 1;
        px = x * CS;

        isMoving = false;
        return true;
      }
    } else {
      isMoving = false;
      px = x * CS;
      py = y * CS;
    }

    return false;
  }

  //上向き移動処理
  protected boolean moveUp() {

    int nextX = x;
    int nextY = y - 1;
    if (nextY < 0) nextY = 0;

    if (!map.isHit(nextX, nextY)) {

      py -= Chara.SPEED;
      if (py < 0) py = 0;

      movingLength += Chara.SPEED;

      if (movingLength >= CS) {

        y--;
        if (y < 0) y = 0;
        py = y * CS;

        isMoving = false;
        return true;
      }
    } else {
      isMoving = false;
      px = x * CS;
      py = y * CS;
    }

    return false;
  }

  //下向き移動処理
  protected boolean moveDown() {
    int nextX = x;
    int nextY = y + 1;
    if (nextY > map.col - 2) nextY = map.col - 2;

    if (!map.isHit(nextX, nextY)) {

      py += Chara.SPEED;
      if (py > map.getHeight() - CS)
        py = map.getHeight() - CS;

      movingLength += Chara.SPEED;

      if (movingLength >= CS) {

        y++;
        if (y > map.getCol() - 1) 
          y = map.getCol() - 1;

        py = y * CS;

        isMoving = false;
        return true;
      }
    } else {
      isMoving = false;
      px = x * CS;
      py = y * CS;
    }

    return false;
  }

  //画像読み込み関数
  protected void loadImages() {
    img = new PImage();
    img = loadImage("./data/Image/Chara.png");
    player = new PImage();
  }

  //アニメーション用カウントスレッド
  protected class AnimationThread extends Thread {
    public void run() {
      while (true) {
        if ( count == 2) {
          count=0;
        } else {
          count++;
        }

        try {
          Thread.sleep(300);
        } 
        catch (InterruptedException e) {
          e.printStackTrace();
        }
      }
    }
  }

  /* getter と　setter の実装（processingだと意味ない？）*/

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public int getPx() {
    return px;
  }

  public int getPy() {
    return py;
  }

  public void setDirection(int dir) {
    direction = dir;
  }

  public int getMoveType() {
    return moveType;
  }

  public boolean isMoving() {
    return isMoving;
  }

  public void setMoving(boolean flag) {
    isMoving = flag;
    movingLength = 0;
  }

  public void setWalkCount(int walkcount) {
    this.walkCount = walkcount;
  }

  public int getWalkCount() {
    return this.walkCount;
  }

  public int getCount() {
    return count;
  }

  public void setCount(int cou) {
    this.count = cou;
  }

  public String getMessage() {
    return message;
  }
  public void setMessage(String message) {
    this.message=message;
  }
}