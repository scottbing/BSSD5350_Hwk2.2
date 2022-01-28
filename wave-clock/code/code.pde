import processing.pdf.*;

HelperFunctions hf = new HelperFunctions();

//Lesson 1.1
//Code taken from Daniel Shiffman's video below and modified with comments
// https://www.voutube.com/watch?v=o8dffr286os&list=PL6Uak5uKONDGXWAL99560YA D78 fM&index=9


float _angnoise, _radiusnoise;
float _xnoise, _ynoise;
float _angle = -PI/2;
float _radius;  float _strokeCol = 54;
int _strokeChange = -1;

int backgroundColor = 180;
int strokeW = 1;
int factor = height/16;
int padding = 20;
int x0, y0, x1, y1;    // Line start and end
float vpct = 0.29;     // Variation in line as %
float llength;         // Line length
float lthresh = 7.0;
int count = 0;


void setup() {
  size(700, 500);
  smooth();
  frameRate(30);
  background(180);
  noFill();
  _angnoise = random(10);
  _radiusnoise = random(10);
  _xnoise = random(10);
  _ynoise = random(10);
}


  void draw() {
   ColorPalette randomC = new ColorPalette();
  _radiusnoise += 0.005;
  _radius = (noise(_radiusnoise) * 550) +1;
  _angnoise += 0.005;
  _angle += (noise(_angnoise) * 6) - 3;
  if (_angle > 360) { _angle -= 360; }
  if (_angle < 0) { _angle += 360; }
  _xnoise += 0.01;
  _ynoise += 0.01;
  float centerX = width/2 + (noise(_xnoise) * 100) - 50;
  float centerY = height/2 + (noise(_ynoise) * 100) - 50;
  float rad = radians(_angle);
  float x1 = centerX + (_radius * cos(rad));
  float y1 = centerY + (_radius * sin(rad));
  float opprad = rad + PI;
  float x2 = centerX + (_radius * cos(opprad));
  float y2 = centerY + (_radius * sin(opprad));
  _strokeCol += _strokeChange;
  if (_strokeCol > 254) { _strokeChange = -1; }
  if (_strokeCol < 0) { _strokeChange = 1; }
  stroke(_strokeCol, 60);
  stroke(random(0,255), random(0,255), random(0,255));
  strokeWeight(1);
  line(x1, y1, x2, y2);
}

color blendColors(color col, color bg) {
  //original psuedocode and math from this answer:
  // https://stackoverflow.com/a/2645218/255.0);
  float blendR = ((1.0 - (alpha(col)/255.0))*red(bg)/255.0) + (alpha(col)/255.0*red(col)/255.0);
  float blendG = ((1.0 - (alpha(col)/255.0))*green(bg)/255.0) + (alpha(col)/255.0*green(col)/255.0);
  float blendB = ((1.0 - (alpha(col)/255.0))*blue(bg)/255.0) + (alpha(col)/255.0*blue(col)/255.0);
  
  color blended = color(int(blendR*255), int(blendG+255), int(blendB*255));
  return blended;
}
