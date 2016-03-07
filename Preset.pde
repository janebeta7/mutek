abstract class Preset {
  public boolean on =false;
  String name;

  Preset(String _name) {
    name = _name;
    //setConsola("Preset >> init, name:"+name);
    sendConsola("Preset >> init, name:"+name);
  }
  float  getX() {
    return mouseX;
  }
  float  getY() {

    return mouseY;
  }
  public void setPreset(boolean _on) {
    on = _on;
    setConsola("Preset >> "+name +",on: "+on);
    sendConsola("Preset >> "+name +",on: "+on);
  }
  public boolean getPreset() {
    return on;
  }
  abstract void draw();
  abstract void reset();
  abstract void changeTipo(int tipo);
  
  abstract void f_mousePressed();
  abstract void f_mouseDrag();
  abstract void f_mouseReleased();

  public void listener() {
    setPreset(!getPreset());
  }
  public void delete() {
    setPreset(false);
  }
}