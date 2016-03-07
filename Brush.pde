
class Brush extends Preset {
  String directorio;
  boolean on=false;  
  boolean activar = true; //activar, desactivar
  ArrayList brushes;
  public int activa = 0;
  boolean isBg = false;
  public float changeBrush = 0;
  color colorr=color(255, 255, 255);
  public boolean isChangeColor = false;
  float eRadius =20;
  Brush(String _name, String _dir) {  
    super(_name);
    this.directorio = _dir;
    cargar();
  }
  public void changeTipo(int tipo) {
  }
  public void cargar() {
    String[] listado = new String[100];
    listado = assets.readFolder(directorio);
    println("++++++++++ brushes >> +"+directorio);
    brushes = new ArrayList();
    int len = listado.length;
    if (listado.length > 0) {
      for (int i=0; i<len; i++) {
        brushes.add(new Brushes(listado[i], i));
      }
    }
  }
  boolean isChangeBrush() {
    println("changeBrush"+ changeBrush);
    if (changeBrush ==127) return true; 
    else return false;
  }
  public void changeImg(int _num) {

    if (_num <  brushes.size())  activa= _num;
    //  activa= _num;
    println("Brush > activa:"+activa +"num"+ _num+ " brushes.size()"+ brushes.size());
  }
  public void changeImg() {

    activa= int(brushes.size()-1);
    println("Brush > activa:"+activa  );
  }
  public void f_mousePressed() {

    if (super.on) {
      dibuja();
    }
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    super.on = false;
  }
  public void draw() {
    if (super.on) {
      render();
    }
  }
  public void listener() {
    super.listener();
  }
  private void render() {

    if (isSound) {
      isChangeColor = BT_42;
      if (isChangeColor) {
        if (oneColor)  colorr = o_colores.getColor(0);
        else  colorr = o_colores.getColor();
      }
      if (BT_43) {
        tint(colorr, KNOB_4);  
        float a = map(eRadius, 20, 80, 60, 500);
        fill(60, 255, 0, a);
        if (onionData.isBeat() ) eRadius =map(FADER_4, 0, 255, 0, 2000);
        eRadius *=0.98;
        getBrush().displayAuto(eRadius);
      } else
      {
        tint(colorr, KNOB_4); 

        getBrush().displayAuto(o_sound.getMedia(0, LONG)*map(FADER_4, 0, 255, 0, 1000));
      }
    }
  }
  void dibuja() {

    if (!isSound) {
      isChangeColor = BT_42;
      if (isChangeColor) {
        if (oneColor)  colorr = o_colores.getColor(0);
        else  colorr = o_colores.getColor();
      }
      tint(colorr, KNOB_4);      
      getBrush().display();
    }
  }
  public Brushes getBrush() {
    Brushes ftemp = (Brushes) brushes.get(activa);
    return ftemp;
  }
}

public class Brushes {
  private PImage b;
  private String url;
  float posx, posy ;
  private int i;
  Brushes(String _url, int _i) {
    this.url = _url;
    this.posx = width/2;
    this.posy = height/2;
    this.i = _i;
    File file=new File((this.url));
    boolean exists =file.exists(); 
    if (!exists)  println("Brushes > No existe arhivo : "+(this.url));
    else {
      b = loadImage(url);
      println("- Brushes: "+(this.url));
    }
  }
  private void displayAuto(float val) {
    imageMode(CENTER);
    if (BT_41) {

      posx = mouseX;
      posy= mouseY;
    }
    image(b, posx, posy, val, val);
    //image(b, posx+RADIO, posy, val, val);
  }
  private void display() {
    if (BT_41) {

      posx = mouseX;
      posy= mouseY;
    }
    imageMode(CENTER);
    image(b, posx, posy, map(FADER_4, 0, 255, 0, 2500), map(FADER_4, 0, 255, 0, 2500));
  }
}