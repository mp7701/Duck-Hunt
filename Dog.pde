/********************************************************* //<>//
 *  Name: Mia Petrovic                                    *
 *  Course: ICS 3U  Pd. 8                                 *
 *  Assignment: Summative Final                           *
 *  Purpose: Create a class called Dog.......             *
 *  Due Date: May 23, 2018                                *
 *********************************************************/
/*  Methods:
/*  Constructor --- Dog()
/*  void setGameMode(int Screen) -- Sets the game mode (1 - One Bird, 2 - Two Birds, 3 - Clay Discs)
/*  void moveIntro ()--- Moves the dog acros the base of the screen at the begining of every round.
/*  void showKill () --- At the end of the cycle dog shws one killed bird, two killed birds or laughs empty handed.
*/

class Dog
{
  PImage DogStop, DogJump1, DogJump2, DogLaugh, DogKill, DogShow1Duck, DogShow2Ducks, RoundImage;
  PImage[] imagesIntro = new PImage[5];
  int currentFrame = 0;
  int numFrames;
  int iGameMode;
  int iDogXPosition = 0;
  boolean isIntro = true; /// new
  int x = 0;
  int y = 400;
  Dog()
/****************************************************************************
*  Purpose:  Dog class constructor. Setts the values of dog properties      *
*  Parameters: none                                                         *
*  Returns: Dog object                                                      *
****************************************************************************/  
  {
    DogStop = loadImage("DogStop.png");
    DogJump1 = loadImage ("DogJump_1.png");
    DogJump2 = loadImage ("DogJump_2.png");
    DogLaugh = loadImage ("DogLaugh_1.png");
    DogShow1Duck = loadImage ("Holding1Duck.png");
    DogShow2Ducks = loadImage ("Holding2Ducks.png");
    RoundImage = loadImage("Round.PNG");
    frameRate(3);
    imagesIntro[0]  = loadImage("DogWalk_1.png");
    imagesIntro[1]  = loadImage("DogWalk_2.png");
    imagesIntro[2]  = loadImage("DogWalk_3.png");
    imagesIntro[3]  = loadImage("DogWalk_4.png");
    imagesIntro[4]  = loadImage("DogWalk_5.png");

    //Game.play();
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


  void moveIntro ()
/***************************************************************************************
*  Purpose: Moves the dog acros the base of the screen at the begining of every round. *
*  Parameters: none                                                                    *
*  Returns: none                                                                       *
***************************************************************************************/    
  {
    frameRate(2);
    numFrames = 5;
    // Moves dog during introduction
    int offset = 0;
    boolean jumped = false;
    if (x< 300)
    {
      currentFrame = (currentFrame+1) % numFrames;  // Use % to cycle through frames
      image(imagesIntro[(currentFrame+offset) % numFrames], x, y, 125, 100);
      x+=30;

      if (x> 100)
        perfectScore = false; //  remove perfect sign if on the screen
    } else if (x == 300)
    {
      image(DogStop, x, y, 125, 100);
      x+=2;
    } else if (x==302)
    {
      if (y==400)
      {
        image(DogJump1, x, y, 125, 100);
        y-=100;
      } else if (y==300)
      {
        image (DogJump2, x, y, 125, 100);
        x+=10;
        jumped = true;
      }
      if (jumped == true)
      {
        isIntro = false;
        //Game.pause();
        frameRate(oDuckHunt.oScoreboard.iBirdframeRate); //  setting speed for birds
        delay(10);
      }
      iDogXPosition = x;
    }
    
    if (x > 100)
    {
    image(RoundImage, 300, 140, 200, 100);
    text(str(oDuckHunt.oScoreboard.round), 385, 210);
    }
    // End of MoveIntro
  }

  void showKill ()
/*******************************************************************************************
*  Purpose: At the end of the cycle dog shwos one killed bird, two killed birds or laughs  *
*  empty handed.                                                                           *
*  Parameters: none                                                                        *
*  Returns: none                                                                           *
*******************************************************************************************/ 
  {

    PImage ThisDog = DogShow1Duck;
    //if (iGameMode == 1 && oDuckHunt.oBird1.cycleDone) //<>//
    if (iGameMode == 1 && oDuckHunt.oBird1.softCycleDone)
    {
      if (oDuckHunt.oBird1.birdKilled == true) 
      {
        ThisDog = DogShow1Duck;
      } else
      {
        ThisDog = DogLaugh;
      }
      //} else if (iGameMode == 2  && level2Cycledone)
    } else if (iGameMode == 2  && oDuckHunt.oBird1.softCycleDone == true && oDuckHunt.oBird2.softCycleDone == true)
    {
      if (oDuckHunt.oBird1.birdKilled == true && oDuckHunt.oBird2.birdKilled == true) 
      {
        ThisDog = DogShow2Ducks;
      } else if (oDuckHunt.oBird1.birdKilled == true || oDuckHunt.oBird2.birdKilled == true)
      {
        ThisDog = DogShow1Duck;
      } else if (oDuckHunt.oBird1.birdKilled == false && oDuckHunt.oBird2.birdKilled == false)
      {
        ThisDog = DogLaugh;
      }
    } 

    image(ThisDog, 375, 325, 125, 100);


    if (iGameMode == 3)
    {
      // do nothing
    }
  }
  //End of class definition
}
