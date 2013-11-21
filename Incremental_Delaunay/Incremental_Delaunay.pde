vertex testpoint;
vertex endpoint;
vertex pointy;
halfEdge testedge;
halfEdge edge1;
halfEdge edge2;
halfEdge edge3;
vertex currentpoint;
boolean firstClick;
int padding = 200;
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
    this.display();
   
        
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
    }
    else return false;
}

void setup() {
  testpoint = new vertex( 200, 250);
  endpoint = new vertex( 210, 270);
  pointy = new vertex( 300, 300);
  testedge = new halfEdge(testpoint, endpoint);
  size(480, 480);
  background(255);
  firstClick = true;
}

void draw() {
  testedge.display();
  testedge.displayFace();
}

void mouseClicked() {
  
  currentpoint = new vertex(mouseX, mouseY);
  triangleNode tNode;
  if (firstClick == true){
    tNode = makeFirstTriangle(currentpoint);
  }
  else tNode = makeFirstTriangle(currentpoint);
  println(onFace(currentpoint, testedge));
  currentpoint.display();
  //triangulate(currentpoint);
  split(tNode, currentpoint);
}

triangleNode makeFirstTriangle(vertex p) {
    vertex vertexA;
    vertex vertexB;
    vertex vertexC;
    halfEdge A;
    halfEdge B;
    halfEdge C;
    triangleNode tNodeInitial;
    vertexA = new vertex(p.x-padding, p.y-padding);
    vertexB = new vertex(p.x-padding, p.y+padding);
    vertexC = new vertex(p.x+padding, p.y);
    A = new halfEdge(vertexA,vertexB);
    B = new halfEdge(vertexB,vertexC);
    C = new halfEdge(vertexC,vertexA); //counter-clockwise
    A.next = B;
    B.next = C;
    C.next = A;
    A.prev = C;
    B.prev = A;
    C.prev = B;
    firstClick = false;
    tNodeInitial = new triangleNode(A,B,C);
    return tNodeInitial;  
}

class triangleNode {
  halfEdge halfOne;
  halfEdge halfTwo;
  halfEdge halfThree;
  ArrayList<triangleNode> childrenList;
  triangleNode (halfEdge halfA, halfEdge halfB, halfEdge halfC) {
    halfOne = halfA;
    halfTwo = halfB;
    halfThree = halfC;
    childrenList = new ArrayList<triangleNode>();
  }
  
  boolean isLeaf(){
    if (childrenList.size() == 0) {
      return true;
    }
    else return false;
  }
}

// class triangleHierarchy {
//}

void split(triangleNode node, vertex p){
   halfEdge halfOne = node.halfOne;
   halfEdge halfTwo = node.halfTwo;
   halfEdge halfThree = node.halfThree;
   
   halfOne.next = new halfEdge(halfOne.destination, p);
   halfOne.prev = new halfEdge(p, halfOne.origin);
   
   halfTwo.next = new halfEdge(halfTwo.destination, p);
   halfTwo.prev = new halfEdge(p, halfTwo.origin);
   
   halfThree.next = new halfEdge(halfThree.destination, p);
   halfThree.prev = new halfEdge(p, halfThree.origin);

   halfOne.next.prev = halfOne;
   halfOne.next.next = halfOne.prev;
   
   halfOne.prev.next = halfOne;
   halfOne.prev.prev = halfOne.prev;
   
   halfTwo.next.prev = halfTwo;
   halfTwo.next.next = halfTwo.prev;
   
   halfTwo.prev.next = halfTwo;
   halfTwo.prev.prev = halfTwo.prev;
   
   halfThree.next.prev = halfThree;
   halfThree.next.next = halfThree.prev;
   
   halfThree.prev.next = halfThree;
   halfThree.prev.prev = halfThree.prev;
   
   halfOne.next.twin = halfTwo.prev;
   halfTwo.prev.twin = halfOne.next;
   
   halfTwo.next.twin = halfThree.prev;
   halfThree.prev.twin = halfTwo.next;
   
   halfThree.next.twin = halfOne.prev;
   halfOne.prev.twin = halfThree.next;
   
   
}
  
 


