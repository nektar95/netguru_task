import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:netguru_task/l10n/l10n.dart';
import 'package:netguru_task/modules/add_value/ui/add_value_page.dart';
import 'package:netguru_task/modules/favorites/ui/favorites_page.dart';
import 'package:netguru_task/modules/values/ui/values_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).taskHomePageTitle,
            style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [ValuesPage(), AddValuePage(), FavoritesPage()],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          backgroundColor: Theme.of(context).primaryColor,
          color: Theme.of(context).backgroundColor,
          activeColor: Theme.of(context).accentColor,
          items: [
            TabItem(
                icon: Icons.format_quote_sharp,
                title: AppLocalizations.of(context).taskAppHome),
            TabItem(
                icon: Icons.add,
                title: AppLocalizations.of(context).taskAppAddValue),
            TabItem(
                icon: Icons.favorite,
                title: AppLocalizations.of(context).taskAppFavoritesValues),
          ],
        ),
      ),
    );
  }
}
