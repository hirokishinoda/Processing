public class Item {
  String name;
  int num;

  //コンストラクタ
  public Item(String name, int num) {
    this.name=name;
    this.num=num;
  }

  //equalsメソッドオーバーライド
  public boolean equals(Object o) {
    if (o==this) return true;
    if (o==null) return false;    
    if (o instanceof Item) return false;

    return true;
  }

  /* getter と　setter の実装（processingだと意味ない？）*/

  public String getMyName() {
    return name;
  }

  public void setNum(int num) {
    this.num=num;
  }

  public int getNum() {
    return this.num;
  }
}