import 'tarjeta.dart';

class ListaTarjetas {
  static Map<int, Tarjeta> datos = {};
  static int _id = 0;

  static void insertar(Tarjeta t) {
    t.id = _id++;
    datos[t.id] = t;
  }

  static void eliminar(int id) {
    datos.remove(id);
  }

  static List<Tarjeta> obtener() {
    return datos.values.toList();
  }
}
