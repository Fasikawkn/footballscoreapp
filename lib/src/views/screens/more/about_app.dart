import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';

class AboutApp extends StatelessWidget {
  static const routeName = 'footballscoreapp/aboutapp';
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 184, 216, 231),
                  borderRadius: BorderRadius.circular(10.0)),
              child: const Icon(
                Icons.sports_soccer,
                color: kBlueColor,
                size: 40.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Flexible(
              child: Text(
                appName,
                style: TextStyle(
                    color: kBlueColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Flexible(
                child: Text(
              appBuildText,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 16.0),
            )),
            const SizedBox(
              height: 10.0,
            ),
            Flexible(
              child: Text(
                aboutAppText,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  '$mainAppFeature:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange[900]!.withOpacity(0.2)),
                  child: Center(
                    child: Icon(
                      Icons.list,
                      color: Colors.orange[900],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                    child: Text(
                  featureDetail,
                  style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w400),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
