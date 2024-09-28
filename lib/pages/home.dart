import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty? data : ModalRoute.of(context)!.settings.arguments as Map;

    //set Background img
    String bgImg = data['isDaytime']?'day.png':'night.png';
    Color bgcolor = data['isDaytime']?Colors.blue:Colors.indigoAccent;

    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImg'),
                fit: BoxFit.cover,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,60,0,0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    print(result);
                    if (result != null) {
                      setState(() {
                        data = {
                          'Location': result['Location'],
                          'flag': result['flag'],
                          'time': result['time'],
                          'isDaytime': result['isDaytime']
                        };
                      });
                    }
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Choose Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['Location'],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}