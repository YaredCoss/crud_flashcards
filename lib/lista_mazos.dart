import 'mazo.dart';

class ListaMazos {
  static Map<int, Mazo> datosMazos = {};
  static int _id = 0;

  static void insertar(Mazo m) {
    m.id = _id++;
    datosMazos[m.id] = m;
  }

  static void actualizar(Mazo m) {
    datosMazos[m.id] = m;
  }

  static void eliminar(int id) {
    datosMazos.remove(id);
  }

  static List<Mazo> obtener() {
    return datosMazos.values.toList();
  }
}
