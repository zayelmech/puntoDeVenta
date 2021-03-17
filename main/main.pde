import controlP5.*;
import java.util.*;

ControlP5 cp5; 
Textfield buscar, outUnidad,outCantidad;
Button signoMas,signoMenos,primerResultado,segundoResultado,tercerResultado,botonAgregar,botonSalvarCSV;
Table table,tableSearch,Ticket;
int id;
String name,species; 


int widthBuscar=250;
int widthTextSmall=40;
int separacion=20;
int posYsearch=50;


String palabraAnterior;
boolean buscarClicked=false;

String arreglo[]={"","","","",""};
void setup(){
  
  Ticket = new Table();
  Ticket.addColumn("Producto");
  Ticket.addColumn("Unidad");
  Ticket.addColumn("Cantidad");
  Ticket.addColumn("Precio unitario");
  Ticket.addColumn("Total");
    
  
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
    
        posElementBefore = signoMas.getPosition();
        posNextX=int(posElementBefore[0]+float(signoMas.getWidth()));
    
    
  botonAgregar = cp5.addButton("Agregar")
    .setFont(createFont("arial",18))
    .setPosition(posNextX+10,posYsearch)
    .setSize(100,30)
    ; 
    
  botonSalvarCSV = cp5.addButton("Guardar")
    .setFont(createFont("arial",16))
    .setPosition(posNextX+10,200)
    .setSize(120,30)
    ; 
    
   
botonSalvarCSV.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): guardandoTicket(); break;
        case(ControlP5.ACTION_RELEASED): println("stop"); break;
      }
    }
  }
 );
 botonAgregar.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): echaleOtro(); break;
        case(ControlP5.ACTION_RELEASED): println("stop"); break;
      }
    }
  }
 );
 
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
 
 primerResultado.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): primerBoton(); break;
        case(ControlP5.ACTION_RELEASED): println("stop"); break;
      }
    }
  }
 );
 segundoResultado.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): segundoBoton(); break;
        case(ControlP5.ACTION_RELEASED): println("stop"); break;
      }
    }
  }
 );
  tercerResultado.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): tercerBoton(); break;
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

     id = row.getInt("ID");
     species = row.getString("PRODUCTO");
    name = row.getString("UNIDAD");

    println(name + " (" + species + ") has an ID of " + id);
  }
}

void draw(){
  background(0,50,100);
  textSize(30);
  text("XUB MAIZ", 10,25); 
  fill(#00641E);
 //buscar.getText().length() >1
if(keyPressed  ){
//  println(key);
if(buscar.isFocus()){
      functionBuscar();
}
}

}
void functionBuscar(){
 
  String palabras=buscar.getText();
  int longitudPalabras= palabras.length();
  if(longitudPalabras>1){
     
     println("Buscando.." + palabras.toLowerCase());
     tableSearch = new Table();
  
     tableSearch.addColumn("points");
     tableSearch.addColumn("wordFind");
     tableSearch.addColumn("rowIndex");
    
  
    int indexRow=0;
    for(TableRow row : table.rows()){
      
      String checadorOriginal=row.getString("PRODUCTO")+"";      
      String checadorEspecial = checadorOriginal.replace("ñ","w");
      String checador = checadorEspecial.toLowerCase();
      //String hola= "Piña coladañ";
      //println("Hola sin ñ: "+ hola.replace("ñ","n"));
      String palabrasMinus=palabras.replace("ñ","w");
      //println("Comparando "+ palabras.toLowerCase() +" con:"+  checador);
      char[] a =checador.toCharArray();

      char[] b =palabrasMinus.toLowerCase().toCharArray();
      int points=10;
      
      //println("ascii: "+int(b[0]));
         //experimental condition
     if(a[0]==b[0] && a[1]==b[1] ){
          points=points+5;
          }
      /*
      for(int i=0;i<palabras.length();i++){
        
        for(int j=0;j<checador.length();j++){
          if(a[j]==b[i]){
           points++;
          }
       
          
        }
      }
         
     for(int i=0;i<(palabras.length()-1);i++){
       for(int j=0;j<(checador.length()-1);j++){
          if(b[i]==a[j] && b[i+1]==a[j+1] ){
           points=points+20;
          }
        }
      }
      */
      if(palabras.length()>=3){
       for(int i=0;i<(palabras.length()-2);i++){
         for(int j=0;j<(checador.length()-2);j++){
            if(b[i]==a[j] && b[i+1]==a[j+1]&& b[i+2]==a[j+2] ){
             points=points+2;
            }
          }
        }
      }
      
      
       
      String[] m2 = match(checador,palabrasMinus.toLowerCase()+"");
      if (m2 != null) {  // If not null, then a match was found
        // This will print to the console, since a match was found.
        println("Found a match of: " +palabrasMinus.toLowerCase()+" in '" + checador+"'");
        points=points+15;
      } else {
       // println("No match found in '" + checadorOriginal + "'");
      }
      
      
      TableRow result = table.findRow( checadorOriginal, "PRODUCTO");
      
      
     // println("this line has "+points+" points");
        
      TableRow newRowJack = tableSearch.addRow();

      newRowJack.setInt("points",points);
      newRowJack.setString("wordFind",result.getString("PRODUCTO") );
      newRowJack.setInt("rowIndex",indexRow);
      indexRow++;
  
    }
      tableSearch.sortReverse("points");

      int indice=0;
      for (TableRow rowX : tableSearch.rows()) {
          
          int id2 = rowX.getInt("points");
          String species2 = rowX.getString("wordFind");
          int name2 = rowX.getInt("rowIndex");
          arreglo[indice]=species2;
          if(indice<=3){
            indice++;
            println("points:"+id2+" words Array:"+species2 + " Index:"+name2);

          }
      }
      
      if(arreglo[0].length()>18){
      primerResultado.setLabel(arreglo[0].substring(0,18));
      }
      else{
        primerResultado.setLabel(arreglo[0]);
      }  
      if(arreglo[1].length()>18){
        segundoResultado.setLabel(arreglo[1].substring(0,18));
      }
      else{
        segundoResultado.setLabel(arreglo[1]);
      }
      if(arreglo[2].length()>18){
        tercerResultado.setLabel(arreglo[2].substring(0,18));
      }
      else{
        tercerResultado.setLabel(arreglo[2]);
      }
            
      primerResultado.show();
      segundoResultado.show();
      tercerResultado.show();
 }
 else{
  primerResultado.hide();
  segundoResultado.hide();
  tercerResultado.hide();
 }
 
}

void keyPressed(){
  //if(buscar.isFocus()){
    //functionBuscar();
  
}

void ocultarBotonesDesplegables(){
  primerResultado.hide();
segundoResultado.hide();
tercerResultado.hide();
}
void primerBoton(){
TableRow filaParaAgregar= table.findRow(arreglo[0],"PRODUCTO");
int id2 = filaParaAgregar.getInt("ID");
String nameProduct = filaParaAgregar.getString("PRODUCTO");
String unidad = filaParaAgregar.getString("UNIDAD");
int price = filaParaAgregar.getInt("PRECIO UNITARIO");
String presentacion = filaParaAgregar.getString("PRESENTACION");
println("ID:"+id2 +" | "+nameProduct +" | "+ unidad + "| $"+price+"PRESENTACION: "+presentacion);
buscar.setText(nameProduct);
outUnidad.setText(unidad);
ocultarBotonesDesplegables();

}

void segundoBoton(){
TableRow filaParaAgregar= table.findRow(arreglo[1],"PRODUCTO");
int id2 = filaParaAgregar.getInt("ID");
String nameProduct = filaParaAgregar.getString("PRODUCTO");
String unidad = filaParaAgregar.getString("UNIDAD");
int price = filaParaAgregar.getInt("PRECIO UNITARIO");        
String presentacion = filaParaAgregar.getString("PRESENTACION");
println("ID:"+id2 +" | "+nameProduct +" | "+ unidad + "| $"+price+"PRESENTACION: "+presentacion);

buscar.setText(nameProduct);
outUnidad.setText(unidad);
ocultarBotonesDesplegables();

}

void tercerBoton(){
TableRow filaParaAgregar= table.findRow(arreglo[2],"PRODUCTO");

int id2 = filaParaAgregar.getInt("ID");
String nameProduct = filaParaAgregar.getString("PRODUCTO");
String unidad = filaParaAgregar.getString("UNIDAD");
int price = filaParaAgregar.getInt("PRECIO UNITARIO");        
String presentacion = filaParaAgregar.getString("PRESENTACION");
println("ID:"+id2 +" | "+nameProduct +" | "+ unidad + "| $"+price+"PRESENTACION: "+presentacion);
buscar.setText(nameProduct);
outUnidad.setText(unidad);
ocultarBotonesDesplegables();

}

void echaleOtro(){
//wachense esta poderosa función 
  String productName=buscar.getText();
  String productUnit=outUnidad.getText();
  float productCantidad=float(outCantidad.getText())+0;
  float productPrice= table.findRow(productName,"PRODUCTO").getInt("PRECIO UNITARIO");
  float productPresent=table.findRow(productName,"PRODUCTO").getFloat("PRESENTACION");
  float subtotal= (productCantidad*productPrice)/productPresent;
  println("Agregando... " + productName +" | "+ productUnit +" | "+ productCantidad +" | "+productPrice +" | "+subtotal);
  
    TableRow newRowJack = Ticket.addRow();
  
      newRowJack.setString("Producto",productName);
      newRowJack.setString("Unidad",productUnit);
      newRowJack.setFloat("Cantidad",productCantidad);
      newRowJack.setFloat("Precio unitario",productPrice);
      newRowJack.setFloat("Total",subtotal);
      
      buscar.setText("");
      outUnidad.setText("");
      outCantidad.setText("");
}

void guardandoTicket(){
  int x=int(random(0,2031));
  saveTable(Ticket, "/new"+x+".csv");
  println("Listo! csv guardada");
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
