import 'package:aka_mercado/common/widgets/custom_button.dart';
import 'package:aka_mercado/constants/global_variables.dart';
import 'package:aka_mercado/features/admin/services/admin_services.dart';
import 'package:aka_mercado/features/search/screens/search_screen.dart';
import 'package:aka_mercado/models/order.dart';
import 'package:aka_mercado/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

// ADMIN
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(context: context, status: status+1, order: widget.order, onSuccess: () {
      setState(() {
        currentStep += 1;
      });
    },);
  }

  @override   
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Buscar en AKÁ Mercado',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ver detalles del pedido',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fecha del pedido: ${DateFormat().format(
                    DateTime.fromMillisecondsSinceEpoch(
                      widget.order.orderedAt),
                  )}'),
                  Text('ID del Pedido: ${widget.order.id}'),
                  Text('Total del pedido: \$${widget.order.totalPrice}'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Detalles de la Compra',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    Row(
                      children: [
                        Image.network(
                          widget.order.products[i].images[0],
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Cantidad: ${widget.order.quantity[i].toString()} unidades',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Seguimiento',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Stepper(
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  if(user.type == 'admin') {
                    return CustomButton(
                      text: 'Listo',
                      onTap: () => changeOrderStatus(details.currentStep),
                    );
                  }
                  return const SizedBox();
                },
                steps: [
                  Step(
                    title: const Text('Pendiente'),
                    content: const Text(
                      'Tu pedido aún no ha sido entregado',
                    ),
                    isActive: currentStep > 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed, 
                  ),
                  Step(
                    title: const Text('Completado'),
                    content: const Text(
                      'Tu pedido ha sido entregado.',
                    ),
                    isActive: currentStep > 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed, 
                  ),
                  Step(
                    title: const Text('Recibido'),
                    content: const Text(
                      'Tu pedido ha sido entregado y recibido!',
                    ),
                    isActive: currentStep > 2,
                    state: currentStep > 2
                        ? StepState.complete
                        : StepState.indexed, 
                  ),
                  Step(
                    title: const Text('Entregado'),
                    content: const Text(
                      'Tu pedido ha sido entregado y recibido!',
                    ),
                    isActive: currentStep >= 3,
                    state: currentStep >= 3
                        ? StepState.complete
                        : StepState.indexed, 
                  ),
                ],
              )
            ),
          ],
          ),
        ),
      ),
    );
  }
}