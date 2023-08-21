import 'package:flutter/material.dart';

import '../../config/functions.dart';
import '../../model/side_bar_item.dart';
import '../../widgets/copy_rigtht.dart';
import 'widgets/side_bar_header.dart';
import 'widgets/side_bar_item.dart';

class CustomSiderBar extends StatefulWidget {
  const CustomSiderBar({super.key});

  @override
  State<CustomSiderBar> createState() => _CustomSiderBarState();
}

class _CustomSiderBarState extends State<CustomSiderBar> {
  //int seletedindex = 0;
  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return Drawer(
      //backgroundColor: Colors.grey.withOpacity(0.1),
      child: Stack(
        children: [
          Container(
            height: paddingTop,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.1),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //buildHeader(context),
                Column(
                  children: [
                    const SideBarHeader(),
                    const SizedBox(height: 25),
                    builMenuItems(context),
                  ],
                ),

                builBottomArea(context, paddingBottom)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget builMenuItems(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: List.generate(
            SideBarItemModel.tab.length - 1,
            (index) => SideBarItem(
              asset: SideBarItemModel.tab[index].svg,
              title: SideBarItemModel.tab[index].title,
              isSeleted: SideBarItemModel.selectedIndex == index ? true : false,
              onTap: () {
                setState(() {
                  SideBarItemModel.selectedIndex = index;
                });

                if (SideBarItemModel.tab[index].routeName.isNotEmpty) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SideBarItemModel.tab[index].routeName, (route) => false);
                } else {
                  Navigator.pop(context);
                  Functions.showSnackBar(
                    ctxt: context,
                    messeage: 'Disponible bientôt',
                  );
                }
              },
            ),
          ),
        ),

        /////////////////
        ///
        ///
      ],
    );
  }

  Widget builBottomArea(BuildContext context, double paddingBottom) {
    return Column(
      children: [
        SideBarItem(
            asset: 'assets/icons/power.svg',
            title: 'Déconnexion',
            // isLast: true,
            onTap: () {
              Navigator.pop(context);
              Functions.showSnackBar(
                ctxt: context,
                messeage: 'Disponible bientôt',
              );
            }),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding:
                  EdgeInsets.only(right: 5, left: 5, bottom: paddingBottom),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const FittedBox(
                child: CopyRight(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
