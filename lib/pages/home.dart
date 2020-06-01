import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    // set background
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/$bgImage'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 140.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                RaisedButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag']
                      };
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                    child: Icon(
                      Icons.edit_location,
                      color: Colors.black,
                    ),
                  ),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                    child: Text(
                      'Edit Location',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/img/${data['flag']}'),
                      radius: 15.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 26.0,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    letterSpacing: -1.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
