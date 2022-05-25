class Platform
{

  PVector pos; // top left corner
  float w;
  float h;
  Hitbox hb;
  color col;
  boolean isMoveable;
  int direct;

  Platform(float x, float y, float wid, float ht, color cl, boolean move)
  {
    pos = new PVector(x, y);
    w = wid;
    h = ht;
    hb = new Hitbox(x, y, wid, ht);
    col = cl;
    isMoveable = move;
    direct = (int)random(1,3);
  }

  void draw()
  {
    rectMode(CORNER);
    fill(col);
    rect(pos.x, pos.y, w, h);
  }

  void movePlatform()
  {
    pos.add(new PVector(0, joseph.velo.y*-1));
    hb.update(new PVector(0, joseph.velo.y*-1));
  }

  void movingPlatform()
  {
    float spd= random(1,4);
    if (direct == 1)
    {
      pos.add(new PVector(spd, 0));
      hb.update(new PVector(spd, 0));
    }
      if (direct == 2)
    {
      pos.add(new PVector(-1*spd, 0));
      hb.update(new PVector(-1*spd, 0));
    }
    if (pos.x < 0)
    { 
      pos.x = width;
      hb.checkCornerX(width);
    }
    if (pos.x>width)
    { 
      pos.x = 0;
      hb.checkCornerX(0);
    }
  }
}
