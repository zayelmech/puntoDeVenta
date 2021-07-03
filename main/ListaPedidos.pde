
public class ListaPedidos extends tablaCSV implements interfaceListaMetodos {

  ListaPedidos(String archivo) {
    super(archivo);
  }

  public void agregarProducto(String[] rowOfProduct) {
    TableRow filaDeProducto;


    //filaDeProducto = super.getTable().findRow(rowOfProduct[0], 0);
    //println("Se encontró el producto: "+filaDeProducto.getString(1));
    boolean encontrado =false;

    int filaIndex =0;
    for (TableRow row : super.getTable().rows()) {
      try {
        if (row.getString(0).equals(rowOfProduct[0])) {
          filaDeProducto= row;
          println("Producto encontrado en la lista :: " + row.getString(0));

          float cantidadToAdd = filaDeProducto.getFloat(3) + float(rowOfProduct[3]);
          super.modificarFila(filaIndex, 3, str(cantidadToAdd));  

          String clientesToAdd =filaDeProducto.getString(5)+"," +rowOfProduct[5];
          super.modificarFila(filaIndex, 5, clientesToAdd);
          
          float pzsToAdd =filaDeProducto.getFloat(6) +float(rowOfProduct[6]);
          super.modificarFila(filaIndex, 6, str(pzsToAdd));
          
          
          encontrado =true;
        }
      }
      catch(Exception e) {
        println(e);
      }
      filaIndex++;
    }



    if (encontrado==false) {
      println("Producto NO encontrado en la lista");
      super.agregarFila(rowOfProduct);      
      println("El producto ya fue agregado a la lista");
    }
  }
}
