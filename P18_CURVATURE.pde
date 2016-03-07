/*CURVATURES*/


class Preset17 extends Preset {
  Curver[] curvers;
  PImage myField;
  int NUMCURVERS=100;
  int[][] grid;
  color[][] colorGrid;
  int count;
  Preset17(String _name) {

    super(_name);

    iniciar();
    reset();
  }
   public void changeTipo(int tipo) {
  }
  public void f_mousePressed() {
    if ( super.on)  reset();
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void draw() {

    if (super.on) {
      // bg.changeImg(1);
      render();
    }
  }

  public void listener() {  
    super.listener();
  }
  private void render() {
      
  boolean resetNeeded=true;
   
    for(int i=0;i<NUMCURVERS;i++) {
      resetNeeded&=curvers[i].inactive;
      if(!curvers[i].inactive) {
        curvers[i].drawFrill(colorGrid);
      }
    }
    noStroke();
    fill(0);
    for(int i=0;i<NUMCURVERS;i++) {
      if(!curvers[i].inactive) {
        curvers[i].drawCenter();
        curvers[i].update(grid);
      }
    }
    if (resetNeeded) {
      count++;

      for(int i=0;i<NUMCURVERS;i++) {
        curvers[i].reset();
      }
      if(count>100) noLoop();
    }
  }
  public void reset() {
    NUMCURVERS = int(map(aKNOB[0][0], 0, 127, 1, 30));
     println("NUMCURVERS:"+NUMCURVERS);
    grid = new int[width][height];
    colorGrid = new color[width][height];
    color cul = color(255);
    color cur = color(255,0,0);
    color cll = color(255);
    color clr = color(random(256f),random(256f),random(256f));  
    for(int w=0;w<width;w++) {
      for(int h=0;h<height;h++) {  
        colorGrid[w][h]=color((1f-(float)w/width)*(1f-(float)h/height)*red(cul)+((float)w/width)*(1f-(float)h/height)*red(cur)+(1f-(float)w/width)*((float)h/height)*red(cll)+((float)w/width)*((float)h/height)*red(clr),(1f-(float)w/width)*(1f-(float)h/height)*green(cul)+((float)w/width)*(1f-(float)h/height)*green(cur)+(1f-(float)w/width)*((float)h/height)*green(cll)+((float)w/width)*((float)h/height)*green(clr),(1f-(float)w/width)*(1f-(float)h/height)*blue(cul)+((float)w/width)*(1f-(float)h/height)*blue(cur)+(1f-(float)w/width)*((float)h/height)*blue(cll)+((float)w/width)*((float)h/height)*blue(clr),60);
      }
    }
    curvers = new Curver[NUMCURVERS];
    Vec3D pos = new Vec3D(mouseX,mouseY,0f);
    Vec3D hdg = new Vec3D();
    for(int i=0;i<NUMCURVERS;i++) {
      pos.set(mouseX+2*cos(i*TWO_PI/NUMCURVERS),mouseY+2*sin(i*TWO_PI/NUMCURVERS),0f);
      hdg.set(cos(i*PI),sin(PI),0f);
      hdg.normalize();
      curvers[i] = new Curver(pos,hdg,grid);
    }
  }
  void iniciar() {
    count = 0;
  }
}


class Curver {

  Vec3D position;
  Vec3D prevPosition;
  Vec3D heading;
  Vec3D prevHeading;
  int[][] grid;
  float step;
  float age;
  float turnPerStep;
  float newTurnPerStep;
  boolean overEdge;
  boolean shrinking;
  float ageStep;
  boolean inactive;
  boolean polarity;
  PImage  myField;
  Curver() {
    myField = loadImage("beat/particle_curvature2.png");
    position = new Vec3D(random((float)width),random((float)height),0f);
    prevPosition=new Vec3D(position);
    heading = new Vec3D(random(-1f,1f),random(-1f,1f),0f);
    heading.normalize();
    prevHeading = new Vec3D(heading);
    age=1.0f;
    step=1.0f;//step=1.0f;
    //newTurnPerStep=turnPerStep=random(0.01f,0.02f)*(random(100f)<50f?-1f:1f);
    newTurnPerStep=turnPerStep=0.10f*(random(100f)<50f?-1f:1f);
    overEdge=false;
    ageStep=0.01f;
    inactive=false;
    shrinking=false;
    polarity=(random(100f)<50f)?true:false;
  }

  Curver(Vec3D position, Vec3D heading,int[][] _grid) {
    myField = loadImage("beat/particle_curvature2.png");
    this.grid = _grid;
    this.position = new Vec3D(position);
    prevPosition=new Vec3D(position);
    this.heading = new Vec3D(heading);
    heading.normalize();
    prevHeading = new Vec3D(heading);
    age=1.0f;
    step=1.0f;
    //el primero de todos!
    newTurnPerStep=turnPerStep=random(0.01f,0.05f)*(random(100f)<50f?-1f:1f);

    overEdge=false;
    ageStep=0.01f;
    inactive=false;
    shrinking=false;
    polarity=(random(100f)<50f)?true:false;
  }

  void reset() {

    heading = new Vec3D(random(-1f,1f),random(-1f,1f),0f);
    position = new Vec3D(random((float)width),random((float)height),0f);
    heading.normalize();
    prevPosition.set(position);
    prevHeading.set(heading);
    overEdge=false;
    age=1.0f;
    step=1.0f;
    ageStep*=0.9f;
    //newTurnPerStep=turnPerStep=random(0.01f,0.05f)*(random(100f)<50f?-1f:1f);
    newTurnPerStep=turnPerStep=0.10f*(random(100f)<50f?-1f:1f);
    inactive=false;
    shrinking=false;
    polarity=(random(100f)<50f)?true:false;
  }
  void update(int[][] Grid) {
    prevPosition.set(position);
    prevHeading.set(heading);
    overEdge=false;
    position.addSelf(heading.scale(step));
    if(position.x<2) { 
      position.x+=width-4;
      overEdge=true;
    }
    if(position.x>=width-2) { 
      position.x-=width-4;
      overEdge=true;
    }
    if(position.y<2) { 
      position.y+=height-4;
      overEdge=true;
    }
    if(position.y>=height-2) { 
      position.y-=height-4;
      overEdge=true;
    }

    if (shrinking) {
      age-=4*ageStep;
      if (age<1.0f) inactive=true;
    }
    else {
      age+=ageStep;
    }

    Vec3D newHeading = new Vec3D(heading.x*cos(turnPerStep)-heading.y*sin(turnPerStep),heading.y*cos(turnPerStep)+heading.x*sin(turnPerStep),0f);
    //       Vec3D newHeading = new Vec3D(heading.x*cos(turnPerStep)-heading.y*sin(turnPerStep),heading.y*cos(turnPerStep)+heading.x*sin(turnPerStep),0f);
    heading.set(newHeading);

    if(shrinking) {
      turnPerStep=0.99f*turnPerStep+newTurnPerStep;
    }
    else {
      if(random(100f)<1f) newTurnPerStep=random(0.001f,0.005f)*(random(100f)<50f?-1f:1f);
      turnPerStep=0.99f*turnPerStep+0.01f*newTurnPerStep;
    }


    if(overEdge) {

      inactive=true;
    }
    if(grid[(int)(position.x+step*heading.x)][(int)(position.y+step*heading.y)]>0) {
      shrinking=true;
    }
    grid[(int)position.x][(int)position.y]++;
  }

  void drawFrill(color[][] colorGrid) {
    smooth();
    if(!shrinking) {
      fill(colorGrid[(int)position.x][(int)position.y]);
      noStroke();


      // noFill();
      float randomL = (polarity)?random(age*10.0f):-random(age*10.0f);
      line(position.x,position.y,position.x+randomL*heading.y,position.y-randomL*heading.x);

      if(age>2.5f) {
        randomL = (polarity)?random(age*3.0f-7.0f):-random(age*3.0f-7.0f);
        ellipse( position.x-randomL*heading.y,position.y+randomL*heading.x,0.5f*age,0.5f*age);

        // image( myField ,position.x-randomL*heading.y,position.y+randomL*heading.x,0.5f*age,0.5f*age);
      }
    }
    else {
      if(age>1.5f) {
        tint(random(120f,256f));
        ellipse(position.x-random(-20f,20f)*heading.y,position.y+random(-20f,20f)*heading.x,2.5f*age,2.5f*age);

        image  ( myField,position.x-random(-20f,20f)*heading.y,position.y+random(-20f,20f)*heading.x,2.5f*age,2.5f*age);
      }
    }
  }

  void drawCenter() {

    if (oneColor) fill(o_colores.getColor(0),STROKE_ALFA); 
    else fill(o_colores.getColor(),STROKE_ALFA);
    imageMode(CENTER);
    //image( myField,position.x,position.y,RADIO,RADIO);
        ellipse(position.x,position.y,age,age);
  }
}