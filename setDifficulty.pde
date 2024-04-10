/* ___SET DIFFICULTY TO___ */
void setDifficulty(String difficultyName) {
  difficulty = difficultyName;

  if (difficulty == "hard") {

    pipesNumber = 8;
    pipeGap = 145;
    backgroundImg = backgroundHardImg;
    groundImg = groundHardImg;
    pipeTopImg = pipeTopHardImg;
    pipeBottomImg = pipeBottomHardImg;
    
  } else if (difficulty == "medium") {
  
    pipesNumber = 6;
    pipeGap = 135;
    backgroundImg = backgroundMediumImg;
    groundImg = groundMediumImg;
    pipeTopImg = pipeTopMediumImg;
    pipeBottomImg = pipeBottomMediumImg;

  } else {
    
    pipesNumber = 4;
    pipeGap = 160;
    backgroundImg = backgroundEasyImg;
    groundImg = groundEasyImg;
    pipeTopImg = pipeTopEasyImg;
    pipeBottomImg = pipeBottomEasyImg;

  }

  playersPipesScored = new boolean[4][pipesNumber];
  pipesX = new int[pipesNumber];
  pipesY = new int[pipesNumber];

}
