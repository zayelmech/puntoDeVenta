public class BuscadorCSV {

  private Table lista;
  Textfield barraBusqueda;
  CallbackListener cbBusqueda;
  ControlListener enter;
  private int posX;
  private int posY;
  private int largo;
  private int alto;

  ArrayList<BotonesDesplegables> productoEncontrado = new ArrayList<BotonesDesplegables>();



  BuscadorCSV(Table listaC, String columna, int ID) {
    this.lista = listaC;
    barraBusqueda = cp5.addTextfield("barOfSearch"+ID);
  }

  public void setParametros(int posX, int posY, int largo, int alto) {
    this.posX = posX;
    this.posY = posY;
    this.largo = largo;
    this.alto = alto;
    
    cbBusqueda = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      println("Haciendo algo"+theEvent.getAction());
      
      switch(theEvent.getAction()) {
        case(ControlP5.ACTIVE):
        //println(theEvent.getController().getInfo());
        println("Scroleando ando");
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
      .setSize(this.largo, this.alto)
      .setPosition(this.posX, this.posY)
      .setFont(createFont("arial", 20))
      .setAutoClear(false)
      .setColor(color(#16557c))
      .setColorBackground(color(255))
      .setColorForeground(color(255))
      .setColorCursor(color(#A0A0A0))
      .addCallback(cbBusqueda);

  }

  public void buscarString(String wordsToFind) {
  
  }
  
  public boolean isFocus(){
    return barraBusqueda.isFocus();
  }
  

  public class BotonesDesplegables {


    ArrayList<Button> BotonDesplegable = new ArrayList<Button>();
    
    
  }
}
