class Preset3 extends Preset {
  PImage clouds;
  float TINTA;
  Preset3(String _name) {
    super(_name);
    reset();
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    noiseDetail(5, 0.4);
   // loadPixels();
aKNOB[3][4]= 14;aKNOB[3][5]= 32;
    // Render the noise to a smaller image, it's faster than updating the entire window.
    clouds = createImage(128, 128, RGB);
  }
  public void draw() {
    if (super.on) {
      render();
    }
  }
  public void changeTipo(int tipo) {
  }
  public void listener() {
    super.listener();
  }
  private void render() {
    float hue = (noise(millis() * 0.0001) * 200) % 100;
    setConsola("hue"+hue);
    float cspeed =  map(aKNOB[3][4],0,127,0,0.0039);

    float z = millis() * cspeed;
    float dx = millis() * cspeed;

    for (int x=0; x < clouds.width; x++) {
      for (int y=0; y < clouds.height; y++) {
        float cxx = map(aKNOB[3][5],0,127,0,1.80);
        float n = 500 * (noise(dx + x * cxx, y * 0.01, z) - 0.0);
        float cMode =   map(aKNOB[3][6],0,127,0,253);;

        color c = color(n, 80-n,n);
        clouds.pixels[x + clouds.width*y] = c;
      }
    }
    clouds.updatePixels();
    imageMode(CORNER);
    
    
     TINTA = map(aKNOB[3][7],0,127,0,255);
    tint(TINTA, 255);

    image(clouds, 0, 0, width, height);
    imageMode(CENTER);
  }
}