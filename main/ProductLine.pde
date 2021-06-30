
public class ProductLine {
  //5 textInput
  Textfield campo1, campo2, campo3, campo4, campo5;
  Button deleteProduct;
  CallbackListener cbDelete;

  int nPedido=0;
  int hField=20;
  int xInicial=200;
  int yInicial =195;
  
  /*
   = cp5.addButton("exper")
   .setFont(createFont("arial",18))
   .setPosition(23,23)
   .setSize(25, 50)
   .setValue(1)
   .setId(1)
   .setLabel("X")
   .addCallback(cbExp);
   */

  ProductLine(int nPedido, String[] atributos) {
    this.nPedido = nPedido;
    int axisY=  yInicial + (hField+1)*nPedido  ;

    campo1 = cp5.addTextfield("CamA"+nPedido, xInicial, axisY, 325, hField)
      .setFont(createFont("arial", 14))
      .setAutoClear(false)
      .setColor(color(#16557c))
      .setColorBackground(color(255))
      .setColorForeground(color(255))
      .setColorCursor(color(#A0A0A0))
      .setText(atributos[0]);

    campo2 = cp5.addTextfield("CamB"+nPedido, xInicial+330, axisY, 80, hField)
      .setFont(createFont("arial", 14))
      .setAutoClear(false)
      .setColor(color(#16557c))
      .setColorBackground(color(255))
      .setColorForeground(color(255))
      .setColorCursor(color(#A0A0A0))
      .setText(atributos[1]);

    campo3 = cp5.addTextfield("CamC"+nPedido, xInicial+415, axisY, 80, hField)
      .setFont(createFont("arial", 14))
      .setAutoClear(false)
      .setColor(color(#16557c))
      .setColorBackground(color(255))
      .setColorForeground(color(255))
      .setColorCursor(color(#A0A0A0))
      .setText(atributos[2]);

    campo4 = cp5.addTextfield("CamD"+nPedido, xInicial+500, axisY, 80, hField)
      .setFont(createFont("arial", 14))
      .setAutoClear(false)
      .setColor(color(#16557c))
      .setColorBackground(color(255))
      .setColorForeground(color(255))
      .setColorCursor(color(#A0A0A0))
      .setText(atributos[3]);

    campo5 = cp5.addTextfield("CamE"+nPedido, xInicial+585, axisY, 80, hField)
      .setFont(createFont("arial", 14))
      .setAutoClear(false)
      .setColor(color(#16557c))
      .setColorBackground(color(255))
      .setColorForeground(color(255))
      .setColorCursor(color(#A0A0A0))
      .setText(atributos[4]);

    campo1.getCaptionLabel().setVisible(false);
    campo2.getCaptionLabel().setVisible(false);
    campo3.getCaptionLabel().setVisible(false);
    campo4.getCaptionLabel().setVisible(false);
    campo5.getCaptionLabel().setVisible(false);

    cbDelete =new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        switch(theEvent.getAction()) {
          case(ControlP5.ACTION_PRESSED):
          println(theEvent.getController().getInfo());

          int lineToDelete= int(theEvent.getController().getValue());

          lineOfProduct.get(lineToDelete).removerLinea(lineToDelete);
          try {
            lineOfProduct.remove(Ticket.lastRowIndex());
          }
          catch(Exception e)
          {
            println(e);
          }
          break;
          case(ControlP5.ACTION_RELEASED):
          println("adios");
          break;
        }
      }
    };
    
    
    deleteProduct= cp5.addButton("X"+nPedido)
      .setFont(createFont("arial", 18))
      .setPosition(xInicial+585+85, axisY)
      .setSize(25, hField)
      .setValue(nPedido)
      .setId(nPedido)
      .setLabel("X")
      .onPress(cbDelete);
      
  }
  public void actualizar(int nPedido, String[] atributos) {
    
    campo1.setText(atributos[0]);
    campo2.setText(atributos[1]);
    campo3.setText(atributos[2]);
    campo4.setText(atributos[3]);
    campo5.setText(atributos[4]);
    deleteProduct.setValue(nPedido);
  }
  void addEvent(int nPedido) {

    //deleteProduct[nPedido].show();
  }

  public void removerLinea(int indice) {

    //println("Numero de filas en el Ticket"+ Ticket.lastRowIndex());

    cp5.get(Textfield.class, "CamA"+Ticket.lastRowIndex()).remove();
    cp5.get(Textfield.class, "CamB"+Ticket.lastRowIndex()).remove();
    cp5.get(Textfield.class, "CamC"+Ticket.lastRowIndex()).remove();
    cp5.get(Textfield.class, "CamD"+Ticket.lastRowIndex()).remove();
    cp5.get(Textfield.class, "CamE"+Ticket.lastRowIndex()).remove();
    cp5.get(Button.class, "X"+Ticket.lastRowIndex()).remove();

    if (indice>=0) {
      Ticket.removeRow(indice);
      println("Producto: "+indice +"fue eliminado del csv Ticket");
    }    
    //println("Numero de filas en el Ticket"+ Ticket.lastRowIndex());

    this.actualizarTodos();
  }

  void remover(int indice) {

    cp5.get(Textfield.class, "CamA"+indice).remove();
    cp5.get(Textfield.class, "CamB"+indice).remove();
    cp5.get(Textfield.class, "CamC"+indice).remove();
    cp5.get(Textfield.class, "CamD"+indice).remove();
    cp5.get(Textfield.class, "CamE"+indice).remove();
    cp5.get(Button.class, "X"+indice).remove();
    //deleteProduct[indice].hide();
  }

  void actualizarTodos() {
    producto =0;
    for (TableRow row : Ticket.rows()) {
      
      String reglonProducto[]={row.getString("Producto"), row.getString("Unidad"), row.getString("Cantidad"), row.getString("Precio unitario"), row.getString("Total") };
      lineOfProduct.get(producto).actualizar(producto, reglonProducto);
      producto++;
    }
  }
}
