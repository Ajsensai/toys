//----------------------
//Anthony Bale 47009470
//COMP1000 26/05/21
//----------------------

//Animation Counters
  int counter = 0;
  int smallbounce = 0;
  int bounce = 0;
  int boxbounce = 0;
  int firstDelaybounce = 0;
  int secondDelaybounce = 0;
  int fadefrom200 = 200;
  int stars[] = new int[20]; // If you wait in the menu screen it turns to night & stars come out from a generated list, similar to the background
  int starX[] = new int[20];
  int starY[] = new int[20];
  int starVarX = 0;
  int starVarY = 0;
  int starbounce = 0;
//Grid Ints
  int cellSize = 50;
  int titleCellSize = 5;
  color cellColor = 0;
  int[] colourList = new int[1000];
  int val = int(random(180,220));
  int goup = 0;
//Controls
  int boxX = 60;
  boolean warmUpCond = false;
  boolean actionFire = false;
  boolean showBar = false;
  int powerLevel = 0;
  boolean shoot = false;
//Physics
  float dir = 1;
  int friction = 1;
  float newVelocity = 0.0;
  float power;
  float coefficient = 0.5;
//Goals & Balls
  int[] storeGoalX = new int[50]; 
  int[] storeGoalY = new int[50];
  int goalFillerX = -100;
  int goalFillerY = -100;
  int[] drawGoalYFix = {31,212,372,511,629,31,212,372,511,629}; // <-- this is probably cheating but i wanted a set range for goals
  int changegoal = 0;
  int ballLandX = -100;
  int ballLandY = -100;
  int constantX = 0;
  int[] storeBallLandX = new int[50];
  int[] storeBallLandY = new int[50];
  int storeBallCounter = 0;
//Trigger
  boolean game = false;

void setup(){
  size(1280,960);
  generateColourList();
  generateGoalList();
  generateStarList();}

void draw(){
if (game == false){
  titleScreen();
  animation();}
if (game == true){
  drawGrid();
  animation();
  playArea();
  drawGoal((storeGoalX[changegoal]), drawGoalYFix[changegoal]);
  drawPlayer(boxX);
  charging();
  actionFire();
  previousBall();
  callEndScreen();
  tutorial();}}

//creates a cell & fills with colours from generateColourList
void drawCell(int row, int col, color c){
  noStroke();
  fill(c);
  rectMode(CORNER);
  rect(col*cellSize, row*cellSize, cellSize, cellSize);}

//This function generates a list of colours
void generateColourList(){
  for(int i=0; i < colourList.length; i++) {
   colourList[i] = val;
   val= int(random(180,220));}}

void generateStarList(){
  for(int i=0; i < stars.length; i++) {
   starX[i] = starVarX;
   starY[i] = starVarY;
   starVarX = int(random(0,width));
   starVarY = int(random(0,800));}}

//This function populates a list of possible goal locations
void generateGoalList(){
  for(int i=0; i < storeGoalX.length; i++) {
   storeGoalX[i] = goalFillerX;
   storeGoalY[i] = goalFillerY;
   goalFillerX = int(random(1,10));
   goalFillerY = int(random(1,6));}}

//This function loops to draw cells infinitely
void drawGrid(){
  for(int i = 0; i <= height/cellSize; i++){
    for(int j = 0; j <= width/cellSize; j++){
      cellColor = color(50, colourList[goup], 50);
      drawCell(i, j, cellColor);
      goup++;
      if (goup >= 260){
        goup = 0;}}}}

//Function for the title screen
void titleScreen(){
dayCycle();
drawNinja();
textSize(22);
fill(255);
text("Anthony Bale 47009470       Press ENTER to Play", 100,900);}

//tutorial
void tutorial(){
if (changegoal == 0){
  textSize(50);
  fill(255);
  text("Use a & d to move side to side", width/2-200, height/2-200);
  text("Press W to begin charge", width/2-200, height/2);
  text("Press T to fire", width/2-200, height/2-100);
  textSize(20);
  text("Fire a practice shot to begin game", boxX-150, 800);}}

//This function draws the goal based on previously populated list
void drawGoal(int x, int y){
  fill(0);
  stroke(255);
  ellipseMode(CENTER);
  ellipse(x*100, y, 100, 100);
  line(x*100, y, x*100, y-100);
  fill(255,0,0);
  rect(x*100, y-75, x*100+50, y-100);}

//This function draws the player model (i only put float y because of the criteria, it's not being used)
void drawPlayer(float X){
  fill(255,253,208); //cream
  noStroke();
  rectMode(CORNERS);
  rect(X,820+bounce,X+80,900+bounce);
  fill(255,0,0);
  rect(X,840+bounce,X+80,850+bounce); //headband
  rect(X-35,830+firstDelaybounce,X,840+firstDelaybounce); //connected
  rect(X-25,850+firstDelaybounce,X,860+firstDelaybounce); //connected
  rect(X-75,820+secondDelaybounce,X-35,830+secondDelaybounce); //air
  rect(X-75,845+secondDelaybounce,X-25,855+secondDelaybounce);}

//This function draws a power bar
void charging(){
  if (warmUpCond == true){
  fill(255,0,0,counter*2);
  rect(boxX,820+bounce,boxX+80,900+bounce); //head glow
  rect(width-60,height,width-80,height-counter*2);
  textSize(44);
  fill(0,0,0);
  text((counter/10),width-55,height-10);}}

void playArea(){
  fill(0,150,0);
  rectMode(CORNERS);
  rect(width-width,height,width,height-height/5);}

//This function sets various counters for animation (Frame 1-31 = 0, 32-63 = 1, 64-95 = 2)
void animation(){
  counter = counter % 96;
  counter++;
  constantX = constantX %width;
  constantX++;
  smallbounce = counter/32; //moves 1 pixel
  bounce = (counter-24)/32; //off-set
  bounce *= 2; //moves 2 pixels
  boxbounce = (counter+8)/16;
  boxbounce *= 2; //moves 2 pixels
  firstDelaybounce = (counter-8)/32; //off-set
  firstDelaybounce *= 5; //moves 5 pixels
  secondDelaybounce = (counter-16)/32; //offset
  secondDelaybounce *= 5; //moves at 5 pixels
  starbounce = (counter-4)/16;
  starbounce *=50;}

//This function determines the animation which occurs when a ball is fired & then resets variables
void actionFire(){
if (actionFire == true){
  drawBall(boxX, 900);
  fill(255);
  textSize(44);
  text((powerLevel),width-55,height-10);
  fill(200,0,0,fadefrom200);
  rect(width-width,height,width,height-height/5);
  fadefrom200--;
  if (fadefrom200 < 1){
    fadefrom200 = 200;
    actionFire = false;
    dir = 1;
    friction = 1;
    changegoal = changegoal+1;
    ballLandX = 0;}}}

//This function fires the ball & determines friction
void drawBall(int x, int y){
  fill(255);
  stroke(0);
  circle(x+40, y+dir, 50);
  ballLandX = (x+40);
  ballLandY = int((y+dir));
  dir -= newVelocity * coefficient;
  if (newVelocity > 0){
    newVelocity--;
    if (newVelocity <1){
      storeBallLandX[storeBallCounter] = ballLandX;
      storeBallLandY[storeBallCounter] = ballLandY;
      storeBallCounter = storeBallCounter+1;
      newVelocity = 0;}}}

//Displaying previous balls
void previousBall(){
for (int i = 0; i < storeBallLandX.length; i++){
  fill(200);
  stroke(0);
  circle(storeBallLandX[i], storeBallLandY[i],50);}}

//Victory Screen
void endScreen(){
  drawNinja();
  text("Nice Shot!", width/2-150, height/2);}

void callEndScreen(){
  if (ballLandX/100 < (storeGoalX[changegoal])+1 && ballLandX/100 > (storeGoalX[changegoal])-1 && newVelocity < 5){
    if (ballLandY < drawGoalYFix[changegoal]+10 && ballLandY > drawGoalYFix[changegoal]-10){
      endScreen();}}}

//Fun drawing for the title screen (I KNOW ITS MESSY, JUST LET ME DRAW MY NINJA)
void drawNinja(){
  rectMode(CORNERS);
  fill(100,200,100);
  stroke(0);
  rect(0,800,width,height);
  fill(255,253,208); //cream
  stroke(0);
  rect(460,700,495,800);
  rect(505,700,540,800);
  fill(165,113,78); //brown
  stroke(0);
  rect(450,675+smallbounce,550,700+smallbounce);
  fill(255);
  stroke(0);
  rect(450,500+bounce,550,675+bounce);
  fill(255,253,208); //cream
  stroke(0);
  rect(415,500+bounce,450,675+bounce);
  rect(550,500+bounce,585,675+bounce);
  fill(255,253,208); //cream
  stroke(0);
  rect(455,400+bounce,545,500+bounce);
  fill(255,0,0);
  stroke(0);
  rect(455,420+bounce,545,440+bounce); //headband
  rect(410,400+firstDelaybounce,455,420+firstDelaybounce); //connected
  rect(420,440+firstDelaybounce,455,460+firstDelaybounce); //connected
  rect(375,380+secondDelaybounce,410,400+secondDelaybounce); //air
  rect(375,430+secondDelaybounce,420,450+secondDelaybounce);}

//At this point im just playing around - This draws a day night cycle and some stars for the title screen
void dayCycle(){
  fill(211,241,255);
  rectMode(CORNERS);
  rect(0,0,width,height);
  fill(0,0,0,-500+constantX);
  rectMode(CORNERS);
  rect(0,0,width,height);
  fill(255,255-constantX/30,0);
  ellipseMode(CORNERS);
  noStroke();
  ellipse(constantX-50,200,constantX+50,300);
  fill(255,255,255,-500+constantX);
  ellipseMode(CORNERS);
  noStroke();
  ellipse(constantX-50,200,constantX+50,300);
  if (constantX > 600){
    for(int i=0; i < stars.length; i++) {
     fill(255,255,255,starbounce+i);
     ellipseMode(CENTER);
     ellipse(starX[i],starY[i],10,10);}}}

//This function is for controls
void keyPressed(){
  if (key == ENTER) game = true;
  if (game == true){
    if (key == 'a' && boxX > -50 && fadefrom200 == 200){ boxX = boxX-100; warmUpCond = false;}
    if (key == 'd' && boxX < width+50 && fadefrom200 == 200){ boxX = boxX+100; warmUpCond = false;}
    if (key == 'w' && fadefrom200 == 200){ warmUpCond =! warmUpCond; showBar =! showBar;}
    if (key == 't' && fadefrom200 == 200 && warmUpCond == true){ actionFire = true; showBar =! showBar;}
    if (key == 't' && fadefrom200 == 200 && warmUpCond == true){ powerLevel = counter/10; newVelocity = powerLevel*6.5;}
    if (key == 't' && fadefrom200 == 200 && warmUpCond == true){ shoot = true; warmUpCond =! warmUpCond;}}}
