import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:traintravelers/screens/loginpage.dart';

       class Dashboard extends StatefulWidget {
        @override
     _DashboardState  createState() => _DashboardState();

}

 class _DashboardState extends State<Dashboard> {
    Material myItems(IconData icon, String heading, int color){
    return Material(

      elevation:14.0,
      color: Colors.white,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),

      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.all(8.0),
                    child: Text(heading,style: TextStyle(color: new Color(color),fontSize: 20.1,
                    )

                    ),
                  ),

                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,


                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );


  }
  @override
  Widget build(BuildContext context){
    return Scaffold(

        appBar: AppBar(
          title: Text('Main Menu',
            style:TextStyle(
              color: Colors.white,

            ),
          ),
        ),
        body: StaggeredGridView.count(

          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Ticket Booking"),
            ),
            RaisedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginPage()),
                );
              },
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Season Ticket Booking"),
            ), RaisedButton(
              onPressed: () {},
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Booking train box"),
            ), RaisedButton(
              onPressed: () {},
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Details of traveling side"),
            ),
            RaisedButton(
              onPressed: () {},
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Resorts Booking"),
            ),
            RaisedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginPage ()),
                );
              },
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text("Train Time Table"),
            ),











          ],
          staggeredTiles: const [
            StaggeredTile.extent(1,200.0),
            StaggeredTile.extent(1,200.0),
            StaggeredTile.extent(1,200.0),
            StaggeredTile.extent(1,200.0),
            StaggeredTile.extent(1,200.0),
            StaggeredTile.extent(1,200.0),



          ],)

    );
  }
}