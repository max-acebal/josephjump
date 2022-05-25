class Joseph {
  float radius;
  PVector pos;
  PVector velo;
  PVector gravity;
  Hitbox hb;
  PImage img;

  Joseph(float rad, float xPos, float yPos)
  {
    pos = new PVector(xPos, yPos);
    radius = rad;
    velo = new PVector();
    gravity = new PVector(0, .1);
    hb = new Hitbox(pos.x - radius, pos.y-radius, rad*2, rad*2);
  }
  void update(PVector vl)
  {
    pos.add(vl);
    hb.update(vl);
  }
  void updateGravity()
  {
    velo.add(gravity);
    pos.add(velo);
    hb.update(velo);
  }

  void draw()
  {
    ellipseMode(RADIUS);
    stroke(255);
    fill(175);

    ellipse(pos.x, pos.y, radius, radius);

    //hb.draw();
  }
  float getVelocityX()
  {
    return velo.x;
  }
  void setVelocityX(float vl)
  {
    velo.x = vl;
  }
  void changeDirection()
  {
    velo.y= -7.5;
  }

  void checkPos()
  {
    if (pos.x < 0)
    { 
      pos.x = width;
      hb.checkCornerX(width-radius);
    }
    if (pos.x>width)
    { 
      pos.x = 0;
      hb.checkCornerX(0-radius);
    }
    if (pos.y < 0)
    {
      pos.y = height ;
      hb.checkCornerY(height-radius);
      velo.y+= -5;
    }
  }
  boolean isCollided(Hitbox other)
  {
    return hb.intersect(other);
  }
  
  boolean bottomCollide(Hitbox other)
  {
    return (hb.bottomIntersect(other));
  }
  
  void killJoseph()
  {
    joseph.pos.y = height*500;
  }
  
}
