
float x, y, w, h, xSpeed, ySpeed;
float r=10;
boolean start=false;
//paddle LX/LY= left paddle
//paddle RX/LY = right paddle
int paddleLX, paddleLY, paddleW, paddleH, paddleSpeed, paddleRX, paddleRY; 
int index=20;
float[] xPos= new float[index];
float[] yPos= new float[index];
float dimension;
float fade; 
boolean up1=false, down1=false, up2=false, down2=false;
int live1;
int live2;
int lost=-1;

//Continue Game
boolean continueG= false;
//choosing a random velocity to begin game 
float xRand;
void setup() {
  size(800, 600);
  background(0);
  x=width/2;
  y=height/2;
  w=20;
  h= 20; 
  //RANDOMLY CHOOSES VELOCITY AT BEGINING OF GAME
  xRand= random(1, 10);
  if (xRand<5) {
    xSpeed=4;
  }
  if (xRand>5) {
    xSpeed=-4;
  }

  ySpeed=random(-10, -3);
  rectMode(CENTER);
  paddleW=20;
  paddleH=100;
  paddleLY=height/2;
  paddleLX=0;
  paddleRX=width;
  paddleRY=height/2;
  paddleSpeed=7;
  rect (paddleLX, paddleLY, paddleW, paddleH);
  rect (paddleRX, paddleRY, paddleW, paddleH);
  ellipse(x, y, w, h);
  live1=1;
  live2=1;
  textSize(15);
  text("Player One Lives: "+live1, 10, 20); 
  text("Player Two Lives: "+live2, 620, 595);
  stroke(255);
  line(0, 25, width, 25);

  line(0, 575, width, 575);
}
void draw() {
  if (start) {
    drawCircle();
    bounceCircle();
    leftPaddle();
    moveLeftPaddle();
    restrictPaddle1(); 

    rightBounce();
    leftBounce();
    rightPaddle();
    moveRightPaddle();
    restrictPaddle2();
    leaveScreen();
    stroke(255);
    line(0, 25, width, 25);
    line(0, 575, width, 575);

    gameOver();
    if (live1 != lost && live2 != lost) {
      text("Player One Lives: "+live1, 10, 20); 
      text("Player Two Lives: "+live2, 650, 590);
    }
    ballTrail();
  }
}
//draw circle
void drawCircle() {
  background(0);
  fill(255);
  noStroke();
  ellipse(x, y, w, h);
}
//BALL TRAIL
void ballTrail() {
  dimension= 20;
  fade=255; 
  for ( int i=index-1; i>0; i--) {
    xPos[i]=xPos[i-1];
    yPos[i]=yPos[i-1];
  }
  xPos[0]=x;
  yPos[0]=y;
  for (int i=0; i<index; i++) {
    fill(255, fade);
    ellipse( xPos[i], yPos[i], dimension, dimension);
    dimension=dimension-1; 
    fade= fade-10;
  }
}

//bouncing circle
void bounceCircle() {
  x=x+xSpeed;
  y=y+ySpeed;
  if (y+r>=height-25||y-r<25) {
    ySpeed=ySpeed*-1;
  }
}
//drawing player one paddle
void leftPaddle() {
  fill(255);
  rect (paddleLX, paddleLY, paddleW, paddleH);
}
//move player one paddle
void moveLeftPaddle() {
  if (down1) {
    paddleLY=paddleLY+paddleSpeed;
  }
  if (up1) {
    paddleLY=paddleLY-paddleSpeed ;
  }
}
//keeping player 1 paddle in screen (left side)
void restrictPaddle1() {
  if (paddleLY-paddleH/2<25) {
    paddleLY=paddleLY+paddleSpeed;
  }
  if (paddleLY+paddleH/2>height-25) {
    paddleLY=paddleLY-paddleSpeed;
  }
}


//draw player2 paddle 
void rightPaddle() {
  fill(255);
  rect(paddleRX, paddleRY, paddleW, paddleH);
}
//move player 2 
void moveRightPaddle() {
  if (down2) {
    paddleRY=paddleRY+paddleSpeed;
  }
  if (up2) {
    paddleRY=paddleRY-paddleSpeed;
  }
}
//restrict right paddle off the screen
void restrictPaddle2() {
  if (paddleRY-paddleH/2<25) {
    paddleRY=paddleRY+paddleSpeed;
  }
  if (paddleRY+paddleH/2>height-25) {
    paddleRY=paddleRY-paddleSpeed;
  }
}

//bounce ball off paddles
void rightBounce() {
  if (x+r>paddleRX- paddleW/2 && y-r<paddleRY+ paddleH/2 && y+r>paddleRY-paddleH/2) {
    if (x<paddleRX) {   
      xSpeed=xSpeed*-1;
    }
  }
}
//bounce off left paddle
void leftBounce() {
  if (x-r<paddleLX+ paddleW/2 && y-r<paddleLY+ paddleH/2 && y+r>paddleLY-paddleH/2) {
    if (x>paddleLX) {
      xSpeed=xSpeed*-1;
    }
  }
}
//checking to see which side the ball leaves the screen (left or right)
void leaveScreen() {
  //resets ball to P2 paddle
  if ( x<0) {
    if (continueG) {
      //P1 LOOSES LIFE
      live1=live1-1;
      x=paddleLX+20;
      y=paddleLY;
      continueG=false;
    }
  }
  //resets ball to P1 paddle
  if (x>width) {
    if (continueG) {
      //P2 LOOSES LIFE
      live2=live2-1;
      x=paddleRX-20;
      y=paddleRY;
      continueG=false;
    }
  }
}
//game over page
void gameOver() {

  //p1 looses
  if ( live1==lost) {
    xSpeed=0;
    ySpeed=0;
    x=-10;
    y=-10;
    background(0);
    fill(255);
    textSize(100);
    text("GAME OVER", 150, 200);
    textSize(50);
    text("PLAYER TWO WINS!!", 155, 300);
  }
  //p2 looses
  if ( live2==lost) {
    xSpeed=0;
    ySpeed=0;
    x=-10;
    y=-10;
    background(0);
    fill(255);
    textSize(100);
    text("GAME OVER", 150, 200);
    textSize(50);
    text("PLAYER ONE WINS!!", 155, 300);
  }
}

void keyPressed() {
  if (key=='t'||key=='T') {
    start=true;
  }
  // reset game at N or n
  if (key=='n'||key=='N') {

    setup();
    start=false;
  }
  //PLAYER ONE
  //P1 UP
  if (key =='w'|| key=='W') {
    up1=true;
  }//P1 DOWN
  if ( key=='s'|| key=='S') {
    down1=true;
  }
  //P2 UP
  if ( key=='i'|| key=='I') {
    up2=true;
  }
  //P2 DOWN
  if ( key=='k'|| key=='K') {
    down2=true;
  }
  if ( key=='c'||key=='C') {
    continueG=true;
  }
}
void keyReleased() {
  //P1 UP
  if (key =='w'|| key=='W') {
    up1=false;
  }
  //P1 DOWN
  if ( key=='s'|| key=='S') {
    down1=false;
  }
  //P2 UP
  if ( key=='i'|| key=='I') {
    up2=false;
  }
  //P2 DOWN
  if ( key=='k'|| key=='K') {
    down2=false;
  }
}
