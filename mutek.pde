
/* Alba G. Corral */
/* keychan - 2015 November
 */

//*********catch********* ****************** importamos librerias ****************** ****************** *//
int NUM_PRESETS = 20;
Boolean isOPENGL = false ;
Boolean isPerformance=false;

int sizeX = 1920 ;
int sizeY =  1080 ; //https://en.wikipedia.org/wiki/1080p#/media/File:Vector_Video_Standards2.svg
int locationXPerformance = 1920;
int locationYPerformance = 0;
int locationX = 0;
int locationY = 0;
int posx ;
int posy;
int COLORACTIVE = 0;

/*------------------------------------------------------------------------------------------------*/
//***************b*** ****************** importamos librerias ****************** ****************** *//
import java.awt.Color;
import java.awt.*;
import java.awt.event.*;
import traer.physics.*;
import oscP5.*;
import netP5.*;
/*  */
import janebeta7.*;
import com.hamoid.*; //videoExport


// ******************   DECLARACION DE PARAMETROS  ************************************//
//----------------OBJETOS
Preset[] presets;
Background bg;
VideoExport videoExport;
Fade o_fade;

Brush brush;
Sound_fft o_sound;
Assets assets;
Siluetas siluetas; //objeto para las maskaras
Colors o_colores;
onionFaceData_Class onionData;

//----------------VARIABLES
boolean recording = false;
PImage img = new PImage();
PImage maskara, imCa ;
boolean isCalibrar= false;
boolean isDebug = true;
boolean USARRATON =true;
boolean renderToFrames = false;
boolean glow = false;
int TIPO = 1;
color COLOR_FONDO = color(0  );
float ALFA=50;
float BG_ALFA = 255;
int RADIOMAXIM =1000;
boolean isBlur, isSound, isReset = false;
boolean oneColor = false;
float INC=48;
float SCALA = 1;
float CONTADOR=255;

float VOLUMEN  = 100;
float STROKE_ALFA = 40; // normalmente para Strokes
float RADIO = 200;//RADIO DE LOS CIRCULOS
float PINTURA = 150;
float PINTURA_VAL = 400;
float FRAMERATE  =24;
Boolean isFrameRate = true;
float SPEED  =2;
float SPEED_METROPOP =10;
float SPEEDX  = 0;
float SPEEDY  = 0;

float SPEED_FADE  =3;

float DAMPERVAL = 0.05;
float ATRACCION = 300;
int pixelShiftx=0;
int pixelShifty =1 ;
int shiftDirection = 1;
float  SPEED_SHIFT= 2;
boolean isBlockLines = false;
// SWITCHERS //
boolean isInvert = true;
boolean isSpring = false;
boolean isSeguimiento = false;
boolean isClear = false;
boolean isOnion = true;
boolean isBg = false;
boolean isFade = false;
 boolean isCamera=false;

boolean isCursor = false;

int tipoParticula = 1;
float FORCE =0;
float RADIO_TOXI =20;

//----------------------CONTROL_1----------------
float KNOB_1 = 100;
float KNOB_12 = 100;
float FADER_1 =100;
float FADER_11 =100;
float FADER_12 =100;
float FADER_13 =100;
Boolean BT_11 = false;
Boolean BT_12 = false;
Boolean BT_13 = false;
//----------------------CONTROL_2---------------- 
float KNOB_2 = 100;
float FADER_2 =100; 
Boolean BT_21 = false;
Boolean BT_22 = false;
Boolean BT_23 = false;
Boolean isPosition= false;
Boolean isResize = false;
float ancho, alto=0;
//----------------------CONTROL_3----------------
float KNOB_3 = 100;
float FADER_3 =100; 
float FADER_31 =100;

Boolean BT_31 = false;
Boolean BT_32 = false;
Boolean BT_33 = false;
//----------------------CONTROL_4----------------
float KNOB_4 = 100;
float FADER_4 =10; 
float FADER_41=10;
Boolean BT_41 = false;
Boolean BT_42 = false;
Boolean BT_43 = false;
//----------------------CONTROL_5----------------
float KNOB_5 = 255;
float FADER_5 =25; 
float  FADER_51 = 10;
Boolean BT_51 = false;
Boolean BT_52 = false;
Boolean BT_53 = false;
//----------------------CONTROL_6----------------
float KNOB_6 = 100;
float FADER_6 =100; 
Boolean BT_61 = false;
Boolean BT_62 = false;
Boolean BT_63 = false;

//----------------------CONTROL_7----------------
float KNOB_7 = 400;
float FADER_7 = 150;
float FADER_71 = 100;



Boolean BT_71 = false;
Boolean BT_72 = false;
Boolean BT_73 = false;
//----------------------CONTROL_8----------------
float KNOB_8 = 10;
float FADER_8 =100; 
Boolean BT_81 = false;
Boolean BT_82 = false;
Boolean BT_83 = false;
//----------------------botones----------------
Boolean BT_91 = false;
Boolean BT_92 = false;
Boolean BT_93 = false;
Boolean BT_94 = false;
Boolean BT_95 = false;
Boolean BT_96 = false;
Boolean BT_97 = false;
Boolean BT_98 = false;
Boolean BT_99 = false;
Boolean BT_100 = false;
Boolean BT_101 = false;
int INTCOLOR = 0 ;
PGraphics offscreen;
import java.awt.Color;

// Called every time a new frame is available to read
void settings() {

 println("INIT KEYCHAN....");
//(java.swing.JFrame)frame.getContentPane().setBackground(new java.awt.Color(color(0,0,0)));
fullScreen();  //TWO MONITORS
 
 //
 }
void setup() {
  noCursor();
     background(0);
   //size(1920, 1080,OPENGL);
  
   //frame.setLocation(locationX, locationY);

 // size(1920, 1080);
   surface.setSize(1920,1080);
  noCursor();
  /* if (!isOPENGL) size(sizeX, sizeY);
   else {
   size(sizeX, sizeY, OPENGL);
   } */
  // size(1920, 1080);
  //initVideo();
  onionData = new onionFaceData_Class(this);
  if (isFrameRate) frameRate(FRAMERATE);
  setupkeys(); //EVENTOS
  posx = width/2;
  posy= height/2; 


  videoExport = new VideoExport(this, getIncrementalFilename("videoout/"+getClass().getSimpleName()+"###.mp4"));
  videoExport.setFrameRate(FRAMERATE);

  initMIDI();

  inicio();
}
void inicio() {
  imageMode(CENTER);
  background(COLOR_FONDO);
  // cursor(CROSS);
  stroke(0);

  //setBackground(Color.black);
  imCa = loadImage("calibration.jpg");
  background(0);
  assets = new Assets();
  o_colores  = new Colors(this); //instanciamos el objeto colores con 100 colores como máximo en cada paleta
  o_colores.addFolder(dataPath("set/"));
  o_colores.setPalette(COLORACTIVE);

  o_fade = new Fade();
  siluetas = new Siluetas(dataPath("siluetas/"));
  bg = new Background(dataPath("backgrounds/"));

  o_sound = new Sound_fft(this);
  PESO = new float[LONG];
  initPresets();

  sendConsola("---------INIT: OK----------------");
  endLaunchControl();
}

void initPresets() {
  presets = new Preset[NUM_PRESETS];
  int i = 0;
  presets[i++] = new Preset0("01 PARTICLES----");
  presets[i++] = new Preset1("02 LAZOS");
  presets[i++] = new Preset2("03 NOISE");
  presets[i++] = new Preset3("04 NIEBLA");
  presets[i++] = new Presetx("05 TANGENCIAS");
  presets[i++] = new Preset5("06 PITAGORAS PELOS");
  presets[i++] = new Preset6("07 klee");
  presets[i++] = new Preset7("08 lord triangles");
  presets[i++] = new Preset8("09 Curtain");
  presets[i++] = new Preset9("10 METROPOP");
  presets[i++] = new Preset10("11 PINTURA");
  presets[i++] = new Preset11("12 TRIANGLES");
  presets[i++] = new Preset12("13 INFINITE");
    presets[i++] = new Preset13("14 LIA");
    presets[i++] = new Preset14("15 GOLD THINKINGS");
   presets[i++] = new Preset15("16 LINES");
   presets[i++] = new Preset16("16 nubes");
  presets[i++] = new Preset17("18 curvature");
    presets[i++] = new Preset18("19 SOUNDLINES");
        presets[i++] = new Preset19("19 METROPOP ANTIGUO");
  brush = new Brush("_Brushes_", dataPath("brushes/"));
}



void draw() {
  //noCursor();



  /*if (isPerformance )  surface.setLocation(locationXPerformance, locationYPerformance);
  else surface.setLocation(locationX, locationY);*/



  drawMidi();
  
  o_sound.draw();
 // try {
  if (aBT[0][10]) isClear = true; 
  else if (BT_91) isClear = true; 
  else isClear = false;

  if (isClear) { 
    background(COLOR_FONDO);
  }






  bg.render();

  brush.draw(); 

  render(); //PRESETS
  //if (renderToFrames) renderFrames();

  float vv = map(KNOB_6, 0, 255, 0, 1);
  //vv = 0.6;f
  shiftRender();

  if (BT_83) mirrorVertical();
  if (BT_82) mirrorHorizontal();
  //if (BT_96 ) setOFF();

  if (recording) {
    videoExport.saveFrame();
    

  }
      siluetas.render();
  o_fade.render();
  /*}
   catch(Exception e) {
   
   sendConsola("***************DRAW EXCEPTION: "+e.toString()+"\n");
   }*/
}
void shiftRender() {
  if ( BT_63 ) shiftDirection = 1; 
  else shiftDirection=-1;
  if (BT_62 ) 
  {
    if ( BT_61 ) {
      pixelShiftx = 1*shiftDirection;
      pixelShifty = 0;
    } else
    {
      pixelShiftx = 0;
      pixelShifty = 1*shiftDirection;
    }
    pixelShift(int(pixelShiftx*SPEED_SHIFT), int(pixelShifty*SPEED_SHIFT));
  }
}
void render() {
  // setConsola("tipoParticula:"+tipoParticula);
  for (int i = 0; i < presets.length; i++) {
    presets[i].draw();
  }
}


public void stop() {

  super.stop();
}
void setConsola(String txt) {
  println(txt);
  onionData.setConsola(txt);
}