import processing.sound.*;

/* ______________________________FLAPPYMULTI______________________________ */

//Authors : Noah Buisson, Benoit Busnardo, Gaspard Hedde, Clément Michellod 

/* ______________________________________________________________________ */

PImage backgroundImg, pipeTopImg, pipeBottomImg, groundImg, backgroundEasyImg, backgroundMediumImg, backgroundHardImg, pipeTopEasyImg, pipeTopMediumImg, pipeTopHardImg, pipeBottomEasyImg, pipeBottomMediumImg, pipeBottomHardImg, groundEasyImg, groundMediumImg, groundHardImg, iconImg, scoreImg, restartImg, restartSelectedImg, menuImg, menuSelectedImg, soundOnImg, soundOffImg, soundOnSelectedImg, soundOffSelectedImg, playImg, playSelectedImg, easyImg, mediumImg, hardImg, easySelectedImg, mediumSelectedImg, hardSelectedImg, leftArrowImg, rightArrowImg, musicOnImg, musicOffImg, musicOnSelectedImg, musicOffSelectedImg, settingsImg, settingsSelectedImg, confirmImg, confirmSelectedImg, p1Img, p2Img, p3Img, p4Img, p1SelectedImg, p2SelectedImg, p3SelectedImg, p4SelectedImg, easyScreenImg, mediumScreenImg, hardScreenImg;
SoundFile flapSound, hitSound, scoreSound, wooshSound, themeSound;
PFont textFont, numbersFont;
color mainColor, highscoreColor;

float minRotation, maxRotation, minYVertical, maxYVertical, textOpacity;
int game, title, menu, settings, easyHighscore, hardHighscore, mediumHighscore, groundX, pipeGap, pipesNumber, pipesAppearWidth, pipesAppearGap, pipeGroundGap, startTime, elapsedTime, getReadyTime, groundColisionY, topColisionY, gameOverSelectedButton, menuSelectedButton, settingsSelectedButton, gameOverButtonsCount, menuButtonsCount, settingsButtonsCount, flapSoundTimeout, wooshSoundTimeout, highscoreTimeout, ySpeed, xSpeed, jumpSpeed;
int[] pipesX, pipesY;
String difficulty;
boolean drawLastFrame, showText, playingTheme, playingFlapSound, playingWooshSound, nextPipeIsHigh, sound, music;

/* ___RELATED TO PLAYERS___ */

PImage[] playersImg;
color[] playersColor;

float[] playersRotationAngle;
int[] playersX, playersY, playersYVelocity, playersDeadX, playersScore, playersScoreboardX, playersScoreboardY, playersScoreY, playersKeyY;
boolean[] players, playersDead, playersIsDying;
boolean[][] playersPipesScored;

String[] playersKey, highscores;

/* ___SETUP___ */
void setup() {
  fullScreen();
  frameRate(30);

  // Window icon and title
  iconImg = loadImage("data/images/icon.png");  
  surface.setIcon(iconImg);
  surface.setTitle("FlappyMulti - A multiplayer Flappy Bird Game");

  settings = gameOverSelectedButton = settingsSelectedButton = 0;
  drawLastFrame = playingTheme = playingFlapSound = false;
  menu = title = 1;
  
  /* ___ADAPT VARS___ */
  ySpeed = 3; //1
  xSpeed = 10; //5
  jumpSpeed = 25; //15
  minYVertical = -25; // 18
  maxYVertical = 25;
  minRotation = -PI/5;
  maxRotation = PI/5;
  
  gameOverButtonsCount = 2;
  settingsButtonsCount = menuSelectedButton = 3;
  menuButtonsCount = 4;

  /* ___LOAD HIGHSCORES FROM FILE___ */
  highscores = loadStrings("highscores.txt");
  easyHighscore = int(highscores[0]);
  mediumHighscore = int(highscores[1]);
  hardHighscore = int(highscores[2]);

  playersX = new int[4];
  playersY = new int[4];
  playersYVelocity = new int[4];
  playersScore = new int[4];
  playersDeadX = new int[4];
  playersKeyY = new int[4];

  /* ___PLAYERS___ */
  playersImg = new PImage[4];
  players = new boolean[4];
  playersDead = new boolean[4];
  playersIsDying = new boolean[4];

  players[0] = true;
  players[1] = players[2] = players[3] = false;

  playersDead[0] = false;
  playersDead[1] = playersDead[2] = playersDead[3] = true;

  playersIsDying[0] = false;
  playersIsDying[1] = playersIsDying[2] = playersIsDying[3] = true;

  /* ___PLAYERS COLORS___ */
  playersColor = new color[4];

  playersColor[0] = color(234, 112, 69);
  playersColor[1] = color(254, 196, 0);
  playersColor[2] = color(55, 127, 190);
  playersColor[3] = color(55, 198, 67);

  /* ___PLAYERS KEY___ */
  playersKey = new String[4];

  playersKey[0] = "Red button";
  playersKey[1] = "Yellow button";
  playersKey[2] = "Blue button";
  playersKey[3] = "Green button";

  playersKeyY[0] = playersKeyY[2] = height/2-200;
  playersKeyY[1] = playersKeyY[3] = height/2-50;

  /* ___PLAYERS SCORES___ */
  playersScoreboardY = new int[4];
  playersScoreboardX = new int[4];
  playersScoreY = new int[4];

  playersScoreboardX[0] = width/2+215;
  playersScoreboardX[1] = width/2+140;
  playersScoreboardX[2] = width/2+65;
  playersScoreboardX[3] = width/2-10;

  playersScoreboardY[0] = playersScoreboardY[1] = playersScoreboardY[2] = playersScoreboardY[3] = height/2-32;

  playersScoreY[0] = 100;
  playersScoreY[1] = 200;
  playersScoreY[2] = 300;
  playersScoreY[3] = 400;

  /* ___INITIALISE SOUNDS TIMEOUTS___ */
  getReadyTime = 1000;
  flapSoundTimeout = highscoreTimeout = wooshSoundTimeout = millis();

  /* ___COLISIONS FOR PLAYERS___ */
  groundColisionY = height-160;
  topColisionY = 35;

  /* ___ROTATIONS FOR PLAYERS___ */
  playersRotationAngle = new float[4];


  /* ___PIPE SPAWN GAPS___ */
  pipesAppearGap = 200;
  pipeGroundGap = 50;
  pipesAppearWidth = width+pipesAppearGap;

  /* ___COLORS___ */
  mainColor = color(255, 255, 255);

  /* ___DEFINE IMAGES___ */
  loadImages();

  backgroundImg = backgroundEasyImg;
  groundImg = groundEasyImg;
  pipeTopImg = pipeTopEasyImg;
  pipeBottomImg = pipeBottomEasyImg;

  /* ___DEFINE DIFFICULTY___ */
  setDifficulty("easy");

  /* ___DEFINE SOUNDS___ */
  loadSounds();

  sound = true;
  music = true;

  if (music) {
    if (!playingTheme) {
      themeSound.loop();
      playingTheme = true;
    }
  }
  

  /* ___DEFINE FONTS___ */
  textFont = createFont("data/fonts/text.otf", 32);
  numbersFont = createFont("data/fonts/numbers.ttf", 32);
  textSize(40);
  textFont(textFont);

  fill(255,255,255);
}

/* ___EXIT GAME WHEN PRESSING ESC___ */
void exitGame() {
  println("Saving highscores...");
  saveHighscores();
  exit();
}


/* ________________________________PIPE POSITIONS FUNCTIONS___________________ */
                                
/*________________________________________________________________________ */

/* ___ RESET PIPES BEFORE A GAME ___ */
void resetPipes() {
  /* ___REPLACE ALL PIPES___ */
  for(int i = 0; i < pipesX.length; i++) {
    pipesX[i] = pipesAppearWidth + i * (pipesAppearWidth / pipesNumber);
    pipesY[i] = pipeY();

    playersPipesScored[0][i] = false;
    playersPipesScored[1][i] = false;
    playersPipesScored[2][i] = false;
    playersPipesScored[3][i] = false;
  }
}

/* ___GENERATE RANDOM PIPE Y POSITION___ */
int pipeY() {
  int minY, maxY;
  
  if (difficulty == "easy") {
    
    return (int)random(pipeGap*2, height - pipeGap*2 - pipeGroundGap);

  } else {
    
    if (nextPipeIsHigh) {
      nextPipeIsHigh = false;
      minY = pipeGroundGap * 6;
      maxY = pipeGroundGap * 8;
    } else {
      nextPipeIsHigh = true;
      minY = height - pipeGroundGap * 10;
      maxY = height - pipeGroundGap * 8;
    }
    
    return (int)random(minY, maxY);
  }
}
