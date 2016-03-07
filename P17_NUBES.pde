class Preset16 extends Preset {
  int n_attractors=10;
  int cell=100; // cell size

  Vec2D[] gravityPCollection= new Vec2D[n_attractors];
  Vec2D[] orientorCollection;
  Vec2D[] orientorSortedCollection;

  float[] gravity= new float[n_attractors];
  float[] distCollection;
  Assets assets;
  ArrayList particuleCollection;

  /*bg*/
  boolean isBg = false;


  boolean lancer =true;
  Preset16(String _name) {
    
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
    particuleCollection= new ArrayList();
    noCursor();

    makeAttractions();
  }
  public void draw() {
    if (super.on) {
      if (BT_94) reset();
      render();
    }
  }
  public void changeTipo(int tipo) {
  }
  public void listener() {
    super.listener();
  }
  private void render() {
   if (mousePressed)
      makeAttractions();
    
   n_attractors=int(map(aKNOB[0][4], 0, 127, 0, 10));
    
    //cell=667; // cell size
    //cell=int(map(mouseY, 0, height, 200, 1000));
    cell =int( map(aKNOB[0][0], 0, 127, 200, 1000));
    orientorCollection= new Vec2D[particuleCollection.size()];
    distCollection= new float[particuleCollection.size()];

    for (int j=0; j< particuleCollection.size (); j++) {


      Vec2D p = (Vec2D)particuleCollection.get(j);
      Vec2D target = new Vec2D();


      float distTot= 0;
      float minDist=100000000;
      int minIdx=0;

      for (int i=0; i<n_attractors; i++) {



        float disti = p.distanceTo(gravityPCollection[i]);

        if (disti<minDist) {
          minDist=disti;
        }
        Vec2D  vi = gravityPCollection[i].sub(p);
        vi.normalize();
        vi.scaleSelf(gravity[i]/disti);

        target.addSelf(vi);
      }  


      target.normalizeTo(5);

      // STOCKAGE DES ORIENTEURS et DISTANCES 
      orientorCollection[j]=target;
      distCollection[j]= minDist;
    }


    float distmax=max(distCollection);
    float distmin=min(distCollection);

    orientorSortedCollection= new Vec2D[particuleCollection.size()];

    for (int j=0; j< particuleCollection.size (); j++) {

 int pi =int( map(aKNOB[0][1], 0, 127, -2, 2));
  int normalice =int( map(aKNOB[0][2], 0, 127, -4, 4));
      Vec2D temp=orientorCollection[j].getRotated(PI/pi);
      orientorSortedCollection[j] =  temp.normalizeTo(normalice);
    }

    for (int j=0; j< particuleCollection.size (); j++) {
      Vec2D p =  (Vec2D)particuleCollection.get(j);  
      p.addSelf(orientorSortedCollection[j]);
      noStroke();
      if (BT_51)
       fill(bg.getColor((int)p.x, (int)p.y), map(aKNOB[0][7], 0, 127, 0, 255));
      else 
       fill(o_colores.getColor(0),map(aKNOB[0][7], 0, 127, 0, 255));
     // fill(#1115EA, map(aKNOB[0][7], 0, 127, 0, 255));
      ellipse(p.x, p.y, 2, 2);
    }
  }
  void makeAttractions() {
    // POINT ATTRACTEUR
    
    for (int i = 0; i < n_attractors; i = i+1) {
      float ax = mouseX;
      float ay = mouseY;
      gravityPCollection[i]= new Vec2D(ax, ay);
      gravity[i]=random(1, 100);
      fill(255, 0, 0, 255);
      //ellipse(ax, ay, 15, 15);
    }

    // POINTS  
    for (int i=0; i<=width; i=i+cell) {
      for (int j=0; j<=height; j=j+cell) {
        fill(255, 255);
        //ellipse(i, j, 5, 5);
        Vec2D p = new Vec2D(i, j);
        particuleCollection.add(p);
      }
    }
  }
}