PImage img;
int flag = 0;
int arr[];
String texts[]= new String[1];  
String lines = "{\"drawing\":[";

void setup() {
  size(155, 198);
  //size(151, 187);
  img = loadImage("GANESHA.png"); //change name of image
  println("image:" +  img.width + ":"+ img.height); 
  initialize();
}
void checkPixel(int posx, int posy)
{  int pos = posy * img.width + posx;
   if ( arr[pos] > 0 ) return;
   float r = red(img.pixels[pos]);
   float g = green(img.pixels[pos]);
   float b = blue(img.pixels[pos]);
   if(r < 62 || g < 62 || b < 62)
   {   arr[pos] = 2;
       lines = lines + "{\"x\": "+posx+","+"\"y\":"+posy+"},\n"; 
       checkPixel(min(posx + 1, img.width-1),posy);
       checkPixel(min(posx + 1, img.width-1),min(posy + 1, img.height-1));
       checkPixel(posx,min(posy + 1, img.height-1));
       checkPixel(max(posx - 1, 0),min(posy + 1, img.height-1));
       checkPixel(max(posx - 1, 0),posy);
       checkPixel(max(posx - 1, 0),max(posy - 1, 0));
       checkPixel(posx ,max(posy - 1, 0));
       checkPixel(min(posx + 1, img.width-1),max(posy - 1, 0));

   }
   else    
      arr[pos] = 1;
}

void initialize()
{  img.loadPixels();
   
   arr =new int[img.width * img.height];
   for (int y = 0; y < img.height; y++)  
   for (int x = 0, loc = 0; x < img.width; x++) 
         { loc = y * img.width + x;
           arr[loc] = 0;
         }
   for (int x = 0; x < img.width; x++) 
     for (int y = 0; y < img.height ; y++)
          checkPixel(x,y); 
            
    lines=lines + "]}";
    texts[0]=lines;
    saveStrings("trial1.json", texts);
      
}

void draw() {
    // Since we are going to access the image's pixels too  
  background(255, 255, 255);
  loadPixels();       
   {
    for (int x = 0; x < width; x++) 
    for (int y = 0; y < height; y++){
      int loc = x + y*width;
      if(arr[loc] == 2)
        { float r = red(img.pixels[loc]);
          float g = green(img.pixels[loc]);
          float b = blue(img.pixels[loc]);
           //println("x: "+x+","+"y:"+y);
           pixels[loc] = color(r,g,b);
        }  
      }
    }
  updatePixels();
}
