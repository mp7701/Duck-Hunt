/****************************************************************
 *  Name: Mia Petrovic                                          *
 *  Course: ICS 3U  Pd. 8                                       *
 *  Assignment: Summative Final                                 *
 *  Purpose: Create a class bird to implement bird in the game  *
 *  Due Date: May 23, 2018                                      *
 ***************************************************************/
/*  Methods:
/*  Constructor -- -Bird()
/*  void setGameMode(int Screen) -- Sets the game mode (1 - One Bird, 2 - Two Birds, 3 - Clay Discs)
/*  boolean birdHit(int mX, int mY) --- called from mouseReleased(), checks if the mouse coordinates are withing current bird coordinates (returns true for hit)
/*  void setTimer() --- Sets the class property time to control that birds are not flying for longer than 6 seconds 
/*  void birdFlies() --- called from within Draw() to move the bird on the screen
/*  void changeDirection() --- Changes the direction that bird flies after it hits the left, right or top border of the screen or touches the grass.
/*  void right() --- moves the bird to the right by positive x coordinated increments
/*  void left() --- moves the bird to the left by negative x coodinates increments
/*  void up() -- moves the bird up on the screen ater 6 seconds passed or 3 misses 
/*  void birdFalls(int xx, int xy) --- moves the bird down after being hit and sets the coordinates (xx, yy) to display the test indication poit eaerned for this kill
*/

class Bird

{
    // class to implement the bird in Duck Hunt
  boolean birdKilled = false;
  boolean birdFallen = false;
  boolean birdFlyAway = false;  
  int iGameMode; 
  //Arrays of red images 
  PImage[] rightRed = new PImage[3];
  int currentRightRed = 0;
  int numRightRed = 3;
  PImage[] leftRed = new PImage[3];
  int currentLeftRed = 0;
  int numLeftRed = 3;
  PImage[] upRed = new PImage[3];
  int currentUpRed = 0;
  int numUpRed = 3;
  PImage[] fallRed = new PImage[2];
  int currentFallRed = 0;
  int numFallRed = 2;
  //Array of blue images 
  PImage[] rightBlue = new PImage[3];
  int currentRightBlue = 0;
  int numRightBlue = 3;
  PImage[] leftBlue = new PImage[3];
  int currentLeftBlue = 0;
  int numLeftBlue = 3;
  PImage[] upBlue = new PImage[3];
  int currentUpBlue = 0;
  int numUpBlue = 3;
  PImage[] fallBlue = new PImage[2];
  int currentFallBlue = 0;
  int numFallBlue = 2;
  //Array of black images 
  PImage[] rightBlack = new PImage[3];
  int currentRightBlack = 0;
  int numRightBlack = 3;
//  int offset = 0;
  int offset = 3;
  PImage[] leftBlack = new PImage[3];
  int currentLeftBlack = 0;
  int numLeftBlack = 3;
  PImage[] upBlack = new PImage[3];
  int currentUpBlack = 0;
  int numUpBlack = 3;
  PImage[] fallBlack = new PImage[2];
  int currentFallBlack = 0;
  int numFallBlack = 2;

  //
  PImage RedHit = loadImage("RedHit.png");
  PImage BlueHit = loadImage("BlueHit.png");
  PImage BlackHit = loadImage("BlackHit.png");
  //

  int x = 200;
  int y = 325;
  boolean hitx = false;
  boolean hity = false;
  
  boolean softCycleDone;
  
  int shotx, shoty; // new
  
  int time;
  
  int iframeRate; //new
  
  PImage FlyAway = loadImage("FlyAway.png");
  int dir, col, xIncrement, yIncrement, cycle;
  boolean birdHit = false;
  boolean cycleDone = false;
  int roundDone = 0;
  int thisBirdInTheRound = 0;

  Bird()
/*************************************************************************
*  Purpose:  Bird class constructor. Setts the values of bird properties *
*  Parameters: none                                                      *
*  Returns: Bird object                                                  *
*************************************************************************/  
  {
    //Array of red birds
    rightRed[0]  = loadImage("RedDiagonal1.png");
    rightRed[1]  = loadImage("RedDiagonal2.png");
    rightRed[2]  = loadImage("RedDiagonal3.png");
    leftRed [0] = loadImage ("RedDiagonalLeft1.png");
    leftRed [1] = loadImage ("RedDiagonalLeft2.png");
    leftRed [2] = loadImage ("RedDiagonalLeft3.png");
    upRed [0] = loadImage ("RedUp1.png");
    upRed [1] = loadImage ("RedUp2.png");
    upRed [2] = loadImage ("RedUp3.png");
    fallRed[0] = loadImage ("RedFall1.png");
    fallRed[1] = loadImage ("RedFall2.png");

    //Array of blue birds
    rightBlue[0]  = loadImage("BlueDiagonal1.png");
    rightBlue[1]  = loadImage("BlueDiagonal2.png");
    rightBlue[2]  = loadImage("BlueDiagonal3.png");
    leftBlue [0] = loadImage ("BlueDiagonalLeft1.png");
    leftBlue[1] = loadImage ("BlueDiagonalLeft2.png");
    leftBlue [2] = loadImage ("BlueDiagonalLeft3.png");
    upBlue [0] = loadImage ("BlueUp1.png");
    upBlue [1] = loadImage ("BlueUp2.png");
    upBlue [2] = loadImage ("BlueUp3.png");
    fallBlue[0] = loadImage ("BlueFall1.png");
    fallBlue[1] = loadImage ("BlueFall2.png");

    //Array of black birds 
    rightBlack[0]  = loadImage("BlackDiagonal1.png");
    rightBlack[1]  = loadImage("BlackDiagonal2.png");
    rightBlack[2]  = loadImage("BlackDiagonal3.png");
    leftBlack [0] = loadImage ("BlackDiagonalLeft1.png");
    leftBlack[1] = loadImage ("BlackDiagonalLeft2.png");
    leftBlack [2] = loadImage ("BlackDiagonalLeft3.png");
    upBlack [0] = loadImage ("BlackUp1.png");
    upBlack [1] = loadImage ("BlackUp2.png");
    upBlack [2] = loadImage ("BlackUp3.png");
    fallBlack[0] = loadImage ("BlackFall1.png");
    fallBlack[1] = loadImage ("BlackFall2.png");

    dir = (int)random(1, 3); //  random initial direction of the bird.
    
    xIncrement = (int)random (5, 25); //  random x coordinbate increment to move the bird lef or right.
    yIncrement = (int)random (5, 25); //  random y coordinbate increment to move the bird up or down.

    col = (int)random(1, 4);  // random colour of the bird.

    cycle = 0;
    
    softCycleDone = false; ///  controls when dog will show the kill.
    
    shotx = 0; //  x coordinate at place where bird got shot. Used to display the points for this kill
    shoty = 0; //  y coordinate at place where bird got shot. Used to display the points for this kill

    if (dir == 2)
      xIncrement = -1 * xIncrement;
    time = 0;
  }
  //  Constructor

  void right()
/*******************************************************************************
*  Purpose:  Moves the bird to the right by positive x coordinated increments  *
*  Parameters: none                                                            *
*  Returns: none                                                               *
*******************************************************************************/
  {
    if (col == 1)
    {
      currentRightRed = (currentRightRed+1) % numRightRed;  // Use % to cycle through frames
      image(rightRed[(currentRightRed+offset) % numRightRed], x, y, 100, 75);
    } else if (col == 2)
    {
      currentRightBlue = (currentRightBlue+1) % numRightBlue;  // Use % to cycle through frames
      image(rightBlue[(currentRightBlue+offset) % numRightBlue], x, y, 100, 75);
    } else if (col == 3)
    {
      currentRightBlack = (currentRightBlack+1) % numRightBlack;  // Use % to cycle through frames
      image(rightBlack[(currentRightBlack+offset) % numRightBlack], x, y, 100, 75);
    }
  }

  void left()
/*******************************************************************************
*  Purpose:  Moves the bird to the left by negative x coordinated increments   *
*  Parameters: none                                                            *
*  Returns: none                                                               *
*******************************************************************************/  
  {
    if (col == 1)
    {
      currentLeftRed = (currentLeftRed+1) % numLeftRed;  // Use % to cycle through frames
      image(leftRed[(currentLeftRed+offset) % numLeftRed], x, y, 100, 75);
    } else if (col == 2)
    {
      currentLeftBlue = (currentLeftBlue+1) % numLeftBlue;  // Use % to cycle through frames
      image(leftBlue[(currentLeftBlue+offset) % numLeftBlue], x, y, 100, 75);
    } else if (col == 3)
    {
      currentLeftBlack = (currentLeftBlack+1) % numLeftBlack;  // Use % to cycle through frames
      image(leftBlack[(currentLeftBlack+offset) % numLeftBlack], x, y, 100, 75);
    }
  }

  void up()
/*************************************************************************************************
*  Purpose:  Bird moves up when either 3 shots were fired and missed or after 6 secods passed.   *
*  Parameters: none                                                                              *
*  Returns: none                                                                                 *
*************************************************************************************************/    
  {
    if (col == 1) //  move images based on randomly selected color
    {
      currentUpRed = (currentUpRed+1) % numUpRed;  // Use % to cycle through frames
      image(upRed[(currentUpRed+offset) % numUpRed], x, y, 100, 75);
    } else if (col == 2)
    {
      currentUpBlue = (currentUpBlue+1) % numUpBlue;  // Use % to cycle through frames
      image(upBlue[(currentUpBlue+offset) % numUpBlue], x, y, 100, 75);
    } else if (col == 3)
    {
      currentUpBlack = (currentUpBlack+1) % numUpBlack;  // Use % to cycle through frames
      image(upBlack[(currentUpBlack+offset) % numUpBlack], x, y, 100, 75);
    }

    if (y <= -275) //  this bird is GONE !!!!!!!
    {
      //cycle = cycle + 1;
        //if (cycle == iGameMode)
        cycleDone = true;
        canClick = true;
    }
    
    if (y >= -75) //  allow the dog to show the kill
    {
      //cycle = cycle + 1;
        //if (cycle == iGameMode)
        softCycleDone = true;
        canClick = true;
    }    
  }

  void setGameMode(int Screen)
/***************************************************************************************
*  Purpose: Sets the game mode (1 - One Bird, 2 - Two Birds, 3 - Clay Discs)           *
*  Parameters: Integer Screen --- Parameter indicates the game mode                    *
*  Returns: none                                                                       *
***************************************************************************************/  
  {
    iGameMode = Screen;
  }

  boolean birdHit(int mX, int mY)
/***************************************************************************************
*  Purpose:  Checks if the mouse coordinates are withing current bird coordinates      *
*  (returns true for hit). Called from mouseReleased()                                 *
*  Parameters: Integer x Coordinate, Integer y coordinate                              *
*  Returns: boolean --- true for hit and false for miss                                *
***************************************************************************************/   
  {
    if (mX >= x && mX <= x + 100 && mY >= y && mY <= y + 75)
    {
      //println("hit");
      birdKilled = true;
      return true;
    }
    return false;
  }


  void birdFalls(int xx, int xy)
/********************************************************************************************
*  Purpose:  Moves the bird down after being hit and sets the coordinates (xx, yy) to       *
*  display the test indication poit eaerned for this kill.                                  *
*  Parameters: Integer x Coordinate, Integer y coordinate (position of the object when hit) *
*  Returns: none                                                                            *
********************************************************************************************/  
  { 
    
    if (shotx == 0 || shoty == 0)
    {
      shotx = xx;
      shoty = xy;
    }
    
    int score = oDuckHunt.oScoreboard.getScore(oDuckHunt.oScoreboard.round, col);
    
    text( str(score), shotx, shoty);
    
    if (col == 1)
    {

      currentFallRed = (currentFallRed+1) % numFallRed;  // Use % to cycle through frames
      image(fallRed[(currentFallRed+offset) % numFallRed], x, y, 100, 75);
    } else if (col == 2)
    {

      currentFallBlue = (currentFallBlue+1) % numFallBlue;  // Use % to cycle through frames
      image(fallBlue[(currentFallBlue+offset) % numFallBlue], x, y, 100, 75);
    } else if (col == 3)
    {

      currentFallBlack = (currentFallBlack+1) % numFallBlack;  // Use % to cycle through frames
      image(fallBlack[(currentFallBlack+offset) % numFallBlack], x, y, 100, 75);
    }

    if (y >= 600) //  this bird is GONE !!!!!!!
    {
      cycle = cycle + 1;
        //if (cycle == iGameMode)
        cycleDone = true;
        canClick = true;
    }
    
    if (y >= 400) //  dog shows kill
    {
      //cycle = cycle + 1;
        //if (cycle == iGameMode)
        softCycleDone = true;
        canClick = true;
        //Get.close();
    }
  } //birdFalls

  void changeDirection()
/***************************************************************************************
*  Purpose:  Changes the direction that bird flies after it hits the left, right or    *
*  top border of the screen or touches the grass.                                      *
*  Parameters: none                                                                    *
*  Returns: none                                                                       *
***************************************************************************************/    
  {
    if (x >= 700)
    {
      hitx = true;

      xIncrement = (int)random (5, 25);
      xIncrement = -1 * xIncrement;
      dir = 2;
      x = 699;
    } else if (x <=0)
    {
      hitx = true;
      xIncrement = (int)random (5, 25);
      dir = 1;
      x = 2;
    } else if ((y >= 320) && (birdKilled == false))
    {
      hity = true;
      yIncrement = (int)random (5, 25);
      yIncrement = -1 * yIncrement;
      y = 319;
    } else if ((y <=0)  && (birdFlyAway == false))
    {
      hity = true;
      yIncrement = (int)random (5, 25);
      y = 2;
    }
  } // end of changeDirection()


  void birdFlies()
/***************************************************************************************
*  Purpose:  Called from within Draw() to move the bird on the screen                  *
*  Parameters: none                                                                    *
*  Returns: none                                                                       *
***************************************************************************************/   
  { 
    //  Bird flies. Called from the draw()
    changeDirection();

    if (birdKilled == false && (millis() - time < 6000) && shotFired < 3) ///  bird flies for 6 seconds or after 3 bullets shot only if not killed
    {  
      if (dir == 1)
      {
        right();
      } else if (dir == 2)
      {
        left();
      }
      x += xIncrement;
      y += yIncrement;
    } else if ((millis() - time > 6000 && birdKilled == false) || (shotFired >= 3 && birdKilled == false)) // bird missed, it flies away.
    {
      birdFlyAway = true;
      
      canClick = false;  ///  no clicks while bird flies away
      
      up();
      x +=0;
      y -=50;
      stroke(255);
      fill(255);
      rect(295, 145, 210, 60);
      image(FlyAway, 300, 150, 200, 50);
    }      
    else if (birdKilled == true) //  bird killed, falls down.
    {
      birdFallen = true;
      
      canClick = false;  ///  no clicks while bird falls
      
      birdFalls(x, y);
      x +=0;
      y +=50;
    }
  } // end of birdFlies()



  void setTimer()
/***************************************************************************************
*  Purpose:  Sets the class property time to control that birds are not flying         *
*  for longer than 6 seconds.                                                          *
*  Parameters: none                                                                    *
*  Returns: none                                                                       *
***************************************************************************************/   
  {
    if (time == 0)
    {
      time = millis();
    }
  }
}
