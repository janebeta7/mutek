class Preset11 extends Preset {
  Wurm w1 = new Wurm(0,0); 
  Wurm w2 = new Wurm(0,600);
  Wurm w3 = new Wurm(800,0);
  Wurm w4 = new Wurm(800,600);
  Wurm w5 = new Wurm(400,300);
  Preset11(String _name) {
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
    float[] wurm = new float[width];
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
    w1.draw();
    w2.draw();
    w3.draw();
    w4.draw();
    w5.draw();
  }
}
class Wurm {

  int wurm_size = 60;       
  float xpos, ypos;      
  float xspeed = 0.4;  
  float yspeed = 0.3;  

  int xdirection = 1;  // Left or Right
  int ydirection = 1;  // Top to Bottom

  float myAngle = 0;


  Wurm (float theXpos, float theYpos) {
    xpos = theXpos;
    ypos = theYpos;
  }



  void draw() {

    xpos = xpos + ( xspeed * xdirection );
    ypos = ypos + ( yspeed * ydirection );

    if (xpos > width-wurm_size || xpos < 0) {
      xdirection *= -1;
    }
    if (ypos > height-wurm_size || ypos < 0) {
      ydirection *= -1;
    }
    noStroke();
    myAngle += map(KNOB_3,0,255,0,10)/100;
    pushMatrix();
    float alfa =FADER_3*o_sound.getLevel();
    float alfa2 = FADER_3 *o_sound.getLevel();
    translate(xpos,ypos);
    rotate(myAngle);
    fill(0,alfa2);
    triangle(ATRACCION*2, ATRACCION*2, -RADIO, -RADIO, 50, 0);
    noStroke();
     fill(255,ALFA);
    triangle(ATRACCION*4, ATRACCION*4, -RADIO, -RADIO, 150, 0);
    fill(o_colores.getColor(),KNOB_8);
    triangle(-250, -250, map(KNOB_1,1,100,1,900), 20, 50, 0);
    popMatrix();
  }
}