/*******************************************
 *                                         * 
 * Image Filter Project starter code       *
 *                                         *
 * UTeach CSP                              *
 * Bradley Beth                            *
 * rev. 20160927                           * 
 *                                         *
 * Search this source code for the phrase  *
 * "complete this section" to locate the   *
 * targeted sections of code you must      *
 * complete.                               *
 *                                         *
 *******************************************/

boolean PicLoaded = false;
boolean Grayscale = false;
boolean Trip = false;
boolean Nega = false;
boolean Radical = false;
int picWidth = 0;
int picHeight = 0;
PImage img;

/***********************************/

void setup() 
{
  size(800, 480);
  background(185);
  textAlign(LEFT);
  textSize(16); 
}

void draw()
{

  background(185);
  noStroke();
  int picStart = 0;
  int picEnd = 0;
  
  /* draw buttons */

  stroke(0);
  fill(0);
  textSize(16);
  text("File Operations",665,30);
  line(650,0,650,480);
  noStroke();
  
  fill(255);
  rect(660, 50, 130, 40, 10);
  fill(55);
  text("Load Picture", 675, 75);

  fill(255);
  rect(660, 100, 130, 40, 10);
  fill(55);
  text("Save Picture", 675, 125);

  stroke(0);
  line(650,150,800,150);
  noStroke();

  stroke(0);
  fill(0);
  textSize(16);
  text("Filter Effects",675,180);
  line(650,0,650,480);
  noStroke();

  if (Grayscale)
    fill(#FFFF7D);    //Effect on means a yellow lighted button
  else
    fill(255);
  rect(660, 200, 130, 40, 10);
  fill(55);
  text("Grayscale", 680, 225);
  
  if (Trip)
    fill(#FFFF7D);    //Effect on means a yellow lighted button
  else
    fill(255);
  rect(660, 250, 130, 40, 10);
  fill(55);
  text("Trip", 680, 275);

  if (Nega)
    fill (#FFFF7D);     //Effect on means a yellow lighted button 
  else
    fill(255); 
  rect(660, 300, 130, 40, 10);
  fill(55);
  text("Negative?", 680, 325);

  if (Radical)
    fill (#FFFF7D);    //Effect on means a yellow lighted button
  else
    fill(255);   
  rect(660, 350, 130, 40, 10);
  fill(55);
  text("Radical!", 680, 375);

  noStroke();
  textSize(16);

  //The following loads and displays an image file.
  //The image is resized to best fit in a 640x480 frame.
  if (PicLoaded)
  {     
    picWidth = img.width;
    picHeight = img.height;
    
    if (picWidth > 640)
    {
      picHeight = (int)(picHeight*(640.0/picWidth));
      picWidth = 640;
    }
    if (picHeight > 480)
    {
      picWidth = (int)(picWidth*(480.0/picHeight));
      picHeight = 480;
    }
    image(img, 0, 0, picWidth, picHeight);
    
    picStart = 0;
    picEnd = picStart+width*picHeight;

    loadPixels();
    /***** Effects Code *****/
    if (Grayscale)
    {
      int i = picStart;
      while (i < picEnd) 
      {
        color c = pixels[i];
        float gray = (red(c)+green(c)+blue(c))/3.0;  //average the RGB colors
        pixels[i] = color(gray, gray, gray);
        i = i + 1;
        if (i % width >= picWidth)        // This will ignore anything on the line that 
          i = i + width - picWidth;       // after the image (such as buttons)
      }   
    }

    if (Trip)
    {
      int i=0;
      while(picEnd-i-width+picWidth>=0)
      {
        color c=pixels[picStart+i];
        float r=Math.abs(200-red(c));
        float g=Math.abs(200-green(c));
        float b=Math.abs(200-blue(c));
        pixels[picEnd-i-width+picWidth]=color(r,g,b);
        i+=(int)(Math.random()*3+3);
          if(i%width>=picWidth)
          i+=width-picWidth;
      }
    }

    if (Nega)
    {
      int i = picStart;
      while (i < picEnd) 
      {
        color c = pixels[i];
        float r=Math.abs(green(c)+blue(c)-red(c));
        float g=Math.abs(red(c)+blue(c)-green(c));
        float b=Math.abs(green(c)+red(c)-blue(c));
        pixels[i] = color(r,g,b);
        i+=1;
        if (i % width >= picWidth)    
          i+=width - picWidth;      
      }
    }
    
    if (Radical)
    {
      int i = picStart;
      while (i < picEnd) 
      {
        color c = pixels[i];
        float r=(500*red(c)/green(c)/blue(c));
        float g=(500*green(c)/red(c)/blue(c));
        float b=(500*blue(c)/green(c)/red(c));
        if(r+g+b<150)
        {
          r*=2;
          g*=2;
          b*=2;
        }
        pixels[i] = color(r,g,b);
        i+=1;
        if (i % width >= picWidth)    
          i+=width - picWidth;      
      }
    }
    
    updatePixels(); 
    redraw();
  }
  
  fill(255);
  noStroke();
}

void mouseClicked() {
  
  redraw();
}

void mousePressed()
{
  //The following define the clickable bounding boxes for any buttons used.
  //Note that these boundaries should match those drawn in the draw() function.
  
  if (mouseX>660 && mouseX<790 && mouseY>50 && mouseY<90)
  {
    selectInput("Select a file to process:", "infileSelected");
  }
  
  if (mouseX>660 && mouseX<790 && mouseY>100 && mouseY<140)
  {
    selectOutput("Select a file to write to:", "outfileSelected");
  }
  
  if (mouseX>660 && mouseX<790 && mouseY>200 && mouseY<240 && PicLoaded)
  {
    Grayscale = !Grayscale;
  }   
  
  if (mouseX>660 && mouseX<790 && mouseY>250 && mouseY<290 && PicLoaded)
  {
    Trip = !Trip;
  } 

  if (mouseX>660 && mouseX<790 && mouseY>300 && mouseY<340 && PicLoaded)
  {
    Nega = !Nega;
  }  

  if (mouseX>660 && mouseX<790 && mouseY>350 && mouseY<390 && PicLoaded)
  {
    Radical = !Radical;
  } 

  redraw();
}

void infileSelected(File selection) 
{
  if (selection == null) 
  {
    println("IMAGE NOT LOADED: Window was closed or the user hit cancel.");
  } 
  else 
  {
    println("IMAGE LOADED: User selected " + selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
    PicLoaded = true;
    Grayscale = false;
    Trip = false;
    Nega = false;
    Radical = false;
    redraw();
  }
}

void outfileSelected(File selection) 
{
  if (selection == null) 
  {
    println("IMAGE NOT SAVED: Window was closed or the user hit cancel.");
  } 
  else 
  {
    println("IMAGE SAVED: User selected " + selection.getAbsolutePath() + ".png");
    noLoop();
    updatePixels();
    redraw();
    save(selection.getAbsolutePath()+".png");
    redraw();
    loop();
  }
}