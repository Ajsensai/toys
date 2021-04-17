int counter = 0;
int smallbounce = 0;
int bounce = 0;
int boxbounce = 0;
int firstDelaybounce = 0;
int secondDelaybounce = 0;
int constantX = 0;
int starbounce = 0;
int daycount = 0;
int boxmovex = 50;
int boxmovey = 50;

void setup()
{
  size(1000,1000);
}

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
  background(211,241,255); //sky blue

//Night sky
  fill(0,0,0,-500+constantX);
  rectMode(CORNERS);
  rect(0,0,1000,800);

//stars
  fill(255,255,255,starbounce); //needs fixing
  rectMode(CENTER);
  noStroke();
  if (constantX > 600)
  {
    fill(255,255,255,50+starbounce);
    rect(107,112,10,10);
    fill(255,255,255,starbounce);
    rect(158,200,10,10);
    fill(255,255,255,25+starbounce);
    rect(223,127,10,10);
    fill(255,255,255,250-starbounce);
    rect(51,549,10,10);
    fill(255,255,255,10+starbounce);
    rect(512,141,10,10);
    fill(255,255,255,200-starbounce);
    rect(741,190,10,10);
    fill(255,255,255,30+starbounce);
    rect(812,412,10,10);
    fill(255,255,255,100-starbounce);
    rect(691,119,10,10);
    fill(255,255,255,starbounce);
    rect(680,210,10,10);
  }

//Info Text
  textSize(17);
  fill(0,0,0,-constantX+700);
  if (constantX > 600)
  {
    fill(255,255,255,constantX-500);
  }
  text(("Day: ")+daycount, width=900, height=30);
  text(("ConstantX: ")+constantX, width=750, height=30);
  text(("Bounce: ")+bounce, width=650, height=30);
  text(("Starbounce: ")+starbounce, width=500, height=30);
  text(("FrameLoop: ")+counter, width=350, height=30);
  text(("Boxmovex: ")+boxmovex, width=200, height=30);

//Drawing base
  rectMode(CORNERS);
  fill(100,200,100);
  stroke(0);
  rect(0,800,1000,1000);

//Menu text
  textSize(60);
  fill(0,0,0,-constantX+700);
  if (constantX > 600)
  {
    fill(255,255,255,constantX-500);
  }
  text(("Play"), width=100, height=900);
  text(("Quit"), width=400, height=900);
  text(("Settings"), width=700, height=900);
  
//Sun Yellow
  fill(255,255-constantX/30,0);
  ellipseMode(CORNERS);
  noStroke();
  ellipse(constantX-50,200,constantX+50,300);

//Orange Sun cover
  fill(255,255,255,-500+constantX);
  ellipseMode(CORNERS);
  noStroke();
  ellipse(constantX-50,200,constantX+50,300);
  
//Boxmove selector
  fill(255,255,255);
  noStroke();
  {
  rect(boxmovex,850+boxbounce,boxmovex+40,890+boxbounce);
  }
  

//Golfer Legs
  fill(255,253,208); //cream
  stroke(0);
  rect(460,700,495,800);
  rect(505,700,540,800);

//Golfer Belt
  fill(165,113,78); //brown
  stroke(0);
  rect(450,675+smallbounce,550,700+smallbounce);

//Golfer torso
  fill(255);
  stroke(0);
  rect(450,500+bounce,550,675+bounce);

//Golfer Arms
  fill(255,253,208); //cream
  stroke(0);
  rect(415,500+bounce,450,675+bounce);
  rect(550,500+bounce,585,675+bounce);
  
//Golfer Head
  fill(255,253,208); //cream
  stroke(0);
  rect(455,400+bounce,545,500+bounce);

//Golfer Expression (looks shit)
  //fill(0);
  //stroke(0);
  //rect(475,480,520,484); //line
  //rect(510,476,520,480); //smirk

//Golfer Bandana
  fill(255,0,0);
  stroke(0);
  rect(455,420+bounce,545,440+bounce); //headband
  rect(410,400+firstDelaybounce,455,420+firstDelaybounce); //connected
  rect(420,440+firstDelaybounce,455,460+firstDelaybounce); //connected
  rect(375,380+secondDelaybounce,410,400+secondDelaybounce); //air
  rect(375,430+secondDelaybounce,420,450+secondDelaybounce); //air
}

void keyPressed()
  {
  if (key == 'a' && boxmovex > 50) boxmovex = boxmovex-300;
  if (key == 'd' && boxmovex < 650) boxmovex = boxmovex+300;
  if (key == ' ' && boxmovex == 50)
    {
      //put menu selection here, need to cancel initial void and start a new draw
    }
  }
  
