import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class drawconnectors extends PApplet {

float lastx = -1;
float lasty = -1;

public void setup() {
  size(480, 480);
}

public void draw() {
  if (mousePressed) {
    fill(0);
    ellipse(mouseX, mouseY, 8, 8);
    drawline();
  }
  
}

public void drawline(){
  if (lastx != -1){
  line(lastx, lasty, mouseX, mouseY);
  }
  lastx = mouseX;
  lasty = mouseY;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "drawconnectors" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
