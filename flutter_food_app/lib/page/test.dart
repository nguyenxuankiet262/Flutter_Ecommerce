import 'package:flutter/material.dart';

class MyTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            //debugPrint('Inner box scrolled ${innerBoxIsScrolled}');
            return <Widget>[
              new SliverOverlapAbsorber(
                  handle:
                  NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: SliverAppBar(
                    floating: false,
                    pinned: true,
                    forceElevated: false,
                    centerTitle: true,
                    backgroundColor: Colors.blue,
                    expandedHeight: 400.0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text('FlexibleSpace'),
                    ),
                  ))
            ];
          },
          body: Builder(
            builder: (BuildContext context) {
              return new CustomScrollView(
                primary: true,
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  new SliverOverlapInjector(
                    // This is the flip side of the SliverOverlapAbsorber above.
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverGrid.count(
                    crossAxisCount: 2,
                    children: <Widget>[
                      Text(
                        'first',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'second',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              );
            },
          )),
    );
  }
}