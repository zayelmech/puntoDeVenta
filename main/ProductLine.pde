
public class ProductLine {
  //5 textInput
  Textfield campo1, campo2, campo3, campo4, campo5;
  Button deleteProduct;
  CallbackListener cbDelete;

  int nPedido=0;
  int hField=20;
  int xInicial=200;
  int yInicial =195;

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
      .setText(atributos[0])
      ;
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
      .onPress(cbDelete)
      .setLabel("X");

    if (axisY>=595 || axisY<195  ) {
      campo1.hide();
      campo2.hide();
      campo3.hide();
      campo4.hide();
      campo5.hide();
      deleteProduct.hide();
    } else {
      campo1.show();
      campo2.show();
      campo3.show();
      campo4.show();
      campo5.show();
      deleteProduct.show();
    }
    //.setLabel("X")
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

  public void scroll(int delta) {

    int axisY=  yInicial + (hField+1)*this.nPedido  ;

    float[] posVerticalAbsoluta={campo1.getPosition()[0], float(axisY)};
    float[] posVerticalNew= {posVerticalAbsoluta[0], posVerticalAbsoluta[1]-delta*20};
    if (posVerticalNew[1]>=595 || posVerticalNew[1]<195  ) {
      campo1.hide();
      campo2.hide();
      campo3.hide();
      campo4.hide();
      campo5.hide();
      deleteProduct.hide();
    } else {
      campo1.show();
      campo2.show();
      campo3.show();
      campo4.show();
      campo5.show();
      deleteProduct.show();

      campo1.setPosition(posVerticalNew);
      campo2.setPosition(campo2.getPosition()[0], posVerticalNew[1]);
      campo3.setPosition(campo3.getPosition()[0], posVerticalNew[1]);
      campo4.setPosition(campo4.getPosition()[0], posVerticalNew[1]);
      campo5.setPosition(campo5.getPosition()[0], posVerticalNew[1]);
      deleteProduct.setPosition(deleteProduct.getPosition()[0], posVerticalNew[1]);
    }
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
      println("Producto: "+indice +" fue eliminado del csv Ticket");
    }    
    this.actualizarTodos();
  }

  void remover(int indice) {

    cp5.get(Textfield.class, "CamA"+indice).remove();
    cp5.get(Textfield.class, "CamB"+indice).remove();
    cp5.get(Textfield.class, "CamC"+indice).remove();
    cp5.get(Textfield.class, "CamD"+indice).remove();
    cp5.get(Textfield.class, "CamE"+indice).remove();
    cp5.get(Button.class, "X"+indice).remove();
  }

  void actualizarTodos() {
    producto =0;
    lineOfProduct.clear();
    totalAprox=0;
    for (TableRow row : Ticket.rows()) {
      remover(producto);      
      String reglonProducto[]={row.getString("Producto"), row.getString("Unidad"), row.getString("Cantidad"), row.getString("Precio unitario"), row.getString("Total") };
      lineOfProduct.add(new ProductLine(producto, reglonProducto));
      totalAprox+=row.getFloat("Total");

      producto++;
    }
  }
}
