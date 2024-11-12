import 'package:aka_mercado/features/account/services/account_services.dart';
import 'package:aka_mercado/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Mis pedidos',
              onTap: () {},
            ),
            AccountButton(
              text: 'Vender',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Cerrar Sesión',
              onTap: () => AccountServices().logOut(context),
            ),
            AccountButton(
              text: 'Mi Lista de Deseos',
              onTap: () {},
            ),
          ],
        ),
      ],

    );
  }
}