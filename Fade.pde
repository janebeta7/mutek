//clase que controla el fade in y el fade out
class Fade {
  boolean on=false;  
  Fade() {
    setConsola("Fade >> init Fade");
  }
  public void render() {
  // println("on:"+on);
    // on = aBT[0][11];
     if ( aBT[0][11]) on = true;
     else if (BT_91) on = true;
     else if (isFade) on = true;
     else on = false;
    
    if (on==true)  fade();
  }
 public void setFade(Boolean v){
   on = v;
 }
  public void setFade() {

    on =!on;
    sendConsola("Fade >> setFade:"+on);
    //setConsola("Fade >> setFade:"+on);
  }
  private void fade() {
    //println("fading");
    noStroke();
    fill(COLOR_FONDO,map(aKNOB[0][8],0,127,0,255));
   
    rectMode(CORNER);
    rect(0,0,width,height);
    //setConsola("width"+width);
  }
}