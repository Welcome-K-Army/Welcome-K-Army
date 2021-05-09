import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../../constants.dart';
import 'menu.dart';

class FavoriteMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return MenuIconButton(menuList[index]);
          },
        ));
  }
}
