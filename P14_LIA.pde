//preset2
class Preset13 extends Preset {
  ModuleA[] modsA;
  ModuleB[] modsB;

  boolean initialized = false;
  int num =100; //numero de particulas
  int modo = 1; //modo de dibujo
  float posxx, posyy;
  boolean ISPOINT = true;

  Preset13(String _name) {
    super(_name);

    reset();
  }
  public void changeTipo(int tipo) {
    
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {

    modsA = new ModuleA[num];
    modsB = new ModuleB[num];
    setupModules();
  }
  public void listener() {
    super.listener();
  }
  public void draw() {
    if (BT_94) reset();
   // num = int( map(KNOB_1,0,100,0, num));
    //modo = _modo;
    if (super.on) {
      render();
      setModo(TIPO);
    }
  }
  public void setModo(int _modo) {
    // println("Preset2 >> modo:"+modo+" " +_modo);
    modo = _modo;
  }
  private void render() {
    initialized = true;
    if (initialized == true) {
      for (int i=0; i<num; i++) {
        modsA[i].updateMe(modo);
        for (int j=0; j<num; j++) {
          modsB[j].myAngle = modsA[j].myAngle;
          modsB[j].myRadius = modsA[j].myRadius+i;
        }
        modsB[i].updateMe(modsA[i].x, modsA[i].y, modo);
        if ( (modsA[i].x < 0) || (modsA[i].x > width) || (modsA[i].y < 0) || (modsA[i].y > height) ) {
          modsA[i].x = posxx;
          modsA[i].y = posyy;
          modsB[i].x = posxx;
          modsB[i].y = posyy;
          float a = random(360);
          modsA[i].myAngle = a;
          modsB[i].myAngle = a;
          float r = random(3, 10);
          modsA[i].myRadius = r;
          modsB[i].myRadius = r+i*i;
        }
      }
    }
  }

  void setupModules() {
    for (int i=0; i<num; i++) {
      int qq;
      if (random(1) > 0.5) {
        qq = 1;
      } 
      else {
        qq = -1;
      }
      float x = width/2;
      float y = height/2;
      float angle = random(360);
      float direction = random(10, 40); //TODO
      modsA[i] = new ModuleA(i, x, y, angle, direction, qq);
      modsB[i] = new ModuleB(i, x, y, angle, direction, qq);
    }
  }
}


class Module {
  int i;
  float x, y, myAngle, myRadius, dir;
  float mx = width/2;
  float my = height/2;
  float delay = 10.0;
//  float delay = 240.0;
 
  Module(int spriteNum, float xx, float yy, float deg, float rad, float pp) {
    i = spriteNum;
    x = xx;
    y = yy;
    myAngle = deg;
    myRadius = rad;
    dir = pp;
  }
}



class ModuleA extends Module {

  ModuleA(int spriteNum, float xx, float yy, float deg, float rad, float pp) {
    super(spriteNum, xx, yy, deg, rad, pp);
  }

  void updateMe(int modo) {
    if (BT_11){
    float mh = x - mouseX;
    float mv = y - mouseY;
    float mdif = sqrt(mh*mh+mv*mv);
    float dh = width/2 - mouseX;
    float dv = height/2 - mouseY;
    float ddif = sqrt(dh*dh+dv*dv);
    if (dir == 1) {
      myAngle +=  abs(ddif - mdif)/150.0;
    }
    else {
      myAngle -=  abs(ddif - mdif)/150.0;
    }
    myRadius +=  mdif/100.00;
    if (myRadius > width) {
      myRadius = random(10, 40);
    }
   //delay = map(SPEED,0,900,0,400);
    mx += (mouseX - mx)/delay;
    my += (mouseY - my)/delay;
    x = mx + (myRadius * cos(radians(myAngle)));
    y = my + (myRadius * sin(radians(myAngle)));
    }
    else
    {
      float mh = x - width/2;
    float mv = y - height/2;
    float mdif = sqrt(mh*mh+mv*mv);
    float dh = width/2 - width/2;
    float dv = height/2 - height/2;
    float ddif = sqrt(dh*dh+dv*dv);
    if (dir == 1) {
      myAngle +=  abs(ddif - mdif)/150.0;
    }
    else {
      myAngle -=  abs(ddif - mdif)/150.0;
    }
    myRadius +=  mdif/map(RADIO,0,RADIOMAXIM,400,100);
    if (myRadius > width) {
      myRadius = random(10, 40);
    }
   //delay = map(SPEED,0,900,0,400);
    mx += (width/2 - mx)/delay;
    my += (height/2 - my)/delay;
    x = mx + (myRadius * cos(radians(myAngle)));
    y = my + (myRadius * sin(radians(myAngle)));
    }

   /* noFill();

     ellipse(x,y,RADIO,RADIO);

    point(x, y);*/
    point(x, y);
  }
}



class ModuleB extends Module {
  boolean isPoint;
  color colorr;
  ModuleB(int spriteNum, float xx, float yy, float deg, float rad, float pp) {
    // this.isPoint = isPoint;
    super(spriteNum, xx, yy, deg, rad, pp);
  }
  void updateMe(float modsA_x, float modsA_y, int modo) {
   // delay = map(SPEED,0,900,0,400);
   if (BT_11) {
    mx += (mouseX - mx)/delay;
    my += (mouseY - my)/delay;
   }
   else
   {
        mx += (width/2 - mx)/delay;
    my += (height/2 - my)/delay;
   }
    x = mx + (myRadius * cos(radians(myAngle)));
    y = my + (myRadius * sin(radians(myAngle)));
    if (modo == 1) {
      x = mx;
      y = my ;
    }
    if (modo == 2) {
      x = mx;
      y = my + (myRadius * sin(radians(myAngle)));
    }
    if (modo == 3) {
      x = mx + (myRadius * cos(radians(myAngle)));

      y = my ;
    }
    if (modo == 4) {
      x = mx + (myRadius * cos(radians(myAngle)));
      y = my + (myRadius * sin(radians(myAngle)));
    }   
    if (modo == 5) {
      x = mx + (myRadius * tan(radians(myAngle)));
       y = my ;
    } 
    if (modo == 6) {
      isPoint = true;
      x = mx ;
      y = my + (myRadius * tan(radians(myAngle)));
    } 
    noStroke();
    strokeWeight(1);
    if (BT_52)  {
      colorr = bg.getColor((int)modsA_x, (int)modsA_y);
      stroke(colorr, map(ALFA,0,255,0,80));
      point(modsA_x, modsA_y);
    }
    if (BT_53) {
      fill(o_colores.getColor(), STROKE_ALFA);
       ellipse(modsA_x, modsA_y, 2, 2);
    }
   
    strokeWeight(1);


    if (!oneColor)
      stroke(o_colores.getColor(0), map(STROKE_ALFA, 0, 255, 0, 30));
    else
    {

      stroke(255, map(STROKE_ALFA, 0, 255, 0, 40));
    }
    
    if (BT_41)  dibujaPuntos(modsA_x, modsA_y, x, y); 
    else 

      line(modsA_x, modsA_y, x, y);
  }

  public void dibujaPuntos(float modsA_x, float modsA_y, float xx, float yy) {
    float x1 = modsA_x, y1 = modsA_y;

    float x2 = xx, y2 = yy;
    float longLinea = dist(x1, y1, x2, y2);

    for (int i = 0; i <= longLinea/3; i++) {
      float x = lerp(x1, x2, i/longLinea) + 1;
      float y = lerp(y1, y2, i/longLinea);
      fill(bg.getColor(int(x), int(y)), ALFA);
      ellipse(x, y,2,2);
    }
  }

  public void setPoint() {
    println("Preset2> isPoint:"+isPoint);
    isPoint =!isPoint;
  }
}