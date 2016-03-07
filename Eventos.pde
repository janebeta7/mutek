import controlP5.*;
ControlP5 cp5;
void setupkeys() {
  try {
  cp5 = new ControlP5(this);

  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(0);
    }
  }
  , ALT, '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(1);
    }
  }
  , ALT, '2');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(2);
    }
  }
  , ALT, '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(3);
    }
  }
  , ALT, '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(4);
    }
  }
  , ALT, '5');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(5);
    }
  }
  , ALT, '6');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(6);
    }
  }
  , ALT, '7');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(7);
    }
  }
  , ALT, '8');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(8);
    }
  }
  , ALT, '9');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      brush.changeImg(9);
    }
  }
  , ALT, '0');
  //Bbackgrounds
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(0);
    }
  }
  , SHIFT, '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(1);
    }
  }
  , SHIFT, '2');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(2);
    }
  }
  , SHIFT, '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(3);
    }
  }
  , SHIFT, '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(4);
    }
  }
  , SHIFT, '5');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(5);
    }
  }
  , SHIFT, '6');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(6);
    }
  }
  , SHIFT, '7');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(7);
    }
  }
  , SHIFT, '8');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(8);
    }
  }
  , SHIFT, '9');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(9);
    }
  }
  , SHIFT, '0');
 cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(10);
    }
  }
  , SHIFT, 'q');
 cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      bg.changeImg(11);
    }
  }
  , SHIFT, 'w');
  //presets
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      setOFF();
    }
  }
  , ENTER, '0');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      presets[1].listener();
    }
  }
  , ENTER, '1');
  //cp5.mapKeyFor(new ControlKey() {public void keyEvent() {presets[2].listener();}}, ENTER,'2');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      presets[3].listener();
    }
  }
  , ENTER, '2');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      presets[18].listener();
    }
  }
  , ENTER, '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
        presets[19].listener();
    }
  }
  , ENTER, '5');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      presets[6].listener();
    }
  }
  , ENTER, '6');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      presets[7].listener();
    }
  }
  , ENTER, '7');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      presets[11].listener();
    }
  }
  , ENTER, '8');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      presets[10].listener();
    }
  }
  , ENTER, '9');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      presets[10].listener();
    }
  }
  , ENTER, '7', '0');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      presets[11].listener();
    }
  }
  , ENTER, '1', '1');

  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[13].listener();
    }
  }
  , ENTER, '1', '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
     // presets[14].listener();
    }
  }
  , ENTER, '1', '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[15].listener();
    }
  }
  , ENTER, '1', '5');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[16].listener();
    }
  }
  , ENTER, '1', '6');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[17].listener();
    }
  }
  , ENTER, '1', '7');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[22].listener();
    }
  }
  , ENTER, '1', '8');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[19].listener();
    }
  }
  , ENTER, '1', '9');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[20].listener();
    }
  }
  , ENTER, '2', '0');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[21].listener();
    }
  }
  , ENTER, '2', '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[22].listener();
    }
  }
  , ENTER, '2', '2');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[23].listener();
    }
  }
  , ENTER, '2', '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[24].listener();
    }
  }
  , ENTER, '2', '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[25].listener();
    }
  }
  , ENTER, '2', '5');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[26].listener();
    }
  }
  , ENTER, '2', '6');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
     // presets[27].listener();
    }
  }
  , ENTER, '2', '7');

  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[29].listener();
    }
  }
  , ENTER, '2', '9');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //presets[30].listener();
    }
  }
  , ENTER, '3', '0');


  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(0);
    }
  }
  , '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(1);
    }
  }
  , '2');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(2);
    }
  }
  , '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(3);
    }
  }
  , '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(4);
    }
  }
  , '5');

  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(5);
    }
  }
  , '6');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(6);
    }
  }
  , '7');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(7);
    }
  }
  , '8');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(8);
    }
  }
  , '9');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(9);
    }
  }
  , '0');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(10);
    }
  }
  , '¡');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(10);
    }
  }
  , TAB, '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(11);
    }
  }
  , TAB, '2');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(12);
    }
  }
  , TAB, '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(13);
    }
  }
  , TAB, '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(14);
    }
  }
  , TAB, '5');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      o_colores.setPalette(15);
    }
  }
  , TAB, '6');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      //o_colores.setPalette(16);
    }
  }
  , TAB, '7');


  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
     
     
    }
  }
  , CONTROL, '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      println("---------change tipo------2");
presets[1].changeTipo(1);
    }
  }
  , CONTROL, '2');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      println("---------change tipo------3");
presets[1].changeTipo(2);
    }
  }
  , CONTROL, '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      println("---------change tipo------4");
presets[1].changeTipo(3);
    }
  }
  , CONTROL, '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      println("---------change tipo------5");
presets[1].changeTipo(4);
    }
  }
  , CONTROL, '5');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      println("---------change tipo------6");
presets[1].changeTipo(5);
    }
  }
  , CONTROL, '6');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      println("---------change tipo------7");
presets[1].changeTipo(6);
    }
  }
  , CONTROL, '7');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      println("---------change tipo------8");
      presets[1].changeTipo(7);
    }
  }
  , CONTROL, '8');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      println("---------change tipo------9");
presets[1].changeTipo(1);
    }
  }
  , CONTROL, '1');
  }
   catch(Exception e) {
   
   sendConsola("***************keys EXCEPTION: "+e.toString()+"\n");
   }
}
boolean[] keys = new boolean[526];
boolean checkKey(String k)
{
  for (int i = 0; i < keys.length; i++)
    if (java.awt.event.KeyEvent.getKeyText(i).toLowerCase().equals(k.toLowerCase())) return keys[i];  
  return false;
}
void keyReleased()
{ 
  keys[keyCode] = false;
}


/*---------------------------------teclado----------------------------------*/
void keyPressed() {
  try {
  keys[keyCode] = true;
  println(java.awt.event.KeyEvent.getKeyText(keyCode));
  String tecla = java.awt.event.KeyEvent.getKeyText(keyCode);
  println("tecla: "+tecla);

  if (checkKey("F1"))  
    if (checkKey("F2")) 
      if (checkKey("F3"))  
        if (checkKey("F4")) 
          if (checkKey("F5"))  
            if (checkKey("F6"))  
              if (checkKey("F7"))  
                if (checkKey("F8"))  brush.changeImg(7);


  if (key=='g') {
     presets[14].listener();
  }
  if (checkKey("Arriba")) { 
    posy = posy +100;
    println("posy+:"+alto);
  }
  if (checkKey("Abajo")) { 
    posy = posy -100;
    println("posy-:"+posy);
  }

  if (checkKey("Izquierda")) { 
    posx = posx -100;
    println("posx-:"+posx);
  }
  if (checkKey("Derecha")) { 
    posx = posx +100;
    println("posx-:"+posx);
  }
  if (keyPressed) {
    switch (key) {

    case 'f':
      isFade =! isFade;
      break;
    case 'c':
      presets[8].listener();

      break;
    case 'a':
      o_colores.setPalette();

      break;
    case 'b':
      // setBg();
      colorMode(RGB, 255);
      break;

    case 'n':
       presets[16].listener();

      break; 
    case 'm':
      presets[9].listener();


      break;  
    case 's':
      salvarImagen();

      break; 
    case 'p':
      presets[10].listener();
      break; 
    case 'x':
      presets[11].listener();
      break;    

    case 'r':
      presets[17].listener();
      
      break; 



    case 'd':
      siluetas.setSiluetas();

      break;
   
      case '1':
       o_colores.setPalette(0);
       break;
       case '2':
       o_colores.setPalette(3);
       break;
       case '3':
       o_colores.setPalette(4);
       break;       
       case '4':
       o_colores.setPalette(5);
       break;  
       case '5':
       o_colores.setPalette(6);
       break;       
       
       case '6':
       o_colores.setPalette(7);
       break;
       case '7':
       o_colores.setPalette(8);
       break;   
       case '8':
       o_colores.setPalette(9);
       break;    
       case '9':
      // o_colores.setPalette(10);
       break; 
    case '¡':
      break; 
    

    case 'e':


      break;  

    case 't':
      presets[7].listener();

      break; 




    case 'l':
      presets[13].listener();
      break; 
    case 'y':

      presets[1].listener();
      break; 
    case 'u':
      presets[12].listener();
      break; 
    case 'o':
      oneColor =! oneColor;
      println("OneColor: "+oneColor);
      break; 
    case 'i':
      presets[12].listener();

      // onionData.inicializa(); //sincronizamos con OnionData

      break; 
    case 'k':
      brush.listener();
      break; 
    case 'v':
    recording  =!recording;
    println("recording:"+recording);
    
     //presets[20].listener();
      break;  
    case '+':
      setOFF();
      break;


    case 'z':
      presets[28].reset();
      //
      break;


    case ',':
     // presets[29].listener();


      break;
    case '.':
      isSound  =!isSound;
      sendConsola("MIDI >>  isSound:"+isSound);


      break;
    case '-':
      presets[27].listener();


      break;
    }
  }
  }
   catch(Exception e) {
   
   sendConsola("***************EXCEPTION EVENTOS: "+e.toString()+"\n");
   }
}

void mousePressed()
{
  brush.f_mousePressed();
  for (int i = 0; i < presets.length; i++) {
    presets[i].f_mousePressed();
  }
}

void mouseDragged()
{
  for (int i = 0; i < presets.length; i++) {
    presets[i].f_mouseDrag();
  }
  
}

void mouseReleased()
{

  for (int i = 0; i < presets.length; i++) {
    presets[i].f_mouseReleased();
  }
}