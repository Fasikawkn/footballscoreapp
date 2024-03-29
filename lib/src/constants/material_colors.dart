import 'package:flutter/material.dart';


MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}



const kPrimaryColor = Color(0xff191A1D);
const kPrimaryColor2 = Color(0xff1F1F26);

const kgreyColor = Colors.grey;
const kWhiteColor = Colors.white;
const kScaffoldBackGroundColor = Colors.black;
const kBlueColor = Colors.blue;

// about app
const appName = 'Foot Ball Score App';
const aboutAppText = 'Football Score App is an app the gives guide about matches in popular leagues, countries and mathes';
const mainAppFeature = 'Main app feature';
const featureDetail = 'Fixture, result, stats, table and top scorers data.';
const appBuildText = 'App Build Version 1.0.0';

const privacyPolicy = 'This SERVICE is provided by Developer Sports Media at no cost and is intended for use as is. This page is used to inform website visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service. If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at live footbal unless otherwise defined in this Privacy Policy.';
const informationCollectionAndUser = 'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to "INTRENET PERMISSION". The information that we request is will be retained by us and used as described in this privacy policy. The app does use third party services that may collect information used to identify you. Link to privacy policy of third party service providers used by the app';
const googleplayService = 'Google Play Services';
const adMob = 'AdMob';
const firebaseAnalytics = 'Firebase Analytics';
const logData = 'Log Data';
const informationCollectionAndUserTwo = 'We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.';
const cookies = 'Cookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your device internal memory. This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collection information and to improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.';
const serviceProvider = 'We may employ third-party companies and individuals due to the following reasons: To facilitate our Service; To provide the Service on our behalf; To perform Service-related services; or To assist us in analyzing how our Service is used. We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.';
const security = 'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.';
const linksToOtherSites = 'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.';
const childrensPrivacy = 'These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.';
const changesToThisPrivacyPolicy = 'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.';
const contact = 'If you have any question about this privacy policy, please do not hesitate to contact us on our developer gmail account.';