class Enemy {
  PVector pos; // top left corner
  float lengt;
  Hitbox hb;
  color col;
  int direct;
  int neg;
  Enemy(float x, float y)
  {
    pos = new PVector(x, y);
    lengt = 50;
    col = color(0, 0, 255);
    hb = new Hitbox(x, y, lengt, lengt);
    direct = (int)random(1, 4);
    neg = (int)random(-2, 2);
  }

  void draw()
  {
    rectMode(CORNER);
    fill(col);
    rect(pos.x, pos.y, lengt, lengt);
    fill(255);
    rect(pos.x + 10, pos.y+30, 30, 8);

    ellipseMode(RADIUS);
    ellipse(pos.x + 12, pos.y+20, 3, 3);
    ellipse(pos.x+ 37.8, pos.y+20, 3, 3);

    strokeWeight(3);
    line(pos.x+8, pos.y +8, pos.x+19, pos.y +13);
    line(pos.x + 30, pos.y+13, pos.x+ 41, pos.y+8);

    //hb.draw();
  }
  void enemyMove() {
    float spd= (int)random(1, 3);
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
  void moveDown() {

    pos.add(new PVector(0, 4));
    hb.update(new PVector(0, 4));
  }
}
