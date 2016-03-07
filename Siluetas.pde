
class Siluetas {
  String directorio;
  boolean  usarRatonINIT= USARRATON;
  int[] mx;      //records mouseX locations
  int[] my;      //records mouseY locations
  int history=100;      //how many states the mouse is recorded
  int drawCounter=0;  //counts delays for the...
  int drawDelay=4;    //delay that must pass before the mouse is recorded again
  public boolean isDibujar = false;
  boolean isAnim = false;
  int siluetaActiva= 0;
  //the higher the number the smoother the curves but less responsive it is
  PGraphics pg;  
  ArrayList  formas ;
  boolean activadas=false; 
  Siluetas(String _directorio) {
    mx=new int[history];
    my=new int[history];
    stroke(0);
    directorio = _directorio;
    formas = new ArrayList();

    pg = createGraphics(width,height);
    cargarMask();
  }
  public void changeSiluetas(int _num) {
    if (_num <  formas.size())  siluetaActiva= _num;
    //setConsola("siluetaActiva:"+siluetaActiva);
  }
  public void selectSiluetaAvanzar() {
    if (siluetaActiva == formas.size()-1) siluetaActiva  = 0;
    else siluetaActiva++;
  }
  public void selectSiluetaRetroceder() {
    if (siluetaActiva == 0) siluetaActiva  = formas.size()-1;
    else siluetaActiva--;
  }
  public void render() {
    draw(); 
    activadas = BT_12;//kontrol
    isInvert= BT_13; //kontrol
    if (activadas==true) {
      //setConsola("------activadas");
      
      displayInvert(255,255);
      if (isPosition ) {
       
        move(mouseX,mouseY);
      }
      if (isResize) rresize(ancho,alto);
    }
  }


  void  cargarMask() {

    //recorreremos el directorio y cargaremos todas las mascaras en Form

    String[] listado = new String[100];
    listado = leerDirectorio(directorio);
 
    int numSiluetas = listado.length / 2;
    setConsola("-----cargarMask:"+directorio+" NUMERO DE IMAGENES:"+numSiluetas);
    if (listado.length > 0) {
      for (int i=0; i<numSiluetas; i++) {
        String nomimg = "siluetas/imagen"+i+".png";
        String nomimgmask = "siluetas/imagen"+i+"_a.png";
        File file=new File(dataPath(nomimg));
        File file2=new File(dataPath(nomimgmask));
        boolean exists =file.exists(); 
        boolean exists2 =file2.exists();
        if (!exists || !exists2) {
          setConsola("Mask > No existen archivos de maskara: "+dataPath(nomimg));
        }
        else {
          setConsola("Mask > añadimos maskara:i "+i +"name:"+ nomimg +" "+nomimgmask);
          formas.add(new Formas(i,nomimg,nomimgmask)); //añadimos a mi ArrayList de formas
        }
      }
    }
    else setConsola("Mask > no existen archivos de maskaras");
    siluetaActiva = 0;
  }
  void displayInvert(int i,color colorr) {

   //setConsola("siluetaActiva;"+siluetaActiva);
    Formas formatemp = (Formas) formas.get(siluetaActiva);
   // setConsola("displayInvert:"+siluetaActiva);
    if (!isInvert) formatemp.displayInvert(colorr);
    else formatemp.display(colorr);
  }
  public void activaSiluetas() {
    activadas = !activadas;
  }
  public void move(float posx,float posy) {
    setConsola("move:"+posx);
    Formas formatemp = (Formas) formas.get(siluetaActiva);

    formatemp.move(posx,posy);
  } 
  public void rresize(float _ancho,float _alto) {

    Formas formatemp = (Formas) formas.get(siluetaActiva);
    //setConsola("isInvert:"+isInvert);
    formatemp.rresize(_ancho,_alto);
  } 
  public void setSiluetas() {
    activadas = false;
    isPosition = false;
    isResize  = false;
    if (  isDibujar ) {
      isDibujar = false;
      ancho = 0;
      alto = 0;
      salvar();
    }
    else isDibujar = true;
    //setConsola("setSiluetas>> isDibujar:"+isDibujar);
  }


  void draw()
  {
    if (isDibujar) dibujar();
    else noCursor();
  }
  void dibujar() {

    USARRATON = true;
    //setConsola("SILUETAS > dibujar");
    //delete();
    cursor(CROSS);

    if ( TIPO == 3 ) {
      
    }

    {
      if(mousePressed && (TIPO ==1 || TIPO == 2)) {
       
        pg.beginDraw();
        // pg.fill(255);
        pg.fill(255);
        pg.noStroke();
        if (TIPO == 1 )   {
          noStroke();
        pg.ellipse(mouseX,mouseY,RADIO,RADIO);
        }

        if (TIPO == 2 ) { 
          pg.rectMode(CENTER); 
          pg.rect(mouseX,mouseY,RADIO,RADIO); 
          pg.rectMode(CORNER);
        }
        pg.endDraw();

        image(pg,width/2,height/2);
      }
    }
  }



  void display(int i) {
    if (formas.size() > i) {
      Formas formatemp = (Formas) formas.get(i);
      formatemp.display();
    }
  }


  void delete() {

    drawCounter = 0;
    formas.clear();
  }
  void display(int i,color colorr) {
    if (formas.size() > i) {
      Formas formatemp = (Formas) formas.get(i);
      formatemp.display(colorr);
    }
  }  
  void salvar() {
    drawCounter = formas.size();
    setConsola("---------------------      salvar:"+drawCounter);

   // pg.endDraw();
    //delete();
    if (TIPO !=3) background(0);
    // if(drawCounter>0){

    String nombreImagen = "siluetas/imagen"+ formas.size()+".png";
    String nombreImagenAlfa = "siluetas/imagen"+ formas.size()+"_a.png";

    formas.add(new Formas( drawCounter,nombreImagen,nombreImagenAlfa,pg)); //añadimos a mi ArrayList de formas

    //inicializamos el dibujador
    //drawCounter = 0;
    mx=new int[history];
    my=new int[history];
    isDibujar=false;
    USARRATON = usarRatonINIT;
    pg = createGraphics(width, height); 

    // }
  }
  private String [] leerDirectorio(String _path) {
    //setConsola("LEEEEER DIRECTORIO:"+_path);
    File dir = new File(_path);  
    String[] children =  dir.list();
    if (children == null) {
      setConsola("*******  error en la lectura del directorio >>"+_path);
    } 
    else {
      //setConsola("*******  list >>"+_path +"children.length:"+children.length);    
      for (int i=0; i<children.length; i++) {
        children[i] = _path + children[i];
        //setConsola("*******  formas["+i+"] >>"+children[i]);
      }
    } 
    return children;
  }
}

class Formas {
  PGraphics grafico;
  PImage img;
  String nombreimg;
  String nombreimgalfa;
  int i;
  float posx,posy;
  float ancho,alto;
  float anchoinc ;
  float altoinc;
  color colorear = color(255);
  PImage imga;
  Formas(int i,String nombreimg,String nombreimgalfa,PGraphics grafico) {
    this.i  = i;
    this.nombreimg  = nombreimg;
    this.nombreimgalfa  = nombreimgalfa;
    this.grafico  = grafico;
    this.posx = 0;
    this.posy =0;
    //setConsola("------------new siluetas"+i);
    salvar();
  }
  Formas(int i,String nombreimg,String nombreimgalfa) {
    setConsola("Mask: int siluetas ");
    this.i  = i;
    this.nombreimg  = nombreimg;
    this.nombreimgalfa  = nombreimgalfa;
    this.posx = 0;
    this.posy = 0;
    setConsola("------------new siluetas saved"+ this.i);

    cargar();
  }
  public void move(float posx, float posy) {
    this.posx = posx;
    this.posy = posy;
  }
  void cargar() {
    setConsola("-------------------- cargamos:"+nombreimg+ " nombreimgalfa"+nombreimgalfa);
    imga = loadImage(nombreimgalfa);
    img = loadImage(nombreimg);
    ancho = img.width;
    alto = img.height;
  }
  void salvar() {
    setConsola("---------------------------------salvamos imagen:"+nombreimg);
    grafico.save("data/"+nombreimg);
   // image(grafico,width/2,height/2);
  
  
   background(0);
 delay(2000);
 println("invertir");
 
   img = loadImage(nombreimg);
   imageMode(CORNER);
  image(img,0,0,width,height);
  imageMode(CENTER);
  invertir();
  }
  void display() {

    File file=new File(nombreimg);
    noTint();

//setConsola("display");
    image(img,0,0);
  }

  void invertir() {


  PGraphics pg = createGraphics(width, height); 
    pg.beginDraw();
    // pg.background(255,0,0);
    //pg.background(0);
    
    // pg.background(255);
   // int dimension = (img.width*img.height);
    img.filter(THRESHOLD, 0.2);
    img.loadPixels();
    pg.loadPixels();
    // img.filter(GREY);
    for (int i=0; i < img.pixels.length; i++) { 
      if (img.pixels[i] ==  color(255)) {
      
      }
      else
      {
         pg.pixels[i] = color(0);
      }
     
     
    }
     pg.updatePixels();
      pg.endDraw();
     pg.save("data/"+nombreimgalfa);
      println("---------------------------------salvamos imagen invertir:"+nombreimgalfa);
      delay(2000);
      imga = loadImage(nombreimgalfa);
      
      cargar();
  }

  public void invertir(String rutaImagen) {
     PImage img = loadImage (rutaImagen);
      PGraphics pg = createGraphics(width, height, P3D); 
      pg.beginDraw();
      int dimension = (img.width*img.height);
      for (int i=0; i < dimension; i++) { 
        if ( color(img.pixels[i]) != color(255, 255, 255)) {
          pg.pixels[i] = color(0, 0, 0);
        }
      } 
      pg.endDraw();
      pg.save("data/"+nombreimgalfa);
     // println("SILUETAS > invertir "+nombreimgalfa);
      imga = loadImage(nombreimgalfa);
  }
  public void rresize(float _ancho,float _alto) {
    this.anchoinc = _ancho;
    this.altoinc = _alto;
    setConsola("rresize altoinc+"+altoinc);
  }
  void display(color colorr) {
    //setConsola("Siluetas: invert"+isInvert +"posx:"+posx);
    imageMode(CORNER);
    File file=new File(nombreimg);

    //if (oneColor) tint(o_colores.getColor(0),ALFA);
    image(img, posx, posy,ancho+anchoinc,alto+altoinc);
    // setConsola("alto+"+altoinc);
    imageMode(CENTER);
  }
  void displayInvert(color colorr) {
    imageMode(CORNER);

    tint(0,255);
    
   // noTint();
   // setConsola("displayInvert: ancho"+ancho +"posx:"+posx);
    image(imga,posx,posy,ancho+anchoinc,alto+altoinc);
    imageMode(CENTER);
  }
}