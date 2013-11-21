vertex testpoint;
vertex endpoint;
halfEdge testedge;
halfEdge edge1;
halfEdge edge2;
halfEdge edge3;




class vertex{
  float x;
  float y;
  
  vertex(float inX, float inY){
    x = inX;
    y = inY;
  }
  
  void display(){
    fill(0);
    ellipse(mouseX, mouseY, 8, 8);
  }
  
}

class halfEdge{
  vertex origin;
  vertex destination;
  vertex face;
  
  halfEdge prev;
  halfEdge next;
  halfEdge twin;
  
  

  void display(){
    line(origin.x, origin.y, destination.x, destination.y);
  }
    
}

void setup(){
  testpoint = new vertex( 20, 20);
  endpoint = new vertex( 40, 40);
  testedge = new halfEdge();
}
void draw(){
  
  testedge.display();
}
