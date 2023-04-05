import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredPage extends StatelessWidget {
  const StaggeredPage({
    Key? key,
  }) : super(key: key);

  static const tiles = [
    GridTile(1, 2),
    GridTile(2, 1),
    GridTile(1, 1),
    GridTile(1, 2),
    GridTile(2, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StaggeredGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 17,
        children: [
          ...tiles.mapIndexed((index, tile) {
            return StaggeredGridTile.fit(
              crossAxisCellCount: tile.crossAxisCount,
              child: Image.asset(
                'assets/images/intro${index + 1}.png',
              ),
            );
          }),
        ],
      ),
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}
