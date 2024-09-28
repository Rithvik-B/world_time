import 'package:flutter/material.dart';
import 'package:world_time/services/worldTime.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(locUrl: 'Asia/Kolkata', location: 'Hyderabad', flag: 'india.png'),
    WorldTime(locUrl: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(locUrl: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(locUrl: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(locUrl: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(locUrl: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(locUrl: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(locUrl: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(locUrl: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index)async{
    WorldTime instance = WorldTime(location: '${locations[index].location}', flag: '${locations[index].flag}', locUrl: '${locations[index].locUrl}');
    await instance.getTime();
    Navigator.pop(context, {
      'Location':instance.location,'flag':instance.flag,'time':instance.time,'isDaytime':instance.isDaytime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Choose Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
