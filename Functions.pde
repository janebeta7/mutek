//-----------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------

void salvarImagen() {
  String sketchName = getClass().getSimpleName();
  String nombre = getIncrementalFilename("out/"+sketchName+"###.jpg");
  saveFrame(nombre);
}
public String getIncrementalFilename(String what) {
  String s="", prefix, suffix, padstr, numstr;
  int index=0, first, last, count;
  File f;
  boolean ok;

  first=what.indexOf('#');
  last=what.lastIndexOf('#');
  count=last-first+1;

  if ( (first!=-1)&& (last-first>0)) {
    prefix=what.substring(0, first);
    suffix=what.substring(last+1);

    // Comment out if you want to use absolute paths
    // or if you're not using this inside PApplet
  if (sketchPath()!=null) prefix=savePath(prefix);

    index=0;
    ok=false;

    do {
      padstr="";
      numstr=""+index;
      for (int i=0; i<count-numstr.length (); i++) padstr+="0";       
      s=prefix+padstr+numstr+suffix;

      f=new File(s);
      ok=!f.exists();
      index++;

      // Provide a panic button. If index > 10000 chances are it's an 
      // invalid filename.
      if (index>10000) ok=true;
    } 
    while (!ok);

    // Panic button - comment out if you know what you're doing
    if (index>10000) {
      setConsola("getIncrementalFilename thinks there is a problem - Is there "+
        " more than 10000 files already in the sequence or is the filename invalid?");
      return prefix+"ERR"+suffix;
    }
  }
  setConsola("save File >> "+s );
  return s;
}
void limpiaPantalla() {
  background(COLOR_FONDO);
}
///RENDER FRAMES//
void renderFrames() {
  if (renderToFrames==true) {

    saveFrame("./render/particles-####.tiff");
  }
}


/*-----------------------------presets-----------------------------*/
// opengl blending as seen here http://www.rui-m.com/p5/Boids/ ;)
void glowStuff() {
}

void sound(float MedLow, float MedMed, float MedHi, float MediaLevel, int LongCadenaFreq, Float[] arrFreq, float param1, float param2, float param3, float param4, float param5, float param6, float param7, float param8) {
  print("PLUG  /SOUND");
}
void mirrorVertical2()
{
  loadPixels();
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {    
      pixels[j*width+i] = pixels[(width - i - 1) + j*width]; // Reversing x to mirror the image
    }
  }
  updatePixels();
}
void mirrorVertical()
{
  loadPixels();
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {    
      pixels[(width - i - 1) + j*width] = pixels[j*width+i];  // Reversing x to mirror the image
    }
  }
  updatePixels();
}
void mirrorHorizontal()
{
  loadPixels();
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      pixels[(height-y-1)*width+x] = pixels[y*width+x];
    }
  } 
  updatePixels();
}



void pixelShift(int xshift, int yshift) {
  // copy screen into an array
  color transArr[] = new color[width * height];

  loadPixels();
  arraycopy(pixels, transArr);

  for (int y=1; y < height; y++) {
    for (int x=1; x < width; x++) {

      if ((x+xshift < width) && (x+xshift > 0)) {
        if ((y+yshift < height) && (y+yshift > 0)) {
          pixels[x + (y*width)] = transArr[(x+xshift)+ ((y+yshift)*width)];
        }
      }
    }
  }
  updatePixels();
}


void calibrar() {
  imageMode(CORNER);
  image(imCa, 0, 0);
  imageMode(CENTER);
}
void sendConsola(String txt) {
  setConsola("---->"+txt);
 // onionData.setConsola(txt);
}
void setOFF() {
  for (int i = 0; i < presets.length; i++) {
    presets[i].on = false;
  }
  COLOR_FONDO = #000000 ;
  bg.isBg = false;
  //videos.isVideo = false;

  isPosition= false;
  isResize = false;
  brush.reset();
}
void resetALL() {
  for (int i = 0; i < presets.length; i++) {
    if (presets[i].on) presets[i].reset();
  }
  bg.reset();
}