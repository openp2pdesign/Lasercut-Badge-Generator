// BADGE_GENERATOR v0.1
// LICENSE: GPL v.3
// AUTHOR: Massimo Menichinelli
// WEB: http://www.openp2pdesign.org

import processing.pdf.*;

PGraphics pdf;

Boolean newPage = false;

// List of badges
Badge[] allBadges = new Badge[500];

// Variable for reading the names from the .csv file
String[] lines;

// Variable for drawing the text
PFont f;

float posx = 0;
float posy = 0;

void setup() {
  // The display, 1 px = 1mm in the real world (the .pdf file must be scaled later in Inkscape)
  size(900,600,PDF, "test.pdf");
  background(255);
  f = createFont("Blackout-TwoAM",16,true);
  lines = loadStrings("names.csv");
}

void draw() {
  textFont(f,16); 
  fill(0); 
  
  // Read the names in the .csv file and display them
  for (int index = 0; index < lines.length; index = index+1) {
    if (newPage == true) {
      // Record the display to a .pdf file
      PGraphicsPDF pdf = (PGraphicsPDF) g;
      pdf.nextPage();
      newPage = false;
    }
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
  exit();

}

// Class of the badges
class Badge {
  // Global variables
  String name = "NAME";
  String surname = "SURNAME";
  String role = "ROLE";
  String fullprofile;
  String profilenorole;
  float badgedimensionx = 0;
  float badgedimensiony = 0;
  float textheight;
  float name_size = 0;
  float surname_size = 0;
  float role_size = 0;

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
    
    profilenorole = name+"\n"+surname;
    fullprofile = name+"\n"+surname+"\n"+role;
    
    // Check the dimension of the longest element, be it name or surname o role
    name_size = textWidth(name);
    println("Name size: "+name_size);
    surname_size = textWidth(surname);
    println("Surname size: "+surname_size);
    role_size = textWidth(role);
    println("Role size: "+role_size);
    
    // Checking the X dimension of the badge
    badgedimensionx = max(name_size, surname_size, role_size);
    badgedimensionx = badgedimensionx+10;
    println("Badge X size: "+badgedimensionx);
    
    // Checking the Y dimension of the badge
    textheight = textAscent()+textDescent();
    badgedimensiony = (textheight*3)+10;
    println("Badge Y size: "+badgedimensiony);
    
    // Check if the X position of the badge is < 900 i.e. still on the plate
    if ((badgedimensionx+posx) > 900) {
      println("Going to another line...");
      posy = posy + badgedimensiony;
      posx = 0;
    }
    
    // Ccheck if the Y position of the badge is < 600 i.e. still on the plate
    if ((badgedimensiony+posy) > 600) {
      println("Going to another page...");
      posx = 0;
      posy = 0;
      // Create a new page in the .pdf file
      newPage = true;
    } else {newPage = false;}
    
    // to check that every line is < 600
    // otherwise create a new page in the pdf and start from zero again
  
    noFill();
    rect(posx,posy,badgedimensionx,badgedimensiony);
    
   // Check if we have a role to visualize, and then visualize name, surname and role (if any)
    if (role.equals("NONE") == true) {
      text(profilenorole,posx+5,posy+textheight);
    } else {
      textLeading(16);
      text(fullprofile,posx+5,posy+textheight);
    }
  }
  
  
}

