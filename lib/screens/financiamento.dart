import 'package:flutter/material.dart';
import 'dart:math';

class Financiamento extends StatefulWidget {
  const Financiamento({super.key});

  @override
  State<Financiamento> createState() => _FinanciamentoState();
}

class _FinanciamentoState extends State<Financiamento> {

  final valorController = TextEditingController();
  final taxaController = TextEditingController();
  final parcelasController = TextEditingController();
  final taxasExtrasController = TextEditingController();

  double total = 0;
  double parcela = 0;

  void calcular() {
    double valor = double.tryParse(valorController.text) ?? 0;
    double taxa = (double.tryParse(taxaController.text) ?? 0) / 100;
    int parcelas = int.tryParse(parcelasController.text) ?? 0;
    double taxasExtras = double.tryParse(taxasExtrasController.text) ?? 0;

    if (parcelas > 0 && taxa > 0) {
      parcela = valor *
          (taxa * pow(1 + taxa, parcelas)) /
          (pow(1 + taxa, parcelas) - 1);

      total = (parcela * parcelas) + taxasExtras;
    } else {
      parcela = 0;
      total = 0;
    }

    setState(() {});

    mostrarResultado();
  }

  void mostrarResultado() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Resultado"),
        content: Text(
          "Valor total a ser pago: R\$ ${total.toStringAsFixed(2)}\n"
          "Valor da parcela: R\$ ${parcela.toStringAsFixed(2)}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Ok"),
          )
        ],
      ),
    );
  }

  InputDecoration campo(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simulador de Financiamento"),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          image: const DecorationImage(
            image: AssetImage("assets/financiamentofundo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.black.withOpacity(0.5), 
          child: Column(
            children: [

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Valor do financiamento:",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: valorController,
                keyboardType: TextInputType.number,
                decoration: campo("Digite o valor"),
              ),

              const SizedBox(height: 15),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Taxa de juros ao mês:",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: taxaController,
                keyboardType: TextInputType.number,
                decoration: campo("Digite a taxa de juros"),
              ),

              const SizedBox(height: 15),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Número de parcelas:",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: parcelasController,
                keyboardType: TextInputType.number,
                decoration: campo("Digite o número de parcelas"),
              ),

              const SizedBox(height: 15),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Demais taxas e custos:",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: taxasExtrasController,
                keyboardType: TextInputType.number,
                decoration: campo("Digite o total de taxas e custos"),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: calcular,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Valor total a ser pago: R\$ ${total.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                "Valor da parcela: R\$ ${parcela.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}