
int numc = 0;                                                  // Number of string segments we are currently at.
int numObstacles = 1;                                          // Number of obstacles.
int numStrings = 10;                                           // Number of strings.
int numStringSegments = 40;                                    // Number of segments in each string.
int numSegments = numStrings*numStringSegments;                // Number of total segments.

float maxd = 25;                                               // The distance at which the segments feel most comfortable with to each other.
float g = 1.0;                                                 // Gravity constant.
float k = 0.99;                                                // Damping constant.
float r = 50;                                                  // Obstacle radius.
float v = 0.9;                                                 // Obstacle damping.
float m = 30;                                                  // Mouse constant

string[] strings;
stringSegment[] stringSegments;
obstacle[] obstacles;

class Preset8 extends Preset {

  Preset8(String _name) {
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
    // Create all objects
 numc = 0;                                                  // Number of string segments we are currently at.
 numObstacles = 2;                                          // Number of obstacles.
 numStrings = 190;                                           // Number of strings.
 numStringSegments = 25;                                    // Number of segments in each string.
 numSegments = numStrings*numStringSegments;                // Number of total segments.

 maxd = 50;                                               // The distance at which the segments feel most comfortable with to each other.
 g = 1.0;                                                 // Gravity constant.
 k = 0.99;                                                // Damping constant.
 r = map(aKNOB[0][1],0,127,0,500);                                                  // Obstacle radius.
 v = 0.9;                                                 // Obstacle damping.
 m = 30; 
    // Create obstacles
    obstacles = new obstacle[numObstacles];
    for ( int i=0; i<numObstacles; i++ ) { 
      obstacles[i] = new obstacle();
    }

    // Create strings
    strings = new string[numStrings];
    stringSegments = new stringSegment[numSegments];
    for ( int i=0; i<numStrings; i++ ) { 
      strings[i] = new string();
    }
  }
  public void draw() {
    if (super.on) {
      numStrings = 150;                                           // Number of strings.
 numStringSegments = 23;                                    // Number of segments in each string.
 numSegments = numStrings*numStringSegments;                // Number of total segments.

 maxd = 50;                                               // The distance at which the segments feel most comfortable with to each other.
 g = 1.0;                                                 // Gravity constant.
 k = 0.99;                                                // Damping constant.
                                                 // Obstacle radius.
 v = 0.9;                                                 // Obstacle damping.
 m = 30;
       r = map(aKNOB[0][1],0,127,0,500);
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
    //background(255,0,0);
   
    //background(0);
  if (BT_51){
     //playVideo();
     // displayVideo();
  }
    // Redraw/Recalculate all objects where necessary
   
      for ( int i=0; i<numStrings; i++ )
      {
        strings[i].drawString(width/2+15*(i-numStrings/2), 0, -1, -1);
      }

      if ( mouseX == 0 && mouseX == 0 )
      {
        obstacles[0].obstaclate(map(aKNOB[0][1],0,127,0,500), map(aKNOB[0][1],0,127,0,500));
      } else
      {
        obstacles[0].obstaclate(mouseX, mouseY);
      }

      stroke(o_colores.getColor(0));
      //strokeWeight(2);
      //line(300,0,500,0);
    
  }
}

// ------------------------------------------------------------------------------
// Curtain - http://www.arkitus.com
// Copyright (C) 2005  Ali Eslami
// 
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// ------------------------------------------------------------------------------
// Obstacle.java
// These objects are are obstacles for the
// string. They block their movement.
// ------------------------------------------------------------------------------

class obstacle
{
  float fx;
  float fy;
  float vx;
  float vy;
  float x;
  float y;

  obstacle()
  {
    x = 400;
    y = 210;
  }

  void obstaclate(float X, float Y)
  {
    move(X, Y);
    block();
    display();
  }

  void block()
  {
    fx = 0;
    fy = 0;

    for ( int i=0; i<numSegments; i++ )
    {
      float deltax = x-stringSegments[i].x;
      float deltay = y-stringSegments[i].y;
      float theta = atan2(deltay, deltax);
      float d = sqrt(pow(deltax, 2)+pow(deltay, 2));

      if ( d < r )
      {
        stringSegments[i].assignPosition(x-r*cos(theta), y-r*sin(theta));
        stringSegments[i].bx = -(r-d)*cos(theta);
        stringSegments[i].by = -(r-d)*sin(theta);

        fx = (r-d)*cos(theta);
        fy = (r-d)*sin(theta);
      }
    }
  }

  void move(float X, float Y)
  {
    float deltax;
    float deltay;

    if (mouseY != 0 || mouseY != 0)
    {
      deltax = X-x;
      deltay = Y-y;
    } else
    {
      deltax = 400-x;
      deltay = 210-y;
    }

    fx += deltax/m;
    fy += deltay/m;

    vx += fx/10;
    vy += fy/10;

    x += vx;
    y += vy;

    // damping
    vx *= v;
    vy *= v;
  }

  void display()
  {
    //stroke(0, 0, 0);
   // fill(240, 240, 240);
   // ellipse(x, y, 2*r, 2*r);

    if (mouseX != 0 || mouseY != 0)
    {
      //stroke(200, 200, 200);
      //line(x, y, mouseX, mouseY);
      strokeWeight(2);
      stroke(50, 50, 50);
      point(x, y);
      point(mouseX, mouseY);
    }
  }
}
// ------------------------------------------------------------------------------
// Curtain - http://www.arkitus.com
// Copyright (C) 2005  Ali Eslami
// 
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// ------------------------------------------------------------------------------
// String.java
// These objects are the controllers for each string
// segment. They create them, tell them where to start off from
// and where to end.
// ------------------------------------------------------------------------------

class string
{
  int n0;

  string()
  {
    n0 = numc;

    for ( int i=0; i<numStringSegments; i++ )
    {
      stringSegments[numc] = new stringSegment(numc);
      numc++;
    }
  }

  void drawString(float X1, float Y1, float X2, float Y2)
  {
    for ( int i=0; i<numStringSegments; i++ )
    {
      if ( i > 0 && i < numStringSegments - 1 )
      {
        stringSegments[n0+i].fall();
        stringSegments[n0+i].pull();
        stringSegments[n0+i].move();
        stringSegments[n0+i].drawSelf();
        stringSegments[n0+i].drawLine();
      } else
      {
        if ( i == 0 )
        {
          stringSegments[n0+i].assignPosition(X1, Y1);
          stringSegments[n0+i].pull();
          stringSegments[n0+i].drawSelf();
        } else
        {
          if ( X2 == -1 && Y2 == -1 )
          {
            stringSegments[n0+i].fall();
            stringSegments[n0+i].move();
            stringSegments[n0+i].drawSelf();
            stringSegments[n0+i].drawLine();
            stringSegments[n0+i].drawBob();
          } else
          {
            stringSegments[n0+i].assignPosition(X2, Y2);
            stringSegments[n0+i].drawSelf();
            stringSegments[n0+i].drawLine();
          }
        }
      }
    }
  }
}
// ------------------------------------------------------------------------------
// Curtain - http://www.arkitus.com
// Copyright (C) 2005  Ali Eslami
// 
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// ------------------------------------------------------------------------------
// String.java
// These objects are the actual small straight
// lines that make up the whole string. All the physics
// is applied to each and everyone of them.
// ------------------------------------------------------------------------------

class stringSegment
{
  float x;
  float y;

  float tx;        // Tension in string
  float ty;
  float wx;        // Weight of gravity
  float wy;
  float fx;        // Total force
  float fy;
  float bx;        // Bounce force - Collisions
  float by;

  float vx;
  float vy;
  float m;
  int n;

  stringSegment(int N)
  {
    x = width/2 + random(-width, width);
    y = 0;
    vx = random(-40, 40);
    vy = 0;
    n = N;
    m = 1;
  }

  void drawSelf()
  {
   if (BT_22){ fill(0, 0, 0);
    stroke(bg.getColor(int(x),int(y)),map(aKNOB[0][15],0,0127,0,255));
    rect(x-2, y, 7, 6);}
  }
  void drawSelf2()
  {
    fill(0, 0, 0);
    stroke(0, 0, 0);
    rect(x-2, y, 7, 6);
  }
  void drawLine()
  {
    //float alfa =FADER_8*o_sound.getLevel()*100;
   if (BT_51) 
   stroke(bg.getColor(int(x),int(y)),map(aKNOB[0][7],0,0127,0,255));
   else  stroke(o_colores.getColor(),map(aKNOB[0][7],0,0127,0,255));
    strokeWeight(map(aKNOB[0][0],0,127,0,10));
    line(stringSegments[n-1].x, stringSegments[n-1].y, x, y);
    line(stringSegments[n-1].x+4, stringSegments[n-1].y, x+4, y);
  }

  void drawBob()
  {
    //fill(230,230,230);
    // stroke(0,0,0);
    //ellipse(x,y,10,10);
  }

  void pull()
  {
    float deltax = x-stringSegments[n+1].x;
    float deltay = y-stringSegments[n+1].y;
    float d = sqrt(pow(deltax, 2)+pow(deltay, 2));
    float theta = atan2(deltay, deltax);
    float ft = (maxd-d)/2;

    tx += ft*cos(theta);
    ty += ft*sin(theta);

    stringSegments[n+1].assignPosition(x-maxd*cos(theta), y-maxd*sin(theta)); // Makes strings rigid - remove for elasticity
    stringSegments[n+1].tx = -ft*cos(theta);
    stringSegments[n+1].ty = -ft*sin(theta);
    stringSegments[n+1].vx *= k;
    stringSegments[n+1].vy *= k;
  }

  void fall()
  {
    // Vertical force of gravity
    wx = 0;
    wy = m*g;
  }

  void move()
  {
    // Calculate the total force
    fx = tx + wx + bx;
    fy = ty + wy + by;

    // Update velocity with acceleration
    vx += fx/m;
    vy += fy/m;

    // Update positions
    x += vx;
    y += vy;

    // Reset b force
    bx = 0;
    by = 0;
  }

  void assignPosition(float X, float Y)
  {
    x = X;
    y = Y;
  }
}