import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boba_gang/models/boba.dart';

//  access the data from the stream

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final bobas = Provider.of<List<Boba>>(context) ?? [];

    return ListView.builder(
      itemCount: bobas.length,
      itemBuilder: (context, index) {
        return BobaTile(boba: bobas[index]);
      },
    );
  }
}

class BobaTile extends StatelessWidget {

  final Boba boba;
  BobaTile({ this.boba });


  @override
  Widget build(BuildContext context) {

    bool decision = false;
    if (boba.boba == 'yes') { decision = true; }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: decision ? AssetImage('assets/images/withBoba.jpg') : AssetImage('assets/images/noBoba.jpg'),
          ),
          title: Text(boba.name),
          subtitle: Text('${boba.flavor}  |  ${boba.sugars}% sugar  ')
        ),
      )
    );
  }
}