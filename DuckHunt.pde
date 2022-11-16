/*********************************************************
 *  Name: Mia Petrovic                                    *
 *  Course: ICS 3U  Pd. 8                                 *
 *  Assignment: Summative Final                           *
 *  Purpose: Create a class to duckhunt control the game  *
 *  Due Date: May 23, 2018                                *
 *********************************************************/
/*  Methods:
/*  Constructor --- duckhunt(int xMode) - Depending on the game mode creates necesary objects (one bird, two birds, clay discs, dog and scoreboard object )
/*  void setGameMode(int Screen) -- Calls setGameMOde() on all objects to ensure that all are synchronized
*/   

class duckhunt
///Controls the whole game
/// creates other objects and sets teh behaviour depending on game mode
{
  int iGameMode = 0;
  boolean roundOver = false;
  Dog oDog1;
  Bird oBird1, oBird2;
  scoreboard oScoreboard;
  Clay oDisc1;
  Clay oDisc2;


  duckhunt(int xMode)
/****************************************************************************
*  Purpose:  Duck Hunt game class constructor. Depending on the game mode   *
*  creates necesary objects (one bird, two birds, clay discs, dog and       *
*  scoreboard objects                                                       *
*  Parameters: Integer xMode --- Parameter indicates the game mode          *
*  Returns: duckhunt object                                                 *
****************************************************************************/  

  {
    if (xMode == 1 || xMode == 2)
    {
      oDog1 = new Dog();
      oBird1 = new Bird();
      birdInTheRound = birdInTheRound + 1;
      oBird1.thisBirdInTheRound = birdInTheRound;
    }
    if (xMode == 2)
      {
      oBird2 = new Bird();
      birdInTheRound = birdInTheRound + 1;
      oBird2.thisBirdInTheRound = birdInTheRound;
      }
    if (xMode == 3)
    {
      oDisc1 = new Clay();
      discInTheRound = discInTheRound + 1;
      oDisc1.thisDiscInTheRound = discInTheRound;
      oDisc2 = new Clay();
      discInTheRound = discInTheRound + 1;
      oDisc2.thisDiscInTheRound = discInTheRound;      
    }
    oScoreboard = new scoreboard();
    
  }

  void setGameMode(int Screen)
/***************************************************************************************
*  Purpose:  Calls setGameMOde() on all objects to ensure that all are synchronized.   *
*  Parameters: Integer Screen --- Parameter indicates the game mode                    *
*  Returns: none                                                                       *
***************************************************************************************/
  {
    iGameMode = Screen;
    oScoreboard.setGameMode(Screen); 
    if (Screen != 3)
    {
    oDog1.setGameMode(Screen);
    oBird1.setGameMode(Screen);
    if (Screen == 2)
      oBird2.setGameMode(Screen);
    if (Screen == 3)
      oBird2.setGameMode(Screen);
    } else
    {
      oDisc1.setGameMode(Screen);
      oDisc2.setGameMode(Screen);
    }
  }
}