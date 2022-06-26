import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AmountCards extends StatefulWidget {
  final double cardWidth;
  final double cardheight;
  final Color cardColor;
  final String title;
  final Color titleColor;
  final Color amountColor;
  final double amount;
  final double textSpacing;
  final double textSize;

  const AmountCards(
      {Key? key,
      required this.cardWidth,
      required this.cardheight,
      required this.cardColor,
      required this.title,
      required this.amount,
      this.textSpacing = 30,
      required this.textSize,
      required this.titleColor,
      required this.amountColor})
      : super(key: key);

  @override
  State<AmountCards> createState() => _AmountCardsState();
}

class _AmountCardsState extends State<AmountCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: widget.cardWidth,
      height: widget.cardheight,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              offset: Offset.zero,
              color: Color.fromARGB(255, 87, 87, 87),
              spreadRadius: 1,
              blurStyle: BlurStyle.outer,
              blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(10),
        color: widget.cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            widget.title,
            style:
                TextStyle(fontSize: widget.textSize, color: widget.titleColor),
          ),
          SizedBox(
            height: widget.textSpacing,
          ),
          AutoSizeText(
            '${widget.amount < 0 ? 0 : widget.amount}',
            style: TextStyle(fontSize: 15, color: widget.amountColor),
            minFontSize: 12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
