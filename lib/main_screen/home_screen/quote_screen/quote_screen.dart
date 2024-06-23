import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/main_screen/home_screen/quote_screen/quote_function.dart';
import 'package:study_stats/settings/constants.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({key, required this.quote});
  final Map quote;
  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  var scr = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets/image/Star.png',
          ),
          Constants.gap(width: 20)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      "Your daily Quote",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Constants.gap(height: 0),
              RepaintBoundary(
                key: scr,
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Constants.white,
                    ),
                    height: MediaQuery.sizeOf(context).height * .5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/image/quote.png'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            '"${widget.quote['quote']}" \n- ${widget.quote['author']}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset('assets/image/quote.png'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Constants.gap(height: 20),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      screenshotController
                          .capture(delay: Duration(milliseconds: 500))
                          .then((Uint8List? imageBytes) async {
                        await [Permission.storage].request();
                        await QuoteFunction.saveImage(
                          imageBytes!,
                          name: "Quote",
                          context: context,
                        );
                        // await OrderFuntion.saveAndShare(
                        //     imageBytes!, context);
                        // await OrderFuntion.saveImage2(
                        //
                      });
                    },
                    child: Container(
                      height: 44,
                      width: MediaQuery.sizeOf(context).width * .5,
                      decoration: BoxDecoration(
                        color: Constants.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.arrow_down_to_line_alt,
                            color: Constants.white,
                          ),
                          Text(
                            "Save to Photos",
                            style: TextStyle(
                              color: Constants.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Constants.gap(height: 10),
                  GestureDetector(
                    onTap: () {
                      screenshotController
                          .capture(delay: Duration(milliseconds: 500))
                          .then((Uint8List? imageBytes) async {
                        await [Permission.storage].request();
                        await QuoteFunction.shareScreenShort("Qoute",
                            previewContainer: scr, context: context);
                        // await QuoteFunction.saveAndShare(imageBytes!, context);
                        // await OrderFuntion.saveAndShare(
                        //     imageBytes!, context);
                        // await OrderFuntion.saveImage2(
                        //
                      });
                    },
                    child: Container(
                      height: 44,
                      width: MediaQuery.sizeOf(context).width * .5,
                      decoration: BoxDecoration(
                          // color: Constants.black,
                          border: Border.all(color: Constants.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.share,
                          ),
                          Text(
                            " Share",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
