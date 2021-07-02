/* 
 Code by: Abdiel Carreño 
 Github: zayelmech
 Web: www.imecatro.com
 version:1.0
 Año: 2021
 */

import controlP5.*;
import java.util.*;

ControlP5 cp5; 
Textfield cliente, buscar, outUnidad, outCantidad, outPrice, outPiezas, outPresentacion, outSubtotal;
Button signoMas2, signoMenos2, signoMas, signoMenos, primerResultado, segundoResultado, tercerResultado, botonAgregar, botonSalvarCSV, botonCargarTxt;
//Textarea notasArea, productArea, unidadArea, cantidadArea, precioArea, subtotalArea;
Button plusMidKg, plusQuaKg, subMidKg, subQuaKg; 

Table table, tableSearch, Ticket, ticketHeader, clientesTable;
int id, producto=0;
String name, species, productDescription= ""; 

int numeroPedido =1;
int widthBuscar=370;
int widthTextSmall=40;
int separacion=20;
int posYsearch=50;


String palabraAnterior;
boolean buscarClicked=false;

String arreglo[]={"", "", "", "", ""};
CallbackListener cb, cbList, cbPrueba;

ArrayList<ProductLine> lineOfProduct = new ArrayList<ProductLine>();
Slider sliderArea;

void setup() {


  cp5 = new ControlP5(this);

  Ticket = new Table();
  Ticket.addColumn("Producto");
  Ticket.addColumn("Unidad");
  Ticket.addColumn("Cantidad");
  Ticket.addColumn("Precio unitario");
  Ticket.addColumn("Total");

  try {

    clientesTable = loadTable("./data/clientes.csv", "header");
    println(clientesTable.getRowCount()+" Clientes registrados");
  }
  catch(Exception e) {
    println(e);
  }
  BuscadorCSV buscadorClientes = new BuscadorCSV(clientesTable, "Nombre", 1);

  buscadorClientes.setParametros(20, 250, 150, 30);

  cbPrueba = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      println("Haciendo algo"+theEvent.getAction());

      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_WHEEL):
        //println(theEvent.getController().getInfo());
        println("scrolling...");

        for (int i=0; i<lineOfProduct.size(); i++) {
          lineOfProduct.get(i).scroll(int(sliderArea.getValue()));
        }
        break;
        case(ControlP5.ACTION_RELEASE):
        for (int i=0; i<lineOfProduct.size(); i++) {
          lineOfProduct.get(i).scroll(int(sliderArea.getValue()));
        }

        //lineOfProduct.get(0).scroll(int(sliderArea.getValue()));
        break;
        case(ControlP5.ACTION_EXIT):
        println("adios");
        break;
      }
    }
  };
  //170
  sliderArea= cp5.addSlider("sliderTicks2")
    .setPosition(175, 195)
    .setSize(20, 400)
    .setRange(100, 0) // values can range from big to small as well
    .setValue(0)
    .setScrollSensitivity(0.5)
    .setHandleSize(20)
    .setColorForeground(color(#16557c))
    .setColorBackground(color(125))
    .setSliderMode(Slider.FLEXIBLE)
    .setLabelVisible(false)
    .addCallback(cbPrueba)
    .hide()
    ;

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



  cb = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED):

        println(theEvent.getController().getInfo());
        if (theEvent.getController().getValue()>=0) {
          functionMas(0, theEvent.getController().getValue());
        } else {
          functionMenos(0);
        }
        break;
        case(ControlP5.ACTION_RELEASED):
        println("adios");
        break;
      }
    }
  };

  cbList = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      int indice= int(theEvent.getController().getValue());
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        productoSeleccionado(arreglo[indice]); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        productDescription= " ";
        break;
        case(ControlP5.ACTION_MOVE): 
        println("primerResultado is Focus");
        println(arreglo[indice]);
        productDescription=arreglo[indice];
        break;
      }
    }
  };
  /*
  int hField=20;
   int xInicial=200;
   int yInicial =195;
   
   for (int i=0; i<19; i++) {
   
   int axisY=  yInicial + (hField+1)*i ;
   
   deleteProduct[i] = cp5.addButton("X"+i)
   .setFont(createFont("arial", 18))
   .setPosition(xInicial+585+85, axisY)
   .setSize(25, hField)
   .setValue(i)
   .setId(i)
   .setLabel("X")
   .hide()
   .addCallback(cbDelete);
   }
   */
  //deleteProduct[producto]

  //Flujo normal
  //plusMidKg, plusQuaKg,subMidKg,subQuaKg; 
  cliente =cp5.addTextfield("Cliente", width/2 -widthBuscar-120, 160, 150, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorCursor(color(#A0A0A0));
  ;

  plusMidKg = cp5.addButton("+ 1/2kg")
    .setFont(createFont("arial", 14))
    .setPosition(width/2 +140, 110 )
    .setSize(75, 25)
    .setValue(0.5);

  plusMidKg.addCallback(cb);

  plusQuaKg = cp5.addButton("+ 1/4kg")
    .setFont(createFont("arial", 14))
    .setPosition(width/2+60, 110 )
    .setSize(75, 25)  
    .setValue(0.25);

  plusQuaKg.addCallback(cb);

  signoMenos2 = cp5.addButton("- ")
    .setFont(createFont("arial", 20))
    .setPosition(width/2 -40- 101-35, 90 )
    .setSize(35, 30)
    .hide(); 

  outPresentacion=cp5.addTextfield("Presentacion", width/2 -40-70-35, 90, 70, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .hide();


  signoMas2 = cp5.addButton(" +")
    .setFont(createFont("arial", 20))
    .setPosition(width/2 -40-35, 90)
    .setSize(35, 30)
    .hide();

  outPiezas=cp5.addTextfield("pzs", 20, posYsearch, 40, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorCursor(color(#A0A0A0));

  buscar = cp5.addTextfield("Buscar", width/2 - widthBuscar-40, posYsearch, widthBuscar, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorCursor(color(#A0A0A0));


  float posElementBefore[] = buscar.getPosition();
  int posNextX=int(posElementBefore[0]+float(buscar.getWidth()));

  primerResultado = cp5.addButton("Result_1")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX-widthBuscar, posYsearch+30)
    .setSize(widthBuscar, 30)
    .setColorBackground(color(#d79d6a))
    .setColorForeground(color(#f87a2c))
    .setValue(0)
    .hide()    ; 
  segundoResultado = cp5.addButton("Result_2")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX-widthBuscar, posYsearch+60)
    .setSize(widthBuscar, 30)
    .setColorBackground(color(#d79d6a))
    .setColorForeground(color(#f87a2c))
    .setValue(1)
    .hide(); 
  tercerResultado = cp5.addButton("Result_3")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX-widthBuscar, posYsearch+90)
    .setSize(widthBuscar, 30)
    .setColorBackground(color(#d79d6a))
    .setColorForeground(color(#f87a2c))
    .setValue(2)
    .hide(); 

  outUnidad = cp5.addTextfield("Unidad", posNextX + separacion, posYsearch, widthTextSmall, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorCursor(color(#A0A0A0));


  posElementBefore = outUnidad.getPosition();
  posNextX=int(posElementBefore[0]+float(outUnidad.getWidth()));

  signoMenos = cp5.addButton("-")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX+separacion*3, posElementBefore[1])
    .setSize(35, 30)
    .setValue(-1);
  //.setColorBackground(color(248, 121, 43));

  posElementBefore = signoMenos.getPosition();
  posNextX=int(posElementBefore[0]+float(signoMenos.getWidth()));

  outCantidad = cp5.addTextfield("Cant.", posNextX, posYsearch, widthTextSmall, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorCursor(color(#A0A0A0));

  posElementBefore = outCantidad.getPosition();
  posNextX=int(posElementBefore[0]+float(outCantidad.getWidth()));

  signoMas = cp5.addButton("+")
    .setFont(createFont("arial", 20))
    .setPosition(posNextX+1, posYsearch)
    .setSize(35, 30)
    .setValue(1);

  posElementBefore = signoMas.getPosition();
  posNextX=int(posElementBefore[0]+float(signoMas.getWidth()));

  outPrice=cp5.addTextfield("$ c/u", posNextX+30, posYsearch, int(widthTextSmall*1.5), 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorCursor(color(#A0A0A0));

  posElementBefore = outPrice.getPosition();
  posNextX=int(posElementBefore[0]+float(outPrice.getWidth()));

  outSubtotal=cp5.addTextfield("$Total", posNextX+30, posYsearch, widthTextSmall*2, 30)
    .setFont(createFont("arial", 20))
    .setAutoClear(false)
    .setColor(color(#16557c))
    .setColorBackground(color(255))
    .setColorForeground(color(255))
    .setColorCursor(color(#A0A0A0));

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
    .setPosition(posNextX, 595-30)
    .setSize(100, 30);

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

  signoMenos.addCallback(cb);
  signoMas.addCallback(cb);

  signoMenos2.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        functionMenos(1); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        break;
      }
    }
  }
  );


  signoMas2.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_PRESSED): 
        functionMas(1, 0); 
        break;
        case(ControlP5.ACTION_RELEASED): 
        println("stop"); 
        break;
      }
    }
  }
  );



  primerResultado.addCallback(cbList);
  segundoResultado.addCallback(cbList);
  tercerResultado.addCallback(cbList);


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

  // selectInput("Select a file to process:", "fileSelected");
}

int sombra=0;
int mode=1;
int timeOld=millis();
float xCircle=0;
float yCircle=0;
void draw() {

  sombra=sombra+mode;

  if (sombra >220)
  {
    sombra=220;
    mode=-1;
  }
  if (sombra<100) {
    sombra=100;

    mode=1;
  }


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
  rect(initialX, initialY, anchoColum1 +5+ anchoColum2, altura);//1
  rect(initialX+2*separacion+anchoColum1+anchoColum2, initialY, 80, altura);//2
  rect(initialX+3*separacion+2*anchoColum1+anchoColum2, initialY, 80, altura);//3
  rect(initialX+4*separacion+3*anchoColum1+anchoColum2, initialY, 80, altura);//4
  rect(initialX+5*separacion+4*anchoColum1+anchoColum2, initialY, 80, altura);//5
  fill(235);//220
  rect(initialX, initialY+35, 665, 400);

  fill(255);
  textSize(20);
  text("PRODUCTO", initialX+5, initialY+altura-separacion);
  text("UNIDAD", initialX+5+separacion+anchoColum1+anchoColum2, initialY+altura-separacion);
  text("CANTID", initialX+1+3*separacion+2*anchoColum1+anchoColum2, initialY+altura-separacion);
  text("$ C/U", initialX+5+4*separacion+3*anchoColum1+anchoColum2, initialY+altura-separacion);
  text("$ SUBT", initialX+5+5*separacion+4*anchoColum1+anchoColum2, initialY+altura-separacion);

  textSize(12);
  //textFont(arial)
  text("coded by imecatro.com ©", width/2 -100, height-15);

  //random stars
  fill(sombra);//220
  int timeNow =millis();

  if ((timeNow - timeOld)>1000) {
    xCircle=random(665)+200;
    yCircle=random(400)+initialY+35;
    timeOld= timeNow;
  }
  circle(xCircle, yCircle, 15);

  if (!buscar.isFocus()) {
    primerResultado.hide();
    segundoResultado.hide();
    tercerResultado.hide();
  }

  //buscar.getText().length() >1
  if (keyPressed  ) {
    //  println(key);
    if (buscar.isFocus() && keyCode!=BACKSPACE) {
      functionBuscar("default");
    }
    if (outCantidad.isFocus() || outPrice.isFocus() ) {
      calcularSubtotal();
    }
  }

  if (buscar.getText().length()<1 ) {
    ocultarBotonesDesplegables();
  }


  fill(255);
  textSize(20);
  text("Description: " + productDescription, 40, height-50 );
}
//en draw

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
        String[] match2=null;
        if (palabrasSeparadas[ind].length()>2) {
          try {
            String[] m2 = match(checador, palabrasSeparadas[ind].toLowerCase());
            match2=m2;
          }
          catch(Exception e) {
            e.printStackTrace();
          }
          if (match2 != null) {  // If not null, then a match was found

            println("Found a match of: " +palabrasSeparadas[ind].toLowerCase()+" in '" + checador+"'");
            points += 4;
          } else {
            if (palabrasSeparadas[ind].toLowerCase()=="jabón") {
              println("ese mi polo"+" in '" + checador+"'");
            }
          }
        }
      }

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
    int maxChars= primerResultado.getWidth()/14;

    if (arreglo[0].length()>=maxChars) {
      primerResultado.setLabel(arreglo[0].substring(0, maxChars));
    } else {
      primerResultado.setLabel(arreglo[0]);
    }  
    if (arreglo[1].length()>=maxChars) {
      segundoResultado.setLabel(arreglo[1].substring(0, maxChars));
    } else {
      segundoResultado.setLabel(arreglo[1]);
    }
    if (arreglo[2].length()>=maxChars) {
      tercerResultado.setLabel(arreglo[2].substring(0, maxChars));
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
    println("OTRA entrada"+key);
  }
}
void calcularSubtotal() {

  float productCantidad=float(outCantidad.getText());
  float productPrice=float(outPrice.getText());
  //float productPresent=float(outPresentacion.getText());
  float subtotal;
  if ( !outCantidad.getText().isEmpty() && !outPrice.getText().isEmpty()) {
    subtotal= (productCantidad*productPrice)+0.0;//productPresent;
  } else {
    subtotal =0;
  }
  outSubtotal.setText(str(subtotal));
}

void ocultarBotonesDesplegables() {
  primerResultado.hide();
  segundoResultado.hide();
  tercerResultado.hide();
}

void productoSeleccionado(String producto) {

  TableRow filaParaAgregar= table.findRow(producto, "PRODUCTO");
  int id2 = filaParaAgregar.getInt("ID");
  String nameProduct = filaParaAgregar.getString("PRODUCTO");
  String unidad = filaParaAgregar.getString("UNIDAD");
  float price = filaParaAgregar.getFloat("PRECIO UNITARIO");
  String presentacion = filaParaAgregar.getString("PRESENTACION");
  println("ID:"+id2 +" | "+nameProduct +" | "+ unidad + "| $"+price+" | PRESENTACION: "+presentacion);
  buscar.setText(nameProduct);
  outUnidad.setText(unidad);

  if (unidad.equals("pz")) {
    outPiezas.hide();
  } else {
    outPiezas.show();
  }

  if (presentacion.isEmpty()) {
    signoMas2.hide();
    signoMenos2.hide();
    outPresentacion.hide();
  } else {
    signoMas2.show();
    signoMenos2.show();
    outPresentacion.show();
  }
  outPresentacion.setText(presentacion);
  outPrice.setText(str(price));
  ocultarBotonesDesplegables();
  outCantidad.setText("0");
  outSubtotal.setText("0");
}


void echaleOtro() {
  //wachense esta poderosa función 

  String productName=buscar.getText();
  if (!productName.isEmpty()) {
    int productPzOption=int(outPiezas.getText())+0; 
    String productUnit=outUnidad.getText();
    float productCantidad=float(outCantidad.getText())+0.0;
    float productPrice=float(outPrice.getText())+0.0;
    // float productPresent=1.0;//float(outPresentacion.getText())+0.0;
    float subtotal=float(outSubtotal.getText());///productPresent+0.0;
    //juntar nombre y presentacion 

    TableRow newRowJack = Ticket.addRow();
    if (productCantidad==0) {
      productName=productPzOption+"pzs "+productName;
    } 
    newRowJack.setString("Producto", productName);
    newRowJack.setString("Unidad", productUnit);
    newRowJack.setFloat("Cantidad", productCantidad);
    newRowJack.setFloat("Precio unitario", productPrice);
    newRowJack.setFloat("Total", subtotal);

    String reglonProducto[]={productName, productUnit, str(productCantidad), str(productPrice), str(subtotal) };


    println("Agregando... No."+producto+ " --" + productPzOption+"x"+productName +" | "+ productUnit +" | "+ productCantidad +" | "+productPrice +" | "+subtotal);
    println(reglonProducto);

    //String newProduct[] = {reglonProducto[0], reglonProducto[1], reglonProducto[2], reglonProducto[3], reglonProducto[4]};
    lineOfProduct.add(new ProductLine(producto, reglonProducto));
    /*
    for (int i=0; i<22; i++) {
      lineOfProduct.add(new ProductLine(producto, reglonProducto));
      producto++;
    }
    */
    int excedente=0;
    if (lineOfProduct.size()>20) {
      sliderArea.show();
      excedente=lineOfProduct.size()-20;
    }
    int alturaMax = sliderArea.getHeight();
    int alturaMin = 20;
    int alturaActual=20;
    if (alturaMax-excedente*alturaMin >=alturaMin) {
      alturaActual=alturaMax-excedente*alturaMin;
    }
    sliderArea.setHandleSize(alturaActual);
    sliderArea.setRange(excedente, 0);
    println(excedente+" Esto esta de sobra");
    //lineOfProduct[producto]= new ProductLine(producto, reglonProducto);
    //lineOfProduct[producto].addEvent(producto);

    //callbackOf(producto);
    //cp5.get(Button.class, "X"+producto).addCallback(cb);
    producto++;

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
  String nameClient = cliente.getText()+"_Xub";
  
  
  
  cliente.setText("");
  saveTable(Ticket, "/order_"+numeroPedido+"_"+nameClient+".csv");
  numeroPedido++;
  println("Listo! csv guardada");
  println("Tamaño de objetos lineOfProduct = "+lineOfProduct.size());
  println("Tamaño de ticket = "+Ticket.getRowCount());
  
  for (int i=0; i<Ticket.getRowCount(); i++) {
    try {
      lineOfProduct.get(i).remover(i);
      
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }
  lineOfProduct.clear();
  
  producto =0;
  //notasArea.setText("");

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
void functionMas(int mode, float value) {

  float sumando=1.0;
  String unit = outUnidad.getText();
  String productPresent= outPresentacion.getText();
  String salida[]={"", ""};

  if (!productPresent.isEmpty()) {
    try {
      salida=split(productPresent, ' ' );
      println("datos: " + salida[0] +" / "+ salida[1] +" / "+unit );
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }

  switch(mode) {
  case 0: 
    sumando=value;     
    break;

  case 1:
    if (salida[1].equals("grs") && unit.equals("kg") ) {
      sumando = float(salida[0])/1000;
    } else if (!salida[1].equals("grs") && unit.equals("kg")) {
      sumando = value;
    } else {
      sumando =1.0;
    }
    break;
  }

  float cantidad;
  float cantidadActual;
  if (outCantidad.getText().isEmpty()) {
    cantidadActual=0;
  } else {
    cantidadActual=float(outCantidad.getText());
  }

  cantidad= cantidadActual + sumando;
  int x = str(cantidad).length();
  if (x>4) {
    outCantidad.setText(str(cantidad).substring(0, 4));
  } else {
    outCantidad.setText(str(cantidad));
  }

  calcularSubtotal();
}

void functionMenos(int mode ) {
  float  sumando=1.0;
  String unit = outUnidad.getText();
  String productPresent= outPresentacion.getText();
  String salida[]={"", ""};

  if (!productPresent.isEmpty()) {
    try {
      salida=split(productPresent, ' ' );
      println("datos: " + salida[0] +" / "+ salida[1] +" / "+unit );
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }

  switch(mode) {
  case 0: 
    sumando=1.0;     
    break;

  case 1:

    if (salida[1].equals("grs") && unit.equals("kg")) {
      sumando = float(salida[0])/1000;
      println("sirviendo al pueblo " + sumando);
    } else {
      sumando =1.0;
    }
    break;
  }

  float cantidad;
  float cantidadActual;
  if (outCantidad.getText().isEmpty()) {
    cantidadActual=0;
  } else {
    cantidadActual=float(outCantidad.getText());
  }

  cantidad= cantidadActual - sumando;
  if (cantidad < 0) {
    cantidad=0;
  }

  int x = str(cantidad).length();
  if (x>4) {
    outCantidad.setText(str(cantidad).substring(0, 4));
  } else {
    outCantidad.setText(str(cantidad));
  }
  calcularSubtotal();
  //println("productos "+cantidad2);
}
