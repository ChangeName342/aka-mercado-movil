import 'package:aka_mercado/common/widgets/custom_textfield.dart';
import 'package:aka_mercado/constants/global_variables.dart';
import 'package:aka_mercado/constants/utils.dart';
import 'package:aka_mercado/features/address/services/address_services.dart';
import 'package:aka_mercado/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  
  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  PaymentConfiguration? _paymentConfig;
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    _initializePayment();
  }

  Future<void> _initializePayment() async {
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total',
        status: PaymentItemStatus.final_price,
      ),
    );

    _paymentConfig = await PaymentConfiguration.fromAsset('gpay.json');
    setState(() {});
  }

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void onGooglePlayResult(res) {
    if(Provider.of<UserProvider>(context, listen: false)
      .user
      .address
      .isEmpty) {
      addressServices.saveUserAddress(
        context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

void payPressed(String addressFromProvider) {
  addressToBeUsed = "";
  bool isForm = flatBuildingController.text.isNotEmpty ||
      areaController.text.isNotEmpty ||
      pincodeController.text.isNotEmpty ||
      cityController.text.isNotEmpty;

  if(isForm) {
    if(_addressFormKey.currentState!.validate()) {
      addressToBeUsed =
          '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
    } else {
      showSnackBar(context, 'Por favor, llene todos los campos correctamente.');
      return; // Añadir return para evitar continuar si el formulario es inválido
    }
  } else if(addressFromProvider.isNotEmpty) {
    addressToBeUsed = addressFromProvider;
  } else {
    showSnackBar(context, 'Por favor, proporcione una dirección válida.');
    return; // Añadir return para evitar continuar si no hay dirección
  }

  onGooglePlayResult(addressToBeUsed);
}

  
  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'O',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: flatBuildingController,
                      hintText: 'Piso, número de casa, edificio',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: areaController,
                      hintText: 'Área, Calle',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: pincodeController,
                      hintText: 'Código Postal',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: cityController,
                      hintText: 'Ciudad',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), 
              if (_paymentConfig != null)
                GooglePayButton(
                  onPressed: () => payPressed(address),
                  width: double.infinity,
                  type: GooglePayButtonType.buy,
                  paymentConfiguration: _paymentConfig!,
                  onPaymentResult: onGooglePlayResult,
                  paymentItems: paymentItems,
                ),
              if (_paymentConfig == null)
                const CircularProgressIndicator(), 
            ],
          ),
        ),
      ),
    );
  }
}




