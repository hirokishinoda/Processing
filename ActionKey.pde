public class ActionKey {

  private int state;
  private int mode;
  private int amount;

  public static final int NORMAL = 0;
  public static final int DETECT_INITIAL_PRESS_ONLY = 1;
  private static final int STATE_RELEASED = 0;
  private static final int STATE_PRESSED = 1;
  private static final int STATE_WAITING_FOR_RELEASE = 2;

  //コンストラクタ（モード自動設定）
  public ActionKey() {
    this(NORMAL);
  }

  //コンストラクタ（モード設定）
  public ActionKey(int mode) {
    this.mode = mode;
    reset();
  }

  //　status 放した状態に設定
  public void reset() {
    state = STATE_RELEASED;
    amount = 0;
  }

  //キー入力押された
  public void press() {
    if (state != STATE_WAITING_FOR_RELEASE) {
      amount++;
      state = STATE_PRESSED;
    }
  }

  //キー入力放された
  public void release() {
    state = STATE_RELEASED;
  }

  public boolean isPressed() {
    if (amount != 0) {
      if (state == STATE_RELEASED) {
        amount = 0;
      } else if (mode == DETECT_INITIAL_PRESS_ONLY) {
        state = STATE_WAITING_FOR_RELEASE;
        amount = 0;
      }

      return true;
    }

    return false;
  }
}