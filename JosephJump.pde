import java.util.ArrayList;
Joseph joseph;
Platform platformOne;
Scoreboard scoreboard;
ArrayList<Platform> blockGenerate; 
ArrayList<Enemy> enemies;
ArrayList<PowerUp> powerup;
int power;
Enemy test;
boolean startup;
PImage img;

void setup() {
  size(600, 1000);
  startup = true;
  joseph = new Joseph(20, width/2, height/2);
  blockGenerate = new ArrayList<Platform>();
  scoreboard = new Scoreboard();
  enemies = new ArrayList<Enemy>();
  enemies.add(0, new Enemy(100, 900));
  blockGenerate.add(0, new Platform(290, 940, 70, 20, 255, false));
  powerup = new ArrayList<PowerUp>();
  powerup.add(0, new PowerUp(width/2, height/ 1.2));
  power = 0;
  img = loadImage("sky.png");
  for (int i = 1; i<20; i++)
  {
    int temp = (int)random(1, 10);
    if (temp > 2)
    {
      if (temp%2 ==0)
      {
        blockGenerate.add(i, new Platform((float)((Math.random()*520+80)-70), (float)((blockGenerate.get(i-1).pos.y - 200) + Math.random()*20), 70, 20, 255, true));
      }
      if (temp%2 != 0)
      {
        blockGenerate.add(i, new Platform((float)((Math.random()*520+80)-70), (float)((blockGenerate.get(i-1).pos.y - 200) + Math.random()*20), 70, 20, 255, false));
      }
    }
    if (temp<=2)
    { 
      if (temp%2 ==0)
        blockGenerate.add(i, new Platform((float)((Math.random()*520+80)-70), (float)((blockGenerate.get(i-1).pos.y - 200) + Math.random()*20), 70, 20, color(255, 0, 0), true));
      if (temp%2 != 0)
      {
        blockGenerate.add(i, new Platform((float)((Math.random()*520+80)-70), (float)((blockGenerate.get(i-1).pos.y - 200) + Math.random()*20), 70, 20, color(255, 0, 0), false));
      }
    }
  }
  for (int i=1; i< blockGenerate.size()-1; i++)
  {
    int prob = (int)random(1, 10);
    float distance= random(10, 30);
    if (prob == 1)
    {
      enemies.add(new Enemy((float)((Math.random()*520+80)-70), (float)(blockGenerate.get(i).pos.y-distance)));
    }
  }
}

void draw() {
  if (startup)
  {
    background(img);
    textSize(80);
    fill(0);
    text("JOSEPH JUMP", width/11, height/2);
    textSize(20);
    text("USE Left & Right TO MOVE AND UP TO USE POWERUP", width/8.5, height/1.85);
    text("DON'T HIT THE BOTTOM OF BLUE CUBES", width/6.8, height/1.75);
    text("(PRESS SPACE TO BEGIN)", width/3.5, height/1.65);
    if (key == 32)
    {
      startup = false;
    }
  }
  if (startup ==false) {
    background(0);
    joseph.updateGravity();
    joseph.checkPos();
    joseph.draw();
    scoreboard.showScore();
    textSize(20);
    text("Powerups Left:" + power, width-300, 40);

    for (int i =0; i<blockGenerate.size(); i++)
    {
      blockGenerate.get(i).draw();
    }

    for (int i = 0; i<blockGenerate.size(); i++)
    {
      if (joseph.isCollided(blockGenerate.get(i).hb) && joseph.velo.y >0 && blockGenerate.get(i).col == 255)
      {
        joseph.changeDirection();
      }
      if (joseph.isCollided(blockGenerate.get(i).hb) && joseph.velo.y >0 && blockGenerate.get(i).col == color(255, 0, 0))
      {
        joseph.changeDirection();
        blockGenerate.remove(i);
      }
    }

    for (int i =0; i<blockGenerate.size(); i++)
    {
      if (blockGenerate.get(i).isMoveable)
      {
        blockGenerate.get(i).movingPlatform();
      }
    }

    for (int i =0; i<blockGenerate.size(); i++)
    {
      if (blockGenerate.get(i).pos.y > height)
      {
        blockGenerate.remove(i);

        int temp = (int)random(1, 10);
        if (temp > 2)
        {
          if (temp%2 ==0)
            blockGenerate.add(new Platform((float)((Math.random()*520+80)-70), (float)((blockGenerate.get(blockGenerate.size()-1).pos.y - 200) + Math.random()*20), 70, 20, 255, true));
          if (temp%2!=0)
          {
            blockGenerate.add(new Platform((float)((Math.random()*520+80)-70), (float)((blockGenerate.get(blockGenerate.size()-1).pos.y - 200) + Math.random()*20), 70, 20, 255, false));
          }
        }
        if (temp<=2)
        { 
          if (temp%2 ==0)
            blockGenerate.add(new Platform((float)((Math.random()*520+80)-70), (float)((blockGenerate.get(blockGenerate.size()-1).pos.y - 200) + Math.random()*20), 70, 20, color(255, 0, 0), true));
          if (temp%2!=0)
          {
            blockGenerate.add(new Platform((float)((Math.random()*520+80)-70), (float)((blockGenerate.get(blockGenerate.size()-1).pos.y - 200) + Math.random()*20), 70, 20, color(255, 0, 0), false));
          }
        }
      }
    }

    for (int i =0; i<enemies.size(); i++)
    {
      if (enemies.get(i).pos.y > height)
      {
        enemies.remove(i);
        float distance = random(10, 30);
        enemies.add(new Enemy((float)((Math.random()*520+80)-70), (float)(blockGenerate.get(blockGenerate.size()-1).pos.y+distance)));
      }
    } 

    for (int i =0; i<enemies.size(); i++)
    {
      enemies.get(i).draw();
      enemies.get(i).enemyMove();
    }
    //collision with enemies 
    for (int i=0; i< enemies.size(); i++)
    {
      if (joseph.isCollided(enemies.get(i).hb))
      {
        if (joseph.bottomCollide(enemies.get(i).hb) && joseph.velo.y <0)
        {

          joseph.killJoseph();
        }
        if (joseph.velo.y >0)
        {
          enemies.remove(i);
          joseph.changeDirection();

          float distance = random(10, 30);
          enemies.add(new Enemy((float)((Math.random()*520+80)-70), (float)(blockGenerate.get(blockGenerate.size()-1).pos.y+distance)));
        }
      }
    }


    // move blocks and enemies down
    if (joseph.pos.y < 480 && joseph.velo.y <0)
    {
      for (int i = 0; i< blockGenerate.size(); i++)
      {
        blockGenerate.get(i).movePlatform();
      }
    }
    for (int i=0; i< enemies.size(); i++)
    { 

      if (joseph.pos.y <480 && joseph.velo.y<0)
        enemies.get(i).moveDown();
    }

    // displays game over and restarts
    if (joseph.pos.y > height)
    {
      textSize(40);
      text("GAME OVER", width-415, height/2);
      textSize(20);
      text("(press space to restart)", width-415, height/1.8);

      if (key == 32)
      {
        setup();
      }
    }
    //PowerUp Draw
    for (int i = 0; i < powerup.size(); i++)
    {
      powerup.get(i).draw();
    }
    for (int i=0; i< powerup.size(); i++)
    { 
      if (joseph.pos.y <480 && joseph.velo.y<0)
        powerup.get(i).moveDown();
    }
    for (int i=0; i< powerup.size(); i++)
    { 
      if (joseph.isCollided(powerup.get(i).hb))
      {
        power =1;
        powerup.remove(i);
        powerup.add(i, new PowerUp((float)((Math.random()*520+80)-70), (float)(Math.random()*2000+2000)*-1));
      }
    }
    for (int i=0; i< powerup.size(); i++)
    { 
      if (powerup.get(i).pos.y > height)
      {
        powerup.remove(i);
        powerup.add(i, new PowerUp((float)((Math.random()*520+80)-70), (float)(Math.random()*2000+2000)*-1));
      }
    }
  }
}

//ball movement
void keyPressed() {

  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      if (joseph.getVelocityX()>0)
      {
        joseph.setVelocityX(0);
      }
      joseph.update((new PVector(-10, 0)));
    }
    if (keyCode == RIGHT)
    {
      if (joseph.getVelocityX()<0)
      {
        joseph.setVelocityX(0);
      }
      joseph.update((new PVector(10, 0)));
    }

    if (keyCode == UP)
    {
      if (power>0)
      { 
        joseph.velo.y= -15;
        power-=1;
      }
    }
  }
}
