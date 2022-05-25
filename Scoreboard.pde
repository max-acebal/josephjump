class Scoreboard {
  int score;

  Scoreboard()
  {
    score = 0;
  }

  void showScore()
  {
    textSize(20);
    text("Score:" + score/1000, width-415, 40);
    if (!(joseph.pos.y>height)) 
    {
      if (joseph.velo.y<0)
      {
        score+= joseph.pos.y;
      }
      if (joseph.velo.y>0)
      {
        score-= joseph.pos.y;
      }
      if (score <0)
      {
        score =0;
      }  
    }
  }
}
