/*sound*/
float[] PESO; //Ajust for precieved sound levels
int LONG = 48;
int INCMAX = 256;

/*-----------------------------------------------------------------*/
class Sound_fft {

  Sound_fft(PApplet parent) {
  }
  public void setDamper(float damper) {
  }
  public void draw() {
    // dibujaSpectrum();
  }
  public float get_LiveInput(int i) {
    return onionData.getCadenaFreq(i);
  }


  public float get_fft(int i) {
    //setConsola("myFFT.spectrum[i]"+myFFT.spectrum[i]);
    return onionData.getCadenaFreq(i);
    //  else   return myFFT.spectrum[i];
  }
  public float getLevel() {

    return onionData.getLevel();

    //else   return myFFT.getLevel(myInput);
  }

  public float getSpectrumLenght() {

    return  onionData.getLongCadenaFreq();
    // else    return  onionData.getLongCadenaFreq();
  }
  public boolean isBeat() {
    return false;
  }

  public float getMediaLow() {
    return onionData.medLow;
  }
  public float getMediaLow2() {
    return onionData.medLow2;
  }
  public float getMediaHi() {
    return onionData.medHi;
  }
  public float getMediaMed() {
    return onionData.medMed;
  }
  public float getMedia(int in, int out) {
    float mitja = 0;
    for (int i=in; i<out; i++) {
      mitja+= onionData.getCadenaFreq(i);
      // else    return  onionData.getLongCadenaFreq();
    }


    mitja=mitja/(out-in);
    // setConsola("----mitja:"+mitja);
    return(mitja);
  }
  public void stop() {
    // Ess.stop();
    //super.stop();
  }
}