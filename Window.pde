public class Window implements Common {
  ArrayList<String> sentence;
  int max;
  PImage window;

  //コンストラクタ（上限設定なし）
  public Window() {
    sentence = new ArrayList<String>();
    window = new PImage();
    window = loadImage("./data/Image/window.png");
    window = window.get(7,7,625,384);
    this.max=0;
  }

  //コンストラクタ（上限設定）
  public Window(int max) {
    sentence= new ArrayList<String>();
    window = new PImage();
    window = loadImage("./data/Image/window.png");
    window = window.get(7,7,625,384);
    //window = window.get(16,16,617,377);
    this.max=max;
  }

  //文章追加
  public void addSentence(String str) {
    if (max!=0) {
      if (sentence.size()>max) {
        sentence.remove(0);
      }
    }
    sentence.add(str);
  }
  
  //文章削除
  public void clearSentence(){
    sentence.clear();
  }
  
  //文章表示
  public void displaySentence(int coler, int textsize, int x, int y) {
    textSize(textsize);
    fill(coler);
    for (int i=0; i<sentence.size(); i++) {
      text(sentence.get(i), x, y+i*textsize);
    }
  }

  //ウィンドウ表示
  public void displayWindow(int x, int y, int Width, int Height) {
    image(window,x,y,Width,Height);
    strokeWeight(1);
    stroke(#BBBBBB);
  }
}