import 'dart:math';
import 'package:bmi/constants.dart';

class CalculatorBrain{
  CalculatorBrain({required this.height,required this.weight});

  final int height;
  final int weight;
  late double bmi;
  String calculateBMI(){
    bmi =  weight / pow(height/100,2);
    return bmi.toStringAsFixed(1);
  }

  String getResult(){
    if(bmi >= 25){
      return 'Overweight';
    }else if(bmi > 18.5){
        return 'Normal';
    }else{
      return 'Underweight';
    }
  }
  String getInterpretation(){
    if(bmi >= 25){
      return 'BlackHole';
    }else if(bmi > 18.5){
      return 'Greek God';
    }else{
      return 'Stick man';
    }
  }
}