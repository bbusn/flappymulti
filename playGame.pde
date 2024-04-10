
/* ___PLAY GAME___ */
void playGame() {
 for (int i = 0; i < players.length; i++) {
    if (players[i]) {
      playersDead[i] = false;
      playersIsDying[i] = false;
      playersYVelocity[i] = 0;
      playersScore[i] = 0;
      playersDeadX[i] = 0;
    } else {
      playersDead[i] = true;
      playersIsDying[i] = true;
    }
  }
  if (!players[1] && !players[2] && !players[3]) {
    playersX[0] = width / 2;
    playersY[0] = height/3;
  } else if (players[1] && !players[2] && !players[3]) {
    playersX[0] = width / 2 + 50;
    playersX[1] = width / 2 - 50;
    playersY[0] = playersY[1] = height/3;
  } else if (players[1] && players[2] && !players[3]) {
    playersX[0] = width / 2 + 100;
    playersX[1] = width / 2;
    playersX[2] = width / 2 - 100;
    playersY[0] = height/3;
    playersY[1] = height/3 - 40;
    playersY[2] = height/3;
  } else {
    playersX[0] = width / 2 + 150;
    playersX[1] = width / 2 + 50;
    playersX[2] = width / 2 - 50;
    playersX[3] = width / 2 - 150;

    playersY[0] = height/3 + 40;
    playersY[1] = height/3;
    playersY[2] = height/3 + 40;
    playersY[3] = height/3;
  }

  showText = true;
  nextPipeIsHigh = random(1) > 0.5;

  resetPipes();
  
  groundX = -200;
  menu = 0;
  game = 1;
  startTime = millis();
}
