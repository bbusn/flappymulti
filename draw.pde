/* ___DRAW___ */
void draw() {
  /* ___IF GAME IS ON___ */
  if(game == 1) {
    /* ___IF ALL BIRDS ARE DEAD___ */
    if (playersDead[0] && playersDead[1] && playersDead[2] && playersDead[3]) {
      drawLastFrame = true;
      menu = game = 0;
    }

    if (sound) {
      if (millis() - flapSoundTimeout > 140) {
        playingFlapSound = false;
      }
    }

    drawImage(CORNER, backgroundImg, 0, 0);

    /* ___DRAW ALL PIPES___ */
    drawPipes();

    /* ___FOR ALL PLAYERS___ */
    for (int i = 0; i < players.length; i++) {
      if (players[i]) {
        /* ___GET ELAPSTED TIME SINCE START TIME___ */
        elapsedTime = millis() - startTime;

        if (!playersDead[i]) {
          if (elapsedTime > getReadyTime) {
            /* ___ADD GRAVITY TO VERTICAL VELOCITY___ */
            playersYVelocity[i] += ySpeed;
          } else {
            if (i == 0) { 
              /* ___GETTING READY TEXT WITH BLINKING ANIMATION___ */
              int blinkInterval = 100;
              boolean isVisible = (millis() / blinkInterval) % 2 == 0;
              if (isVisible) {
                strokeText("Get Ready", width/2, 200, mainColor, 0, 110, 4, textFont, CENTER, 255);
              }
            }
          }

          /*___UPDATE PLAYER VERTICAL VELOCITY___*/
          playersY[i] += playersYVelocity[i];
          
          /* ___ROTATE PLAYER BIRD___ */
          playersRotationAngle[i] = map(playersYVelocity[i], minYVertical, maxYVertical, minRotation, maxRotation);

          /* ___DRAW PLAYER BIRD___ */
          int opacity = 255;
          if (playersIsDying[i]) {
            opacity = 155;
          }
          drawPlayer(playersX[i], playersY[i], playersRotationAngle[i], playersImg[i], opacity);
          
          /* ___IF PLAYER TOUCHED GROUND___ */
          if (playersY[i] > groundColisionY) {
            /* ___IF PLAYER IS NOT ALREADY DYING___ */
            if (!playersIsDying[i]) {
              if (sound) {
                hitSound.play();
              }
              playersIsDying[i] = true;
            }
            playersDead[i] = true;
          }

          /* ___IF PLAYER TOUCHED CEILING___ */
          if (!playersIsDying[i]) {
            /* ___PLAYER 1 TOP COLLISION___ */
            if (playersY[i] < topColisionY) {
              playersIsDying[i] = true;
              if (sound) {
                hitSound.play();
              }
              playersYVelocity[i] += abs(playersYVelocity[i]); // Add vertical velocity to make a rebounce
            }
          }
        } else {
          /* ___IF PLAYER 1 IS DEAD___ */
          playersYVelocity[i] = 0;
          playersY[i] = groundColisionY;
          if (!(playersIsDying[0] && playersIsDying[1] && playersIsDying[2] && playersIsDying[3])) {
            playersX[i] -= xSpeed;
          }
          drawPlayer(playersX[i], playersY[i], playersRotationAngle[i], playersImg[i], 155);
        }
        /* ___DRAW SCORE___ */
        if (elapsedTime > getReadyTime) {
          int opacity;
          if (difficulty == "easy") {
            opacity = 255;
          } else if (difficulty == "medium") {
            opacity = 235;
          } else {
            opacity = 200;
          }
          if (playersDead[i] || playersIsDying[i]) {
            opacity = 15;
          }
          strokeText(str(playersScore[i]), 100, playersScoreY[i], playersColor[i], 0, 80, 4, numbersFont, LEFT, opacity);
        }
      }
    }

    /* ___FOR ALL PIPES___ */
    for(int i = 0; i < pipesX.length; i++) {
      /* ___IF PIPE IS OUTSIDE SCREEN___ */
      if(pipesX[i] + (pipeTopImg.width / 2) < 0) {
        /* ___RESET PIPE SCORED___ */
        for (int j = 0; j < players.length; j++) {
          if (players[j]) {
            playersPipesScored[j][i] = false;
          }
        }

        /* ___RESET FIRST PIPE AFTER LAST PIPE ___ */
        if (i == 0) {
          pipesY[i] = pipeY();
          pipesX[i] = pipesX[pipesX.length - 1] + (pipesAppearWidth / pipesNumber);
        } else {
          pipesY[i] = pipeY();
          pipesX[i] = pipesX[i - 1] + (pipesAppearWidth / pipesNumber);
        }
      }

      /* ___FOR ALL PLAYERS INSIDE PIPE LOOP___ */
      for (int j = 0; j < players.length; j++) {
        if (players[j]) {
          /* ___ IF BIRDS PASSED THROUGH A PIPE ___ */
          if (playersX[j] > pipesX[i]) {
            /* ___ IF BIRD DID NOT PASSED THIS ONE ___ */
            if (!playersPipesScored[j][i]) {
              playersScore[j]++;
              if (sound) {
                scoreSound.play();
              }
              playersPipesScored[j][i] = true;
            }
          }
          /* ___IF PLAYER BIRD TOUCHED A PIPE ___ */
          if((abs(playersX[j] - pipesX[i]) < pipeTopImg.width - 20 && (abs(playersY[j] - pipesY[i]) > pipeGap-30))) {
            /* ___IF PLAYER BIRD TOUCHED INSIDE OF A PIPE ___ */
            if (abs(playersX[j] - pipesX[i]) < 70) {
              if (!playersIsDying[j]) {
                playersYVelocity[j] += abs(playersYVelocity[j]); // Add vertical velocity to make a rebounce
                if (sound) {
                  hitSound.play();
                }
              }
              playersIsDying[j] = true;                        
            } else {
              playersX[j] -= 10;  // Add horizontal velocity to make a rebounce
              if (!playersIsDying[j]) {
                if (sound) {
                  hitSound.play();
                }
                playersIsDying[j] = true;                        
              }
            }
          }
        }
      }
      /* ___MOVE PIPE ON X SO IT FOLLOWS GROUND___ */
      if (!(playersIsDying[0] && playersIsDying[1] && playersIsDying[2] && playersIsDying[3])) {
        if (elapsedTime > getReadyTime) {
          pipesX[i] -= xSpeed;
        }
      }
    }
    
    /* ___DRAW GROUND___ */
    drawImage(CENTER, groundImg, groundX, height-groundImg.height/2);
    drawImage(CENTER, groundImg, groundX+groundImg.width, height-groundImg.height/2);

    /* ___IF BIRDS ARE NOT DYING MOVE GROUND___ */
    if (!(playersIsDying[0] && playersIsDying[1] && playersIsDying[2] && playersIsDying[3])) {
      groundX -= xSpeed;

      /* ___IF GROUND X IS TOO LOW, RESET X___ */
      if (groundX < -width/2) {
        groundX += width/2;
      }
    }

    fill(255);
    textSize(40);
  
  } else {
    if (sound) {
      if (millis() - wooshSoundTimeout > 100) {
        playingWooshSound = false;
      }
    }

    if (menu == 1) {
      /* ___DRAW BACKGROUND___ */
      drawImage(CORNER, backgroundImg, 0, 0);

      /* ___DRAW GROUND___ */
      drawImage(CENTER, groundImg, groundX, height-groundImg.height/2);
      drawImage(CENTER, groundImg, groundX+groundImg.width, height-groundImg.height/2);

      /* ___MOVE GROUND___ */
      groundX -= xSpeed;

      /* ___IF GROUND X IS TOO LOW, RESET X___ */
      if (groundX < -width/2) {
        groundX += width/2;
      }

      /* ___IF AT TITLE START___ */
      if (title == 1) {
        strokeText("FlappyMulti", width/2, height/2, mainColor, 0, 150, 4, textFont, CENTER, 255);
        int blinkInterval = 300;
        boolean isVisible = (millis() / blinkInterval) % 2 == 0;
        
        if (isVisible) {
          strokeText("Use space and arrows to navigate through the menu", width/2, height/2+100, mainColor, 0, 50, 3, textFont, CENTER, 255);
        }
      } else {
        if (settings == 1) {
          strokeText("FlappyMulti", width/2, height/2-300, mainColor, 0, 150, 4, textFont, CENTER, 255);
          for (int i = 0; i < settingsButtonsCount; i++) {
            /*____IF BUTTON SELECTED____*/
            if (i == settingsSelectedButton) {
              if (i == 0) {
                /*____DRAW ARROWS____*/
                drawArrows(height/2-150);
                if (music) {
                  strokeImage(musicOnSelectedImg, width/2, height/2-150, 8);
                } else {
                  strokeImage(musicOffSelectedImg, width/2, height/2-150, 8);
                }
              } else if (i == 1) {
                /*____DRAW ARROWS____*/
                drawArrows(height/2);
                if (sound) {
                  strokeImage(soundOnSelectedImg, width/2, height/2, 8);
                } else {
                  strokeImage(soundOffSelectedImg, width/2, height/2, 8);
                }
              } else if (i == 2) {
                strokeImage(confirmSelectedImg, width/2, height/2+150, 8);
              }
            } else {
              if (i == 0) {
                if (music) {
                  strokeImage(musicOnImg, width/2, height/2-150, 8);
                } else {
                  strokeImage(musicOffImg, width/2, height/2-150, 8);
                }
              } else if (i == 1) {
                if (sound) {
                  strokeImage(soundOnImg, width/2, height/2, 8);
                } else {
                  strokeImage(soundOffImg, width/2, height/2, 8);
                }
              } else if (i == 2) {
                strokeImage(confirmImg, width/2, height/2+150, 8);
              }
            }
          }
        } else {
          strokeText("FlappyMulti", width/2, height/2-300, mainColor, 0, 150, 4, textFont, CENTER, 255);
          for (int i = 0; i < menuButtonsCount; i++) {
            /*____IF BUTTON SELECTED____*/
            if (i == menuSelectedButton) {
              if (i == 0) {
                strokeImage(settingsSelectedImg, width/2, height/2-150, 8);
              } else if (i == 1) {
                /*____DRAW ARROWS____*/
                drawArrows(height/2);

                /*____SELECT DIFFICULTY BUTTON____*/
                if (difficulty == "easy") {
                  strokeImage(easySelectedImg, width/2, height/2, 8);
                  strokeImage(easyScreenImg, width/2+500, height/2-85, 10);
                } else if (difficulty == "medium") {
                  strokeImage(mediumSelectedImg, width/2, height/2, 8);
                  strokeImage(mediumScreenImg, width/2+500, height/2-85, 10);
                } else {
                  strokeImage(hardSelectedImg, width/2, height/2, 8);
                  strokeImage(hardScreenImg, width/2+500, height/2-85, 10);
                }
              } else if (i == 2) {
                for (int j = 0; j < players.length; j++) {
                  int posX;
                  if (players[j]) {
                    if (j == 0 || j == 1) {
                      posX = width/2+500;
                    } else {
                      posX = width/2-500;
                    }
                    image(playersImg[j], posX, playersKeyY[j], 50, 35);
                    strokeText(playersKey[j], posX, playersKeyY[j]+60, mainColor, 0, 50, 3, textFont, CENTER, 255);
                  }
                }
                /*____DRAW ARROWS____*/
                drawArrows(height/2+150);
                
                /*____SELECT PLAYERS BUTTON____*/
                if (!players[1] && !players[2] && !players[3]) {
                  strokeImage(p1SelectedImg, width/2, height/2+150, 8);
                } else if (players[1] && !players[2] && !players[3]) {
                  strokeImage(p2SelectedImg, width/2, height/2+150, 8);
                } else if (players[1] && players[2] && !players[3]) {
                  strokeImage(p3SelectedImg, width/2, height/2+150, 8);
                } else {
                  strokeImage(p4SelectedImg, width/2, height/2+150, 8);
                }
              } else if (i == 3) {
                strokeImage(playSelectedImg, width/2, height/2+300, 8);
              }
            } else {
              if (i == 0) {
                strokeImage(settingsImg, width/2, height/2-150, 8);
              } else if (i == 1) {
                if (difficulty == "easy") {
                  strokeImage(easyImg, width/2, height/2, 8);
                } else if (difficulty == "medium") {
                  strokeImage(mediumImg, width/2, height/2, 8);
                } else {
                  strokeImage(hardImg, width/2, height/2, 8);
                }
              } else if (i == 2) {
                /*____SELECT PLAYERS BUTTON____*/
                if (!players[1] && !players[2] && !players[3]) {
                  strokeImage(p1Img, width/2, height/2+150, 8);
                } else if (players[1] && !players[2] && !players[3]) {
                  strokeImage(p2Img, width/2, height/2+150, 8);
                } else if (players[1] && players[2] && !players[3]) {
                  strokeImage(p3Img, width/2, height/2+150, 8);
                } else {
                  strokeImage(p4Img, width/2, height/2+150, 8);
                }
              } else if (i == 3) {
                strokeImage(playImg, width/2, height/2+300, 8);
              }
            }
          }
        }
      }
    } else {
      /*____IF JUST DIED DRAW LAST FRAME____*/
      if (drawLastFrame) {
        //Reuse of starttime to make the text appear after 500ms
        startTime = millis(); 
        /* ___DRAW BACKGROUND___ */
        drawImage(CORNER, backgroundImg, 0, 0);

        drawLastFrame = false;
        /* ___ALL PIPES___ */
        drawPipes();
                
        /* ___DRAW PLAYERS___ */
        for (int i = 0; i < players.length; i++) {
          if (players[i]) {
            drawPlayer(playersX[i], playersY[i], playersRotationAngle[i], playersImg[i], 155);
          }
        }
      }

      /* ___DRAW GROUND___ */
      drawImage(CENTER, groundImg, groundX, height-groundImg.height/2);
      drawImage(CENTER, groundImg, groundX+groundImg.width, height-groundImg.height/2);

      elapsedTime = millis() - startTime;
      textOpacity = elapsedTime * 255 / 500;
            
      strokeText("Game Over", width/2, height/2-200, mainColor, 0, 120, 4, textFont, CENTER, textOpacity);
            
      /* ___IF ELAPSED TIME IS HIGHER THAN 250 MS___ */
      if (elapsedTime < 300 && 250 < elapsedTime) {
        /* ___DRAW SCOREBOARD___ */
        drawImage(CENTER, scoreImg, width/2, height/2);

        /* ___DRAW SCORES___ */
        for (int i = 0; i < players.length; i++) {
          if (players[i]) {
            strokeText(str(playersScore[i]), playersScoreboardX[i], playersScoreboardY[i], playersColor[i], 0, 50, 3, numbersFont, CENTER, 255);
          }
        }
                
        /* ___PRINT HIGHSCORE IN FUNCTION OF DIFFICULTY___ */      
        if (difficulty == "easy") {
          easyHighscore = printHighscore(easyHighscore);
        } else if (difficulty == "medium") {
          mediumHighscore = printHighscore(mediumHighscore);
        } else {
          hardHighscore = printHighscore(hardHighscore);
        }
      }
      /* ___IF ELAPSED TIME IS HIGHER THAN 500 MS___ */
      if (elapsedTime > 500) {
        /* ___DRAW RESTART AND HOME BUTTONS___ */
        for (int i = 0; i < gameOverButtonsCount; i++) {
          if (i == gameOverSelectedButton) {
            if (i == 0) {
              strokeImage(restartSelectedImg, width/2-120, height/2+300, 8);
            } else {
              strokeImage(menuSelectedImg, width/2+120, height/2+300, 8);
            }
          } else {
            if (i == 0) {
              strokeImage(restartImg, width/2-120, height/2+300, 8);
            } else {
              strokeImage(menuImg, width/2+120, height/2+300, 8);
            }
          }
        }
      }
    }
  }
  // text(frameRate, width/2, height/2);
}


/* ________________________________DRAW AND STROKE FUNCTIONS______________ */
                                
/*________________________________________________________________________ */

/* ___ DRAW IMAGE ___ */
void drawImage(int MODE, PImage image, int x, int y) {
  imageMode(MODE);
  image(image, x, y);
}

/* ___ DRAW ARROWS IMAGES ___ */
void drawArrows(int y) {
  imageMode(CENTER);
  image(leftArrowImg, width/2-150, y);
  image(rightArrowImg, width/2+150, y);
}

/* ___ DRAW PLAYER ___ */
void drawPlayer(int playerX, int playerY, float playerRotationAngle, PImage playerImg, int opacity) {
  tint(255, opacity);
  pushMatrix(); // Save the current transformation matrix
  translate(playerX, playerY);
  rotate(playerRotationAngle);
  image(playerImg, 0, 0);
  popMatrix(); // Restore the previous transformation matrix
  tint(255, 255);
}

/* ___ DRAW ALL PIPES ___ */
void drawPipes() {
  for(int i = 0; i < pipesX.length; i++) {
    imageMode(CENTER);
    image(pipeTopImg, pipesX[i], pipesY[i] - (pipeTopImg.height/2+pipeGap));
    image(pipeBottomImg, pipesX[i], pipesY[i] + (pipeBottomImg.height/2+pipeGap));
  }
}

/*___DRAW IMAGE WITH A STROKE*/
void strokeImage(PImage img, int x, int y, int borderThickness) {
  fill(82, 55, 70);
  rectMode(CENTER);
  rect(x - borderThickness/6 , y - borderThickness/6, img.width + borderThickness, img.height + borderThickness, 15);
  drawImage(CENTER, img, x, y);
}

/*___DRAW TEXT WITH A STROKE*/
void strokeText(String message, int x, int y, color fillColor, color strokeColor, int size, int strokeSize, PFont font, int align, float opacity) {
  textFont(font);
  textAlign(align);
  textSize(size);
  fill(strokeColor, opacity);
  text(message, x-strokeSize, y);
  text(message, x, y-strokeSize);
  text(message, x+strokeSize, y);
  text(message, x+strokeSize*2, y+strokeSize*2);
  text(message, x, y+strokeSize);
  fill(fillColor, opacity);
  text(message, x, y);
}
