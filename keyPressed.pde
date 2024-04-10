/* ___ANY KEY PRESSED___ */
void keyPressed() {
  if (keyCode == ESC) {
    exitGame();
  }
  if(game == 1) {
    if (elapsedTime > getReadyTime) {
      /* ___PLAYER 1 JUMP___ */
      if (key == 'e' || key == 'o') {
        if (!playersIsDying[0]) {
          playersYVelocity[0] = -jumpSpeed;
          if (sound) {
            if (!playingFlapSound) {
              flapSound.play();
              flapSoundTimeout = millis();
              playingFlapSound = true;
            }
          }
        }
      }
      /* ___PLAYER 2 JUMP___ */
      if (key == 'c' || key == 'm') {
        if (!playersIsDying[1]) {
          playersYVelocity[1] = -jumpSpeed;
          if (sound) {
            if (!playingFlapSound) {
              flapSound.play();
              flapSoundTimeout = millis();
              playingFlapSound = true;
            }
          }
        }
      }
      /* ___PLAYER 3 JUMP___ */
      if (key == 'a' || key == 'i') {
        if (!playersIsDying[2]) {
          playersYVelocity[2] = -jumpSpeed;
          if (sound) {
            if (!playingFlapSound) {
              flapSound.play();
              flapSoundTimeout = millis();
              playingFlapSound = true;
            }
          }
        }
      }
      /* ___PLAYER 4 JUMP___ */
      if (key == 'x' || key == 'l') {
        if (!playersIsDying[3]) {
          playersYVelocity[3] = -jumpSpeed;
          if (sound) {
            if (!playingFlapSound) {
              flapSound.play();
              flapSoundTimeout = millis();
              playingFlapSound = true;
            }
          }
        }
      }
    }
  } else {
    if (sound) {
      if (!playingWooshSound) {
        wooshSound.play();
        wooshSoundTimeout = millis();
        playingWooshSound = true;
      }
    }
    if (menu == 1) {
      if (title == 1) {
        title = 0;
      } else {
        if (settings == 1) {
          if (keyCode == UP || key == 'z') {
            settingsSelectedButton = (settingsSelectedButton - 1 + settingsButtonsCount) % settingsButtonsCount;
          } else if (keyCode == DOWN || key == 's') {
            settingsSelectedButton = (settingsSelectedButton + 1) % settingsButtonsCount; 
          } else {
            if (settingsSelectedButton == 0) {
              if (keyCode == RIGHT || key == 'd' || keyCode == LEFT || key == 'q') {
                if (music) {
                  music = false;
                  playingTheme = false;
                  themeSound.stop();
                } else {
                  music = true;
                  themeSound.loop();
                  playingTheme = true;
                }
              }
            } else if (settingsSelectedButton == 1) {
              if (keyCode == RIGHT || key == 'd' || keyCode == LEFT || key == 'q') {
                if (sound) {
                  sound = false;
                } else {
                  sound = true;
                }
              }
            } else {
              if (key == 'a' || key == 'i' || key == 'x' || key == 'l' || key == 'e' || key == 'o' || key == 'c' || key == 'm') {
                settings = 0;
              }
            }
          }
        } else {
          if (keyCode == UP || key == 'z') {
            menuSelectedButton = (menuSelectedButton - 1 + menuButtonsCount) % menuButtonsCount;
          } else if (keyCode == DOWN || key == 's') {
            menuSelectedButton = (menuSelectedButton + 1) % menuButtonsCount; 
          } else {
            if (menuSelectedButton == 0) {
              if (key == 'a' || key == 'i' || key == 'x' || key == 'l' || key == 'e' || key == 'o' || key == 'c' || key == 'm') {
                settings = 1;
              }
            } else if (menuSelectedButton == 1) {
              if (keyCode == RIGHT || key == 'd') {
                if (difficulty == "easy") {
                  setDifficulty("medium");
                } else if (difficulty == "medium") {
                  setDifficulty("hard");
                } else {
                  setDifficulty("easy");
                }
              } else if (keyCode == LEFT || key == 'q') {
                if (difficulty == "easy") {
                  setDifficulty("hard");
                } else if (difficulty == "medium") {
                  setDifficulty("easy");
                } else {
                  setDifficulty("medium");
                }
              }
            } else if (menuSelectedButton == 2) {
              if (keyCode == RIGHT || key == 'd') {
                if (!players[1] && !players[2] && !players[3]) {
                  players[1] = true;
                  players[2] = false;
                  players[3] = false;
                } else if (players[1] && !players[2] && !players[3]) {
                  players[1] = true;
                  players[2] = true;
                  players[3] = false;
                } else if (players[1] && players[2] && !players[3]) {
                  players[1] = true;
                  players[2] = true;
                  players[3] = true;
                } else {
                  players[1] = false;
                  players[2] = false;
                  players[3] = false;
                }
              } else if (keyCode == LEFT || key == 'q') {
                if (!players[1] && !players[2] && !players[3]) {
                  players[1] = true;
                  players[2] = true;
                  players[3] = true;
                } else if (players[1] && !players[2] && !players[3]) {
                  players[1] = false;
                  players[2] = false;
                  players[3] = false;
                } else if (players[1] && players[2] && !players[3]) {
                  players[1] = true;
                  players[2] = false;
                  players[3] = false;
                } else {
                  players[1] = true;
                  players[2] = true;
                  players[3] = false;
                }
              }
            } else if (menuSelectedButton == 3) {
              if (key == 'a' || key == 'i' || key == 'x' || key == 'l' || key == 'e' || key == 'o' || key == 'c' || key == 'm') {
                menu = 0;
                playGame();
              }
            }
          }
        }
      }
    } else {
      if (keyCode == RIGHT || key == 'd') {
        gameOverSelectedButton = (gameOverSelectedButton - 1 + gameOverButtonsCount) % gameOverButtonsCount;
      } else if (keyCode == LEFT || key == 'q') {
        gameOverSelectedButton = (gameOverSelectedButton + 1) % gameOverButtonsCount; 
      } else if (key == 'a' || key == 'i' || key == 'x' || key == 'l' || key == 'e' || key == 'o' || key == 'c' || key == 'm') {
        if (gameOverSelectedButton == 0) {
          playGame();
        } else {
          menu = 1;
        }
      }
    }
  
  }
}
