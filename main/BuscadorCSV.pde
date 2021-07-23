public class BuscadorCSV {

  private Table lista;
  private Textfield barraBusqueda;
  private CallbackListener cbBusqueda;
  private ControlListener enter;
  private Button botonBuscar;
  private int posX;
  private int posY;
  private int largo;
  private int alto;
  private int id;
  private int columna;
  private int buttonWidth =25;
  
  ArrayList<BotonesDesplegables> productoEncontrado = new ArrayList<BotonesDesplegables>();



  BuscadorCSV(Table listaC,int columna, int ID) {
    this.columna  = columna;
    this.lista = listaC;
    this.id = ID;
    barraBusqueda = cp5.addTextfield("barOfSearch"+ID);
  }

  public void setParametros(int posX, int posY, int largo, int alto) {
    this.posX = posX;
    this.posY = posY;
    this.largo = largo;
    this.alto = alto;

    cbBusqueda = new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        println("EVENTO #"+theEvent.getAction());
        
        switch(theEvent.getAction()) {
          case(ControlP5.ACTIVE):
            //println("Scroleando ando");
          break;
          case(ControlP5.PRESSED):
            buscarString(barraBusqueda.getText(), int(theEvent.getController().getValue()));
            println(":: "+theEvent.getController().getValue());
          break;
          case(ControlP5.ACTION_EXIT):
          println("Hasta la protsima");
          break;
        }
      }
    };

    enter= new ControlListener() {
      public void controlEvent(ControlEvent theEvent) {
        if (theEvent.isAssignableFrom(Textfield.class)) {
          println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
        }
      }
    };

    barraBusqueda
      .setSize(this.largo-buttonWidth, this.alto)
      .setPosition(this.posX, this.posY)
      .setFont(createFont("arial", 20))
      .setAutoClear(false)
      .setColor(color(#16557c))
      .setColorBackground(color(255))
      .setColorForeground(color(255))
      .setColorCursor(color(#A0A0A0))
      .addCallback(cbBusqueda)
      ;

    botonBuscar=cp5.addButton("S"+this.id)
      .setFont(createFont("arial", 18))
      .setPosition(this.posX+barraBusqueda.getWidth(), this.posY)
      .setSize(buttonWidth, barraBusqueda.getHeight())
      .setValue(this.columna)
      .onPress(cbBusqueda)
      .setLabel("O")
      ;
  }

  private void buscarString(String wordsToFind, int whatColumn ) {
    for (TableRow row : lista.matchRows(wordsToFind, whatColumn)) {
      println("Coincidencia: "+ row.getString(whatColumn)); 
    }
  }

  public boolean isFocus() {
    return barraBusqueda.isFocus();
  }


  public class BotonesDesplegables {
  }
}
