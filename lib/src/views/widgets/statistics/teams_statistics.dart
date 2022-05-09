import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TeamsStatistics extends StatelessWidget {
  const TeamsStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      color: kPrimaryColor2,
      child: Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          const Text(
            'Team Possession',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                '37%',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0),
              ),
              CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 15.0,
                percent: 0.63,
                backgroundColor: Colors.blue.withOpacity(0.5),
                progressColor: Colors.blue,
              ),
              const Text(
                '63%',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0),
              ),
             
            ],
          ),
           const SizedBox(
                height: 40.0,
              ),
          _buildEvents(8, 'Shots Total', 7),
          _buildEvents(1, 'Shots on Goal', 4),
          _buildEvents(6, 'Fouls', 8),
          _buildEvents(2, 'Offsides', 4),
          _buildEvents(2, 'Corners', 1),
          _buildEvents(1, 'Yellow Cards', 1),
          
        ],
      ),
    );
  }

  Widget _buildEvents(int leftCount, String name, int rightCount) {
    int value = leftCount + rightCount;
    double leftValue = leftCount / value;
    double rightValue = rightCount / value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          Expanded(
            flex: 1,
            child: Text(
              leftCount.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: LinearPercentIndicator(
              lineHeight: 25.0,
              isRTL: true,
              barRadius: const Radius.circular(5.0),
              width: 100.0,
              progressColor: Colors.blue,
              percent: leftValue,
              backgroundColor: Colors.blue.withOpacity(0.5),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: LinearPercentIndicator(
              
              lineHeight: 25.0,
              isRTL: false,
              barRadius: const Radius.circular(5.0),
              width: 100.0,
              progressColor: Colors.blue,
              percent: rightValue,
              backgroundColor: Colors.blue.withOpacity(0.5),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              rightCount.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
