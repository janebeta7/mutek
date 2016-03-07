import toxi.physics2d.behaviors.*;
import toxi.physics2d.*;
import toxi.geom.*;
import java.util.Iterator;
class Preset7 extends Preset {
  VerletPhysics2D physics;
  VerletParticle2D prev;
  VerletParticle2D head; //particula primera;
  VerletParticle2D last; //particula ultima;
  float snapDist=10*10;// squared snap distance for picking particles
  boolean isLock = true;
  boolean isMove = true;
  VerletParticle2D selected=null; //particula seleccionada
  int continuous, current; // variables to create a new continuous line on each mouse drag
  //PARAMETROS
  PImage textura;
  int time ;
  float r = 1;
  Preset7(String _name) {
    super(_name);
    reset();
  }
  public void changeTipo(int tipo) {
  }
  public void f_mousePressed() {
    if (super.on) {
    }
  };
  public void f_mouseDrag() {

    if (super.on) {
      // create a locked (unmovable) particle at the mouse position
      VerletParticle2D p = new VerletParticle2D(mouseX, mouseY);
      p.lock();
      // if there is at least one particle and this is the current continuous line
      if (physics.particles.size() > 
        0 &&

        continuous == current) {
        // get the previous particle (aka the last in the list)
        VerletParticle2D prev = physics.particles.get(physics.particles.size()-1);
        head=(VerletParticle2D) physics.particles.get(0);
        last = (VerletParticle2D) physics.particles.get(physics.particles.size()-1);
        // create a spring between the previous and the current particle of length 10 and strength 1
        VerletSpring2D s = new VerletSpring2D(p, prev, 20, 0.005);
        // add the spring to the physics system
        physics.addSpring(s);
      } else {
        current = continuous;
      }
      // unlock previous particle
      if (prev!=null) {
        prev.unlock();
      }
      // add the particle to the physics system
      physics.addParticle(p);
      // create a forcefield around this particle with radius 20 and force -1.5 (aka push)
      toxi.physics2d.behaviors.ParticleBehavior2D b = new toxi.physics2d.behaviors.AttractionBehavior(p, RADIO_TOXI, FORCE);
      // add the behavior to the physics system (will be applied to all particles)
      physics.addBehavior(b);
      // make current particle the previous one...
      prev=p;
    }
  };
  public void f_mouseReleased() {
    if (super.on) {
      if (prev!=null) {
        prev.unlock();
      }
      continuous++;
    }
  };
  public void reset() {
    //textura = loadImage("brushes/damnicons_3.png");
    if (physics !=  null) remove();
    physics = new VerletPhysics2D();
    strokeWeight(1);
  }
  public void draw() {

    RADIO_TOXI = map(aKNOB[2][1], 0, 127, -100, 127);
    FORCE = map(aKNOB[2][2], 0, 127, 0, 20);
    if (super.on) {
      render();
    }
  }
  public void listener() {
    super.listener();
  }
  private void render() {
    time = second(); 
    if (BT_94)  try { 
      remove();
    }

    catch(Exception e) {
      println("***************DRAW EXCEPTION LORDS: "+e.toString()+"\n");
    }
    if (aBT[2][1]) isMove = true; 

    else isMove= false;
    if (isMove) {
      try {
        last.unlock();
        head.lock();
        last.set(mouseX, mouseY);
      }
      catch(Exception e) {
        println("***************DRAW EXCEPTION lordS: "+e.toString()+"\n");
      }
    }

    if (aBT[2][0]) {
      head.unlock();
      last.lock();
      head.set(mouseX, mouseY);
    }
    physics.update(); // update all the physics stuff (particles, springs, gravity)
    r+=PI/500;
    // draw a line segment for each spring and change the color of it based on the x position
    for (VerletSpring2D s : physics.springs) {
      // map the direction of each spring to a hue

      // define a color in HSV and convert into ARGB format (32bit packed integer)
      if (oneColor)  stroke(0, map(aKNOB[2][7], 0, 127, 0, 255));

      else
        stroke(255, map(aKNOB[2][7], 0, 127, 0, 255));
      if (BT_51) {
        //noStroke();
      }

      // noFill();

      if (BT_51)  fill(bg.getColor((int)s.a.x, (int)s.a.y), map(aKNOB[2][15], 0, 127, 0, 255)); 
      else 
      {
        try { 
          fill(o_colores.getColor((int)map(KNOB_2, 0, 100, 0, 4)), map(aKNOB[2][15], 0, 127, 0, 255));
        }

        catch(Exception e) {
          println("***************DRAW EXCEPTION LORDS: "+e.toString()+"\n");
        }
      }
      // fill(x,y,x3,y2);
      if (TIPO ==2)   strokeWeight(2); 
      point(s.a.x, s.a.y);
      strokeWeight(1);
      if (TIPO ==1) {

        triangle(s.a.x, s.a.y, s.b.x, s.b.y, s.b.x+((s.b.x-s.a.x)/2), s.b.y-30);
      }  
      if (TIPO == 3) {

        pushMatrix();
        translate(s.a.x, s.a.y);
        float rot = r +map(aKNOB[2][0], 0, 127, -TWO_PI, TWO_PI);
        rotate(rot); 
        triangle(0, 0, aKNOB[2][9]/2, aKNOB[2][9], aKNOB[2][9], aKNOB[2][9]/2);


        // rotate(time * radians(90));
        /*  beginShape();
         
         vertex(s.a.x,s.a.y);
         vertex(s.b.x,s.b.y);
         vertex(s.b.x+((s.b.x-s.a.x)/2),s.b.y-RADIO);*/
        //  vertex(s.b.x, s.b.y);

        /*  endShape(CLOSE);*/
        popMatrix();
      }
      if (TIPO ==4)  line(s.a.x, s.a.y, s.b.x, s.b.y);
    }
    try {
      // remove stuff that is off the screen to keep things running smoothly ;-)
      removeOffscreen();
    }
    catch(Exception e) {
      println("***************DRAW EXCEPTION: "+e.toString()+"\n");
    }
    changeBehavior();
  }
  void seguir() {
  }
  void removeOffscreen() {
    // remove off-screen springs
    for (Iterator<VerletSpring2D> i=physics.springs.iterator (); i.hasNext(); ) {
      VerletSpring2D s=i.next();
      if (s.a.y >
        height+100 || s.b.y > 
        height+100) {
        i.remove();
      }
    }

    // remove off-screen particles && behaviors
    for (int i=physics.particles.size ()-1; i>=0; i--) {
      VerletParticle2D p = physics.particles.get(i);
      if (p.y > 
        height+200) {
        physics.removeParticle(p);
        ParticleBehavior2D b = physics.behaviors.get(i+1);
        physics.removeBehavior(b);
      }
    }
  }
  void remove() {
    FORCE =0;
    RADIO_TOXI =20;
    // remove off-screen springs
    for (Iterator<VerletSpring2D> i=physics.springs.iterator (); i.hasNext(); ) {
      VerletSpring2D s=i.next();

      i.remove();
    }

    // remove off-screen particles && behaviors
    for (int i=physics.particles.size ()-1; i>=0; i--) {
      VerletParticle2D p = physics.particles.get(i);

      physics.removeParticle(p);
      ParticleBehavior2D b = physics.behaviors.get(i+1);
      physics.removeBehavior(b);
    }
  }
  void changeBehavior() {
    // remove off-screen particles && behaviors
    for (int i=physics.particles.size ()-1; i>=0; i--) {
      VerletParticle2D p = physics.particles.get(i);

      ParticleBehavior2D b = physics.behaviors.get(i);
      physics.removeBehavior(b);
      toxi.physics2d.behaviors.ParticleBehavior2D bb = new toxi.physics2d.behaviors.AttractionBehavior(p, RADIO_TOXI, FORCE);
      physics.addBehavior(bb);
    }
  }
}