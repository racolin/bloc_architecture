import 'package:flutter/material.dart';

import '../../supports/convert.dart';
import '../../data/models/voucher_model.dart';
import '../clippers/ticket_clipper.dart';
import '../res/dimen/dimens.dart';

class VoucherWidget extends StatelessWidget {
  final VoucherModel voucher;
  final VoidCallback? onClick;

  const VoucherWidget({
    Key? key,
    required this.voucher,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: ClipPath(
        clipper: TicketClipper(numberOfSmall: 8, ticketRate: 2 / 7),
        child: Container(
          height: 100,
          color: Colors.white70,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(spaceSM),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(spaceXS),
                    child: Image.network(
                      voucher.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(spaceMD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        voucher.title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        dateToString(voucher.expire, 'dd/MM/yyyy'),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
