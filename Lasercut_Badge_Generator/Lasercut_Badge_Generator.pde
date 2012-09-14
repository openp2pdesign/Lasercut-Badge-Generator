// BADGE_GENERATOR v0.1
// LICENSE: GPL v.3
// AUTHOR: Massimo Menichinelli
// WEB: http://www.openp2pdesign.org

import processing.pdf.*;

PGraphics pdf;

// List of badges
Badge[] allBadges = new Badge[700];

// Variable for reading the names from the .csv file
String[] lines;

// Variable for drawing the text
PFont f;

float posx = 0;
float posy = 0;

void setup() {
  // The display, 1 px = 1mm in the real world (the .pdf file must be scaled later in Inkscape)
  size(900,600,PDF, "badges.pdf");
  background(255);
  f = createFont("Blackout-TwoAM",16,true);
  lines = loadStrings("names.csv");
}

void draw() {
  textFont(f,16); 
  fill(0); 
  
  // Read the names in the .csv file and display them
  for (int index = 0; index < lines.length; index = index+1) {
    String[] pieces = split(lines[index], ',');
    allBadges[index] = new Badge(pieces[0], pieces[1], pieces[2]);
    println("=========================================");
    println("Name: "+allBadges[index].name);
    println("Surname: "+allBadges[index].surname);
    println("Role: "+allBadges[index].role);
    println(posx);
    println(posy);
    allBadges[index].display();
    // Update the position of the cursor
    posx = posx + allBadges[index].badgedimensionx;
    
  }
   println("Done.");
  exit();

}

// Class of the badges
class Badge {
  // Global variables
  String name = "NAME";
  String surname = "SURNAME";
  String role = "ROLE";
  String hashtag = "#OKFest";
  String fullprofile;
  String profilenorole;
  float badgedimensionx = 0;
  float badgedimensiony = 0;
  float textheight;
  float name_size = 0;
  float surname_size = 0;
  float role_size = 0;
  float hashtag_size = 0;
  float[] maxarray = new float[4];

  // Constructor
  Badge(String _name, String _surname, String _role) {
  name = _name.toUpperCase();
  surname = _surname.toUpperCase();
  role = _role.toUpperCase();
  }
 
  // Functions
  
  // Draw the badges
  void display() {
    
    // Convert all " " into "_"
    name = name.replaceAll(" ", "_");
    surname = surname.replaceAll(" ", "_");
    role = role.replaceAll(" ", "_");
    
    profilenorole = hashtag+"\n"+name+"\n"+surname;
    fullprofile = hashtag+"\n"+name+"\n"+surname+"\n"+role;
    
    // Check the dimension of the longest element, be it name or surname o role
    name_size = textWidth(name);
    println("Name size: "+name_size);
    surname_size = textWidth(surname);
    println("Surname size: "+surname_size);
    role_size = textWidth(role);
    println("Role size: "+role_size);
    hashtag_size = textWidth(hashtag);
    println("Hashtag size: "+hashtag_size);
    
    maxarray[0]=name_size;
    maxarray[1]=surname_size;
    maxarray[2]=role_size;
    maxarray[3]=hashtag_size;
    
    // Checking the X dimension of the badge
    badgedimensionx = max(maxarray);
    badgedimensionx = badgedimensionx+10;
    println("Badge X size: "+badgedimensionx);
    
    // Checking the Y dimension of the badge
    textheight = textAscent()+textDescent();
    
    if(role.equals("") == true) {
       badgedimensiony = (textheight*3);
    } else {
       badgedimensiony = (textheight*4);
    }
    
    println("Badge Y size: "+badgedimensiony);
    
    // Check if the X position of the badge is < 900 i.e. still on the plate
    if ((badgedimensionx+posx) > 900) {
      println("Going to another line...");
      posy = posy + badgedimensiony;
      posx = 0;
    }
    
    // Check if the Y position of the badge is < 600 i.e. still on the plate
    // otherwise create a new page in the pdf and start from zero again
    if ((badgedimensiony+posy) > 580) {
      println("Going to another page...");
       // Create a new page in the .pdf file
      PGraphicsPDF pdf = (PGraphicsPDF) g;
      pdf.nextPage();
      posx = 0;
      posy = 0;
    }
  
    noFill();
    
    // Uncomment the following line in order to have a box around each tag, for debuggin purposes
    //rect(posx,posy,badgedimensionx,badgedimensiony);
    
   // Check if we have a role to visualize, and then visualize name, surname and role (if any)
    if (role.equals("NONE") == true) {
      text(profilenorole,posx+5,posy+textheight);
    } else {
      textLeading(16);
      text(fullprofile,posx+5,posy+textheight);
    }
  }
  
  
}

