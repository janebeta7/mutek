class Preset5 extends Preset {
  int espacio = 50;
    int NUM =1; //NUMERO DE CIRCULOS
    Circulo[] w = new Circulo[NUM]; //array de cienpies
    int radio = 100;
    Circulo circulo ;
    int z = 0;
  Preset5(String _name) {
    
    super(_name);
    reset();
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
    if (super.on) {
      reset();
    }
  };
  public void reset() {
    for (int i=0; i<NUM; i++) {
      w[i] = new Circulo(int(random(radio)), int(random(espacio)), width/2, height/2); //nuevo circulo
    }
  }
  public void draw() {
    if (super.on) {
      render();
      
      if (aBT[5][8]) reset();
      radio = int(map(aKNOB[5][1],0,127,0,500));
    }
  }
  public void changeTipo(int tipo) {
  }
  public void listener() {
    super.listener();
  }
  private void render() {
    for (int z=0; z<NUM; z++) {
      
      w[z].draw();//llamamos al metodo de la clase Wurm.draw();
    }
  }
}

class Circulo {
  //


  float a = 0.0  ;
  float inc = TWO_PI/240;
  int longitud = 100;
  boolean dibujado= false; 
  int radio, radioini, Ax, Ay, espacio;
  color colorr;
 



  //constructor de la clase
  Circulo (int _radio, int _espacio, int _Ax, int _Ay) {
    this.radioini = radio;
    this.radio = _radio;
    this.Ax = _Ax;
    this.Ay =_Ay;
    this.espacio = _espacio;

    colorr = o_colores.getColor();
  }
  void draw() {
    //variante while dibuja de golpe
    while (a <  TWO_PI) {
      dibuja();
      a = a + inc;
    }

    // setConsola("-------------------------radio:"+radio);
    a =0;
    radio = radio+1;


    if (radio > 800) {
      dibujado = true;
      // background(0);
      a = 0;
      radio =radioini;
      colorr = o_colores.getColor();

    }
  }

  void dibuja() {

    // strokeWeight(1); 
    //    ahora recorremos la longitud de r para ir creando puntos que recorran todo el areadel circulo
    for (int i = 0; i < radio; i = i+100) {

      float xx = cos(a)*i+Ax; 
      float yy = sin(a)*i+Ay; 
      float xx2 = cos(a)*(i+int(random(100)))+Ax; 
      float yy2 = sin(a)*(i+int(random(100)))+Ay; 
      if (isSound)
      stroke(o_colores.getColor(), constrain(o_sound.getMediaMed(),0,255));
   else 
      stroke(o_colores.getColor(), map(aKNOB[5][7],0,127,0,10));
   
      float cx1 =  xx+int(random(20));
      float cx2 = xx2+int(random(20));
      float cy1 = yy+int(random(20));
      float cy2 = yy2+int(random(20));
noFill();
      bezier(xx, yy, cx1, cy1, cx2, cy2, xx2, yy2);
    }
  }
}