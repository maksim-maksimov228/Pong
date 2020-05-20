//ball
final int BALL_SIZE = 30;
final int HALF_BALL_SIZE = BALL_SIZE / 2;

int ballX;
int ballY;
int ballDx = 5;
int ballDy = 5;

//paddle
final int PADDLE_WIDTH = 30;
final int PADDLE_HEIGHT = 120;
final int PADDLE_HALF_WIDTH = PADDLE_WIDTH / 2;
final int PADDLE_HALF_HEIGHT = PADDLE_HEIGHT / 2;

int leftPaddleX;
int leftPaddleY;
int leftPaddleDY = 5;

int rightPaddleX;
int rightPaddleY;
int rightPaddleDY = 5;

//score
final int SCORE_SIZE = 100;
final int MARGIN_TOP = 100;
final int MARGIN_SIDE = 200;

int score1 = 0;
int score2 = 0;

void setup() {
  fullScreen();
  background(0);
  noStroke();
  rectMode(CENTER);
  
  ballX = width / 2;
  ballY = height / 2;
  
  leftPaddleX = PADDLE_HALF_WIDTH;
  rightPaddleX = width - PADDLE_HALF_WIDTH;
  leftPaddleY = rightPaddleY = height / 2;
  loadSounds();
}

void draw() { 
  background(0);
  fill(255);
  rect(ballX, ballY, BALL_SIZE, BALL_SIZE);

  ballX += ballDx;
  ballY += ballDy;
  
  if (ballX - HALF_BALL_SIZE >= width) {
    score1++;
    ballX = width / 2;
    ballY = height / 2;
    ballDx *= -1;
  }
  if (ballX + HALF_BALL_SIZE < 0) {
    score2++;
    ballX = width / 2;
    ballY = height / 2;
    ballDx *= -1;
  }
  if (ballY + HALF_BALL_SIZE >= height || ballY - HALF_BALL_SIZE < 0) {
    ballDy *= -1;
  }
  
  rect(leftPaddleX, leftPaddleY, PADDLE_WIDTH, PADDLE_HEIGHT);
  rect(rightPaddleX, rightPaddleY, PADDLE_WIDTH, PADDLE_HEIGHT);
  
  if (keyPressed) {
    if(keyCode == UP) {
      leftPaddleY -= leftPaddleDY;
      rightPaddleY -= rightPaddleDY;
      if (leftPaddleY - PADDLE_HALF_HEIGHT < 0) {
        leftPaddleY = PADDLE_HALF_HEIGHT;
      }
      if (rightPaddleY - PADDLE_HALF_HEIGHT < 0) {
        rightPaddleY = PADDLE_HALF_HEIGHT;
    }
  } else if (keyCode == DOWN) {
      leftPaddleY += leftPaddleDY;
      rightPaddleY += rightPaddleDY;
      if (leftPaddleY + PADDLE_HALF_HEIGHT > height) {
        leftPaddleY = height - PADDLE_HALF_HEIGHT;
      }
      if (rightPaddleY + PADDLE_HALF_HEIGHT > height) {
        rightPaddleY = height - PADDLE_HALF_HEIGHT;
      }
    }
  }
      
  if (abs(ballX - leftPaddleX) < HALF_BALL_SIZE + PADDLE_HALF_WIDTH && 
      abs(ballY - leftPaddleY) < HALF_BALL_SIZE + PADDLE_HALF_HEIGHT ||
      abs(ballX - rightPaddleX) < HALF_BALL_SIZE + PADDLE_HALF_WIDTH && 
      abs(ballY - rightPaddleY) < HALF_BALL_SIZE + PADDLE_HALF_HEIGHT) {
    ballDx *= -1;
    HitSound.play();
    HitSound.rewind();
  }
  
  textSize(SCORE_SIZE);
  textAlign(CENTER, CENTER);
  text(score1, MARGIN_SIDE, MARGIN_TOP);
  text(score2, width - MARGIN_SIDE, MARGIN_TOP);
}
