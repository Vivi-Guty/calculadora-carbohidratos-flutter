// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

/// Definición de una interfaz para la relación de carbohidratos
abstract class CarbohydrateRatio {
  /// * [gramsMaltodextrin] es la cantidad de maltodextrina en gramos.
  /// * [gramsFructose] es la cantidad de fructosa en gramos.
  double get gramsMaltodextrin; // Gramos de maltodextrina
  double get gramsFructose; // Gramos de fructosa
}

/// Definición de una interfaz para la relación de componentes
abstract class Ratio {
  /// * [maltodextrin] es el porcentaje de maltodextrina.
  /// * [fructose] es el porcentaje de fructosa.
  double get maltodextrin; // Porcentaje de maltodextrina
  double get fructose; // Porcentaje de fructosa
}

// Servicio compartido que calcula los carbohidratos basados en la relación y concentración
class SharedService {
  /// Calcula los carbohidratos totales y los distribuye según la relación dada.
  ///
  /// * [ml] es el volumen en mililitros.
  ///
  /// * [concentration] es la concentración de carbohidratos en porcentaje.
  ///
  /// * [ratio] es la relación de maltodextrina a fructosa.
  CarbohydrateRatio calculateCarbohydrates(
      int ml, int concentration, Ratio ratio) {
    double totalCarbohydrate = ml * (concentration / 100);
    double partsTotals = ratio.maltodextrin + ratio.fructose;

    return CarbohydrateRatioImpl(
      gramsMaltodextrin:
          (totalCarbohydrate * (ratio.maltodextrin / partsTotals)),
      gramsFructose: (totalCarbohydrate * (ratio.fructose / partsTotals)),
    );
  }
}

/// Servicio controlador para manejar incrementos y decrementos de valores en TextEditingController
class ControllerService {
  /// Incrementa el valor del controlador por un valor especificado.
  ///
  /// * [controller] es el controlador del campo de texto.
  ///
  /// * [incrementValue] es el valor a incrementar.
  void increment(TextEditingController controller, int incrementValue) {
    int currentValue = int.tryParse(controller.text) ?? 0;
    currentValue += incrementValue;
    controller.text = currentValue.toString();
  }

  /// Decrementa el valor del controlador por un valor especificado.
  ///
  /// * [controller] es el controlador del campo de texto.
  ///
  /// * [decrementValue] es el valor a decrementar.
  void decrement(TextEditingController controller, int decrementValue) {
    int currentValue = int.tryParse(controller.text) ?? 0;
    if (currentValue - decrementValue >= 0) {
      currentValue -= decrementValue;
      controller.text = currentValue.toString();
    }
  }

  /// Limpia el valor del controlador, estableciéndolo a 0.
  ///
  /// * [controller] es el controlador del campo de texto.
  void clear(TextEditingController controller) {
    controller.text = 0.toString();
  }
}

/// Implementación concreta de la interfaz CarbohydrateRatio
class CarbohydrateRatioImpl implements CarbohydrateRatio {
  @override
  final double gramsMaltodextrin;
  @override
  final double gramsFructose;

  CarbohydrateRatioImpl(
      {required this.gramsMaltodextrin, required this.gramsFructose});
}

/// Implementación concreta de la interfaz Ratio
class RatioImpl implements Ratio {
  @override
  final double maltodextrin;
  @override
  final double fructose;

  RatioImpl({required this.maltodextrin, required this.fructose});
}

/// Widget personalizado que crea una fila con controles para manipular un TextEditingController
class CustomRow extends StatelessWidget {
  // Controlador del campo de texto
  final TextEditingController controller;
  // Servicio controlador para manejar incrementos y decrementos
  final ControllerService controllerService;

  /// Concentración inicial
  int concentration = 0;

  /// Título del campo de texto
  String title = '';

  /// Unidad de medida
  String magnitude = '';

  /// Altura del icono
  double heightIcon = 60;

  /// Tamaño del icono
  double sizeIcon = 35;

  /// Margen izquierdo entre elementos
  double marginLeft = 20;

  /// Ancho del campo de texto
  double whidthTextField = 200;

  /// Valor de incremento/decremento
  int deltaValue = 50;

  /// Constructor para el widget `CustomRow`.
  /// Widget personalizado que crea una fila con controles para manipular un TextEditingController
  ///
  /// * [controller] es el controlador del campo de texto.
  ///
  /// * [controllerService] es el servicio controlador para manejar incrementos y decrementos.
  ///
  /// * [concentration] es la concentración inicial.
  ///
  /// * [title] es el título del campo de texto (opcional).
  ///
  /// * [magnitude] es la unidad de medida (opcional).
  ///
  /// * [deltaValue] es el valor de incremento/decremento (opcional).
  ///
  /// * [sizeIcon] es el tamaño del icono (opcional).
  ///
  /// * [heightIcon] es la altura del icono (opcional).
  ///
  /// * [marginLeft] es el margen izquierdo entre elementos (opcional).
  ///
  /// * [whidthTextField] es el ancho del campo de texto (opcional).
  CustomRow(
      {required this.controller,
      required this.controllerService,
      required this.concentration,
      this.title = '',
      this.magnitude = '',
      this.deltaValue = 50,
      this.sizeIcon = 35,
      this.heightIcon = 60,
      this.marginLeft = 20,
      this.whidthTextField = 200});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: this.heightIcon,
                child: IconButton(
                  icon:
                      Icon(Icons.add, color: Colors.green, size: this.sizeIcon),
                  onPressed: () {
                    controllerService.increment(controller, this.deltaValue);
                  },
                ),
              ),
              SizedBox(width: this.marginLeft),
              SizedBox(
                width: this.whidthTextField,
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      return;
                    }
                    int? intValue = int.tryParse(
                        value); // Intenta convertir el valor a entero
                    if (intValue != null) {
                      concentration =
                          intValue; // Actualiza la concentración si es válido
                    } else {
                      controller.text = concentration
                          .toString(); // Restaura el valor anterior si es inválido
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: this.title,
                    suffix: Text(" " + this.magnitude),
                  ),
                ),
              ),
              SizedBox(width: this.marginLeft),
              SizedBox(
                height: this.heightIcon,
                child: IconButton(
                  icon: Icon(Icons.remove,
                      color: Colors.red, size: this.sizeIcon),
                  onPressed: () {
                    controllerService.decrement(controller, this.deltaValue);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget personalizado que crea una fila con controles para manipular un TextEditingController y una relación de carbohidratos.
class CustomRowWithRatio extends StatelessWidget {
  /// Controlador del campo de texto
  final TextEditingController controller;

  /// Servicio controlador para manejar incrementos y decrementos
  final ControllerService controllerService;

  /// Relación inicial de maltodextrina y fructosa
  Ratio ratio = RatioImpl(maltodextrin: 1, fructose: 0.8);

  /// Concentración inicial
  int concentration = 0;

  /// Título del campo de texto
  String title = '';

  /// Unidad de medida
  String magnitude = '';

  /// Altura del icono
  double heightIcon = 60;

  /// Tamaño del icono
  double sizeIcon = 35;

  /// Margen izquierdo entre elementos
  double marginLeft = 20;

  /// Ancho del campo de texto
  double whidthTextField = 200;

  /// Valor de incremento/decremento
  double deltaValue = 1.0;

  /// Bandera para determinar si se cambia maltodextrina o fructosa
  bool willBeChangedMaltodextrin = false;

  /// Constructor para el widget `CustomRowWithRatio`.
  ///Widget personalizado que crea una fila con controles para manipular un TextEditingController y una relación de carbohidratos.
  ///
  /// * [controller] es el controlador del campo de texto.
  ///
  /// * [controllerService] es el servicio controlador para manejar incrementos y decrementos.
  ///
  /// * [ratio] es la relación de maltodextrina a fructosa.
  ///
  /// * [concentration] es la concentración inicial.
  ///
  /// * [willBeChangedMaltodextrin] determina si se cambia la maltodextrina o la fructosa.
  ///
  /// * [title] es el título del campo de texto (opcional).
  ///
  /// * [magnitude] es la unidad de medida (opcional).
  ///
  /// * [deltaValue] es el valor de incremento/decremento (opcional).
  ///
  /// * [sizeIcon] es el tamaño del icono (opcional).
  ///
  /// * [heightIcon] es la altura del icono (opcional).
  ///
  /// * [marginLeft] es el margen izquierdo entre elementos (opcional).
  ///
  /// * [whidthTextField] es el ancho del campo de texto (opcional).
  CustomRowWithRatio(
      {required this.controller,
      required this.controllerService,
      required this.ratio,
      required this.concentration,
      required this.willBeChangedMaltodextrin,
      this.title = '',
      this.magnitude = '',
      this.deltaValue = 1.0,
      this.sizeIcon = 35,
      this.heightIcon = 60,
      this.marginLeft = 20,
      this.whidthTextField = 200});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: this.heightIcon,
                child: IconButton(
                  icon:
                      Icon(Icons.add, color: Colors.green, size: this.sizeIcon),
                  onPressed: () {
                    if (this.willBeChangedMaltodextrin) {
                      // Incrementa el valor de maltodextrina y actualiza el controlador
                      this.ratio = RatioImpl(
                          maltodextrin: double.parse(
                              (ratio.maltodextrin + this.deltaValue)
                                  .toStringAsFixed(2)),
                          fructose: ratio.fructose);
                      controller.text = ratio.maltodextrin.toString();
                    } else {
                      // Incrementa el valor de fructosa y actualiza el controlador
                      this.ratio = RatioImpl(
                          maltodextrin: this.ratio.maltodextrin,
                          fructose: double.parse(
                              (ratio.fructose + this.deltaValue)
                                  .toStringAsFixed(2)));
                      controller.text = ratio.fructose.toString();
                    }
                  },
                ),
              ),
              SizedBox(width: this.marginLeft),
              SizedBox(
                width: this.whidthTextField,
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    if (value.isEmpty || double.tryParse(value) == null) {
                      return;
                    }
                    double? intValue = double.tryParse(
                        value); // Intenta convertir el valor a doble
                    if (intValue != null) {
                      if (this.willBeChangedMaltodextrin) {
                        this.ratio = RatioImpl(
                            maltodextrin: double.parse(
                                double.parse(value).toStringAsFixed(2)),
                            fructose: ratio
                                .fructose); // Actualiza la maltodextrina si es válido
                      } else {
                        this.ratio = RatioImpl(
                            maltodextrin: this.ratio.maltodextrin,
                            fructose: double.parse(double.parse(value)
                                .toStringAsFixed(
                                    2))); // Actualiza la fructosa si es válido
                      }
                    } else {
                      this.ratio =
                          ratio; // Restaura la relación si el valor es inválido
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Maltodextrina (%)',
                  ),
                ),
              ),
              SizedBox(width: this.marginLeft),
              SizedBox(
                height: this.heightIcon,
                child: IconButton(
                  icon: Icon(Icons.remove,
                      color: Colors.red, size: this.sizeIcon),
                  onPressed: () {
                    if (this.willBeChangedMaltodextrin) {
                      // Decrementa el valor de maltodextrina y actualiza el controlador
                      this.ratio = RatioImpl(
                          maltodextrin: double.parse(
                              (ratio.maltodextrin - this.deltaValue)
                                  .toStringAsFixed(2)),
                          fructose: ratio.fructose);
                      controller.text = ratio.maltodextrin.toString();
                    } else {
                      // Decrementa el valor de fructosa y actualiza el controlador
                      this.ratio = RatioImpl(
                          maltodextrin: this.ratio.maltodextrin,
                          fructose: double.parse(
                              (ratio.fructose - this.deltaValue)
                                  .toStringAsFixed(2)));
                      controller.text = ratio.fructose.toString();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
