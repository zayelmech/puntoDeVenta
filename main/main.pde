import controlP5.*;
import java.util.*;

ControlP5 cp5; 
Textfield buscar, outUnidad, outCantidad, outPrice, outPiezas, outPresentacion, outSubtotal;
Button signoMas, signoMenos, primerResultado, segundoResultado, tercerResultado, botonAgregar, botonSalvarCSV, botonCargarTxt;
Textarea notasArea, productArea, unidadArea, cantidadArea, precioArea, subtotalArea;

Table table, tableSearch, Ticket, ticketHeader;
int id;
String name, species,productDescription= ""; 

int numeroPedido =1;
int widthBuscar=300;
int widthTextSmall=40;
int separacion=20;
int posYsearch=50;


String palabraAnterior;
boolean buscarClicked=false;

String arreglo[]={"", "", "", "", ""};
void setup() {


  cp5 = new ControlP5(this);

  Ticket = new Table();
  Ticket.addColumn("Producto");
  Ticket.addColumn("Unidad");
  Ticket.addColumn("Cantidad");
  Ticket.addColumn("Precio unitario");
  Ticket.addColumn("Total");
  /*
  ticketHeader =new Table();
   
   TableRow dateRow = ticketHeader.addRow();
   dateRow.setString(0, "25 marzo de 2021");
   TableRow nameRow = ticketHeader.addRow();
   nameRow.setString(0, "Nombre:");
   nameRow.setString(1, "Cliente");
   TableRow adressRow = ticketHeader.addRow();
   adressRow.setString(0, "Direccion:");
   adressRow.setString(1, "Oax");
   TableRow phoneRow = ticketHeader.addRow();
   phoneRow.setString(0, "Telefono:");
   phoneRow.setString(1, "951--");
   phoneRow.setString(3, "Forma de pago");
   phoneRow.setString(4, "Efectivo");
   saveTable(ticketHeader, "/header.csv");
   */



  notasArea = cp5.addTextarea("txt_notas")
    .setPosition(200, 195)
    .setSize(80, 400)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(32))
    .setColorBackground(color(240))  
    .setColorForeground(color(255, 100));
  productArea = cp5.addTextarea("txt_producto")
    .setPosition(285, 195)
    .setSize(240, 400)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(32))
    .setColorBackground(color(240))  
    .setColorForeground(color(255, 100));

  unidadArea = cp5.addTextarea("txt_unidad")
    .setPosition(290+240, 195)
    .setSize(80, 400)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(32))
    .setColorBackground(color(240))  
    .setColorForeground(color(255, 100));

  cantidadArea = cp5.addTextarea("txt_cantidad")
    .setPosition(530+85, 195)
    .setSize(80, 400)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(32))
    .setColorBackground(color(240))  
    .setColorForeground(color(255, 100));
  precioArea= cp5.addTextarea("txt_precio")
    .setPosition(700, 195)
    .setSize(80, 400)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(32))
    .setColorBackground(color(240))  
    .setColorForeground(color(255, 100));
  subtotalArea= cp5.addTextarea("txt_subtotal")
    .setPosition(785, 195)
    .setSize(80, 400)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(32))
    .setColorBackground(color(240))  
    .setColorForeground(color(255, 100));
  //Flujo normal

  outPresentacion=cp5.addTextfield("Presentacion", width/2 -40-70, 90, 70, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255));

  outPiezas=cp5.addTextfield("pzs", 20, posYsearch, 40, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255));

  buscar = cp5.addTextfield("Buscar", width/2 - widthBuscar-40, posYsearch, widthBuscar, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255));


  float posElementBefore[] = buscar.getPosition();
  int posNextX=int(posElementBefore[0]+float(buscar.getWidth()));

  primerResultado = cp5.addButton("Result_1")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX-widthBuscar, posYsearch+30)
    .setSize(widthBuscar, 30)
    .setColorBackground(color(#d79d6a))
    .setColorForeground(color(#f87a2c))
    .hide()    ; 
  segundoResultado = cp5.addButton("Result_2")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX-widthBuscar, posYsearch+60)
    .setSize(widthBuscar, 30)
    .setColorBackground(color(#d79d6a))
    .setColorForeground(color(#f87a2c))
    .hide(); 
  tercerResultado = cp5.addButton("Result_3")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX-widthBuscar, posYsearch+90)
    .setSize(widthBuscar, 30)
    .setColorBackground(color(#d79d6a))
    .setColorForeground(color(#f87a2c))
    .hide(); 

  outUnidad = cp5.addTextfield("Unidad", posNextX + separacion, posYsearch, widthTextSmall, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255));


  posElementBefore = outUnidad.getPosition();
  posNextX=int(posElementBefore[0]+float(outUnidad.getWidth()));

  signoMenos = cp5.addButton("-")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX+separacion*3, posElementBefore[1])
    .setSize(35, 30);
  //.setColorBackground(color(248, 121, 43));

  posElementBefore = signoMenos.getPosition();
  posNextX=int(posElementBefore[0]+float(signoMenos.getWidth()));

  outCantidad = cp5.addTextfield("Cant.", posNextX, posYsearch, widthTextSmall, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255));

  posElementBefore = outCantidad.getPosition();
  posNextX=int(posElementBefore[0]+float(outCantidad.getWidth()));

  signoMas = cp5.addButton("+")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX+1, posYsearch)
    .setSize(35, 30); 

  posElementBefore = signoMas.getPosition();
  posNextX=int(posElementBefore[0]+float(signoMas.getWidth()));

  outPrice=cp5.addTextfield("$ c/u", posNextX+30, posYsearch, int(widthTextSmall*1.5), 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255));

  posElementBefore = outPrice.getPosition();
  posNextX=int(posElementBefore[0]+float(outPrice.getWidth()));

  outSubtotal=cp5.addTextfield("$Total", posNextX+30, posYsearch, widthTextSmall*2, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255));

  posElementBefore = outSubtotal.getPosition();
  posNextX=int(posElementBefore[0]+float(outSubtotal.getWidth()));

  botonAgregar = cp5.addButton("Agregar")
    .setFont(createFont("arial", 18))
    .setPosition(posNextX+20, posYsearch)
    .setSize(100, 30) ;   /*
    .setColorBackground(color(#7c3d16))
   .setColorForeground(color(#f8b992));*/

  botonSalvarCSV = cp5.addButton("Guardar")
    .setFont(createFont("arial", 16))
    .setPosition(posNextX-10, 595-30)
    .setSize(120, 30);

  /*botonCargarTxt = cp5.addButton("loadTxt")
   .setFont(createFont("arial", 16))
   .setPosition(posNextX-10, 595-70)
   .setSize(120, 30);*/
  /*
    .setColorBackground(color(#16557c))
   .setColorForeground(color(#2caaf8));
   ;*/
  //fromTxtToCsv

  /*botonCargarTxt.addCallback(new CallbackListener() {
   public void controlEvent(CallbackEvent theEvent) {
   switch(theEvent.getAction()) {
   case(ControlP5.ACTION_PRESSED): 
   fromTxtToCsv(); 
   break;
   case(ControlP5.ACTION_RELEASED): 
   println("stop"); 
   break;
   }
   }
   }
   );*/
  botonSalvarCSV.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        guardandoTicket(); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        break;
      }
    }
  }
  );
  botonAgregar.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        echaleOtro(); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        break;
      }
    }
  }
  );

  signoMenos.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        functionMenos(); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        break;
      }
    }
  }
  );


  signoMas.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        functionMas(); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        break;
      }
    }
  }
  );

  primerResultado.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      //println(theEvent.getController().getName());
      /*println(theEvent.getAction());
       if(theEvent.getAction()==5){
       cambiarWidth();
       }*/
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        primerBoton(); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        productDescription= " ";
        break;
        case(ControlP5.ACTION_MOVE): 
        println("primerResultado is Focus");
        println(arreglo[0]);
        productDescription=arreglo[0];
        break;
        case(ControlP5.ACTION_LEAVE): 
        println("primerResultado was Focus"); 
        primerResultado.setWidth(widthBuscar);
        break;
      }
    }
  }
  );


  segundoResultado.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        segundoBoton(); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        productDescription= " ";
        break;
        case(ControlP5.ACTION_MOVE): 
        println("segundoResultado is Focus");
        println(arreglo[1]);
        productDescription=arreglo[1];
        break;
      }
    }
  }
  );
  tercerResultado.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        tercerBoton(); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        productDescription= " ";
        break;
        case(ControlP5.ACTION_MOVE): 
        println("tercerResultado is Focus");
        println(arreglo[2]);
        productDescription=arreglo[2];
        break;
      }
    }
  }
  );


  size(1024, 700);        
  background(64, 183, 175);

  table = loadTable("./dataB.csv", "header");
  println(table.getRowCount() + " total rows in table");
  /*for (TableRow row : table.rows()) {
   
   id = row.getInt("ID");
   species = row.getString("PRODUCTO");
   name = row.getString("UNIDAD");
   
   println(name + " (" + species + ") has an ID of " + id);
   }*/
}


void draw() {


  background(#42b9b0);
  fill(248, 121, 43);
  noStroke();
  rect(0, 0, width, 150);

  fill(255);
  textSize(30);
  text("Punto de Venta: Xub Maiz ", 10, 25);
  int initialX=200;
  int initialY=160;
  int separacion=5;
  int altura=30;
  int anchoColum2=240;
  int anchoColum1=80;

  fill(#f87a2c);
  noStroke();
  rect(initialX, initialY, anchoColum1, altura);//0
  rect(initialX+separacion+anchoColum1, initialY, anchoColum2, altura);//1
  rect(initialX+2*separacion+anchoColum1+anchoColum2, initialY, 80, altura);//2
  rect(initialX+3*separacion+2*anchoColum1+anchoColum2, initialY, 80, altura);//3
  rect(initialX+4*separacion+3*anchoColum1+anchoColum2, initialY, 80, altura);//4
  rect(initialX+5*separacion+4*anchoColum1+anchoColum2, initialY, 80, altura);//5

  fill(255);
  textSize(20);
  text("NOTA", initialX+5, initialY+altura-separacion);
  text("PRODUCTO", initialX+5+separacion+anchoColum1, initialY+altura-separacion);
  text("UNIDAD", initialX+5+separacion+anchoColum1+anchoColum2, initialY+altura-separacion);
  text("CANTID", initialX+1+3*separacion+2*anchoColum1+anchoColum2, initialY+altura-separacion);
  text("$ C/U", initialX+5+4*separacion+3*anchoColum1+anchoColum2, initialY+altura-separacion);
  text("$ SUBT", initialX+5+5*separacion+4*anchoColum1+anchoColum2, initialY+altura-separacion);

  textSize(12);
  //textFont(arial)
  text("coded by imecatro.com ©", width/2 -100, height-15);

  //buscar.getText().length() >1
  if (keyPressed  ) {
    //  println(key);
    if (buscar.isFocus() && keyCode!=BACKSPACE) {
      functionBuscar("default");
    }
    if (outCantidad.isFocus()) {
      calcularSubtotal();
    }
  }
  if (buscar.getText().length()<1 ) {
    ocultarBotonesDesplegables();
  }
  

   fill(255);
   textSize(20);
   text("Description: " + productDescription,40,height-50 );

}
//en draw
void cambiarWidth() {
  primerResultado.setSize(100, 30);
}
String functionBuscar(String wordToSearch) {
  String palabras;
  if (wordToSearch=="default") {
    palabras=buscar.getText();
  } else {
    palabras=wordToSearch;
  }
  int longitudPalabras= palabras.length();
  if (longitudPalabras>1) {

    println("Buscando.." + palabras.toLowerCase());
    tableSearch = new Table();

    tableSearch.addColumn("points");
    tableSearch.addColumn("wordFind");
    tableSearch.addColumn("rowIndex");

    String palabrasMinus=palabras.replace("ó", "o");
    palabrasMinus=palabras.replace("á", "a");
    palabrasMinus=palabras.replace("é", "e");
    palabrasMinus=palabras.replace("í", "i");
    palabrasMinus=palabras.replace("ú", "u");

    palabrasMinus=palabrasMinus.replace("(", " ");
    palabrasMinus=palabrasMinus.replace(")", " ");
    palabrasMinus=palabrasMinus.replace(",", " ");
    palabrasMinus=palabrasMinus.replace("  ", " ");

    String[] palabrasSeparadas = split(palabrasMinus, ' ');
    println("New Line: "+palabrasSeparadas.length);
    for (int ind=0; ind< palabrasSeparadas.length; ind++) {
      print("\tword #"+ind+": " +palabrasSeparadas[ind]);
    }
    println("");
    char[] b =palabrasMinus.toLowerCase().toCharArray();

    int indexRow=0;
    for (TableRow row : table.rows()) {

      String checadorOriginal=row.getString("PRODUCTO")+"";      
      String checador = checadorOriginal.toLowerCase();
      char[] a =checador.toCharArray();
      int points=10;

      if (a[0]==b[0] && a[1]==b[1] ) {
        points=points+5;
      }

      if (palabrasMinus.length()>=3) {
        for (int i=0; i<(palabrasMinus.length()-2); i++) {
          for (int j=0; j<(checador.length()-2); j++) {
            if (b[i]==a[j] && b[i+1]==a[j+1]&& b[i+2]==a[j+2] ) {
              points=points+2;
            }
          }
        }
      }


      for (int ind=0; ind< palabrasSeparadas.length; ind++) {
        //print("\tword #"+ind+": " +palabrasSeparadas[ind]);
        if (palabrasSeparadas[ind].length()>2) {
          String[] m2 = match(checador, palabrasSeparadas[ind].toLowerCase());
          if (m2 != null) {  // If not null, then a match was found

            println("Found a match of: " +palabrasSeparadas[ind].toLowerCase()+" in '" + checador+"'");
            /*
             float mc=checador.length();
             float dinero=palabrasMinus.length();
             float matchRatio=dinero/mc;
             points += int(matchRatio*15.0);
             */
            points += 4;
          } else {
            if (palabrasSeparadas[ind].toLowerCase()=="jabón") {
              println("ese mi polo"+" in '" + checador+"'");
            }
          }
        }
      }

      /*
      String[] m2 = match(checador, palabrasMinus.toLowerCase());
       if (m2 != null) {  // If not null, then a match was found
       println("Found a match of: " +palabrasMinus.toLowerCase()+" in '" + checador+"'");
       float mc=checador.length();
       float dinero=palabrasMinus.length();
       float matchRatio=dinero/mc;
       points += int(matchRatio*15.0);
       } else {
       // println("No match found in '" + checadorOriginal + "'");
       }
       */
      TableRow result = table.findRow( checadorOriginal, "PRODUCTO");
      TableRow newRowJack = tableSearch.addRow();

      newRowJack.setInt("points", points);
      newRowJack.setString("wordFind", result.getString("PRODUCTO") );
      newRowJack.setInt("rowIndex", indexRow);
      indexRow++;
    }
    tableSearch.sortReverse("points");

    int indice=0;
    for (TableRow rowX : tableSearch.rows()) {

      int id2 = rowX.getInt("points");
      String species2 = rowX.getString("wordFind");
      int name2 = rowX.getInt("rowIndex");
      arreglo[indice]=species2;
      if (indice<=3) {
        indice++;
        println("points:"+id2+" words Array:"+species2 + " Index:"+name2);
      }
    }

    if (arreglo[0].length()>22) {
      primerResultado.setLabel(arreglo[0].substring(0, 22));
    } else {
      primerResultado.setLabel(arreglo[0]);
    }  
    if (arreglo[1].length()>22) {
      segundoResultado.setLabel(arreglo[1].substring(0, 22));
    } else {
      segundoResultado.setLabel(arreglo[1]);
    }
    if (arreglo[2].length()>22) {
      tercerResultado.setLabel(arreglo[2].substring(0, 22));
    } else {
      tercerResultado.setLabel(arreglo[2]);
    }

    primerResultado.show();
    segundoResultado.show();
    tercerResultado.show();
  } else {
    primerResultado.hide();
    segundoResultado.hide();
    tercerResultado.hide();
  }
  return arreglo[0];
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      println("arriba");
    } else if (keyCode == DOWN) {
      println("abajo");
    }
  } else if (keyCode==TAB) {
    println("TAB");//ENTER
  } else if (keyCode==BACKSPACE) {
    println("DELETE");//ENTER
  } else {
    println("OTRA entrada");
  }
}
void calcularSubtotal() {
  float productCantidad=float(outCantidad.getText())+0;
  float productPrice=float(outPrice.getText());
  float productPresent=float(outPresentacion.getText());
  float subtotal= (productCantidad*productPrice)/productPresent;
  outSubtotal.setText(str(subtotal));
}

void ocultarBotonesDesplegables() {
  primerResultado.hide();
  segundoResultado.hide();
  tercerResultado.hide();
}
void primerBoton() {
  TableRow filaParaAgregar= table.findRow(arreglo[0], "PRODUCTO");
  int id2 = filaParaAgregar.getInt("ID");
  String nameProduct = filaParaAgregar.getString("PRODUCTO");
  String unidad = filaParaAgregar.getString("UNIDAD");
  int price = filaParaAgregar.getInt("PRECIO UNITARIO");
  String presentacion = filaParaAgregar.getString("PRESENTACION");
  println("ID:"+id2 +" | "+nameProduct +" | "+ unidad + "| $"+price+" | PRESENTACION: "+presentacion);
  buscar.setText(nameProduct);
  outUnidad.setText(unidad);
  ocultarBotonesDesplegables();
  outPresentacion.setText(presentacion);
  outPrice.setText(str(price));
}

void segundoBoton() {
  TableRow filaParaAgregar= table.findRow(arreglo[1], "PRODUCTO");
  int id2 = filaParaAgregar.getInt("ID");
  String nameProduct = filaParaAgregar.getString("PRODUCTO");
  String unidad = filaParaAgregar.getString("UNIDAD");
  int price = filaParaAgregar.getInt("PRECIO UNITARIO");        
  String presentacion = filaParaAgregar.getString("PRESENTACION");
  println("ID:"+id2 +" | "+nameProduct +" | "+ unidad + "| $"+price+"PRESENTACION: "+presentacion);

  buscar.setText(nameProduct);
  outUnidad.setText(unidad);
  ocultarBotonesDesplegables();
  outPresentacion.setText(presentacion);
  outPrice.setText(str(price));
}

void tercerBoton() {
  TableRow filaParaAgregar= table.findRow(arreglo[2], "PRODUCTO");

  int id2 = filaParaAgregar.getInt("ID");
  String nameProduct = filaParaAgregar.getString("PRODUCTO");
  String unidad = filaParaAgregar.getString("UNIDAD");
  int price = filaParaAgregar.getInt("PRECIO UNITARIO");        
  String presentacion = filaParaAgregar.getString("PRESENTACION");
  println("ID:"+id2 +" | "+nameProduct +" | "+ unidad + "| $"+price+"PRESENTACION: "+presentacion);
  buscar.setText(nameProduct);
  outUnidad.setText(unidad);
  ocultarBotonesDesplegables();
  outPresentacion.setText(presentacion);
  outPrice.setText(str(price));
}

void echaleOtro() {
  //wachense esta poderosa función 

  String productName=buscar.getText();
  if (productName.length()>=2) {
    int productPzOption=int(outPiezas.getText())+0; 
    String productUnit=outUnidad.getText();
    float productCantidad=float(outCantidad.getText())+0.0;
    float productPrice=float(outPrice.getText())+0.0;
    ;
    float productPresent=float(outPresentacion.getText())+0.0;
    ;
    float subtotal= (productCantidad*productPrice)/productPresent+0.0;
    ;
    println("Agregando... " + productPzOption+"x"+productName +" | "+ productUnit +" | "+ productCantidad +" | "+productPrice +" | "+subtotal);

    String reglonProducto[]={notasArea.getText(), productArea.getText(), unidadArea.getText(), cantidadArea.getText(), precioArea.getText(), subtotalArea.getText()};// =  productPzOption +productName

    TableRow newRowJack = Ticket.addRow();
    if (productCantidad>0) {
      newRowJack.setString("Producto", productName);
      newRowJack.setString("Unidad", productUnit);
      newRowJack.setFloat("Cantidad", productCantidad);
      newRowJack.setFloat("Precio unitario", productPrice);
      newRowJack.setFloat("Total", subtotal);
      String productReplace=productName;
      if (productName.length()>40)
        productReplace=productName.substring(0, 40);
      String rowTable[]={"", productReplace, productUnit, str(productCantidad), str(productPrice), str(subtotal) };
      for (int indice=0; indice<6; indice++) {
        reglonProducto[indice] += rowTable[indice] +"\n";
      }
    } else {
      String cadenaN=productPzOption+"pzs "+productName;
      newRowJack.setString("Producto", cadenaN);
      newRowJack.setString("Unidad", productUnit);
      newRowJack.setString("Cantidad", " ");
      newRowJack.setFloat("Precio unitario", productPrice);
      newRowJack.setFloat("Total", 0);
      String productReplace=productName;
      if (productName.length()>40)
        productReplace=productName.substring(0, 40);
      String rowTable[]={productPzOption+"pzs", productReplace, productUnit, str(productCantidad), str(productPrice), str(subtotal) };
      for (int indice=0; indice<6; indice++) {

        reglonProducto[indice] += rowTable[indice] +"\n";
      }
    }
    // notasArea, productArea, unidadArea, cantidadArea, precioArea, subtotalArea;

    notasArea.setText(reglonProducto[0]);
    productArea.setText(reglonProducto[1]);
    unidadArea.setText(reglonProducto[2]);
    cantidadArea.setText(reglonProducto[3]);
    precioArea.setText(reglonProducto[4]);
    subtotalArea.setText(reglonProducto[5]);

    buscar.setText("");
    outPiezas.setText("");
    outUnidad.setText("");
    outCantidad.setText("");
    outPresentacion.setText("");
    outPrice.setText("");
    outSubtotal.setText("");
  }
}

void guardandoTicket() {

  int s = second();  // Values from 0 - 59
  int m = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23
  saveTable(Ticket, "/pedido-"+numeroPedido+"-"+h+"-"+m+"-"+s+".csv");
  numeroPedido++;
  println("Listo! csv guardada");
  notasArea.setText("");
  productArea.setText("");
  unidadArea.setText("");
  cantidadArea.setText("");
  precioArea.setText("");
  subtotalArea.setText("");
  Ticket.clearRows();
}
void fromTxtToCsv() {


  String[] lines = loadStrings("/prueba.txt");
  println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    String embeces= functionBuscar(lines[i]);
    TableRow filaParaAgregar= table.findRow(embeces, "PRODUCTO");
    String productName=filaParaAgregar.getString("PRODUCTO");
    String unidad = filaParaAgregar.getString("UNIDAD");
    int price = filaParaAgregar.getInt("PRECIO UNITARIO");
    lines[i] ='"'+ productName +'"'+","+ '"'+ lines[i] +'"'+ ","+unidad+",,"+price;
    println(lines[i]);
  }
  saveStrings("/ticket_auto.csv", lines);
}
void functionMas() {

  int productPresent=int(outPresentacion.getText());
  int cantidad=0;
  if (productPresent>0) {
    cantidad= int(outCantidad.getText()) +productPresent;
  } else {
    cantidad= int(outCantidad.getText()) +1;
  }

  outCantidad.setText(str(cantidad));
  calcularSubtotal();
  //println("productos "+cantidad);
}

void functionMenos() {

  int cantidad2= int(outCantidad.getText());
  int productPresent=int(outPresentacion.getText());
  if (cantidad2>0) {
    if (productPresent>0) {
      cantidad2= cantidad2 -productPresent;
    } else {
      cantidad2=cantidad2-1;
    }
  }

  outCantidad.setText(str(cantidad2));
  calcularSubtotal();
  //println("productos "+cantidad2);
}
