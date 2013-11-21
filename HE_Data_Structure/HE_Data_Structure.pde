vertex testpoint;
vertex endpoint;
vertex pointy;
halfEdge testedge;
halfEdge edge1;
halfEdge edge2;
halfEdge edge3;
vertex currentpoint;

class vertex {
  float x;
  float y;

  vertex(float inX, float inY) {
    x = inX;
    y = inY;
  }

  void display() {
    fill(0);
    ellipse(x, y, 8, 8);
  }
}

class halfEdge {
  vertex origin;
  vertex destination;
  vertex face;

  halfEdge prev;
  halfEdge next;
  halfEdge twin;

  halfEdge( vertex a, vertex b) {
    origin = a;
    destination = b;
    
    float valX = b.x - a.x;
    float valY = b.y - a.y;
    
    float temp = valX * (-1);
    float faceY = a.y + temp;
    float faceX = a.x + valY;
    face = new vertex( faceX, faceY);
    
        
  }


   
  void display() {
    fill(0);
    line(origin.x, origin.y, destination.x, destination.y);
    ellipse(origin.x, origin.y, 8, 8);
    ellipse(destination.x, destination.y, 8, 8);
    

  }

  void displayFace() {
    fill(0);
    ellipse(face.x, face.y, 8, 8);
  }
}

boolean onFace( vertex p, halfEdge hE){
    boolean deterP = ( (hE.destination.x - hE.origin.x)*(p.y - hE.origin.y) ) - ( (p.x - hE.origin.x)*(hE.destination.y - hE.origin.y) ) > 0;    
    boolean deterF = ( (hE.destination.x - hE.origin.y)*(hE.face.y - hE.origin.y) ) - ( (hE.face.x - hE.origin.x)*(hE.destination.y - hE.origin.y) ) >0;    
    if ( deterP == deterF ){
      return true;
    }else return false;
    
}

void setup() {
  testpoint = new vertex( 200, 250);
  endpoint = new vertex( 210, 270);
  pointy = new vertex( 300, 300);

  testedge = new halfEdge(testpoint, endpoint);
  
  size(480, 480);
  background(255);
}

void mouseClicked() {
  //check to see if it's the first point. If so draw the giant triangle.
  //find halfedges that surround point
  currentpoint = new vertex(mouseX, mouseY);
  println(onFace(currentpoint, testedge));
  currentpoint.display();
  
}

void draw() {
  testedge.display();
  testedge.displayFace();
}

