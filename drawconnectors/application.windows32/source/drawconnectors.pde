float lastx = -1;
float lasty = -1;

void setup() {
  size(480, 480);
}

void draw() {
  if (mousePressed) {
    fill(0);
    ellipse(mouseX, mouseY, 8, 8);
    drawline();
  }
  
}

void drawline(){
  if (lastx != -1){
  line(lastx, lasty, mouseX, mouseY);
  }
  lastx = mouseX;
  lasty = mouseY;
}
