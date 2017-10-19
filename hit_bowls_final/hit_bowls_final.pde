import static javax.swing.JOptionPane.*;
// define variables for the game 
float x1 = 300;  // x location for bowl_1
float x2 = 300;  // x location for bowl_2
float x3 = 300;  // x location for bowl_3
float xb = 200;  // x location for bean 
float yb = 520;  // y location for bean
float x_s = 200; // x location for spoon
float dx_s = 2; // increments for spoon in x-dir 
float y_s = 520; // y location for spoon 
float dyb = 10;  // increments for bean in y-dir
float dx1 = 5; // increments for bowl_1 in x-dir 
float dx2 = 4; // increments for bowl_2 in x-dir 
float dx3 = 3; // increments for bowl_3 in x-dir 
int score_1 = 0; // score for bowl_1 
int score_2 = 0; // score for bowl_2
int score_3 = 0; // score for bowl_3
int score = 0; // total score for the game 
int count_1 = 0; // number of hits for bowl_1
int count_2 = 0; // number of hits for bowl_2
int count_3 = 0; // number of hits for bowl_3
float x_p = 565; // location of pressed button in x-dir 
float y_p = 575; // location of pressed button in y-dir
float dy_p = 3; // increments of button after it pressed
boolean clicked =false; // set clicked to be false

PFont myFont;

void setup(){
  showMessageDialog(null,
  // popup game instruction window 
                    "This game is to use the red bean in the spoon to hit "
                    +"bowls for points.\nThe more bowl it hits, the more points"
                    +" you would gain. \n"
                    +"The bottom of game will show number of hits for"
                    +" each bowl and the toal score. \nTo throw the red bean,"
                    +" move your mouse in green 'Go' region", 
                    "Game Instruction",
                    INFORMATION_MESSAGE);
  showMessageDialog(null, "Start Game Now?"); // popup a window ask to start the game
  background(161,217,232); // light blue background
  size(600,600); // the visual size of game 
  myFont = createFont("Aharoni-Bold-48.vlw", 20); // font type and size
  textFont(myFont);
  smooth(); 
  reset(); // used if the player wants to play the game again
}

void reset(){ // reset the set of variables after play_again is clicked
  x1 = 300;
  x2 = 300;
  x3 = 300; 
  xb = 200;
  yb = 520;
  x_s = 200;
  dx_s = 2;
  y_s = 520;
  dyb = 7;
  dx1 = 5;
  dx2 = 4;
  dx3 = 3;
  score_1 = 0;
  score_2 = 0;
  score_3 = 0;
  count_1 = 0;
  count_2 = 0;
  count_3 = 0;
  x_p = 565;
  y_p = 575;
  dy_p = 3;
  clicked =false;
}

void bowl1(){ // draw bowl_1
  noFill();
  strokeWeight(6); 
  ellipse(x1, 40, 80, 40); 
  arc(x1, 40, 80, 92, 0, PI);  // upper half of circle
  fill(0);
  text("100pts ", x1 - 26, 45); // put text "100 pts" inside the bowl
}

void bowl2(){ // draw bowl_2
  noFill();
  strokeWeight(6);
  ellipse(x2, 140, 80, 40);
  arc(x2, 140, 80, 92, 0, PI);  // upper half of circle
  fill(0);
  text("50pts ", x2 - 20, 142); // put text "50 points" inside the bowl
}

void bowl3(){ // draw bowl_3
  noFill();
  strokeWeight(6);
  ellipse(x3, 240, 80, 40);
  arc(x3, 240, 80, 92, 0, PI);  // upper half of circle
  fill(0);
  text("20pts ", x3 - 20, 242); // put text "20 points" inside the bowl
}

void spoon(){ // draw the spoon 
  noFill();
  strokeWeight(3);
  ellipse(x_s, y_s, 40, 20);
  arc(x_s, y_s, 40, 35, 0, PI); // upper a small half of circle
  rect(x_s + 19, y_s - 5, 90, 10); // draw spoon holder
  strokeWeight(2);
  ellipse(x_s + 100, y_s, 7, 4); 
}

void bean(){ // draw the red bean 
  strokeWeight(1);
  fill(111, 0, 17);
  ellipse(xb, yb, 30, 20);
  fill (255);
  ellipse(xb + 5, yb - 5, 7, 2);
  
}

void startButton(){ // create a button to throw the red bean
  fill(50, 154, 20);
  strokeWeight(2);
  ellipse(x_p, y_p, 50, 40);
  fill(255);
  text("Go", x_p - 15, y_p + 8); // print 'Go' inside the button
}

void click(){
  if (dist(mouseX, mouseY, 565, 570) < 15) { 
    // test if the mouse is within the button region 
    y_p += dy_p;
    // button move down a little bit when mouse is in the button region
    if (y_p < 590 || y_p > 500) { dy_p = -dy_p; }
    clicked =true; // change clicked to be true 
  }
}

void draw(){ // called animation 
  background(161,217,232); //light blue background
  frameRate(80); // called 80/sec
  startButton(); // called to draw button 
  bean(); // called to draw red bean
  spoon(); // called to draw the spoon
  bowl1(); // called to draw bowl_1
  bowl2(); // called to draw bowl_2
  bowl3(); //called to draw bowl_3
  x1 += dx1; // move bowl_1 in x-dir
  x2 += dx2;  // move bowl_2 in x-dir
  x3 += dx3; // move bowl_3 in x-dir
  x_s += dx_s; // move spoon in x-dir
  xb += dx_s; // move the red bean with the spoon
  click(); // called to click method 
  if (clicked == true){
    // check whether clicked is true
    yb -= dyb;
    // throw the red bean in up direction
    if (yb < -20 || yb > 550){  // chekc if red bean in within the boundary
     dyb = 0; // stop the red bean when it's out of boundary 
     score = score_1 + score_2 +score_3; // calculate total score
     int response = showConfirmDialog(null, "Your total score is: " + score 
     // popup a window with your game results and ask you if you want to play again
                                      + "\n Would you like to start again?",
                                      "Game results",
                                      YES_NO_OPTION);
      if ( response == NO_OPTION) { // if no is clicked
        System.exit(0); // end the game 
      }
       else if ( response == YES_OPTION) { // if yes is clicked
        reset(); // restart the game 
      }
     }
  }
  if (x1 > width - 40 || x1 < 20){ // check if bowl_1 hits the boundary
    dx1=-dx1; // change bowl_1 direction when meets boundary 
  }
  if (x2 > width - 40 || x2 < 40){ // check if bowl_2 hits the boundary
    dx2=-dx2; // change bowl_2 direction when meets boundary
  }
  if (x3 > width - 40 || x3 < 40){ // check if bowl3_ hits the boundary
    dx3=-dx3; // change bowl_3 direction when meets boundary
  }
  if (x_s > width - 120 || x_s < 10){ // check if spoon hits the boundary
    dx_s=-dx_s; // change spoon direction when meets boundary
  }
  if (dist(xb, yb, x1, 40+3) < 35) { // check if bean is in bowl_1
    score_1 = 100;  
    count_1 = 1;
  }
  if (dist(xb, yb, x2, 140+3) < 35) { // check if bean is in bowl_2
    score_2 = 50;
    count_2 = 1;
  }
  if (dist(xb, yb, x3, 240+3) < 35) { // check if bean is in bowl_3
    score_3 = 20;
    count_3 = 1;
  }
  fill(5, 44, 116); 
  text("Bowl_100: "+ count_1, 5, 590); // display number of hits for bowl_1
  text("Bowl_50: "+ count_2, 130, 590); // display number of hits for bowl_2
  text("Bowl_20: "+ count_3, 245, 590); // display number of hits for bowl_3
  fill(255, 28, 62); // dark blue 
  text("Total score:", 365, 590); 
  text(score_1 + score_2 +score_3, 475, 590); // display total score gained
}