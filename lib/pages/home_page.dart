import 'package:flutter/material.dart';
import 'package:fuel_price_tracker/pages/settings.dart';
import 'package:provider/provider.dart';
import '../models/fuel_type.dart';
import '../models/price_event.dart';
import '../viewmodels/fuel_price_viewmodel.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<FuelPriceViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: _buildAppBar(context, viewModel),
          body: _buildBody(context, viewModel),
          floatingActionButton: _buildFAB(context, viewModel),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, FuelPriceViewModel viewModel) {
    return AppBar(
      backgroundColor: Colors.grey[850],
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.orangeAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.orangeAccent),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SettingsView(),
              fullscreenDialog: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, FuelPriceViewModel viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentPrices(context, viewModel),
            const SizedBox(height: 24),
            _buildPriceHistory(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPrices(BuildContext context, FuelPriceViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Current Prices',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (viewModel.showPetrolPrice)
          _buildPriceCard(
            context,
            'Petrol',
            viewModel.currentPetrolPrice,
            Colors.green,
            Icons.local_gas_station,
            viewModel,
          ),
        if (viewModel.showDieselPrice)
          const SizedBox(height: 16),
        if (viewModel.showDieselPrice)
          _buildPriceCard(
            context,
            'Diesel',
            viewModel.currentDieselPrice,
            Colors.orangeAccent,
            Icons.local_shipping,
            viewModel,
          ),
      ],
    );
  }

  Widget _buildPriceCard(
      BuildContext context,
      String fuelType,
      int price,
      Color color,
      IconData icon,
      FuelPriceViewModel viewModel,
      ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.2),
            Colors.transparent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fuelType,
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'R$price per litre',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildPriceControls(color, fuelType, viewModel),
        ],
      ),
    );
  }

  Widget _buildPriceControls(Color color, String fuelType, FuelPriceViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          IconButton(
            icon: Icon(Icons.add, color: color),
            onPressed: () async {
              if (fuelType == 'Petrol') {
                await viewModel.incrementPetrolPrice();
              } else {
                await viewModel.incrementDieselPrice();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.remove, color: color),
            onPressed: () async {
              if (fuelType == 'Petrol') {
                await viewModel.updatePetrolPrice(viewModel.currentPetrolPrice - 1);
              } else {
                await viewModel.updateDieselPrice(viewModel.currentDieselPrice - 1);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriceHistory(BuildContext context, FuelPriceViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<PriceEvent>>(
          future: viewModel.getPriceHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orangeAccent),
              );
            }

            if (snapshot.hasError) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Text(
                  'Error loading price history: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: const Text(
                  'No price history available',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data![index];
                return _buildHistoryCard(event);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildHistoryCard(PriceEvent event) {
    final bool isPetrol = event.fuelType == FuelType.petrol;
    final color = isPetrol ? Colors.green : Colors.orangeAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: ListTile(
        leading: Icon(
          isPetrol ? Icons.local_gas_station : Icons.local_shipping,
          color: color,
        ),
        title: Text(
          '${isPetrol ? 'Petrol' : 'Diesel'} - R${event.price}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          _formatDateTime(event.timeStamp),
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildFAB(BuildContext context, FuelPriceViewModel viewModel) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.orangeAccent,
      onPressed: () => _showAddPriceDialog(context, viewModel),
      icon: const Icon(Icons.add),
      label: const Text('Add Price'),
    );
  }

  void _showAddPriceDialog(BuildContext context, FuelPriceViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: const Text(
          'Add New Price',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.local_gas_station, color: Colors.green),
              title: const Text(
                'Update Petrol Price',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                Navigator.pop(context);
                await viewModel.incrementPetrolPrice();
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping, color: Colors.orangeAccent),
              title: const Text(
                'Update Diesel Price',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                Navigator.pop(context);
                await viewModel.incrementDieselPrice();
              },
            ),
          ],
        ),
      ),
    );
  }
}