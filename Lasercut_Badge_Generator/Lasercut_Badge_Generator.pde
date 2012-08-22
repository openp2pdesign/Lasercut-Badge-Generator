// BADGE_GENERATOR v0.1
// LICENSE: GPL v.3
// AUTHOR: Massimo Menichinelli
// WEB: http://www.openp2pdesign.org


import processing.pdf.*;

// List of badges
Badge[] allBadges = new Badge[500];

// Variable for reading the names from the .csv file
String[] lines;


// Variable for drawing the text
PFont f;


void setup() {
  size(900,600);
  background(255);
  beginRecord(PDF, "stencils.pdf");
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
    println("Name"+allBadges[index].name);
    allBadges[index].display();
    index = index + 1;
  }
  endRecord();
}

// Class of the badges
class Badge {
  // Global variables
  float posx = 0;
  float posy = 0;
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
    
    // to check if the position on the line is < 900
    // to check that every line is < 600
    // otherwise create a new page in the pdf and start from zero again
  
    noFill();
    rect(posx,posy,posx+badgedimensionx,posy+badgedimensiony);
    
   // Check if we have a role to visualize, and then visualize name, surname and role (if any)
    if (role == "None") {
      text(profilenorole,posx+5,posy+textheight);
    } else {
      textLeading(16);
      text(fullprofile,posx+5,posy+textheight);
    }
  }
  
  
  
}

