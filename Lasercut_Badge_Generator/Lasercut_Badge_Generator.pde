import processing.pdf.*;

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
  myBadge.sizex = textWidth(myBadge.name);
  println("Size x: "+myBadge.sizex);
  endRecord();
  //exit();

}


class Badge {
  // Global variables
  float sizex = 0;
  float sizey = 0;
  float posx = 0;
  float posy = 0;
  String name = "NAME";
  String surname = "SURNAME";
  String role = "ROLE";
  float dimensionbadge = 50;
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
  void display() {
    noFill();
    rect(posx,posy,posx+dimensionbadge,posy+dimensionbadge);
    
    // Convert all " " into "_"
    name = name.replaceAll(" ", "_");
    surname = surname.replaceAll(" ", "_");
    role = role.replaceAll(" ", "_");
    
    // Check the dimension of the longest element, be it name or surname o role
    name_size = textWidth(name);
    surname_size = textWidth(surname);
    role_size = textWidth(role);
    
    
   
    if (role == "None") {
      text(name+"\n"+surname,posx+5,posy+16);
    } else {
      textLeading(16);
      text(name+"\n"+surname+"\n"+role,posx+5,posy+16);
    }
  }
  
  
  
}

