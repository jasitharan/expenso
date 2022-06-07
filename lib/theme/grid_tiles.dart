import 'package:cached_network_image/cached_network_image.dart';
import 'package:expenso/constants.dart';
import 'package:expenso/screens/home_pages/expenses_screen.dart';
import 'package:flutter/material.dart';

class ExpenseTypeGridTile extends StatelessWidget {
  final String image;
  final String title;
  final int expTypeId;

  const ExpenseTypeGridTile(
      {Key? key,
      required this.image,
      required this.title,
      required this.expTypeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, ExpensesScreen.routeName,
                arguments: {'expTypeId': expTypeId, 'expTypeName': title});
          },
          child: Container(
            height: 70,
            width: 70,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: kBackendUrl + image,
                fit: BoxFit.cover,
                height: 35,
                width: 35,
                errorWidget: (context, url, error) =>
                    const Image(image: AssetImage('assets/images/gift.png')),
              ),
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(1, 59, 108, 1),
          ),
        )
      ],
    );
  }
}
