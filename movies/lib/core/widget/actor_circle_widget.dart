import 'package:flutter/material.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/string.dart';


class ActorCircleWidget extends StatelessWidget {
  final String actor;
  const ActorCircleWidget({Key? key, required this.actor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            foregroundImage: AssetImage(AppString.assetUrlPlaceholder),
            radius: 20,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 5),
              width: 60,
              child: Text(
                actor,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColors.white, fontSize: 9),
              ),
            ),
          )
        ],
      ),
    );
  }
}
