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
ArrayList<halfEdge> needsChecking = new ArrayList<halfEdge>();

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
   // displayFace();
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
   // boolean deterP = ( (hE.destination.x - hE.origin.x)*(p.y - hE.origin.y) ) - ( (p.x - hE.origin.x)*(hE.destination.y - hE.origin.y) ) > 0;    
   // boolean deterF = ( (hE.destination.x - hE.origin.y)*(hE.face.y - hE.origin.y) ) - ( (hE.face.x - hE.origin.x)*(hE.destination.y - hE.origin.y) ) >0;    
    
  //  boolean deterP = ( ((hE.destination.y - p.y) * hE.origin.x) + ((hE.destination.x - p.x) * hE.origin.y) + ((hE.destination.x * p.y) - (p.x * hE.destination.y)) ) > 0;
  //  boolean deterF = ( ((hE.destination.y - hE.face.y) * hE.origin.x) + ((hE.destination.x - hE.face.x) * hE.origin.y) + ((hE.destination.x * hE.face.y) - (hE.face.x * hE.destination.y)) ) > 0;
    
    float deterP = ( (hE.origin.y - hE.destination.y)*(p.x - hE.origin.x) ) + ( (hE.destination.x - hE.origin.x)*(p.y - hE.origin.y) );    
    float deterF = ( (hE.origin.y - hE.destination.y)*(hE.face.x - hE.origin.x) ) + ( (hE.destination.x - hE.origin.x)*(hE.face.y - hE.origin.y) );    
    
    if ( deterP * deterF > 0 ){
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
  for(int i = 0; i<1000; i= i+50){
    line( i , 0, i, 1000);
    line(0, i, 1000, i);
  }
}

float twoDeterminant ( float a, float b, float c, float d){
  return (a*d) - (b*c);
}

boolean checkLD( halfEdge hE){
  if(hE.twin == null) {
  return true;
  }else{
  
  vertex realA = hE.destination;
  vertex B = hE.next.destination;
  vertex realC = hE.origin;
  vertex D = hE.twin.next.destination;
  
  vertex A = realC;
  vertex C = realA;
  
  print("A is point (");
  print( A.x );
  print( ", " );
  print(A.y + ")" );
  println();
  
  print("B is point (");
  print( B.x );
  print( ", " );
  print(B.y + ")" );
  println();
  
  print("C is point (");
  print( C.x );
  print( ", " );
  print(C.y + ")" );
  println();
  
  print("D is point (");
  print( D.x );
  print( ", " );
  print(D.y + ")" );
  println();

 // println("B is point (" + B.x + ", " B.y + ")" );
  //println("C is point (" + C.x + ", " C.y + ")" );
  //println("D is point (" + D.x + ", " D.y + ")" );
  
  //drawCircumCircle(A,B,C);
  
  
  float topSquared = ((A.x * A.x) - (D.x * D.x)) + ((A.y * A.y) - (D.y * D.y));
  float midSquared = ((B.x * B.x) - (D.x * D.x)) + ((B.y * B.y) - (D.y * D.y));
  float botSquared = ((C.x * C.x) - (D.x * D.x)) + ((C.y * C.y) - (D.y * D.y));
  
  float termOne = (A.x - D.x) * twoDeterminant( (B.y - D.y), midSquared, (C.y  -D.y), botSquared);
  float termTwo = (A.y - D.y) * twoDeterminant( (B.x - D.x), midSquared, (C.x  -D.x), botSquared);
  float termThree = topSquared * twoDeterminant( (B.x - D.x), (B.y - D.y), (C.x - D.x), (C.y - D.y));
  
  float determinant = termOne - termTwo + termThree;
  println(termOne);
  println(termTwo);
  println(termThree);
  println(determinant);
  if (determinant >= 0){
        println("This is not locally Delaunay");

    return false;
  }
  else{
         println("This is locally Delaunay");

    return true;

  }
  

  
  }
  
}

void flipEdge(halfEdge hE){
  
  stroke(255);
  line(hE.origin.x, hE.origin.y, hE.destination.x, hE.destination.y);
  
  vertex B = hE.next.destination;
  vertex D = hE.twin.next.destination;
  
  hE.twin.prev.next = hE.next;
  hE.next.prev = hE.twin.prev;
  
  hE.twin.next.prev = hE.next;
  hE.prev.next = hE.twin.next;
  
  hE.next.next = new halfEdge(B,D);
  hE.prev.prev = new halfEdge(D,B);
  
  hE.twin.next.next = hE.prev.prev;
  hE.twin.prev.prev = hE.next.next;
  
  edgeList.remove(hE);
}

void drawCircumCircle(vertex A, vertex B, vertex C){
  float temp = 2 * ( (A.x *(B.y-C.y)) + (B.x *(C.y-A.y)) + (C.x*(A.y-B.y)) );
  float centerX =( ( ((A.x*A.x) + (A.y*A.y)) * (B.y - C.y)) + (((B.x*B.x)+(B.y*B.y))*(C.y-A.y)) + (((C.x*C.x)+(C.y*C.y))*(A.y-B.y))) / temp;
  float centerY =( ( ((A.x*A.x) + (A.y*A.y)) * (C.x - B.x)) + (((B.x*B.x)+(B.y*B.y))*(A.x-C.x)) + (((C.x*C.x)+(C.y*C.y))*(B.x-A.x))) / temp;
  
  float diameter = 2 * sqrt( ((centerX - A.x)*(centerX - A.x)) + ((centerY - A.y)*(centerY - A.y)) );  
  
  stroke(0);
  noFill();
  ellipse(centerX, centerY, diameter, diameter);
}

void doFlips(){
 
  while(needsChecking.size() > 0){
    halfEdge hE = needsChecking.get(needsChecking.size()-1);
    if (!checkLD(hE)){
      //flipEdge(hE);
      hE.displayRed();
    }else{
      hE.displayGreen();
    }
    needsChecking.remove(hE);
  }
  
}

void mouseClicked() {
  
  currentpoint = new vertex(mouseX, mouseY);
  triangleNode tNode;
  if (firstClick == true){
    makeFirstTriangle(currentpoint);
  }
  
  tNode = triangulate(currentpoint);
  
  currentpoint.display();
  if ( tNode != null) {
    /*
    //testEdge = tNode.halfTwo;
    testEdge.displayGreen();
    testEdge.prev.displayRed();
    testEdge.next.displayBlue();
    
     println("I'm testing the edge: " + testEdge.origin.x + ", " + testEdge.origin.y + " to " + testEdge.destination.x + ", " + testEdge.destination.y);
      println("my prevedge is: " + testEdge.prev.origin.x + ", " + testEdge.prev.origin.y + " to " + testEdge.prev.destination.x + ", " + testEdge.prev.destination.y);
      println("my nextEdge is: " + testEdge.next.origin.x + ", " + testEdge.next.origin.y + " to " + testEdge.next.destination.x + ", " + testEdge.next.destination.y);

    println(onFace(currentpoint, testEdge));
    println(onFace(currentpoint, testEdge.prev));
    println(onFace(currentpoint, testEdge.next));
    */
    split(tNode, currentpoint);
    needsChecking.add(tNode.halfOne);
    needsChecking.add(tNode.halfTwo);
    needsChecking.add(tNode.halfThree);
    doFlips();
    
  }
  
 
}


void makeFirstTriangle(vertex p) {
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
    
     testEdge = tNodeInitial.halfTwo;
    
    //return tNodeInitial;  
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
    /*
      println("I'm testing the edge: " + edgeList.get(i).origin.x + ", " + edgeList.get(i).origin.y + " to " + edgeList.get(i).destination.x + ", " + edgeList.get(i).destination.y);
      println("my prevedge is: " + edgeList.get(i).prev.origin.x + ", " + edgeList.get(i).prev.origin.y + " to " + edgeList.get(i).prev.destination.x + ", " + edgeList.get(i).prev.destination.y);
      println("my nextEdge is: " + edgeList.get(i).next.origin.x + ", " + edgeList.get(i).next.origin.y + " to " + edgeList.get(i).next.destination.x + ", " + edgeList.get(i).next.destination.y);
*/
    if (onFace( p, edgeList.get(i))){
   //   println("I passed the testEdge: " + edgeList.get(i).origin.x + ", " + edgeList.get(i).origin.y + " to " + edgeList.get(i).destination.x + ", " + edgeList.get(i).destination.y);
      if (onFace( p, edgeList.get(i).next)){
     // println("I passed the nextEdge: " + edgeList.get(i).next.origin.x + ", " + edgeList.get(i).next.origin.y + " to " + edgeList.get(i).next.destination.x + ", " + edgeList.get(i).next.destination.y);
        if (onFace( p, edgeList.get(i).prev)){
      //println("I passed the prevEdge: " + edgeList.get(i).prev.origin.x + ", " + edgeList.get(i).prev.origin.y + " to " + edgeList.get(i).prev.destination.x + ", " + edgeList.get(i).prev.destination.y);
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
  
 


