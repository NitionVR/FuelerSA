import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/fuel_price_viewmodel.dart';


class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TextEditingController _petrolTextController = TextEditingController();
  final TextEditingController _dieselTextController = TextEditingController();

  bool _notifyChanges = false;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<FuelPriceViewModel>(context, listen: false);
    _petrolTextController.text = viewModel.currentPetrolPrice.toString();
    _dieselTextController.text = viewModel.currentDieselPrice.toString();

    _petrolTextController.addListener(() {
      final newValue = int.tryParse(_petrolTextController.text) ?? viewModel.currentPetrolPrice;
      viewModel.updatePetrolPrice(newValue);
    });

    _dieselTextController.addListener(() {
      final newValue = int.tryParse(_dieselTextController.text) ?? viewModel.currentDieselPrice;
      viewModel.updateDieselPrice(newValue);
    });
  }

  @override
  void dispose() {
    _petrolTextController.dispose();
    _dieselTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Settings'),
      ),
      body: Consumer<FuelPriceViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16.0),
              _buildToggleRow(
                context,
                'Show Diesel Price',
                viewModel.showDieselPrice,
                viewModel.updateShowDieselPrice,
              ),
              _buildToggleRow(
                context,
                'Show Petrol Price',
                viewModel.showPetrolPrice,
                viewModel.updateShowPetrolPrice,
              ),
              _buildToggleRow(
                context,
                'Notify Price Changes',
                _notifyChanges,
                _updateNotifyChanges,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: _petrolTextController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Petrol',
                    suffixText: "R/litre",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: _dieselTextController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Diesel',
                    suffixText: "R/litre",
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _updateNotifyChanges(bool value) {
    setState(() {
      _notifyChanges = value;
    });
  }

  Widget _buildToggleRow(
      BuildContext context,
      String label,
      bool initialValue,
      void Function(bool value) updateFunction,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Switch(
            value: initialValue,
            onChanged: updateFunction,
          ),
        ],
      ),
    );
  }
}