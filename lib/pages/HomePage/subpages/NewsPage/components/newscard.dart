import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/Theme.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal(
      {this.title = "Placeholder Title",
      this.cta = "View Article",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc,
      this.publishedAt = "Some Time Ago",
      this.desc = ""});

  final String cta;
  final String img;
  final String desc;
  final String publishedAt;
  final Function tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: GestureDetector(
          onTap: tap(),
          child: Card(
            elevation: 3,
            shadowColor: NowUIColors.muted.withOpacity(0.22),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              bottomLeft: Radius.circular(4.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: NowUIColors.text,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            color: NowUIColors.text,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          cta,
                          style: TextStyle(
                            color: NowUIColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat.yMMMMEEEEd()
                                  .format(DateTime.parse(publishedAt)),
                              style: TextStyle(
                                color: NowUIColors.text,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
