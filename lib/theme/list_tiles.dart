import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ExpenseTile extends StatefulWidget {
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
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String realStatus = widget.status;

    if (widget.status == 'Approved') {
      color = Colors.green;
    } else if (widget.status == 'Rejected') {
      color = Colors.red;
    } else if (widget.status == 'Unknown') {
      realStatus = 'Pending';
      color = Colors.orange;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CachedNetworkImage(
            imageUrl: kBackendUrl + widget.image,
            fit: BoxFit.cover,
            height: 30,
            width: 30,
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage('assets/images/check.png')),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: Text(widget.subTitle),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              '- ₹${widget.price}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.status != ''
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 72),
                    child: Text(
                      realStatus,
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  )
                : Container(),
            widget.status != '' && widget.status != 'Approved'
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              widget.editFunction!();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromRGBO(64, 142, 189, 1),
                            )),
                        IconButton(
                            onPressed: () {
                              widget.deleteFunction!();
                            },
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
