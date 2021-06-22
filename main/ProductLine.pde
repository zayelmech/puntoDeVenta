
public class ProductLine extends CallbackListener {
  //5 textInput
  Textfield campo1, campo2, campo3, campo4, campo5;

  int nPedido=0;
  int hField=20;
  int xInicial=200;
  int yInicial =195;


  //.setPosition(200, 195)
  //.setSize(80, 400)

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



    //cp5.get(Button.class, "X"+nPedido).setLabel("X");

    //borrar.addCallback(xyz);
    //borrar.setLabel("X");
  }
  public void actualizar(int nPedido, String[] atributos) {
    campo1.setText(atributos[0]);
    campo2.setText(atributos[1]);
    campo3.setText(atributos[2]);
    campo4.setText(atributos[3]);
    campo5.setText(atributos[4]);
  }
  void addEvent(int nPedido) {

    deleteProduct[nPedido].show();
  }
  void removerLinea(int indice) {
    Ticket.removeRow(indice);  // Removes the first row

    indice= producto -1;
    producto=0;
    //println("Objetos vacios"+indice);
    cp5.get(Textfield.class, "CamA"+indice).remove();
    cp5.get(Textfield.class, "CamB"+indice).remove();
    cp5.get(Textfield.class, "CamC"+indice).remove();
    cp5.get(Textfield.class, "CamD"+indice).remove();
    cp5.get(Textfield.class, "CamE"+indice).remove();
    deleteProduct[indice].hide();
    this.actualizar();
  }
  void remover(int indice) {

    cp5.get(Textfield.class, "CamA"+indice).remove();
    cp5.get(Textfield.class, "CamB"+indice).remove();
    cp5.get(Textfield.class, "CamC"+indice).remove();
    cp5.get(Textfield.class, "CamD"+indice).remove();
    cp5.get(Textfield.class, "CamE"+indice).remove();
    deleteProduct[indice].hide();
  }
  void actualizar() {
    for (TableRow row : Ticket.rows()) {

      String reglonProducto[]={row.getString("Producto"), row.getString("Unidad"), row.getString("Cantidad"), row.getString("Precio unitario"), row.getString("Total") };

      //println("add..."+ reglonProducto);
      //lineOfProduct[producto].actualizar(producto, reglonProducto);
      lineOfProduct.get(producto).actualizar(producto, reglonProducto);
      producto++;
    }
  }
}
