import processing.pdf.*;

Badge[] allBadges = new Badge[500]; 

PFont f;
Badge myBadge;

void setup() {
  size(900,600);
  background(255);
  beginRecord(PDF, "stencils.pdf");
  f = createFont("Blackout-TwoAM",16,true);
  myBadge = new Badge("Massimo Mario","Menichinelli", "OKFestCrew");
}

void draw() {
  
  textFont(f,16); 
  fill(0); 
  println(myBadge.name);
  println(myBadge.surname);
  myBadge.display();
  endRecord();
  //exit();

}


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
  
  // Draw the tags
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
    
    badgedimensionx = max(name_size, surname_size, role_size);
    badgedimensionx = badgedimensionx+10;
    println("Badge X size: "+badgedimensionx);
    
    textheight = textAscent()+textDescent();
    badgedimensiony = (textheight*3)+10;
    println("Badge Y size: "+badgedimensiony);
    
    // which one is the biggest, then we have the size + 5 sx + 5 dx of a badge cutout
    // to check if the position on the line is < 900
    // to check that every line is < 600
    // otherwise create a new page in the pdf and start from zero again
  
    noFill();
    rect(posx,posy,posx+badgedimensionx,posy+badgedimensiony);
    
   // Check if we have a role to visualize, and then visualize name, surname and role (if any)
    if (role == "None") {
      text(profilenorole,posx+5,posy+textheight+5);
    } else {
      textLeading(16);
      text(fullprofile,posx+5,posy+textheight+5);
    }
  }
  
  
  
}

