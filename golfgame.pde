//--------------------------------------------------------------------------------
//-------------------------GOLF GAME----------------------------------------------
//------------------------AnthonyBale---------------------------------------------
//--------------------------------------------------------------------------------
//Criteria
//game must be 1280 x 960
//launch zone & field, must be full length of field
//representation of player will move back and forth
//user presses key, player stops moving and goes into launch mode
//launch mode determines power - growing after 4 seconds
//when user hits a key in launch mode, ball is launched with chosen pwr
//you must be able to see how power is increasing
//zero str must make the ball not move
//max strength the ball must go past the window
//the ball must have friction (> ball speed = previous ball speed * friction coefficient
//the ball must keep moving until it stops
//if the ball is entirely within the hole - game is won, otherwise the game resets
//the playing field should be a patchwork of random colours
//your ball drawing and player drawing code must be in functions with exactly these signatures: void drawball, void drawplayer
//vary the game so that missing hole does not end game, instead ball stays in place (up to 10 balls) and only the player resets
//the player makes another shot but their ball may collide. balls should deflect in a realistic way with half the speed of the moving ball being transferred
//--------------------------------------------------------------------------------
//--------------------------START-------------------------------------------------
//--------------------------------------------------------------------------------

//Ints
int counter = 0;
int smallbounce = 0;
int bounce = 0;
int boxbounce = 0;
int firstDelaybounce = 0;
int secondDelaybounce = 0;
int constantX = 0;
int starbounce = 0;
int daycount = 0;
int boxmovex = 530;
int togtext = 0;
boolean spawnclub = false;
boolean actionfire = false;
int fadefrom200 = 200;
boolean displaytext = false;
int toghun = 0;
int spawnx = boxmovex;
int spawny = 750;
int ballcount = 0;
//setup
void setup()
{
  size(1280,960);
}

//draw
void draw()
{

//Animation setup
  counter = counter % 96;
  counter++;
  constantX = constantX %1000;
  constantX++;
  daycount += (constantX/1000);

//Frame 1-31 = 0, 32-63 = 1, 64-95 = 2
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
  starbounce *=50;

//Background
  background(150,242,100); //Field Grass

//Top of screen box
  fill(200,200,200,100);
  rectMode(CORNERS);
  noStroke();
  rect(width/width-1,height/height-1,width,height/height+50);

//Info Text
  textSize(17);
  fill(0,0,0);
  text(("GolfGameDraft"),width/width+20,30);
  fill(0,0,0,toghun*2);
  text(("Bounce: ")+bounce,width/width+250,30);
  text(("Starbounce: ")+starbounce,width/width+350,30);
  text(("FrameLoop: ")+counter,width/width+500,30);
  text(("Boxmovex: ")+boxmovex,width/width+650,30);  
  text(("ConstantX: ")+constantX,width/width+800,30);
  text(("Counter: ")+counter,width/width+950,30);
  text(("Toghun: ")+toghun,width/width+1070,30);
  text(("Day: ")+daycount,width/width+1200,30);
  text(("Fade: ")+fadefrom200,width/width+1070,60);
  text(("BC: ")+ballcount,width/width+1070,90);
  text(("Sy: ")+spawny,width/width+1070,120);



  if (displaytext == true)
  {
    toghun++;
    if (toghun >= 100) toghun = 100;
  }
  if (displaytext == false)
  {
    toghun --;
    if (toghun <= 0) toghun = 0;
  }
  
//box reset feature
if (boxmovex > 1360) boxmovex = -100;
if (boxmovex < -100) boxmovex = 1360;


//Generate grass (come back to this later)
  //fill(0,0,0);
  //rectMode(CORNERS);
  //noStroke();
  //rect(width/2+20,height/2-20,width/2-20,height/2+20);

//Play area
  fill(100,200,100);
  rectMode(CORNERS);
  noStroke();
  rect(width/width-1,height/1.3,width,height);

//Moving Object
  fill(255,253,208); //cream
  noStroke();
  rect(boxmovex,820+bounce,boxmovex+80,900+bounce);
  
//Action spawnclub
if (spawnclub == true)
  {
  fill(255,0,0,counter*2);
  rect(boxmovex,820+bounce,boxmovex+80,900+bounce);
  //stroke(0,0,0,counter);
  rect(boxmovex+39,height/1.25-counter/2,boxmovex+41,height/1.2);
  }
//Bandana
  fill(255,0,0);
  rect(boxmovex,840+bounce,boxmovex+80,850+bounce); //headband
  rect(boxmovex-35,830+firstDelaybounce,boxmovex,840+firstDelaybounce); //connected
  rect(boxmovex-25,850+firstDelaybounce,boxmovex,860+firstDelaybounce); //connected
  rect(boxmovex-75,820+secondDelaybounce,boxmovex-35,830+secondDelaybounce); //air
  rect(boxmovex-75,845+secondDelaybounce,boxmovex-25,855+secondDelaybounce); //air

//Action fire flash
if (actionfire == true)
  {
  fill(200,0,0,fadefrom200);
  rect(width/width-1,height/1.3,width,height);
  fadefrom200--;
  if (fadefrom200 < 1)
    {
    actionfire = false;
    fadefrom200 = 200;
    }
  }

//ball counter
if (fadefrom200 == 199)
  {
  ballcount += 1;
  }

//Firing mechanism (broken)
//if (spawnclub == true && ballcount == 1)
//  {
//  fill(0,0,0,255);
//  circle(boxmovex+40,spawny,20);
//  spawny-=(spawny/100);
//  }
//if (ballcount == 2 && spawnclub == true)
//  {
//  fill(0,0,0,255);
//  circle(boxmovex+40,spawny,20);
//  spawny-=(spawny/100);
//  }

  
//last thingymabob
}

void keyPressed()
  {
  if (key == 'a' && boxmovex > -150) boxmovex = boxmovex-10; spawnclub = false;
  if (key == 'd' && boxmovex < width+150) boxmovex = boxmovex+10; spawnclub = false;
  if (key == 'w') spawnclub = true;
  if (key == 32) actionfire = true;
  if (key == 't') displaytext =! displaytext;
  }
