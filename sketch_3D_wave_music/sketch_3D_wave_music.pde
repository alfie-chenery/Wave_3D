import processing.sound.*;
Amplitude amp;
AudioIn mic;
//SinOsc sin;
//SoundFile music;
//FFT fft;
//int bands = 512; //must be power of 2 for FFT constructor
//float[] spectrum = new float[bands];

int res = 10;
int arrayLength = 60;
boolean applyMult = true; //applies multiplier to blocks further from centre

float n; //will actually be int but necessary to be float so some divisions arent truncated
float maxDist;
FloatList history;

void setup(){
  frameRate(60);
  size(800,800,P3D);
  n = width/(2*res); //assumes width=height
  maxDist = sqrt(sq(n/2) + sq(n/2));
  history = new FloatList();
  for(int i=0; i<arrayLength; i++){
    history.append(0); 
  }
  colorMode(HSB, 360);
  
  
  amp = new Amplitude(this);
  //sin = new SinOsc(this);
  //sin.freq(0.5);
  //amp.input(sin);
  //music = new SoundFile(this, "music.wav");
  //music.play();
  //amp.input(file);
  //fft = new FFT(this, bands);
  //fft.input(music);
  mic = new AudioIn(this);
  amp.input(mic);
}

void draw(){
  
  //fft.analyze(spectrum);
  //float average = 0;
  //for(int i=0; i<10; i++){
  //  average += spectrum[i];
  //}
  //average /= 10;
  //history.append(average);
  
  history.append(amp.analyze());
  if(history.size() > arrayLength){
    history.remove(0); 
  }
  
  translate(width/2, 3*height/4, -500);
  background(0);
  ortho();
  rotateX(radians(37.5));
  rotateZ(QUARTER_PI);
  fill(255);
  
  
  
  for(int y=0; y<n; y++){
    for(int x=0; x<n; x++){
      
      pushMatrix();
      
      float dist = sqrt(sq((n-1)/2 - x) + sq((n-1)/2 - y));
      float indexOffset = map(dist, 0, maxDist, 0, arrayLength-1);
      float h = map(history.get( round(arrayLength-1 - indexOffset) ), 0, 1, 50, 300);
      float mult = 1;
      if(applyMult){
        mult = map(dist, 0, maxDist, 1, 3);
      }
      h = h*mult;
      
      translate(-x*res, -y*res, 0);
      float hue = map(h, 50, (applyMult ? 300 : 100), 120, 0);
      fill(hue, 360, 360);
      box(0.9*res, 0.9*res, h);
    
      popMatrix();
    }
  }
}
