int res = 20;

float angle = 0;
float n; //will actually be int but necessary to be float so some divisions arent truncated
float maxDist;

void setup(){
  size(800,800,P3D);
  n = width/(2*res); //assumes width=height
  maxDist = sqrt(sq(n/2) + sq(n/2));
  //println(maxDist);
  //colorMode(HSB);
}

void draw(){
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
      float offset = map(dist, 0, maxDist, 0, TWO_PI);
      float h = map(sin(angle-offset), -1, 1, 50, 300);
      float mult = map(dist, 0, maxDist, 1, 1.5);
      
      translate(-x*res, -y*res, 0);
      float hue = map(dist, 0, maxDist, 0, 255);
      fill(hue, 255, 255);
      box(0.9*res, 0.9*res, mult*h);
    
      popMatrix();
    }
  }
  angle += 0.05;
}
