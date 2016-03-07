/*tangencias*/
class Preset4 extends Preset {
  Eye e1;
  int cont = 0;
  Preset4(String _name) {
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
    cont = 0;
    e1 = new Eye( width/2, height/2, (int) map(aKNOB[4][1],0,127,0,800));
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
    cont++;
    e1.update((int)mouseX, mouseY);
    e1.display();
  }
}
class Eye 
{

  float hh = 0;
  int ex, ey;
  int size;
  float angle = 0.0;
  color col;
  Eye(int x, int y, int s) {
    //background(0);
    ex = x;
    ey = y;
    size = s;
  }

  void update(int mx, int my) {

    //para hayar la recta a un punto tenemos que saber su angulo, esto lo hacemos con la arcotangente, que es la inversa de la tangente q
    //e as u vez es la razon entre el cateto opuesto y el contiguo.
    angle = atan2(my-ey, mx-ex);

    //una vez tengamos ese punto, dibujam
  }
  void display() {
    pushMatrix();
    stroke(0);
    translate(ex, ey);
    rotate(angle);
    noFill();
    /*stroke(255, 0, 0, 5);
    //line(size/2, size/2, cos(angle)*size/2, sin(angle)*size/2);
    stroke(255,0,0, 100);
    line(size/3, size/3, cos(angle)*size/2, sin(angle)*size/2);
      stroke(0,0,0, 100);
    line(size/4, size/4, cos(angle)*size/2, sin(angle)*size/2);*/
    


    stroke(255,  map(aKNOB[4][7],0,127,0,255));
   /// angle = map(aKNOB[4][1],0,127,0,TWO_PI);
    strokeWeight(1);
    pushMatrix();
    translate(size/2, 0);
    //<line(0,0,size/2,0);
    rotate(PI/2-angle);
    //hacer tangencia
    line(0, 0, cos(angle)*size, sin(angle)*size);
    line(0, 0, -cos(angle)*size, -sin(angle)*size);
    popMatrix();

     popMatrix();

  }
}