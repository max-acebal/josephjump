class Hitbox
{
  PVector pos;
  float w, h;

  Hitbox(float x, float y, float w, float h)
  {
    pos = new PVector(x, y);
    this.w = w;
    this.h= h;
  }

  void draw() {

    noFill();
    stroke(255, 0, 0);

    rectMode(CORNER);
    rect(pos.x, pos.y, w, h);
  }

  void update(PVector adjust) {

    pos = pos.add(adjust);
  }

  void checkCornerX(float x) {
    pos.x = x;
  }
  void checkCornerY(float y) {
    pos.y= y;
  }


  boolean intersect(Hitbox other)
  {
    return !(pos.x+w/2 < other.pos.x- other.w/2 
      || pos.x- w/2 > other.pos.x + other.w/2
      || pos.y + h/2 < other.pos.y - other.h/2
      || pos.y - h/2 > other.pos.y + other.h/2);
  }
  
  boolean bottomIntersect(Hitbox other)
  {
    return (pos.y - h/2 < other.pos.y + other.h/2) && 
    (  (pos.x - w/2 > other.pos.x - other.w/2)  && (pos.x - w/2 < other.pos.x + other.w/2) 
    
    || (pos.x + w/2 > other.pos.x - other.w/2)  && (pos.x + w/2 < other.pos.x + other.w/2)) ;
  }
 
 
}
