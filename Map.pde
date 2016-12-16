import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;
import java.util.Vector;

public class Map implements Common {


  int mapBase[][];

  private Vector<Chara> charas = new Vector<Chara>();

  private int width;
  private int height;

  private int row;
  private int col;

  private PImage img;
  private PImage img2;
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

  public Map(String mapname, String eventname) {
    col=0;
    row=0;
    loadMaptxt(mapname);
    //loadEvent(eventname);
    loadImages();
  }

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
        case 0 : 
          if (mapBase[i-1][j]==1) {
            image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
            image( upbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          } else if (mapBase[i+1][j]==1) {
            image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
            image( downbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          } else if (mapBase[i][j-1]==1) {
            image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
            image( leftbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          } else if (mapBase[i][j+1]==1) {
            image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
            image( rightbar, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          } else {
            image( ground, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          }
          break;
        case 1 : 
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 2:
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( rightup_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 3:
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( leftup_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 4:
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( leftdown_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        case 5:
          image( sea, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          image( rightdown_corner, tilesToPixels(j) + offsetX, tilesToPixels(i) + offsetY, CS, CS);
          break;
        }

        for (int n = 0; n < charas.size(); n++) {
          Chara chara = (Chara) charas.get(n);
          chara.CharaDraw(offsetX, offsetY);
        }
      }
    }
  }

  private void loadMaptxt(String fileName) {
    try {
      String str;

      File file = new File(fileName);
      BufferedReader br = new BufferedReader(new FileReader(file));

      while ((str = br.readLine()) != null) {
        String[] str2 = str.split(" ", 0);
        row = str2.length;
        col++;
      }
      br.close();
      mapBase = new int [col][row];
      width = row * CS;
      height = col * CS;
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
    try {
      String str;
      int y = 0;
      int x = 0;

      File file = new File(fileName);
      BufferedReader br = new BufferedReader(new FileReader(file));

      while ((str = br.readLine()) != null) {

        String[] str2 = str.split(" ", 0);

        for (x = 0; x < row; x++) {
          mapBase[y][x] = Integer.valueOf(str2[x]);
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

  private void loadImages() {
    img = new PImage();
    img = loadImage("./date/chip12e_map_01.png");
    img2 = new PImage();
    img2 =loadImage("./date/pipoya_mcset1_base01.png");
    ground = new PImage();
    ground = img2.get( 0, 0, 32, 32);
    sea = new PImage();
    sea = img.get( 0, 64, 32, 32);
    rightup_corner = new PImage();
    rightup_corner = img2.get(0, 736, 32, 32);
    leftup_corner = new PImage();
    leftup_corner = img2.get(63, 736, 32, 32);
    leftdown_corner = new PImage();
    leftdown_corner = img2.get(0, 800, 32, 32);
    rightdown_corner = new PImage();
    rightdown_corner = img2.get(63, 800, 32, 32);
    upbar =new PImage();
    upbar = img2.get(33, 736, 32, 32);
    downbar =new PImage();
    downbar = img2.get(33, 800, 32, 32);
    leftbar =new PImage();
    leftbar = img2.get(0, 768, 32, 32);
    rightbar =new PImage();
    rightbar = img2.get(64, 768, 32, 32);
  }

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

  private void makeCharacter(StringTokenizer st) {
    int x = Integer.parseInt(st.nextToken());
    int y = Integer.parseInt(st.nextToken());
    int charaNo = Integer.parseInt(st.nextToken());
    int dir = Integer.parseInt(st.nextToken());
    int moveType = Integer.parseInt(st.nextToken());
    Chara c = new Chara(x, y, charaNo, dir, moveType, this);
    charas.add(c);
  }

  public void addChara(Chara chara) {
    charas.add(chara);
  }

  public Vector<Chara> getCharas() {
    return charas;
  }

  public boolean isHit(int x, int y) {
    if (mapBase[y][x] == 1 ) {
      return false;
    }
    for (int i = 0; i < charas.size(); i++) {
      Chara chara = (Chara) charas.get(i);
      if (chara.getX() == x && chara.getY() == y) {
        return true;
      }
    }
    return false;
  }

  public int pixelsToTiles(double pixels) {
    return (int)Math.floor(pixels / CS);
  }

  public int tilesToPixels(int tiles) {
    return tiles * CS;
  }

  public int getCol() {
    return col;
  }

  public int getMRow() {
    return row;
  }

  public int getWidth() {
    return this.width;
  }

  public int getHeight() {
    return this.height;
  }
  public void show() {
    for (int i=0; i<col; i++) {
      for (int j=0; j<row; j++) {
        System.out.print(mapBase[i][j]);
      }
      System.out.println();
    }
  }
}