import 'package:floor_calculator/controllers/calculator_controller.dart';
import 'package:floor_calculator/dialogs/result_dialog.dart';
import 'package:floor_calculator/helpers/validator_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/validator_helper.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = CalculatorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de pisos'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.clear_all,
                color: Colors.white,
              ),
              tooltip: "Limpa tuuuuuuutoooo",
              onPressed: _clearFields)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: _buildForm(),
        ),
      ),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderText('Dimensões do cômodo'),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Largura (metros)',
            onSaved: _controller.setRoomWidth,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Comprimento (metros)',
            onSaved: _controller.setRoomLength,
          ),
          _buildVerticalSpace(),
          _buildHeaderText('Dimensões do piso'),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Largura (centímetros)',
            onSaved: _controller.setFloorWidth,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Comprimento (centímetros)',
            onSaved: _controller.setFloorLength,
          ),
          _buildVerticalSpace(),
          _buildHeaderText('Preço do Piso (Inclui rodapés)'),
          _buildVerticalSpace(),
          _buildNumberInputField('Preço (R\$/m²)',
              onSaved: _controller.setPricePerSqMeter,
              validator: ValidatorHelper.isNegativeOrZero),
          _buildVerticalSpace(height: 40),
          _buildCalculateButton(),
        ],
      ),
    );
  }

  _clearFields() {
    setState(() {
      _formKey.currentState.reset();
    });
  }
  _buildNumberInputField(String label,
      {Function(String) onSaved, Function(String) validator}) {
    return TextFormField(
      onSaved: onSaved,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      validator: validator ?? ValidatorHelper.isValidText,
      keyboardType: TextInputType.number,
    );
  }

  _buildCalculateButton() {
    return RaisedButton(
      child: const Text('CALCULAR'),
      onPressed: _calcular,
    );
  }

  _buildHeaderText(String label) {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.2),
      height: 40,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _buildVerticalSpace({double height = 20.0}) {
    return SizedBox(height: height);
  }

  void _calcular() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final result = _controller.calculate();
      showDialog(
        context: context,
        builder: (context) => ResultDialog(result),
      );
    }
  }
}
