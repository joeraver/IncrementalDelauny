vertex testpoint;
vertex endpoint;
vertex pointy;
halfEdge testEdge;
halfEdge edge1;
halfEdge edge2;
halfEdge edge3;
vertex currentpoint;
boolean firstClick;
int padding = 100;
int lastTime = 0;
ArrayList<halfEdge> edgeList = new ArrayList<halfEdge>();

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
    
    edgeList.add(this);
    
    this.display();
   
        
  }

  void display() {
    fill(0);
    line(origin.x, origin.y, destination.x, destination.y);
    ellipse(origin.x, origin.y, 8, 8);
    ellipse(destination.x, destination.y, 8, 8);
    //this.holdOn();
    displayFace();
  }
  
  void displayGreen() {
    fill(255, 0, 0);
    stroke(0, 255, 0);
    line(origin.x, origin.y, destination.x, destination.y);
    ellipse(origin.x, origin.y, 8, 8);
    ellipse(destination.x, destination.y, 8, 8);
    //this.holdOn();
    
    fill(0);
    stroke(0);
  
  }
  
  void displayRed() {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    line(origin.x, origin.y, destination.x, destination.y);
    ellipse(origin.x, origin.y, 8, 8);
    ellipse(destination.x, destination.y, 8, 8);
    //this.holdOn();
    
    fill(0);
    stroke(0);
  
  }
  
  void displayBlue() {
    fill(255, 0, 0);
    stroke(0, 0, 255);
    line(origin.x, origin.y, destination.x, destination.y);
    ellipse(origin.x, origin.y, 8, 8);
    ellipse(destination.x, destination.y, 8, 8);
    //this.holdOn();
    
    fill(0);
    stroke(0);
  
  }

  void holdOn() {
    lastTime = second();
    if ((second() - lastTime) < 3){
      this.holdOn();
    }
  }
  
  void displayFace() {
    fill(0);
    ellipse(face.x, face.y, 8, 8);
    
    line(face.x, face.y, face.x + (destination.x - origin.x)*.3 ,face.y + (destination.y - origin.y)*.3 );
    
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
  size(600, 600);
  background(255);
  firstClick = true;
}

void draw() {
}

void mouseClicked() {
  
  currentpoint = new vertex(mouseX, mouseY);
  triangleNode tNode;
  if (firstClick == true){
    tNode = makeFirstTriangle(currentpoint);
  }
  else tNode = triangulate(currentpoint);
  
  currentpoint.display();
  if ( tNode != null) {
    testEdge = tNode.halfTwo;
    testEdge.displayGreen();
    testEdge.prev.displayRed();
    testEdge.next.displayBlue();
    println(onFace(currentpoint, testEdge));
    split(tNode, currentpoint);
  }
  
 
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
    
     testEdge = tNodeInitial.halfOne;
    
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

triangleNode triangulate(vertex p){
triangleNode tNode = null; 
  for (int i = edgeList.size()-1; i >= 0; i--) {
    if (onFace( p, edgeList.get(i))){
      println("I passed the testEdge: " + edgeList.get(i).origin.x + ", " + edgeList.get(i).origin.y + " to " + edgeList.get(i).destination.x + ", " + edgeList.get(i).destination.y);
      if (onFace( p, edgeList.get(i).next)){
        println("I passed the nextEdge");
        if (onFace( p, edgeList.get(i).prev)){
          println("I passed the prevEdge");
          tNode = new triangleNode(edgeList.get(i).prev, edgeList.get(i), edgeList.get(i).next);
          break;
        }
      }
    }
  }
if (tNode == null){println("it returned null for triangulate.");}
return tNode;
}

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
   halfOne.prev.prev = halfOne.next;
   
   halfTwo.next.prev = halfTwo;
   halfTwo.next.next = halfTwo.prev;
   
   halfTwo.prev.next = halfTwo;
   halfTwo.prev.prev = halfTwo.next;
   
   halfThree.next.prev = halfThree;
   halfThree.next.next = halfThree.prev;
   
   halfThree.prev.next = halfThree;
   halfThree.prev.prev = halfThree.next;
   
   halfOne.next.twin = halfTwo.prev;
   halfTwo.prev.twin = halfOne.next;
   
   halfTwo.next.twin = halfThree.prev;
   halfThree.prev.twin = halfTwo.next;
   
   halfThree.next.twin = halfOne.prev;
   halfOne.prev.twin = halfThree.next;
   
   
}
  
 


