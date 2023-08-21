import '../screens/home/home.dart';
import '../screens/scanner/scan_screen.dart';

class SideBarItemModel {
  final String title;
  final String svg;
  final String routeName;
  const SideBarItemModel({
    required this.title,
    required this.svg,
    required this.routeName,
  });

  static List<SideBarItemModel> tab = [
    SideBarItemModel(
      title: 'Accueil',
      svg: 'assets/icons/home.svg',
      routeName: Home.routeName,
    ),
    SideBarItemModel(
      title: 'Scanner',
      svg: 'assets/icons/qr.svg',
      routeName: ScanSreen.routeName,
    ),
    const SideBarItemModel(
      title: 'Besoin d\'aide ?',
      svg: 'assets/icons/life-ring.svg',
      routeName: '',
    ),
    const SideBarItemModel(
      title: 'A propos de nous',
      svg: 'assets/icons/exclamation.svg',
      routeName: '',
    ),
    const SideBarItemModel(
      title: 'Déconnexion',
      svg: 'assets/icons/power.svg ',
      routeName: '',
    )
  ];

  static int selectedIndex = 0;
}
