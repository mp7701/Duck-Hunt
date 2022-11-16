/*********************************************************
*  Name: Mia Petrovic, Brendan Bain                      *
*  Course: ICS 3U 02  Pd. 8                              *
*  Assignment #Summative                                 *
*  http://ntci.on.ca/compsci/hef/ics3/a4_2018.html       *
*  Purpose:                                              * 
*  Due Date: May 23, 2018                                *
*********************************************************/


// Import sound library
// Works with both Processing 2 and Processing 3
// Confirm if works on school computers
//import processing.sound.*;
///
//import ddf.minim.*;
//import ddf.minim.signals.*;
//import ddf.minim.analysis.*;
//import ddf.minim.effects.*;


PImage main, copyright, gameA, gameB, gameC, topScore, backgroundA, backgroundB, backgroundC, gameOver; //<>//
PImage groundA, grass;
int screen = 0;
boolean level2Cycledone, canClick, newRound, perfectScore, showKill, isGameOver; 
duckhunt oDuckHunt;
int shotFired, birdInTheRound, discInTheRound;
int highestScore = 0;

////  sound files for the game
//SoundFile Game;   //  Dog intro music
//SoundFile Perfect;//  perfect score (bonus earned) music
//SoundFile Miss;   //  Music after the miss
//SoundFile Clear;  //  Round completed music
//SoundFile Get;    //  Music wen the bird is killed
//SoundFile Medley; //  Music for the main menu (opening screen)

//Minim minim;
//AudioPlayer Game, Perfect, Miss, Clear, Get, Medley;
//AudioMetaData GameMeta, PerfectMeta, MissMeta, ClearMeta, GetMeta, MedleyMeta;

void setup ()
{
  size (800, 600);
  background (color(0));
  main = loadImage ("Duck_Hunt_Logo.png");
  copyright = loadImage ("copyright.png");
  gameA = loadImage ("Game_A.png");
  gameB = loadImage ("Game_B.png");
  gameC = loadImage("Game_C.png");
  topScore = loadImage("TopScore.PNG");
  backgroundA = loadImage("Background_A.png");
  backgroundB = loadImage ("Background_B.png");
  backgroundC = loadImage ("Background_C.png");
  groundA = loadImage("Ground_A.png");
  grass = loadImage("Grass.png");
  gameOver = loadImage("GameOver.PNG");
  //oDuckHunt = new duckhunt();
  shotFired = 0;
  birdInTheRound = 0;
  discInTheRound = 0;
  newRound = false;
  perfectScore = false;
  isGameOver = false;
  showKill = false;
  canClick = true;

  //minim = new Minim(this);
  
  //Game = minim.loadFile("Game.mp3");
  //GameMeta = Game.getMetaData();

  //Perfect = minim.loadFile("Perfect.mp3");
  //PerfectMeta = Perfect.getMetaData();
  
  //Miss = minim.loadFile("Miss.mp3");
  //MissMeta = Miss.getMetaData();

  //Clear = minim.loadFile("Clear.mp3");
  //ClearMeta = Clear.getMetaData();

 // Get = minim.loadFile("Get.mp3");
  //GetMeta = Get.getMetaData();

  //Medley = minim.loadFile("Medley.mp3");
  //MedleyMeta = Medley.getMetaData();
  
  //Clear.pause();
  //Medley.play();
}

void draw()
{
  background (0);
  if (screen == 0)  ///   Main screen -- menu and high score
  {
    image (main, 175, 50, 450, 200);
    image (copyright, 175, 540, 375, 15);
    image (gameA, 265, 320, 375, 15);
    image (gameB, 265, 360, 375, 15);
    image (gameC, 265, 400, 395, 17);
//    image (topScore, 255, 440, 190, 40);

    textSize(22);
    fill(255, 255, 255, 204);    
    text(str(highestScore), 445, 465);
    
  } else if (screen == 1) //  Single bird game
  {
    if ((oDuckHunt.oScoreboard.round <= 25)  && (isGameOver == false))
    {        
      background(0);
      image (backgroundA, 0, 0, 800, 450);
      image (groundA, 0, 450, 800, 150);

      text( "R = " + str(oDuckHunt.oScoreboard.round), 60, 500);

      oDuckHunt.setGameMode(1);
      oDuckHunt.oScoreboard.display();

      if (oDuckHunt.oDog1.isIntro == true)
          oDuckHunt.oDog1.moveIntro();
      else 
//        Game.stop(); // stop the dog music
      {
        if (oDuckHunt.oBird1.cycleDone == false) 
        {
          oDuckHunt.oBird1.setTimer();
          oDuckHunt.oBird1.birdFlies();
          image (groundA, 0, 450, 800, 150);
          image (grass, 0, 0, 800, 450);
          oDuckHunt.oScoreboard.display();
          
          if (oDuckHunt.oBird1.softCycleDone == true)
            oDuckHunt.oDog1.showKill();
        } else //  New cycle 
        {
          ///  show the dog with kill
          //oDuckHunt.oDog1.showKill();
          oDuckHunt.oScoreboard.birdsFlyMethod();

          oDuckHunt.oBird1 = new Bird();
          birdInTheRound = birdInTheRound + 1;
          oDuckHunt.oBird1.thisBirdInTheRound = birdInTheRound;
          oDuckHunt.oBird1.cycleDone = false;
          shotFired = 0;
        }
      }
    } else // Game over
    {
      background(0);
      image (backgroundA, 0, 0, 800, 450);
      image (groundA, 0, 450, 800, 150);
      image (grass, 0, 0, 800, 450);
      image (gameOver, 300, 150, 200, 75);
      text( "R = " + str(oDuckHunt.oScoreboard.round), 60, 500);
      oDuckHunt.oScoreboard.display();
    }
  } else if (screen == 2) //  Two birds game
  {

    if ((oDuckHunt.oScoreboard.round <= 25)  && (isGameOver == false))
    {    
      background(0);
      image (backgroundB, 0, 0, 800, 450);
      image (groundA, 0, 450, 800, 150);
      image (grass, 0, 0, 800, 450);
      oDuckHunt.oScoreboard.display();
      oDuckHunt.setGameMode(2);    

      if (oDuckHunt.oDog1.isIntro == true)
        oDuckHunt.oDog1.moveIntro();
      else  //  New cycle 
      {  
        level2Cycledone = oDuckHunt.oBird1.cycleDone && oDuckHunt.oBird2.cycleDone;
        if (level2Cycledone == false)
        {
          if (oDuckHunt.oBird1.cycleDone == false ) 
          {      
            oDuckHunt.oBird1.setTimer();
            oDuckHunt.oBird1.birdFlies();
          }
          if (oDuckHunt.oBird2.cycleDone == false )
          {
            oDuckHunt.oBird2.setTimer();
            oDuckHunt.oBird2.birdFlies();
          } 
          image (groundA, 0, 450, 800, 150);
          image (grass, 0, 0, 800, 450);
          oDuckHunt.oScoreboard.display();
          if (oDuckHunt.oBird1.softCycleDone == true && oDuckHunt.oBird2.softCycleDone == true)
            oDuckHunt.oDog1.showKill();
        } else
        {
          // New Cycle
          ///
          //  show the dog with kill
          //oDuckHunt.oDog1.showKill(); 

          oDuckHunt.oScoreboard.birdsFlyMethod();
          ////
          oDuckHunt.oBird1 = new Bird();
          birdInTheRound = birdInTheRound + 1;
          oDuckHunt.oBird1.thisBirdInTheRound = birdInTheRound;          
          //
          oDuckHunt.oScoreboard.birdsFlyMethod();
          //
          oDuckHunt.oBird1.cycleDone = false;

          oDuckHunt.oScoreboard.birdsFlyMethod();

          oDuckHunt.oBird2 = new Bird();
          birdInTheRound = birdInTheRound + 1;
          oDuckHunt.oBird2.thisBirdInTheRound = birdInTheRound;          
          //
          //oDuckHunt.oScoreboard.birdsFlyMethod();
          oDuckHunt.oBird2.cycleDone = false;
          shotFired = 0;
        }
      }
    } else // Game over
    {

      background(0);
      image (backgroundB, 0, 0, 800, 450);
      image (groundA, 0, 450, 800, 150);
      image (grass, 0, 0, 800, 450);
      image (gameOver, 300, 150, 200, 75);
      text( "R = " + str(oDuckHunt.oScoreboard.round), 60, 500);
      oDuckHunt.oScoreboard.display();
    }
  } else if (screen == 3) //  Clay Discs game
  {
    if ((oDuckHunt.oScoreboard.round <= 25)  && (isGameOver == false))
    {
      background(0);
      image (backgroundC, 0, 0, 800, 450);
      fill (122);
      stroke (0);
      strokeWeight (5);
      rect (0, 450, 800, 150);
      stroke (122);
      rect (0, 455, 800, 150);
      text( "R = " + str(oDuckHunt.oScoreboard.round), 60, 500);
      oDuckHunt.oScoreboard.display();
      oDuckHunt.setGameMode(3);  


      level2Cycledone = oDuckHunt.oDisc1.cycleDone && oDuckHunt.oDisc2.cycleDone;
      
      if (level2Cycledone == false)
      {
        if (oDuckHunt.oDisc1.cycleDone == false ) 
        {      
          oDuckHunt.oDisc1.setTimer();
          oDuckHunt.oDisc1.discFlies();
        }
        if (oDuckHunt.oDisc2.cycleDone == false )
        {
          oDuckHunt.oDisc2.setTimer();
          oDuckHunt.oDisc2.discFlies();
        } 
        oDuckHunt.oScoreboard.display();
      } else
      {
        // New Cycle
        oDuckHunt.oScoreboard.discsFlyMethod();
        ////
        oDuckHunt.oDisc1 = new Clay();
        discInTheRound = discInTheRound + 1;
        oDuckHunt.oDisc1.thisDiscInTheRound = discInTheRound;          
        //
        oDuckHunt.oScoreboard.discsFlyMethod();
        //
        oDuckHunt.oDisc1.cycleDone = false;

        oDuckHunt.oScoreboard.discsFlyMethod();

        oDuckHunt.oDisc2 = new Clay();
        discInTheRound = discInTheRound + 1;
        oDuckHunt.oDisc2.thisDiscInTheRound = discInTheRound;          
        //
        //oDuckHunt.oScoreboard.birdsFlyMethod();
        oDuckHunt.oDisc2.cycleDone = false;
        shotFired = 0;
      }
    } else     //Game over
    {
      background(0);
      image (backgroundC, 0, 0, 800, 450);
      fill (122);
      stroke (0);
      strokeWeight (5);
      rect (0, 450, 800, 150);
      stroke (122);
      rect (0, 455, 800, 150);
      image (gameOver, 300, 150, 200, 75);
      //canClick = true;
      text( "R = " + str(oDuckHunt.oScoreboard.round), 60, 500);
      oDuckHunt.oScoreboard.display();  
    }
  }
//  Development only,  use to display x and y coordinates of the cursor
//  Uncoment two lines below to display.
  //fill(255, 0, 0);
  //text("(" + mouseX + ", " + mouseY + "," + ")", mouseX, mouseY);
}

void mouseReleased()
/**************************************************************
*  Purpose: Use mouseReleased Processing function to handle   *
*  user's mouse input  (Bird or disc hit or miss and menu     *
*  selections).                                               *
*  Parameters: none                                            *
*  Returns: none                                               *
**************************************************************/
{
  if (canClick && shotFired < 3) //  process the mouserelease only if up to 3 bullets are fired or birds fly for less than 6 seconds
  {
    if (screen == 0 && mouseX >= 250 && mouseX <= 640 && mouseY >= 310 && mouseY <= 335) // One bird mode
    {
      screen = 1;
      oDuckHunt = new duckhunt(1);
      //Medley.pause();
    } else if (screen == 0 && mouseX >= 250 && mouseX <= 640 && mouseY >= 360 && mouseY <= 380) // Two birds mode
    {
      screen = 2;
      oDuckHunt = new duckhunt(2);
      //Medley.pause();
    } else if (screen == 0 && mouseX >= 250 && mouseX <= 660 && mouseY >= 395 && mouseY <= 420) // Clay shooting mode
    {
      screen = 3;
      oDuckHunt = new duckhunt(3);
      //Medley.pause();
    } else if ((screen == 1 || screen == 2 || screen == 3) && (isGameOver == true)) //  Return to main screen after game is oved and display the highest score
    {
      highestScore = max(oDuckHunt.oScoreboard.gameScore, highestScore);
      screen = 0;
      setup();
    } else if (screen == 1 && oDuckHunt.oDog1.isIntro == false) //  One bird mode and dog has finished intro
    {
      shotFired = shotFired+ 1;
      if (oDuckHunt.oBird1.birdHit(mouseX, mouseY) == true)
      {
        //Get.play();
        oDuckHunt.oScoreboard.scoreBirdHit(oDuckHunt.oBird1);
      }  
    } else if (screen == 2 && oDuckHunt.oDog1.isIntro == false) //  Two birds mode and dog has finished intro
    {
      shotFired= shotFired+ 1;
      if (oDuckHunt.oBird1.birdHit(mouseX, mouseY) == true)
      {
        //Get.play();
        oDuckHunt.oScoreboard.scoreBirdHit(oDuckHunt.oBird1);
      } 
      else if (oDuckHunt.oBird2.birdHit(mouseX, mouseY) == true) /// prevents two birds to be killed by a single bullet
      {
        //Get.play();
        oDuckHunt.oScoreboard.scoreBirdHit(oDuckHunt.oBird2);
      } 
    } else if (screen == 3) // clay shooting
    {
      shotFired= shotFired+ 1;
      if (shotFired <= 3 && (oDuckHunt.oDisc1.discKilled == false && oDuckHunt.oDisc1.discKilled == false))
      {
      if (oDuckHunt.oDisc1.discHit(mouseX, mouseY) == true)
        oDuckHunt.oScoreboard.scoreDiscHit(oDuckHunt.oDisc1);
      else if (oDuckHunt.oDisc2.discHit(mouseX, mouseY) == true) /// prevents two discs to be hit by a single bullet
        oDuckHunt.oScoreboard.scoreDiscHit(oDuckHunt.oDisc2);
      }
    }
  }
} // end of MouseReleased
