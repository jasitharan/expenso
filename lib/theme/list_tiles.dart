import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ExpenseTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String price;
  final String image;
  const ExpenseTile(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: kBackendUrl + image,
        fit: BoxFit.cover,
        height: 30,
        width: 30,
        errorWidget: (context, url, error) =>
            const Image(image: AssetImage('assets/images/check.png')),
      ),
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: Text(
        '- ₹$price',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
