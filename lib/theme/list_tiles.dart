import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ExpenseTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String price;
  final String image;
  final String status;
  final Function? editFunction;
  final Function? deleteFunction;
  const ExpenseTile({
    Key? key,
    required this.title,
    required this.subTitle,
    this.status = '',
    required this.image,
    required this.price,
    this.editFunction,
    this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String realStatus = status;

    if (status == 'Approved') {
      color = Colors.green;
    } else if (status == 'Rejected') {
      color = Colors.red;
    } else if (status == 'Unknown') {
      realStatus = 'Pending';
      color = Colors.orange;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CachedNetworkImage(
            imageUrl: kBackendUrl + image,
            fit: BoxFit.cover,
            height: 30,
            width: 30,
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage('assets/images/check.png')),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: Text(subTitle),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              '- ₹$price',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            status != ''
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 72),
                    child: Text(
                      realStatus,
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  )
                : Container(),
            status != '' && status != 'Approved'
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => editFunction!(),
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromRGBO(64, 142, 189, 1),
                            )),
                        IconButton(
                            onPressed: () => deleteFunction!(),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  )
                : Container()
          ],
        ),
        divider
      ],
    );
  }
}
