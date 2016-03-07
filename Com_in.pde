//functions that recive the parameters from the Onionface.


//classe on guardem les dades que venen del onionFace.
class onionFaceData_Class {
  OscP5 oscP5, tibP5;
  NetAddress myRemoteLocation, nikkaLocation;
  float level, medLow, medLow2, medMed, medHi, param1, param2, param3, param4, param5, param6, param7, param8;
  int longCadenaFreq;
  float[] cadenaFreq;
  float levelConst;
  //boolean lock = false;
  //inicialitzem
  Boolean isBeat = false;
  float subdivisions = 0;

  //constructor
  onionFaceData_Class(PApplet parent) {

    oscP5 = new OscP5(this, 12000);
    myRemoteLocation = new NetAddress("localhost", 12001);
    // oscP5.plug(this, "sound", "/sound");
    // oscP5.plug(this, "valores", "/valores");
LONG = 48;
    cadenaFreq = new float[48];
    for (int i=0; i<48; i++) {
      cadenaFreq[i] = 0;
    }
  }
  public Boolean isBeat () {
    return isBeat;
  }

  void sound(float[] memory) {

    for (int i=0; i<LONG; i++) {
      setCadenaFreq(memory[i], i);
    }
  }

  

  /* incoming osc message are forwarded to the oscEvent method. */
  void oscEvent(OscMessage theOscMessage) {
    /* with theOscMessage.isPlugged() you check if the osc message has already been
     * forwarded to a plugged method. if theOscMessage.isPlugged()==true, it has already 
     * been forwared to another method in your sketch. theOscMessage.isPlugged() can 
     * be used for double posting but is not required.
     */
    if (theOscMessage.isPlugged()==false) {
      /* print the address pattern and the typetag of the received OscMessage */
      // setConsola("### received an osc message.");
    
       if(theOscMessage.checkAddrPattern("/valores")==true) {
        this.medLow  = theOscMessage.get(0).floatValue();
        this.medLow2  = theOscMessage.get(1).floatValue();
        this.medMed  = theOscMessage.get(2).floatValue();

        this.medHi = theOscMessage.get(3).floatValue();
        this.level  = theOscMessage.get(4).floatValue();
        this.subdivisions  = theOscMessage.get(5).intValue();
        if (theOscMessage.get(6).intValue() == 1) this.isBeat = true; 
        else this.isBeat = false;
      
       //  this.levelConst  = theOscMessage.get(7).floatValue();
        
        // println("### addrpattern\t"+theOscMessage.addrPattern());
     // println(" this.subdivisions:"+ this.subdivisions);
      }
       if(theOscMessage.checkAddrPattern("/sound")==true) {
        // println("### addrpattern\t"+theOscMessage.addrPattern());
        for (int i=0; i<this.subdivisions; i++) {
         setCadenaFreq(theOscMessage.get(i).floatValue(), i);
        }
      }
    }
  }
  void draw() {
  }

  void setConsola(String txt) {
    OscMessage myMessage = new OscMessage("/consola");
    myMessage.add(txt);
    oscP5.send(myMessage, myRemoteLocation);
  }


  void inicializa() {
    println("----com > inicializa");
  }





  ///////////////////////////////////////////
  //posa cada un de les 
  void setMedLow(float medLow) {
    this.medLow = medLow;
  }  

  //function that returns de medLow 
  float getMedLow() {
    return (this.medLow);
  }

  //posa cada un de les 
  void setMedMed(float medMed) {
    this.medMed = medMed;
  }
  void setMediaLevel(float value) {
    this.level = value;
  }
  //function that returns de medLow 
  float getMed() {
    return (this.level);
  }

  //function that returns de medLow 
  float getMedMed() {
    // println("this.medMed"+this.medMed);
    return (this.medMed);
  }

  //posa cada un de les 
  void setMedHi(float medHi) {
    this.medHi = medHi;
  }

  //function that returns de medLow 
  float getMedHi() {
    return (this.medHi);
  }

  //Funcio que agafa la longitud de la cadana de frecuencies
  void setLongCadenaFreq(int longCadenaFreqIn) {
    longCadenaFreq = longCadenaFreqIn;
    //println("estoy definiendo la long del array  = " + longCadenaFreq);
    cadenaFreq = new float[longCadenaFreq];
  }

  //function returns the freq array size
  int getLongCadenaFreq() {
    return(longCadenaFreq);
  }

  //posa cada un de les 
  void setCadenaFreq(float cadenaFreqs, int i) {
    cadenaFreq[i] = cadenaFreqs;
   // println(" cadenaFreq[i] =" + cadenaFreq[i]);
  }


  float getCadenaFreq(int cont) {
    float temp = 0;
    temp = cadenaFreq[cont];
    return (temp);
  }
  float getLevel() {

    return level;
  }
}