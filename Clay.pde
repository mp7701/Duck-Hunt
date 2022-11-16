/*********************************************************
 *  Name: Mia Petrovic                                    *
 *  Course: ICS 3U  Pd. 8                                 *
 *  Assignment: Summative Final                           *
 *  Purpose: Create a class called Clay to implement discs*
 *  Due Date: May 23, 2018                                *
 *********************************************************/
/*  Methods:
/*  Constructor -- -Clay()
/*  void setGameMode(int Screen) -- Sets the game mode (1 - One Bird, 2 - Two Birds, 3 - Clay Discs)
/*  boolean discHit(int mX, int mY) --- called from mouseReleased(), checks if the mouse coordinates are withing current disc coordinates (returns true for hit)
/*  void setTimer() --- Sets the class property time to control that discs are not flying for longer than 6 seconds 
/*  void discFlies() --- called from within Draw() to move the disc on the screen
/*  void Fly() --- moves the disc on the screen based on random x and y increments. Makes the disc smaller by 20% every second.
*/

class Clay
{

  boolean discKilled, discFallen, cycleDone;
  int thisDiscInTheRound, shotx, shoty, time, xIncrement, yIncrement, cycle, currentDisc, numDisc; // new
  int iGameMode, offset, x, y, currentX, currenty; 

  PImage [] DiscFly = new PImage[3]; 
  //PImage DiscEmpty = loadImage("DiscEmpty.PNG");
  //PImage DiscFull = loadImage("DiscFull.PNG");



  Clay()
/****************************************************************************
*  Purpose:  Clay class constructor. Setts the values of clay properties    *
*  Parameters: none                                                         *
*  Returns: Clay object                                                 *
****************************************************************************/ 
  {
    discKilled = false;
    discFallen = false;
    cycleDone = false;

    //Array of red Flying Discs
    DiscFly[0]  = loadImage("Disc1.png");
    DiscFly[1]  = loadImage("Disc2.png");
    DiscFly[2]  = loadImage("Disc3.png");

    //setTimer();
    time = 0;
    xIncrement = (int)random (5, 25); //  new
    yIncrement = (int)random (5, 25); // new
    cycle = 0;

    currentDisc = 0;
    numDisc = 3;  
    offset = 3;
    x = 400;
    y = 450;
    currentX = 150;
    currenty = 100;
    iGameMode = 3;

    xIncrement = (int)random (-25, 25); //  new
    yIncrement = -1 * ((int)random (5, 25)); // new
  }


  void Fly()
/******************************************************************************
*  Purpose:  moves the disc on the screen based on random x and y increments. *
*  Makes the disc smaller by 20% every second.                                *
*  Parameters: none                                                           *
*  Returns: none                                                              *
******************************************************************************/ 
  {
    //  Make immage smaller by 20% every second
    if (millis() - time > 6000) 
      cycleDone = true;
    if (millis() - time > 4000)
    {
      currentDisc = (currentDisc+1) % numDisc;  // Use % to cycle through frames
      image(DiscFly[(currentDisc+offset) % numDisc], x, y, 75, 40);
    }
    if (millis() - time > 3000)
    {
      currentDisc = (currentDisc+1) % numDisc;  // Use % to cycle through frames
      image(DiscFly[(currentDisc+offset) % numDisc], x, y, 93, 51);
    } else if (millis() - time > 2000)
    {
      currentDisc = (currentDisc+1) % numDisc;  // Use % to cycle through frames
      image(DiscFly[(currentDisc+offset) % numDisc], x, y, 104, 64);
    } else if (millis() - time > 1000)
    {
      currentDisc = (currentDisc+1) % numDisc;  // Use % to cycle through frames
      image(DiscFly[(currentDisc+offset) % numDisc], x, y, 130, 80);
    } else  
    {
      currentDisc = (currentDisc+1) % numDisc;  // Use % to cycle through frames
      image(DiscFly[(currentDisc+offset) % numDisc], x, y, 150, 100);
    }
  }


  void discFlies()
/****************************************************************************
*  Purpose:  Called from within Draw() to move the disc on the screen       *
*  Parameters: none                                                         *
*  Returns: none                                                            *
****************************************************************************/ 
  {
    if (discKilled == false && (millis() - time < 6000) && shotFired <= 3)
    {
      Fly();

      x += xIncrement;
      y += yIncrement;
    } else if ((millis() - time > 6000) || (shotFired >= 3))
    {
      cycle = cycle + 1;
        //if (cycle == iGameMode)
      cycleDone = true;
      //canClick = false;
    } else if (discKilled == true)
    {

      int score = oDuckHunt.oScoreboard.getScore(oDuckHunt.oScoreboard.round);

      text( str(score), shotx, shoty);    
    }
  }


  boolean discHit(int mX, int mY)
/***************************************************************************************
*  Purpose:  Checks if the mouse coordinates are withing current disc coordinates      *
*  (returns true for hit). Called from mouseReleased()                                 *
*  Parameters: Integer x Coordinate, Integer y coordinate                              *
*  Returns: boolean --- true for hit and false for miss                                *
***************************************************************************************/   
  {
    if (mX >= x && mX <= x + currentX && mY >= y && mY <= y + currenty)
    {
      
      if (shotx == 0 || shoty == 0)
      {
        shotx = x;
        shoty = y;
      }      
      discKilled = true; //<>//
      //cycleDone = true;
      return true;
    }
    return false;
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

  void setTimer()
/***************************************************************************************
*  Purpose:  Sets the class property time to control that discs are not flying         *
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
