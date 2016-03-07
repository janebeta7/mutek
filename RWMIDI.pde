/////////////////////////////////////////////
// MIDI-related methods
import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage; //Import the MidiMessage classes http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/MidiMessage.html
import javax.sound.midi.SysexMessage;
import javax.sound.midi.ShortMessage;
boolean isMidi = true;

MidiBus midi_pad=null;
MidiBus midi_kontrol=null;
MidiBus midi_novation = null;
MidiBus midi_key=null;
String nano_0 = "PAD";
String nano_1 = "KEYBOARD";
String nano_2 = "SLIDER/KNOB";
String novation = "Launch Control";
//color bytes 
int byte_green = 0x3A;
int byte_red =  0x0B;
int byte_amber= 0x3F;
int byte_yellow= 0x3E;
String byte_on = "0x9";
String byte_off = "0x8";
int ACTIVECHANNEL = 0; //canal activo

int numChannels = 16;
int numButtons = 100;
int[] aButtonsMidiMapping = {  //notes
  9, 10, 11, 12, 25, 26, 27, 28, 114, 115, 116, 117
};

int numKnobs = 16;
int[] aKnobsMidiMapping = {  //controller
  21, 22, 23, 24, 25, 26, 27, 28, 41, 42, 43, 44, 45, 46, 47, 48
};
Boolean[][] aBT = new Boolean[numChannels][numButtons];
float[][] aKNOB = new float[numChannels][numButtons];



Boolean BT_0_114 = false; 
Boolean BT_0_115= false; 
Boolean BT_0_116= false; 
Boolean BT_0_117 = false;



int[] aKeyMaps = { 
  9, 10, 11, 12, 25, 26, 27, 28, 114, 115, 116, 117
};
void initMIDI() {

  //RESET BUTTONS
  for (int i = 0; i < numChannels; i++) {
    for (int j = 0; j < aButtonsMidiMapping.length; j++) {

      aBT[i][j] = false;
    }
  }
  //RESET knobs
  for (int i = 0; i < numChannels; i++) {
    for (int j = 0; j <aKnobsMidiMapping.length; j++) {
      aKNOB[i][j] = 0;
    }
  }
  aKNOB[0][1] =100;
  aKNOB[0][2] =100;
  aKNOB[0][3] =100;
  aKNOB[0][4] =100;
  aKNOB[0][5] =100;
  aKNOB[0][6] =100;
  aKNOB[0][7] =100;
  aKNOB[0][8] =100;
  aKNOB[0][9] =100;
  aKNOB[0][10] =100;
  aKNOB[0][11] =100;
  aKNOB[0][15] =127;
  aKNOB[1][2] = 0.5;

  //MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index aend name.

  /*try {    */


  midi_kontrol = new MidiBus(this, "SLIDER/KNOB", "Real Time Sequencer", "midi_kontrol");
  midi_novation = new MidiBus(this, novation, novation, "midi_novation");
  setConsola("<< MIDI  initMIDI: >>>>>>>>>>>>>>>>>>>>>>"+midi_novation);
  /* }
   catch(Exception e) {
   setConsola("***************MIDI not available.");
   setConsola("***************Exception: "+e.toString()+"\n");
   
   midi_kontrol=null;
   midi_novation = null;
   }*/
  initLaunchControl();
}

void initLaunchControl() {

  setConsola("MIDI > initLaunchControl...."+ACTIVECHANNEL);

  for ( int c=0; c< 8; c ++ ) {
    midi_novation.sendMessage(Integer.decode("0xB"+c), Integer.decode("0x00"), Integer.decode("0x7D")); //(full Brightnes
  }
}
void endLaunchControl() {
  //    midi_novation.sendMessage(Integer.decode("0x87"), 27, byte_green); //chanel, note, light

  for ( int c=0; c< 8; c ++ ) {
    midi_novation.sendMessage(Integer.decode("0xB"+c), Integer.decode("0x00"), Integer.decode("0x00")); //Reset Launch Control

    for ( int i=0; i< aKeyMaps.length; i ++ ) {


      midi_novation.sendMessage(Integer.decode("0x8"+c), aKeyMaps[ i ], byte_green); //chanel, note, light
    }
    //delay(200);
    //midi_novation.sendMessage(Integer.decode("0xB"+c), Integer.decode("0x00"), Integer.decode("0x00"));/*All LEDs are turned off, */
    // if (ACTIVECHANNEL == c)  midi_novation.sendMessage(Integer.decode("0x9"+c), aKeyMaps[c], byte_green); //chanel, note, light
    // midi_novation.sendMessage(0x90, 9, 0x3A); //chanel, note, light
  }
  setConsola("MIDI > initLaunchControl...."+ACTIVECHANNEL);
}

void controllerChange(int channel, int number, int value, long timestamp, String bus_name) {

  // setConsola("Number:"+number);
  //setConsola("Value:"+value);

  if (bus_name == "midi_kontrol") {
    // setConsola("This came from  midi_kontrol");
    controllerIn_kontrol(number, value);
  } else if (bus_name == "midi_novation") {
    // setConsola("This came from  samson");
    controllerIn_novation(number, value, channel);
  }
  midi_novation.sendMessage(Integer.decode("0x87"), getNote(6), Integer.decode("0x00"));
}
/* ------------------------    CNTROLLER IN PAD ---------------------------------------------------------*/



void drawMidi() {
  //listenerButtons();
  listenerPresetsLights();
  // setConsola("aBT[7][6]:"+aBT[7][6]);
}
void listenerButtons() {


  //RESET BUTTONS
  for (int i = 0; i < numChannels; i++) {
    for (int j = 0; j < aButtonsMidiMapping.length; j++) {
      int ind= getNote(j);

      if (aBT[i][j])  midi_novation.sendMessage(Integer.decode("0x9"+i), ind, byte_red);
      // else midi_novation.sendMessage(Integer.decode("0x8"+i), ind, byte_red);
    }
  }
}
void listenerPresetsLights() {
  //smidi_novation.//REsendMessage(0xB1, 00, 00); //RESET
  midi_novation.sendMessage(0x90, 9, 0x3A);
  midi_novation.sendMessage(0x91, 10, 0x3A);
  midi_novation.sendMessage(0x92, 11, 0x3A);
  midi_novation.sendMessage(0x93, 12, 0x3A);
  midi_novation.sendMessage(0x94, 25, 0x3A);
  midi_novation.sendMessage(0x95, 26, 0x3A);
  midi_novation.sendMessage(0x96, 27, 0x3A);
  midi_novation.sendMessage(0x97, 28, 0x3A);

  midi_novation.sendMessage(152, 9, 0x38);
  midi_novation.sendMessage(153, 10, 0x38);
  midi_novation.sendMessage(154, 11, 0x38);
  midi_novation.sendMessage(155, 12, 0x38);
  midi_novation.sendMessage(156, 25, 0x38);
  midi_novation.sendMessage(157, 26, 0x38);
  midi_novation.sendMessage(158, 27, 0x38);
  midi_novation.sendMessage(159, 28, 0x38);
}
void controllerIn_novation(int num, int valor, int channel) {
  //setConsola("Controller Change:"+" Channel:"+channel+ " Number:"+num+" Value:"+valor);
  int ind;
  ACTIVECHANNEL = channel;
  int indKnob = getIndiceKnob(num);
  if (channel < numChannels) { //presetsLights

      if ( indKnob != -1 )  // //comprobamos si se ha movido un knob
    {
      aKNOB[channel][indKnob] = valor;
      setConsola("aKNOB["+channel+"]["+indKnob+"]"+aKNOB[channel][indKnob]);
    }
    if ((channel > 7) && (indKnob == 7))
    {
      aKNOB[0][7] = valor;
    }
    if ((channel > 7) && (indKnob == 15))
    {
      aKNOB[0][15] = valor;
    }
    if ((channel > 1) && (indKnob == 4))
    {
      aKNOB[0][4] = valor;
    }
    if ((channel > 1) && (indKnob == 15))
    {
      aKNOB[0][12] = valor;
    }



    listenerPresetsLights();
  }
  try {
    // println("-----------------------------------------------------");
    switch(num) {
    case 28: /* c16 */
      for (int i= 0; i < 7; i++)
        aKNOB[i][7] = valor;

      break;
    }
  }
  catch(Exception e) {

    println("***************Exception pad: "+e.toString()+"\n");
  }
}

void noteOn(int channel, int pitch, int velocity, long timestamp, String bus_name) {
  setConsola("Note ON:"+"Channel:"+channel+" Pitch "+pitch);

  if (bus_name == "midi_novation") {
    ACTIVECHANNEL = channel;
    int ind = getIndice(pitch); 

    aBT[channel][ind] =!  aBT[channel][ind] ;


    setConsola("aBT["+channel+"]["+ind+"]"+aBT[channel][ind]);
    if (channel < 8) {
      if ( aBT[channel][ind])  midi_novation.sendMessage(Integer.decode("0x9"+channel), pitch, byte_red);
      else midi_novation.sendMessage(Integer.decode("0x8"+channel), pitch, byte_red);
    }
    if (channel == 7 ) listenChannel7(channel, pitch);
    if (channel == 15 ) listenChannel15(channel, pitch); //colores
    if (channel == 13 ) listenChannel13(channel, pitch); //bg
    if (channel == 14 ) listenChannel14(channel, pitch); //brush
    if (channel == 8 ) listenChannel8(channel, pitch); //particles
  }
}

void noteOff(int channel, int pitch, int velocity, long timestamp, String bus_name) {

  // setConsola("Note Off:"+"Channel:"+channel+" Pitch "+pitch);

  if (bus_name == "midi_novation") {
    //setConsola("Note Off:"+"Channel:"+channel+" Pitch "+pitch);
    ACTIVECHANNEL = channel;
    int ind = getIndice(pitch); 
    aBT[channel][ind] =!  aBT[channel][ind] ;
    if (channel == 7 ) listenChannel7(channel, pitch);
   
    /* if (channel == 15 ) listenChannel15(channel, pitch); //colores
     if (channel == 9 ) listenChannel9(channel, pitch); //bg
     if (channel == 8 ) listenChannel8(channel, pitch); //particles*/
    if (channel < 8) {
      if ( aBT[channel][ind])  midi_novation.sendMessage(Integer.decode("0x9"+channel), pitch, byte_red);
      else midi_novation.sendMessage(Integer.decode("0x8"+channel), pitch, byte_red);
    }
    setConsola("aBT["+channel+"]["+ind+"]"+aBT[channel][ind]);
  }
}
void listenChannel7(int channel, int pitch) {
  if (channel == 7 ) //TEMPLATE 8 > Presets listeners
  {
    //si el boton esta en on activamos, si no no
    int ind = getIndice(pitch);
    if (ind < NUM_PRESETS) {
      if ( aBT[channel][ind]) presets[ind].setPreset(true); 
      else presets[ind].setPreset(false);
      setConsola("presets ind"+ind+ "is"+presets[ind].getPreset());
    }
  }
}
void listenChannel14(int channel, int pitch) {

  if (channel == 14 ) 
  {
    brush.changeImg(getIndice(pitch));
  }
}
void listenChannel8(int channel, int pitch) {

  if (channel == 8 ) //TEMPLATE 9 > Pfactory PALETTE
  {
    presets[0].changeTipo(getIndice(pitch));
  }
}
void listenChannel15(int channel, int pitch) {
  setConsola("channel 15");
  if (channel == 15 ) //TEMPLATE 9 > Pfactory PALETTE
  {
    COLORACTIVE = getIndice(pitch);
    o_colores.setPalette(COLORACTIVE);
  }
}
void listenChannel13(int channel, int pitch) {

  if (channel == 13 ) //TEMPLATE 9 > Pfactory PALETTE
  {
    int active = getIndice(pitch);
    bg.changeImg(active);
  }

  //if ( aBT[9][9]) bg.setBg();
}
void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

int getNote(int indice) {
  int v = -1;
  for ( int i=0; i< aKeyMaps.length; i ++ ) {

    if (  i  == indice)  v= aKeyMaps[i];
  }
  return v;
}
int getIndice(int note) {
  int v = -1;
  for ( int i=0; i< aKeyMaps.length; i ++ ) {
    //setConsola("aKeyMaps[ i ]"+aKeyMaps[ i ]+ "indice:"+i);
    if (  aKeyMaps[ i ]  == note)  v= i;
  }
  return v;
}
int getIndiceKnob(int value) {

  int v = -1;
  for ( int i=0; i< aKnobsMidiMapping.length; i ++ ) {
    //setConsola("aKeyMaps[ i ]"+aKeyMaps[ i ]+ "indice:"+i);
    if (  aKnobsMidiMapping[ i ]  == value)  v= i;
  }
  return v;
}
void midiMessage(MidiMessage message) { // You can also use midiMessage(MidiMessage message, long timestamp, String bus_name)
  // Receive a MidiMessage
  // MidiMessage is an abstract class, the actual passed object will be either javax.sound.midi.MetaMessage, javax.sound.midi.ShortMessage, javax.sound.midi.SysexMessage.
  // Check it out here http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/package-summary.html
  /* setConsola();
   setConsola("MidiMessage Data:");
   setConsola("--------");
   setConsola("Status Byte/MIDI Command:"+message.getStatus());
   for (int i = 1; i < message.getMessage ().length; i++) {
   setConsola("Param "+(i+1)+": "+(message.getMessage()[i] & 0xFF));
   }*/
}
/* ------------------------    CONTROLLER IN KONTROL ---------------------------------------------------------*/
void controllerIn_kontrol(int num, int valor) {
  try {

    switch(num) {


      //-----------------------knobs inicio----------------
    case 1: 
      KNOB_1 =  map(valor, 0, 127, 0, 100);
      INC = int(map(valor, 0, 127, 0, INCMAX));
      sendConsola("MIDI >> INC:"+INC+ "valor:" + valor);

      sendConsola("MIDI >> RADIO_TOXI:"+RADIO_TOXI);

      break;
    case 2: 
      KNOB_2 =  map(valor, 0, 127, 0, 100);
      RADIO = map(valor, 0, 127, 0, RADIOMAXIM);
      //onionData.setParam1(RADIO, "RADIO", RADIOMAXIM);
      sendConsola("MIDI >> RADIO:"+RADIO);

      break;  
    case 3: 
      KNOB_3 =map(valor, 0, 127, 0, 360);

      ATRACCION = map(valor, 0, 127, 0, 900);
      sendConsola("MIDI >> ATRACCIONO:"+ATRACCION);
      break;   
    case 4: 
      KNOB_4 = map(valor, 0, 127, 0, 255);
      sendConsola("MIDI >> KNOB_4:"+KNOB_4);
      break;
    case 5: 
      KNOB_5 = map(valor, 0, 127, 0, 255); 
      DAMPING_POINT=  map(valor, 0, 127, 0.0f, 1.0f);
      SPEEDY =  map(valor, 0, 127, 0, 900);
      sendConsola("MIDI >> DAMPING_POINT:"+DAMPING_POINT);
      break; 
    case 6: 
      KNOB_6= map(valor, 0, 127, 0, 255);
      FADER_2 = map(valor, 0, 127, 0, 200);
      SPEEDX =  map(valor, 0, 127, 0, 900);
      sendConsola("MIDI >> FADER_2:"+FADER_2);
      break;
    case 7:
      KNOB_7= map(valor, 0, 127, 1, 200);
      sendConsola("MIDI >> KNOB_7:"+ KNOB_7);
      break;
    case 8:
      KNOB_8= map(valor, 0, 127, 1, 100);
      sendConsola("MIDI >> KNOB_8:"+ KNOB_8);
      STROKE_ALFA = map(valor, 0, 127, 0, 255);   
      sendConsola("MIDI >> STROKE_ALFAA:"+STROKE_ALFA);
      break;   

      //-----------------------knobs FIN----------------  

      //-----------------------botones ----------------
    case 91:  
      if (valor == 127 ) BT_91=true; 
      else BT_91=false;
      sendConsola("MIDI >> BT_91:"+BT_91);
      break;

    case 92: 

      BT_92  =  (valor==127) ? true : false;
      //o_fade.setFade();

      break; 

    case 94:  
      TIPO = 5;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_94  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_94);
      break;
    case 95: 
      sendConsola("MIDI >>  TIPO:"+ TIPO); 
      BT_94  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_95);

      break;
    case 96: 

      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_96  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_96:"+BT_96);
      brush.listener();

      break;
    case 97: 
      TIPO = 1; 
      INTCOLOR=1;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_97  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_97);

      break;
    case 98: 
      TIPO = 2;
      INTCOLOR=2;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_98  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_98);

      break;
    case 99: 
      TIPO = 3; 
      INTCOLOR=3;
      sendConsola("MIDI >>  TIPO:"+ TIPO);
      BT_99  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_93:"+BT_99);

      break;
    case 100:  
      BT_100  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_100:"+BT_100);
      if (BT_100) siluetas.selectSiluetaRetroceder();

      break;
    case 101:  
      BT_101  =  (valor==127) ? true : false;
      sendConsola("MIDI >> BT_101:"+BT_101);
      if (BT_101) siluetas.selectSiluetaAvanzar();
      break;

      //-----------------------botones ---------------
    case 11: 
      BT_11  =  (valor==127) ? true : false;
      sendConsola("BT_11 >>  "+BT_11);
      break;
    case 12: 
      BT_12  =  (valor==127) ? true : false;
      sendConsola("BT_12 >>  "+BT_12);
      break;
    case 13: 
      BT_13  =  (valor==127) ? true : false;
      sendConsola("BT_13 >>  "+BT_13);
      break;

    case 21: 
      BT_21  =  (valor==127) ? true : false;
      sendConsola("BT_21 >>  "+BT_21);
      break;
    case 22: 
      BT_22  =  (valor==127) ? true : false;
      sendConsola("BT_22 >>  "+BT_22);
      break;
    case 23: 
      BT_23  =  (valor==127) ? true : false;
      sendConsola("BT_23 >>  "+BT_23);
      break;      

    case 31: 
      BT_31  =  (valor==127) ? true : false;
      sendConsola("BT_31 >>  "+BT_31);
      break;
    case 32: 
      BT_32  =  (valor==127) ? true : false;
      sendConsola("BT_32 >>  "+BT_32);
      break;
    case 33: 
      BT_33  =  (valor==127) ? true : false;
      sendConsola("BT_33 >>  "+BT_33);
      break;      

    case 41: 
      BT_41  =  (valor==127) ? true : false;
      sendConsola("BT_41 >>  "+BT_41);
      break;
    case 42: 
      BT_42  =  (valor==127) ? true : false;
      sendConsola("BT_42 >>  "+BT_42);
      break;
    case 43: 
      BT_43  =  (valor==127) ? true : false;
      sendConsola("BT_43 >>  "+BT_43);
      break;      

    case 51: 
      BT_51  =  (valor==127) ? true : false;
      sendConsola("BT_51 >>  "+BT_51);
      break;
    case 52: 
      BT_52  =  (valor==127) ? true : false;
      sendConsola("BT_52 >>  "+BT_52);
      break;
    case 53: 
      BT_53  =  (valor==127) ? true : false;
      sendConsola("BT_53 >>  "+BT_53);
      break;      

    case 61: 
      BT_61  =  (valor==127) ? true : false;
      sendConsola("BT_41 >>  "+BT_61);
      break;
    case 62: 
      BT_62  =  (valor==127) ? true : false;
      sendConsola("BT_52 >>  "+BT_62);
      break;
    case 63: 
      BT_63  =  (valor==127) ? true : false;
      sendConsola("BT_53 >>  "+BT_63);
      break; 

    case 71: 
      BT_71  =  (valor==127) ? true : false;
      sendConsola("BT_71 >>  "+BT_71);
      break;
    case 72: 
      BT_72  =  (valor==127) ? true : false;
      sendConsola("BT_72 >>  "+BT_72);
      break;
    case 73: 
      BT_73  =  (valor==127) ? true : false;
      sendConsola("BT_73 >>  "+BT_73);
      break; 

    case 81: 

      BT_81  =  (valor==127) ? true : false;
      sendConsola("BT_81 >>  "+BT_81);
      break;
    case 82: 
      BT_82  =  (valor==127) ? true : false;
      sendConsola("BT_82 >>  "+BT_82);
      break;
    case 83: 
      BT_83  =  (valor==127) ? true : false;
      sendConsola("BT_83 >>  "+BT_83);
      break; 
    case 93: 
      BT_93  =  (valor==127) ? true : false;
      sendConsola("BT_93 >>  "+BT_93);

      break; 




      //-----------------------FADERS ---------------
    case 10: 
      FADER_1 = map(valor, 0, 127, 0, 10);
      //  sendConsola("FADER_1 >>  "+FADER_1);
      SPEED = map(valor, 0, 127, 0, 10);
      // sendConsola("MIDI >> SPEED:"+SPEED);
      FORCE = map(valor, 0, 127, -20, 20);
      sendConsola("MIDI >> FORCE:"+FORCE);
      break;

    case 20: 
      // FADER_2 = map(valor, 0, 127, 0, 255);
      //sendConsola("FADER_2 >>  "+FADER_2);
      break;
    case 30: 
      SPEED_FADE = map(valor, 0, 127, 0, 10);
      FADER_3 =  map(valor, 0, 127, 0, 200);
      sendConsola("FADER_3  >> FADER_3:"+FADER_3 );

      break;
    case 40: 

      FADER_4 =  map(valor, 0, 127, 0, 255);
      sendConsola("FADER_4  >> FADER_4:"+FADER_4 );

      break;
    case 50: 
      if ( BT_52 ) {

        FADER_51 =  map(valor, 0, 127, 0, 100);
        sendConsola("FADER_51  >> FADER_51:"+FADER_51 );
      } else
      {
        STRENGTH_POINT =  map(valor, 0, 127, 0f, 5.0f);
        sendConsola("MIDI >>STRENGTH_POINT:"+STRENGTH_POINT);
        FADER_5 =  map(valor, 0, 127, 0, 255);
        sendConsola("FADER_5  >> FADER_5:"+FADER_5 );
      }

      break;
    case 60: 
      FADER_6 =  map(valor, 0, 127, 0, 255);
      SPEED_SHIFT = map(valor, 0, 127, 1, 10);
      sendConsola("FADER_6  >> FADER_6:"+FADER_6 );
      break;

    case 70: 
      if ( BT_72 ) { 
        FADER_71 = map(valor, 0, 127, 0, 200);
        sendConsola("FADER_71  >> FADER_71:"+FADER_71 );
      } else
      {
      }
      FADER_7 = map(valor, 0, 127, 0, 200);
      sendConsola("FADER_7 >>  "+FADER_7);
      VOLUMEN  = map(valor, 0, 127, 1, 900);

      break;
    case 80: 
      ALFA = map(valor, 0, 127, 0, 255);
      sendConsola("MIDI >> alfa:"+ALFA);
      FADER_8 = map(valor, 0, 127, 0, 255);
      sendConsola("FADER_8 >>  "+FADER_8);
      break;
    }
  }
  catch(Exception e) {
    println("***************Exception: "+e.toString()+"\n");
  }
}