import 'package:flutter/material.dart';
import 'package:movie_test_app/model/item_popular.dart';
import 'package:movie_test_app/screens/details/details_screens.dart';

class PopularView extends StatefulWidget {
  @override
  _PopularViewState createState() => _PopularViewState();
}

class _PopularViewState extends State<PopularView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.62,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 30),
      itemCount: listItemPopular.length,
      itemBuilder: (context, index) {
        return _itemPopular(context, listItemPopular[index]);
      },
    );
  }

  Widget _itemPopular(BuildContext context, ItemPopular itemPopular) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DetailsScreen()));
      },
      child: Column(
        children: [
          Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(itemPopular.urlPhoto))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                            stops: [0.5, 1])),
                  ),
                  Positioned(
                      bottom: 12,
                      right: 16,
                      child: Text(
                        itemPopular.releaseDate,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  itemPopular.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
