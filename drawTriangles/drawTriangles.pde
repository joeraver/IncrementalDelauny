float beforeLastX = -1;
float beforeLastY = -1;

float lastX = -1;
float lastY = -1;

void setup() {
  size(480, 480);
}

void draw() {
  fill(0);
  
}

void mouseClicked(){
  ellipse(mouseX, mouseY, 8, 8);
  drawTriangle();
}

void drawTriangle(){
  if ((lastX == -1)||((lastX == beforeLastX)&&(lastY == beforeLastY))){ 
  }
  else if ((beforeLastX == -1) && (lastX != -1)){
    line(lastX, lastY, mouseX, mouseY);
  }
  else{
    fill(127);
    triangle (beforeLastX, beforeLastY, lastX, lastY, mouseX, mouseY);
  }
  beforeLastX = lastX;
  beforeLastY = lastY;
  print(beforeLastX + ", " + lastX);
  print("\n");
  lastX = mouseX;
  lastY = mouseY;
}
