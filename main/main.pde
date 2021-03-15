import controlP5.*;
import java.util.*;

ControlP5 cp5; 
Textfield buscar, outUnidad,outCantidad;
Button signoMas,signoMenos,primerResultado,segundoResultado,tercerResultado;
Table table,tableSearch;
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
  
  primerResultado = cp5.addButton("Result_1")
                  .setFont(createFont("arial",20))
                  .setPosition(width/2 - widthBuscar,posYsearch+30)
                  .setSize(widthBuscar,30)
                  .hide(); 
  segundoResultado = cp5.addButton("Result_2")
                  .setFont(createFont("arial",20))
                  .setPosition(width/2 - widthBuscar,posYsearch+60)
                  .setSize(widthBuscar,30)
                  .hide(); 
  tercerResultado = cp5.addButton("Result_3")
                  .setFont(createFont("arial",20))
                  .setPosition(width/2 - widthBuscar,posYsearch+90)
                  .setSize(widthBuscar,30)
                  .hide(); 
                  
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

}
void functionBuscar(){
  primerResultado.show();
  segundoResultado.show();
  tercerResultado.show();
  String palabras=buscar.getText();
  int longitudPalabras= palabras.length();
  if(longitudPalabras>1){
    //println("Buscando..");
  if(!(palabras.equals(palabraAnterior)) || buscarClicked==false){
     tableSearch = new Table();
  
     tableSearch.addColumn("points");
     tableSearch.addColumn("wordFind");
     tableSearch.addColumn("rowIndex");
    
  
    int indexRow=0;
    for(TableRow row : table.rows()){
      
      String checadorOriginal=row.getString("species");      
      String checador=row.getString("species").toLowerCase();
      println("Comparando "+ palabras.toLowerCase() +" con:"+  checador);
      char[] a =checador.toCharArray();
      char[] b =palabras.toLowerCase().toCharArray();
      int points=10;
      for(int i=0;i<palabras.length();i++){
        
        //String dobleChar=""+ b[i]+b[i+1];
      //  println("Wachate este cumbion: "+ dobleChar);
        
        for(int j=0;j<checador.length();j++){
          if(a[j]==b[i]){
           points++;
          }
          
        }
      }
        TableRow result = table.findRow( checadorOriginal, "species");
      //println(result.getString("species"));//imprime el texto de la columna
      println("this line has "+points+" points");
        
      TableRow newRowJack = tableSearch.addRow();

      newRowJack.setInt("points",points);
      newRowJack.setString("wordFind",result.getString("species") );
      newRowJack.setInt("rowIndex",indexRow);
      indexRow++;
  
    }
      tableSearch.sortReverse("points");
      String arreglo[]={"","","",""};
      int indice=0;
      for (TableRow rowX : tableSearch.rows()) {
          
          int id2 = rowX.getInt("points");
          String species2 = rowX.getString("wordFind");
          int name2 = rowX.getInt("rowIndex");
          arreglo[indice]=species2;
          indice++;
          
         println("points:"+id2+" wordFind:"+species2 + " Index:"+name2);
      }
      primerResultado.setLabel(arreglo[0]);
      segundoResultado.setLabel(arreglo[1]);
      tercerResultado.setLabel(arreglo[2]);
    buscarClicked=true;
    palabraAnterior=palabras;
  }
 }
}

void keyPressed(){
  if(buscar.isFocus()){
    functionBuscar();
  }
}

void dropdown(int n) {
  /* request the selected item based on index n */
  println(n, cp5.get(ScrollableList.class, "dropdown").getItem(n));
  
  /* here an item is stored as a Map  with the following key-value pairs:
   * name, the given name of the item
   * text, the given text of the item by default the same as name
   * value, the given value of the item, can be changed by using .getItem(n).put("value", "abc"); a value here is of type Object therefore can be anything
   * color, the given color of the item, how to change, see below
   * view, a customizable view, is of type CDrawable 
   */
  
   CColor c = new CColor();
  c.setBackground(color(255,0,0));
  cp5.get(ScrollableList.class, "dropdown").getItem(n).put("color", c);
  
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
