class PowerUp
{
  float radius;
  PVector pos;
  PVector velo;
  PVector gravity;
  Hitbox hb;
  PowerUp(float xPos, float yPos)
  {
    radius = 10;
    pos = new PVector(xPos, yPos);
    hb = new Hitbox(pos.x - radius, pos.y-radius, radius*2, radius*2);
  }

  void update(PVector vl)
  {
    pos.add(vl);
    hb.update(vl);
  }
  void draw()
  {

    ellipseMode(RADIUS);
    stroke(255);
    fill(0, 255, 0);

    ellipse(pos.x, pos.y, radius, radius);

    //  hb.draw();
  }
  void moveDown() {

    pos.add(new PVector(0, 4));
    hb.update(new PVector(0, 4));
  }
}
