import 'package:flutter/material.dart';

void clearInputs(List<TextEditingController> controllers) {
  for (var controller in controllers) {
    controller.clear();
  }
}
