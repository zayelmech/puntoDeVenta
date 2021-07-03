public class tablaCSV {

  private Table tableCSV = new Table();

  tablaCSV(String[] cabecera) {

    for (int i=0; i<cabecera.length; i++) {
      this.tableCSV.addColumn(cabecera[i]);

      println(cabecera[i]);
    }
  }

  public tablaCSV(String ruta) { 
    try {
      this.tableCSV = loadTable("./PedidosNuevos.csv", "header");
    }
    catch(Exception e) {
      println(e);
    }
  }

  void agregarFila(String[] datos ) {
    if (datos.length == tableCSV.getColumnCount()) {

      TableRow newRow = this.tableCSV.addRow();
      for (int i =0; i<datos.length; i++) {
        String texto= datos[i];
        newRow.setString(i, texto);
      }
    } else {
      println("Error 406 :: Tamaño de arreglo no coincide con #columnas en la tabla destino");
    }
  }

  void modificarFila(int fila, int columna, String newString) {

    TableRow result = tableCSV.getRow(fila);
    println("Texto anterior: " + result.getString(columna));
    result.setString(columna, newString);
  }

  void eliminarFila(int id) {

    tableCSV.removeRow(id);
  }

  void guardarComo(String nameOfFile) {

    saveTable(this.tableCSV, nameOfFile+".csv");
  }

  void ordenarTabla(int columnNumber) {
    this.tableCSV.sort(columnNumber);
  }

  public Table getTable() {
    return this.tableCSV;
  }
}
