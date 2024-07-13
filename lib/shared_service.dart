// ignore_for_file: must_be_immutable, unnecessary_this, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, prefer_const_constructors, annotate_overrides

import 'package:flutter/material.dart';

/// Definición de una interfaz para la relación de carbohidratos
abstract class CarbohydrateRatio {
  /// * [gramsMaltodextrin] es la cantidad de maltodextrina en gramos.
  /// * [gramsFructose] es la cantidad de fructosa en gramos.
  double get gramsMaltodextrin; // Gramos de maltodextrina
  double get gramsFructose; // Gramos de fructosa
}

abstract class GelMix {
  /// * [gramsMaltodextrin] es la cantidad de maltodextrina en gramos.
  /// * [gramsFructose] es la cantidad de fructosa en gramos.
  /// * [flavorings] es la cantidad de saborizantes en gramos.
  /// * [salts] es la cantidad de sales en gramos.
  /// * [water] es la cantidad de agua en gramos.
  double get gramsMaltodextrin; // Gramos de maltodextrina
  double get gramsFructose; // Gramos de fructosa
  double get flavorings; // Gramos de saborizantes
  double get salts; // Gramos de sales
  int get water; // Gramos de agua
}

/// Definición de una interfaz para la relación de componentes
abstract class Ratio {
  /// * [maltodextrin] es el porcentaje de maltodextrina.
  /// * [fructose] es el porcentaje de fructosa.
  double get maltodextrin; // Porcentaje de maltodextrina
  double get fructose; // Porcentaje de fructosa
}

/// Definición de una interfaz para la relación de componentes
abstract class RatioDropdownButton {
  /// * [ratio] es ratio de carbohidratos.
  /// * [nameDropdown] es el nombre del dropdown.

  String get nameDropdown; // Es ratio de carbohidratos
  Ratio get ratio; // Porcentaje de maltodextrina
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
      gramsMaltodextrin: double.parse(
          (totalCarbohydrate * (ratio.maltodextrin / partsTotals))
              .toStringAsFixed(2)),
      gramsFructose: double.parse(
          (totalCarbohydrate * (ratio.fructose / partsTotals))
              .toStringAsFixed(2)),
    );
  }

  GelMixImpl gelCalculator(
      Ratio ratio,
      int numberGels,
      int amountCarbohydratesPerGels,
      bool isCheckedFlavoring,
      bool isCheckedSalts,
      String nameDropdown,
      double flavoringForGel,
      double saltsForGel) {
    int totalMix = 1000;
    double mixingRatio = double.parse(
        (amountCarbohydratesPerGels / totalMix).toStringAsFixed(2));
    int flavoringsAndSalts = 100;

    double maltodextrinForGel = double.parse(
        (amountCarbohydratesPerGels / (ratio.maltodextrin + ratio.fructose))
            .toStringAsFixed(2));
    double fructoseForGel = maltodextrinForGel * ratio.fructose;

    double flavorings = isCheckedFlavoring
        ? (nameDropdown != 'Ratio personalizado'
            ? double.parse(
                ((flavoringsAndSalts / 2) * mixingRatio).toStringAsFixed(2))
            : flavoringForGel)
        : 0;
    double salts = isCheckedSalts
        ? (nameDropdown != 'Ratio personalizado'
            ? double.parse(
                ((flavoringsAndSalts / 2) * mixingRatio).toStringAsFixed(2))
            : saltsForGel)
        : 0;

    return GelMixImpl(
      gramsMaltodextrin:
          double.parse((maltodextrinForGel * numberGels).toStringAsFixed(2)),
      gramsFructose:
          double.parse((fructoseForGel * numberGels).toStringAsFixed(2)),
      flavorings: flavorings * numberGels,
      salts: salts * numberGels,
      water: int.parse(
          (((maltodextrinForGel + fructoseForGel + flavorings + salts) *
                      numberGels) /
                  3)
              .toStringAsFixed(0)),
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

/// Implementación concreta de la interfaz CarbohydrateRatio
class GelMixImpl implements GelMix {
  @override
  final double gramsMaltodextrin;
  @override
  final double gramsFructose;
  @override
  final double flavorings;
  @override
  final double salts;
  @override
  final int water;

  GelMixImpl(
      {required this.gramsMaltodextrin,
      required this.gramsFructose,
      required this.flavorings,
      required this.salts,
      required this.water});
}

/// Implementación concreta de la interfaz Ratio
class RatioImpl implements Ratio {
  @override
  final double maltodextrin;
  @override
  final double fructose;

  RatioImpl({required this.maltodextrin, required this.fructose});
}

/// Implementación concreta de la interfaz RatioDropdownButton
class RatioDropdownButtonImpl implements RatioDropdownButton {
  final Ratio ratio;
  final String nameDropdown;

  RatioDropdownButtonImpl({required this.ratio, required this.nameDropdown});
}

/// Widget personalizado que crea una fila con controles para manipular un TextEditingController
class CustomRow extends StatelessWidget {
  // Controlador del campo de texto
  TextEditingController controller;

  // Servicio controlador para manejar incrementos y decrementos
  final ControllerService controllerService = ControllerService();

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

  /// Valor anterior de controlador
  int lastValue = 0;

  /// Constructor para el widget `CustomRow`.
  /// Widget personalizado que crea una fila con controles para manipular un TextEditingController
  ///
  /// * [controller] es el controlador del campo de texto.
  ///
  /// * [controllerService] es el servicio controlador para manejar incrementos y decrementos.
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
                  icon: Icon(Icons.remove,
                      color: Colors.red, size: this.sizeIcon),
                  onPressed: () {
                    controllerService.decrement(controller, this.deltaValue);
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
                      controller.text = '';
                      return;
                    } else if (int.tryParse(value) == null) {
                      controller.text = lastValue.toString();
                      return;
                    }
                    int intValue = int.tryParse(value) ?? lastValue;
                    lastValue = intValue;
                    controller.text = intValue.toString();
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
                  icon:
                      Icon(Icons.add, color: Colors.green, size: this.sizeIcon),
                  onPressed: () {
                    controllerService.increment(controller, this.deltaValue);
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

  /// Relación inicial de maltodextrina y fructosa
  Ratio ratio;

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

  /// Valor anterior de maltodextrina
  double lastMaltodextrin = 1.0;

  /// Valor anterior de fructosa
  double lastFructose = 0.8;

  /// Constructor para el widget `CustomRowWithRatio`.
  ///Widget personalizado que crea una fila con controles para manipular un TextEditingController y una relación de carbohidratos.
  ///
  /// * [controller] es el controlador del campo de texto.
  ///
  /// * [ratio] es la relación de maltodextrina a fructosa.
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
      required this.ratio,
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
                  icon: Icon(Icons.remove,
                      color: Colors.red, size: this.sizeIcon),
                  onPressed: () {
                    if (this.willBeChangedMaltodextrin) {
                      // Decrementa el valor de maltodextrina y actualiza el controlador
                      this.ratio = RatioImpl(
                          maltodextrin: double.parse(
                              (double.parse(controller.text) - this.deltaValue)
                                  .toStringAsFixed(2)),
                          fructose: ratio.fructose);
                      controller.text = ratio.maltodextrin.toString();
                    } else {
                      // Decrementa el valor de fructosa y actualiza el controlador
                      this.ratio = RatioImpl(
                          maltodextrin: this.ratio.maltodextrin,
                          fructose: double.parse(
                              (double.parse(controller.text) - this.deltaValue)
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
                    if (value.isEmpty) {
                      controller.text = '';
                      return;
                    } else if (value.isEmpty ||
                        double.tryParse(value) == null) {
                      controller.text = this.willBeChangedMaltodextrin
                          ? lastMaltodextrin.toString()
                          : lastFructose.toString();
                      return;
                    }
                    double doubleValue = double.tryParse(value) ?? 0.0;
                    if (this.willBeChangedMaltodextrin) {
                      this.ratio = RatioImpl(
                          maltodextrin:
                              double.parse(doubleValue.toStringAsFixed(2)),
                          fructose: ratio.fructose);
                      lastMaltodextrin = doubleValue;
                    } else {
                      this.ratio = RatioImpl(
                          maltodextrin: this.ratio.maltodextrin,
                          fructose:
                              double.parse(doubleValue.toStringAsFixed(2)));
                      lastFructose = doubleValue;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: this.title,
                  ),
                ),
              ),
              SizedBox(width: this.marginLeft),
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
                              (double.parse(controller.text) + this.deltaValue)
                                  .toStringAsFixed(2)),
                          fructose: ratio.fructose);
                      controller.text = ratio.maltodextrin.toString();
                    } else {
                      // Incrementa el valor de fructosa y actualiza el controlador
                      this.ratio = RatioImpl(
                          maltodextrin: this.ratio.maltodextrin,
                          fructose: double.parse(
                              (double.parse(controller.text) + this.deltaValue)
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

/// Widget personalizado que crea una fila con controles para limpiar un TextEditingController.
class CustomRowClear extends StatelessWidget {
  /// Controlador del campo de texto
  final TextEditingController controller;

  /// Servicio controlador para manejar incrementos y decrementos
  final ControllerService controllerService = ControllerService();

  /// Título del campo de texto
  String title = '';

  /// Constructor para el widget `CustomRowClear`.
  /// Widget personalizado que crea una fila con controles para limpiar un TextEditingController.
  ///
  /// * [controller] es el controlador del campo de texto.
  ///
  /// * [title] es el título del campo de texto (opcional).
  CustomRowClear({required this.controller, this.title = 'Limpiar'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 70,
            child: TextButton(
              onPressed: () {
                this.controllerService.clear(this.controller);
              },
              child: Text(this.title),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownButton extends StatelessWidget {
  final List<RatioDropdownButton> list;
  final RatioDropdownButton? selectedValue;
  final ValueChanged<RatioDropdownButton?> onSelected;

  CustomDropdownButton({
    required this.list,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<RatioDropdownButton>(
      initialSelection: selectedValue,
      dropdownMenuEntries: list.map<DropdownMenuEntry<RatioDropdownButton>>(
          (RatioDropdownButton value) {
        return DropdownMenuEntry<RatioDropdownButton>(
            value: value, label: value.nameDropdown);
      }).toList(),
      onSelected: onSelected,
    );
  }
}

class ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final double iconSize;

  ResultRow(
      {required this.label,
      required this.value,
      required this.icon,
      this.color = Colors.black,
      this.iconSize = 24.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: iconSize),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: $value',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class CustomCheckboxListTile extends StatelessWidget {
  bool? isChecked = true;
  String title = '';
  Color checkColor;
  Color fillColorIsChecked;
  Color fillColorIsNotChecked;
  final ValueChanged<bool?>? onChanged;

  CustomCheckboxListTile(
      {required this.isChecked,
      required this.title,
      required this.onChanged,
      this.checkColor = Colors.black,
      this.fillColorIsChecked = Colors.green,
      this.fillColorIsNotChecked = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      controlAffinity: ListTileControlAffinity.leading,
      value: isChecked,
      checkColor: checkColor,
      fillColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (isChecked == true) {
          return fillColorIsChecked;
        }
        return fillColorIsNotChecked;
      }),
      onChanged: onChanged,
    );
  }
}
