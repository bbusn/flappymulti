/* ___LOAD IMAGES___ */
void loadImages() {
    for (int i = 0; i < playersImg.length; i++) {
        playersImg[i] = loadImage("data/images/player_" + (i+1) + ".png");
    }

    groundEasyImg = loadImage("data/images/ground_easy.png");
    groundMediumImg = loadImage("data/images/ground_medium.png");
    groundHardImg = loadImage("data/images/ground_hard.png");

    pipeTopEasyImg = loadImage("data/images/pipe_top_easy.png");
    pipeBottomEasyImg = loadImage("data/images/pipe_bottom_easy.png");
    pipeTopMediumImg = loadImage("data/images/pipe_top_medium.png");
    pipeBottomMediumImg = loadImage("data/images/pipe_bottom_medium.png");
    pipeTopHardImg = loadImage("data/images/pipe_top_hard.png");
    pipeBottomHardImg = loadImage("data/images/pipe_bottom_hard.png");

    backgroundEasyImg = loadImage("data/images/background_easy.png");
    backgroundMediumImg = loadImage("data/images/background_medium.png");
    backgroundHardImg = loadImage("data/images/background_hard.png");

    scoreImg = loadImage("data/images/score.png");
    restartImg = loadImage("data/images/restart.png");
    restartSelectedImg = loadImage("data/images/restart_selected.png");
    menuImg = loadImage("data/images/menu.png");
    menuSelectedImg = loadImage("data/images/menu_selected.png");
    soundOnImg = loadImage("data/images/sound_on.png");
    soundOffImg = loadImage("data/images/sound_off.png");
    soundOnSelectedImg = loadImage("data/images/sound_on_selected.png");
    soundOffSelectedImg = loadImage("data/images/sound_off_selected.png");
    playImg = loadImage("data/images/play.png");
    playSelectedImg = loadImage("data/images/play_selected.png");
    easyImg = loadImage("data/images/easy.png");
    easySelectedImg = loadImage("data/images/easy_selected.png");
    mediumImg = loadImage("data/images/medium.png");
    mediumSelectedImg = loadImage("data/images/medium_selected.png");
    hardImg = loadImage("data/images/hard.png");
    hardSelectedImg = loadImage("data/images/hard_selected.png");
    leftArrowImg = loadImage("data/images/left_arrow.png");
    rightArrowImg = loadImage("data/images/right_arrow.png");
    musicOnImg = loadImage("data/images/music_on.png");
    musicOffImg = loadImage("data/images/music_off.png");
    musicOnSelectedImg = loadImage("data/images/music_on_selected.png");
    musicOffSelectedImg = loadImage("data/images/music_off_selected.png");
    settingsImg = loadImage("data/images/settings.png");
    settingsSelectedImg = loadImage("data/images/settings_selected.png");
    confirmImg = loadImage("data/images/confirm.png");
    confirmSelectedImg = loadImage("data/images/confirm_selected.png");

    p1Img = loadImage("data/images/1_player.png");
    p2Img = loadImage("data/images/2_players.png");
    p3Img = loadImage("data/images/3_players.png");
    p4Img = loadImage("data/images/4_players.png");
    p1SelectedImg = loadImage("data/images/1_player_selected.png");
    p2SelectedImg = loadImage("data/images/2_players_selected.png");
    p3SelectedImg = loadImage("data/images/3_players_selected.png");
    p4SelectedImg = loadImage("data/images/4_players_selected.png");

    easyScreenImg = loadImage("data/images/easy_screen.png");
    mediumScreenImg = loadImage("data/images/medium_screen.png");
    hardScreenImg = loadImage("data/images/hard_screen.png");
}

/* ___LOAD SOUNDS___ */
void loadSounds() {
    themeSound = new SoundFile(this, "data/sounds/theme.wav");
    flapSound = new SoundFile(this, "data/sounds/flap.wav");
    hitSound = new SoundFile(this, "data/sounds/hit.wav");
    scoreSound = new SoundFile(this, "data/sounds/score.wav");
    wooshSound = new SoundFile(this, "data/sounds/woosh.wav");
}
