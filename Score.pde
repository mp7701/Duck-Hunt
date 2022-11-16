/********************************************************* //<>//
 *  Name: Mia Petrovic                                    *
 *  Course: ICS 3U  Pd. 8                                 *
 *  Assignment: Summative Final                           *
 *  Purpose: Create a class coreboard to control the score*
 *  Due Date: May 23, 2018                                *
 *********************************************************/
/*  Methods:
/*  Constructor --- scoreboard() - scoreboard class constructor. Setts the values of scoreboard properties.
/*  void setGameMode(int Screen) -- Sets the game mode (1 - One Bird, 2 - Two Birds, 3 - Clay Discs)
/*  void scoreBirdHit(Bird xBird) -- Checks if the bird is hit andincreases the score based on bird color and round (Game modes 1 and 2).
/*  void scoreDiscHit(Clay xDisc) -- Checks if the disc is hit andincreases the score based on bird color and round (Game mode3).
/*  void birdsFlyMethod() --- Called from inside the Draw() to spin a new cycle of birds. Checks for prefect score in the round and rewards the bonus. Resets the next round.
/*  void discsFlyMethod() --- Called from inside the Draw() to spin a new cycle of discs. Checks for prefect score in the round and rewards the bonus. Resets the next round.
/*  void display() --- Displays the scoreboard with current round, number of bullets remaining, hit indicatior and score.
/* int getScore(int xround, int xColour) --- Used for mode 1 and 2 only (birds). Returns the score after bird is killed based on bird color and round.
/* int getScore(int xround) --- Used for mode 3 (clay discs). Returns the score after disc is hit based on round.
/* boolean GameOver(int xround, int xBirdsKilled) --- Returns true if a number of killed birds or hit discs does not meet the minimum of hits for this round.  
/* int Minimum2Advance() --- Returns minimum number of hits to advance to the next round.
/* void initEmptyDuck() --- Initialises the array of 10 elements to be used by indicator of what duck or disc got hit.




*/   
class scoreboard
{
  PImage shot, hit, score, emptyDuck, hitDuck, perfect, bullet, DiscEmpty, DiscFull;
  int gameScore, birdskilled, birdsFly, discFly, round, iGameMode, iBirdframeRate, iDiscFrameRate;
  int discsKilled;
  //boolean perfectScore;
  boolean [] hitBirds = new boolean[10];
  int h = 0;
  int bonus = 0;

  scoreboard()
/***************************************************************************************
*  Purpose:  scoreboard class constructor. Setts the values of scoreboard properties.  *
*  Parameters: none                                                                    *
*  Returns: scoreboard object                                                          *
***************************************************************************************/   
  {
    shot = loadImage("shot.png");
    score = loadImage("score.png");
    hit = loadImage("hit.png");
    emptyDuck = loadImage ("emptyduck.png");
    hitDuck = loadImage ("hitduck.png");
    perfect = loadImage ("Perfect.PNG");
    bullet = loadImage("bullet.png");
    DiscEmpty = loadImage("DiscEmpty.PNG");
    DiscFull = loadImage("DiscFull.PNG");
    
    gameScore = 0;
    birdsFly = 0;
    discFly = 0;
    birdskilled = 0;
    discsKilled = 0;
    round = 1;
    //perfectScore = false;
    iBirdframeRate = 8;
    iDiscFrameRate = 4;
    //frameRate(iBirdframeRate);
    frameRate(8);
    initEmptyDuck();
    
  } // Constructor

  void setGameMode(int Screen)
/***************************************************************************************
*  Purpose: Sets the game mode (1 - One Bird, 2 - Two Birds, 3 - Clay Discs)           *
*  Parameters: Integer Screen --- Parameter indicates the game mode                    *
*  Returns: none                                                                       *
***************************************************************************************/     
  {
    iGameMode = Screen;
  }

  void scoreBirdHit(Bird xBird)
/****************************************************************************
*  Purpose:  Checks if the bird is hit andincreases the score based on bird *
*  color and round (Game modes 1 and 2).                                    *
*  Parameters: Bird xBird --- Bird object being scored                      *
*  Returns: none                                                            *
****************************************************************************/ 
  {
    if (xBird.birdKilled == true)
    {
      gameScore = gameScore + getScore(round, xBird.col); /// Get the right scores per bird color/round
      birdskilled = birdskilled + 1;
      hitBirds [xBird.thisBirdInTheRound - 1] = true;
    }
  } ///  scoreBirdHit

  void scoreDiscHit(Clay xDisc)
/****************************************************************************
*  Purpose:  Checks if the bird is hit andincreases the score based on bird *
*  color and round (Game modes 1 and 2).                                    *
*  Parameters: Clay xDisc --- Disc object being scored                      *
*  Returns: none                                                            *
****************************************************************************/
  {
    if (xDisc.discKilled == true)
    {
      gameScore = gameScore + getScore(round); /// Get the right scores per round
      discsKilled = discsKilled + 1;
      hitBirds [xDisc.thisDiscInTheRound - 1] = true;
    }
  } ///  scoreDiscHit
  
  void birdsFlyMethod()
/***************************************************************************************
*  Purpose:  Called from inside the Draw() to spin a new cycle of birds. Checks for    *
*  prefect score in the round and rewards the bonus. Resets the next round.            *
*  Parameters: none                                                                    *
*  Returns: none                                                                       *
***************************************************************************************/    
  {
    birdsFly = birdsFly + 1;
    if (birdInTheRound == 10)
    {
      ///    put the picture of the Round
      if (birdInTheRound == birdskilled)
      {
        bonus = getScore(round, 100);
        perfectScore = true;
      } else
      {
        bonus = 0;
        perfectScore = false;
      }

      gameScore = gameScore + bonus; // use parameters round and 100 for perfect score

      newRound = true;
      round = round + 1;

      fill(0, 237, 7, 204);
      isGameOver = GameOver(round, birdskilled);
      if (isGameOver == false)
      {
        oDuckHunt.oDog1.x = 0;
        oDuckHunt.oDog1.y = 400;
        oDuckHunt.oDog1.isIntro = true;
        //Perfect.pause();
        //Game.play();
        birdInTheRound = 0;
        if (iGameMode == 3)
          frameRate(iDiscFrameRate++);
        birdskilled = 0;
        shotFired = 0;
        initEmptyDuck();
      }
    }
  } 
  
    void discsFlyMethod()
/***************************************************************************************
*  Purpose:  Called from inside the Draw() to spin a new cycle of discs. Checks for    *
*  prefect score in the round and rewards the bonus. Resets the next round.            *
*  Parameters: none                                                                    *
*  Returns: none                                                                       *
***************************************************************************************/        
  {
    discFly = discFly + 1;
    if (discInTheRound == 10)
    {
      ///    put the picture of the Round
      if (discInTheRound == discsKilled)
      {
        bonus = getScore(round, 100);
        perfectScore = true;
      } else
      {
        bonus = 0;
        perfectScore = false;
      }

      gameScore = gameScore + bonus; // use parameters round and 100 for perfect score

      newRound = true;
      round = round + 1;
      fill(0, 237, 7, 204);
      isGameOver = GameOver(round, discsKilled);
      if (isGameOver == false)
      {
        //Perfect.pause();
        discInTheRound = 0;
        if (iGameMode == 3)
          frameRate(iDiscFrameRate++);
        discsKilled = 0;
        shotFired = 0;
        initEmptyDuck();
      }
    }
  } 

  void display()
/********************************************************************************************
*  Purpose:   Displays the scoreboard with current round, number of bullets remaining, hit  *
*  indicatior and score.                                                                    *
*  Parameters: none                                                                         *
*  Returns: none                                                                            *
********************************************************************************************/  
  {
    image (score, 600, 520, 160, 60);
    textSize(22);
    fill(255, 255, 255, 204);
    text(str(gameScore), 640, 540); 

    image (hit, 225, 520, 300, 60);
    //   Advance indicator
    strokeWeight(4);
    int ttt = Minimum2Advance();
    for (int i = 305; i <= (305 + (ttt * 3 * 7)); i = i + 7)
    {
      line(i, 570, i, 550);
    }
    strokeWeight(1);    

    image (shot, 60, 520, 100, 60);
    textSize(22);

    h = 0;
    for (int j = 1; j<=3; j++, h+=25)
    {
      image(bullet, 75 + h, 530, 24, 20);
    }

    if (shotFired > 0 && shotFired <= 3)
    {
      h = 0;
      for (h = 1; h <=shotFired; h++)
      {
        stroke (#000000);
        fill (#000000);
        rect (75 + ((3 - h) * 25), 530, 25, 25);
      }
      stroke (#FFFFFF);
      fill (#FFFFFF);
      //rect (x, y, 100, 50);
    }
    PImage displayEmpty = emptyDuck;
    PImage displayHit = hitDuck;
    if (iGameMode ==3)
    {
      displayEmpty = DiscEmpty;
      displayHit = DiscFull;
    }
  
    int k=0; /// draw empty ducks on the score
    for (int i = 1; i<=10; i++, k+=21)
    {
      image(displayEmpty, 305 + k, 528, 18, 17);
    }

    k=0;  /// draw killed ducks on the score 
    for (int i = 1; i <= 10; i++, k+=21)
    {
      if (hitBirds [i - 1] == true)
      {
        image(displayHit, 305 + k, 528, 18, 17);
      }
    }

    if (perfectScore == true)
    {
      image (perfect, 300, 150, 200, 100);
      text(str(bonus), 350, 240);
      //Perfect.play();
    }

    text( "R = " + str(oDuckHunt.oScoreboard.round), 60, 500);
    
  }

  void initEmptyDuck()
/*******************************************************************************************
*  Purpose:  Initialises the array of 10 elements to be used by indicator of what duck     *
*  or disc got hit.                                                                        *
*  Parameters: none                                                                        *
*  Returns: none                                                                           *
*******************************************************************************************/    
  {
    for (int h = 0; h <=9; h++)
    {
      hitBirds [h] = false;
    }
  }

  int getScore(int xround, int xColour)
/*******************************************************************************************
*  Purpose:  Used for mode 1 and 2 only (birds). Returns the score after bird is killed    *
*  based on bird color and round.                                                          *
*  Parameters: int xround (indicates current round), int xColour (indicates colour)        *
*  Returns: Integer -- number of points awarded for this hit                               *
*******************************************************************************************/  
  {
    int retunScore;
    retunScore = 0;

    if ((xround <= 5) && (xColour == 1))
      retunScore = 1500;  
    else if ((xround <= 5) && (xColour == 2))
      retunScore = 1000;
    else if ((xround <= 5) && (xColour == 3))
      retunScore = 500;
    //
    else if ((xround > 5 && xround <= 10) && (xColour == 1))
      retunScore = 2400;  
    else if ((xround > 5 && xround <= 10) && (xColour == 2))
      retunScore = 1500;
    else if ((xround > 5 && xround <= 10) && (xColour == 3))
      retunScore = 800;
    //      
    else if ((xround > 10 && xround <= 15) && (xColour == 1))
      retunScore = 3000;
    else if ((xround > 10 && xround <= 15) && (xColour == 2))
      retunScore = 2000;
    else if ((xround > 10 && xround <= 15) && (xColour == 3))
      retunScore = 1000;
    //   are those the right scores below?
    else if ((xround > 15 && xround <= 20) && (xColour == 1))
      retunScore = 3000;
    else if ((xround > 15 && xround <= 20) && (xColour == 2))
      retunScore = 2000;
    else if ((xround > 15 && xround <= 20) && (xColour == 3))
      retunScore = 1000;
    //   are those the right scores below?
    else if ((xround > 20 && xround <= 25) && (xColour == 1))
      retunScore = 3000;
    else if ((xround > 20 && xround <= 25) && (xColour == 2))
      retunScore = 2000;
    else if ((xround > 20 && xround <= 25) && (xColour == 3))
      retunScore = 1000;
    //  perfect score bonus  
    else if ((xround <= 10) && xColour == 100)  
      retunScore = 10000;
    else if ((xround > 10 && xround <= 15) && xColour == 100)  
      retunScore = 15000;
    else if ((xround > 15 && xround <= 20) && xColour == 100)
      retunScore = 20000;     
    else if ((xround > 20 && xround <= 25) && xColour == 100)
      retunScore = 30000;      
    return retunScore;
  }

  int getScore(int xround)
/*******************************************************************************************
*  Purpose:  Used for mode 3 (clay discs). Returns the score after disc is hit based on    *
*  round.                                                                                  *
*  Parameters: int xround (indicates current round)                                        *
*  Returns: Integer --- number of points awarded for this hit                              *
*******************************************************************************************/    
  {
    int retunScore = 0;
    if (xround <= 5)
    { 
      retunScore = 1000;
    } else if ((xround > 5) && (xround <= 10)) 
    {
      retunScore = 1500;
    }
    else if (xround > 10)
    {
      retunScore = 2000;
    } 
    return retunScore;
  }

  boolean GameOver(int xround, int xBirdsKilled)
/***********************************************************************************************************************
*  Purpose:  Returns true if a number of killed birds or hit discs does not meet the minimum of                        *
*  hits for this round.                                                                                                *
*  Parameters: int xround (indicates current round), int xBirdsKilled (indicates number of objects hit in this round)  *
*  Returns: boolean --- true if game is over                                                                           *
***********************************************************************************************************************/  
  {
    boolean retVal = false;
    if (xround <= 5 && xBirdsKilled < 5)
      retVal = true;
    else if ((xround > 5 && xround <= 10) && (xBirdsKilled < 6))
      retVal = true;
    else if ((xround > 10 && xround <= 15) && (xBirdsKilled < 7))
      retVal = true;      
    else if ((xround > 15 && xround <= 20) && (xBirdsKilled < 8))
      retVal = true;  
    else if ((xround > 20 && xround <= 25) && (xBirdsKilled < 9))
      retVal = true;

    return retVal;
  }
  
  int Minimum2Advance()
/**************************************************************************
*  Purpose:  Returns minimum number of hits to advance to the next round. *
*  Parameters: none                                                       *
*  Returns: integer - minimum number ogf hits to pass current round       *                                                                          *
**************************************************************************/    
  {
    int retVal = 0;
    
    if (round <= 5)
      retVal = 5;
    else if ((round > 5 && round <= 10))
      retVal = 6;
    else if ((round > 10 && round <= 15))
      retVal = 7;      
    else if ((round > 15 && round <= 20))
      retVal = 8;  
    else if ((round > 20 && round <= 25) )
      retVal = 9;
      
    return retVal;  
  
  }
}
