/* ________________________________HIGHSCORES FUNCTIONS___________________ */
                                
/*________________________________________________________________________ */

/* ___PRINT HIGHSCORE ON SCOREBOARD___ */
int printHighscore(int highscore) {
  strokeText(str(highscore), width/2+210, height/2+75, mainColor, 0, 70, 3, numbersFont, CENTER, 255);
  for (int i = 0; i < players.length; i++) {
    if (players[i]) {
      if (playersScore[i] > highscore || millis() - highscoreTimeout < 1000) {
        if (playersScore[i] > highscore) {
          highscore = playersScore[i];
          highscoreColor = playersColor[i];
          highscoreTimeout = millis();
        }
        strokeText("NEW HIGHSCORE", width/2+65, height/2+65, mainColor, 0, 50, 2, textFont, CENTER, 255);
        strokeText(str(highscore), width/2+210, height/2+75, highscoreColor, 0, 70, 3, numbersFont, CENTER, 255);
      } 
    }
  }
  return highscore;
}
/* ___SAVE HIGHSCORE IN HIGHSCORES.TXT___ */
void saveHighscores() {
 highscores[0] = str(easyHighscore);
 highscores[1] = str(mediumHighscore);
 highscores[2] = str(hardHighscore);
 saveStrings("data/highscores.txt", highscores);
}
/* ___LOAD HIGHSCORES FROM FILE___ */
void loadighscores() {
  highscores = loadStrings("data/highscores.txt");
  easyHighscore = int(highscores[0]);
  mediumHighscore = int(highscores[1]);
  hardHighscore = int(highscores[2]);
}
