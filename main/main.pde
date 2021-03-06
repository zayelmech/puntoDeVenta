import controlP5.*;

ControlP5 cp5; 
Textfield buscar, outUnidad,outCantidad;
Button signoMas,signoMenos;
Table table;
int id;
String name,species; 


int widthBuscar=250;
int widthTextSmall=40;
int separacion=20;
int posYsearch=50;


String palabraAnterior;
boolean buscarClicked=false;

void setup(){
  
  cp5 = new ControlP5(this);
  buscar = cp5.addTextfield("Buscar",width/2 - widthBuscar,posYsearch,widthBuscar,30)
                   .setFont(createFont("arial",20))
                   .setAutoClear(false);
  
  float posElementBefore[] = buscar.getPosition();
  int posNextX=int(posElementBefore[0]+float(buscar.getWidth()));
  
  outUnidad = cp5.addTextfield("Unidad", posNextX + separacion,posYsearch,widthTextSmall,30)
                   .setFont(createFont("arial",20))
                   .setAutoClear(false);
                   
        posElementBefore = outUnidad.getPosition();
        posNextX=int(posElementBefore[0]+float(outUnidad.getWidth()));
        
  signoMenos = cp5.addButton("-")
    .setFont(createFont("arial",20))
    .setPosition(posNextX+separacion*3,posElementBefore[1])
    .setSize(35,30); 
        
        posElementBefore = signoMenos.getPosition();
        posNextX=int(posElementBefore[0]+float(signoMenos.getWidth()));
  
  outCantidad = cp5.addTextfield("Cant.",posNextX,posYsearch,widthTextSmall,30)
               .setFont(createFont("arial",20))
                 .setAutoClear(false);
        
        posElementBefore = outCantidad.getPosition();
        posNextX=int(posElementBefore[0]+float(outCantidad.getWidth()));
        
  signoMas = cp5.addButton("+")
    .setFont(createFont("arial",20))
    .setPosition(posNextX+1,posYsearch)
    .setSize(35,30); 
    
    
  signoMenos.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): functionMenos(); break;
        case(ControlP5.ACTION_RELEASED): println("stop"); break;
      }
    }
  }
 );
   
    
  signoMas.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): functionMas(); break;
        case(ControlP5.ACTION_RELEASED): println("stop"); break;
      }
    }
  }
 );
 
 
size(800,600);        
background(0,50,100);

    table = loadTable("./dataB.csv", "header");
      println(table.getRowCount() + " total rows in table");
for (TableRow row : table.rows()) {

     id = row.getInt("id");
     species = row.getString("species");
    name = row.getString("name");

    println(name + " (" + species + ") has an ID of " + id);
  }
}

void draw(){
  
  textSize(30);
  text("XUB MAIZ", 10,25); 
  fill(#00641E);
  if(buscar.isFocus()){
    functionBuscar();
  }
}
void functionBuscar(){

  String palabras=buscar.getText();
  int longitudPalabras= palabras.length();
  if(longitudPalabras>1){
    //println("Buscando..");
  if(!(palabras.equals(palabraAnterior)) || buscarClicked==false){
    for(TableRow row : table.rows()){
      
      String checador=row.getString("species").toLowerCase();
      println("Comparando "+ palabras.toLowerCase() +" con:"+  checador);
      char[] a =checador.toCharArray();
      char[] b =palabras.toCharArray();
      int points=0;
      for(int i=0;i<palabras.length();i++){
        for(int j=0;j<checador.length();j++){
          if(a[j]==b[i]){
           points++;
          } 
        }
      }
      println("this line has "+points+" points");
    }
   
    buscarClicked=true;
    palabraAnterior=palabras;
  }
 }
}



void functionMas(){
  int cantidad= int(outCantidad.getText()) +1;
  outCantidad.setText(str(cantidad));
  println("productos "+cantidad);
}

void functionMenos(){
  
  int cantidad2= int(outCantidad.getText());
  if(cantidad2>0){
  cantidad2=cantidad2-1;
  }
  
  outCantidad.setText(str(cantidad2));
  println("productos "+cantidad2);
}
