import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';

class PrivacyPolicy extends StatelessWidget {
  static const routeName = 'footballscoreapp/privacypolicy';
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).iconTheme.color)),
        title: Text(
          'Privacy',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTItle(context,'Privacy Policy'),
                // const SizedBox(height: 20.0,),
                _buildBody(context,privacyPolicy),
                _buildTItle(context, 'Information Collection and Use'),
                _buildBody(context, informationCollectionAndUser),
                // _buildTItle(context, '')
                const SizedBox(height: 20.0,),
                _buildBody(context, googleplayService),
                _buildBody(context, adMob),
                _buildBody(context, firebaseAnalytics),
                _buildBody(context, logData),
                const SizedBox(height: 20.0,),
                _buildBody(context, informationCollectionAndUserTwo),
                _buildTItle(context, 'Cookies'),
                _buildBody(context, cookies),
                _buildTItle(context, 'Service Providers'),
                _buildBody(context, serviceProvider),
                _buildTItle(context, 'Security'),
                _buildBody(context, security),
                _buildTItle(context, 'Links to Other Sites'),
                _buildBody(context, linksToOtherSites),
                _buildTItle(context, 'Children’s Privacy'),
                _buildBody(context, childrensPrivacy),
                _buildTItle(context, 'Changes to This Privacy Policy'),
                _buildBody(context, changesToThisPrivacyPolicy),
                 _buildTItle(context, 'Contact Us'),
                _buildBody(context, contact),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Flexible _buildBody(BuildContext context, String body) {
    return Flexible(
                fit: FlexFit.loose,
                  child: Text(
                body,
                style: Theme.of(context).textTheme.bodyText1,
              ));
  }

  Widget _buildTItle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                ),
    );
  }
}
