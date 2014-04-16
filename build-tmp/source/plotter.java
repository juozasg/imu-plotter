import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class plotter extends PApplet {

float x = 0;
//TODO: use optirun for the build
public void setup() {
  size(800,800,P3D);
  smooth(4);

  setupGui();
  setupText();
}


public void draw() {
  background(255);
  fill(160);
  lights();
  noStroke();


  beginCamera();
  camera();
  float fY = ((float)mouseY / height) - 0.5f;
  float fX = ((float)mouseX / width) - 0.5f;
  // translate(0, fY * height, 0);
  translate(0,0, -200);
  rotate(PI * fY, 1, 0, 0);
  rotate(-PI * fX, 0, 1, 0);
  endCamera();

  translate(400, 400);
  drawAxixArrow(400, 1, 0, 0);
  drawAxixArrow(400, 0, 1, 0);
  rotateY(PI);
  drawAxixArrow(300 + 300 * (noise(x) - 0.5f), 0, 0, 1);
  x += 0.02f;
}

public void drawAxixArrow(float length, float x, float y, float z) {
  pushMatrix();
  rotate(PI/2, x, y, z);
  drawArrow(64, 10, length);
  popMatrix();
}
public void drawArrow(int sides, float r, float h)
{
  float angle = 360 / sides;
  float h2 = h + (h * 0.05f); // arrow  height
  float r2 = r * 0.1f; // sharp arrow tip circle radius

  // starting circle
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, 0 );
  }
  endShape(CLOSE);

  // cylinder body
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, h);
    vertex( x, y, 0);
  }
  endShape(CLOSE);

  // arrowhead starting circle
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r * 1.5f;
    float y = sin( radians( i * angle ) ) * r * 1.5f;
    vertex( x, y, h );
  }
  endShape(CLOSE);

  // arrow shape
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x1 = cos( radians( i * angle ) ) * r * 1.5f;
    float y1 = sin( radians( i * angle ) ) * r * 1.5f;
    float x2 = cos( radians( i * angle ) ) * r2;
    float y2 = sin( radians( i * angle ) ) * r2;
    vertex( x1, y1, h);
    vertex( x2, y2, h2);
  }
  endShape(CLOSE);

  // arrow tip
  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r2;
    float y = sin( radians( i * angle ) ) * r2;
    vertex( x, y, h2 );
  }
  endShape(CLOSE);

 }

ControlP5 cp5;

public void setupGui()
{
  cp5 = new ControlP5(this);
  // create a new button with name 'buttonA'
  // cp5.addButton("colorA")
  //    .setValue(99)
  //    .setPosition(100,100)
  //    .setSize(200,19);
}


public void colorA(int theValue) {
  println("a button event from colorA: " + theValue);
}
PFont f;

public void setupText() {
  f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
}


public void drawText() {
  textFont(f,36);
  fill(0);
  text("Hello...",10,100);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "plotter" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
