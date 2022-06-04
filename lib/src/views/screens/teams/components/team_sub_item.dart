import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/views/views.dart';


class TeamSubItems extends StatelessWidget {
  const TeamSubItems(
    this.teamModel,{
    
     Key? key }) : super(key: key);
  final TeamModel teamModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        decoration: BoxDecoration(
          color:  Theme.of(context).colorScheme.secondary,
          border: Border(
            top: BorderSide(
              color: kgreyColor.shade600,
              width: 0.4,
            ),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCachedNetworkImage(
                url: teamModel.team!.logo.toString(),
                placeholder: 'assets/images/ball_one.png',
                width: 20.0,
              ),
              Expanded(
                
                child: Row(
                  children: [
                    const SizedBox(
                      width: 40.0,
                    ),
                    Expanded(
                      child: Text(
                        teamModel.team!.name.toString(),
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  ],
                ),
              ),
              Icon(Icons.navigate_next, size: 35.0, color: kgreyColor.shade700)
            ],
          ),
        ),
      ),
    );
  }
}