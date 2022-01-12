import 'package:flutter/material.dart';

void main(){
  runApp(
    HorizonsApp()
  );
}

class HorizonsApp extends StatelessWidget{
   // this widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // This is the theme of the application.
      theme: ThemeData.dark(),
      // Scrolling in Flutter behaves differently depending on the
      // ScrollBehavior. By default, ScrollBehavior changes depending
      // on the current platform. For the purposes of this scrolling
      // workshop, we're using a custom ScrollBehavior so that the
      // experience is the same for everyone - regardless of the
      // platform they are using.
      scrollBehavior: const ConstantScrollBehavior(),
      title: 'Horizons Weather',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Learning Sliver Flutter'),
          backgroundColor: Colors.teal[800],
        ),
        body: WeeklyForecastList(),
      ),
    );
  }
}

class WeeklyForecastList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<DailyForecast> forecasts = Server.getDailyForecastList();

    return SingleChildScrollView(
      child: Column(
        children: forecasts.map((DailyForecast dailyForecast){
          return Card(
            child: ListTile(
              leading: Text(
                dailyForecast.getDate(currentDate.day).toString(),
                style: textTheme.headline4,
              ),
              title: Text(
                dailyForecast.getWeekdays(currentDate.weekday),
                style: textTheme.headline5,
              ),
              subtitle: Text(dailyForecast.description),
              trailing: Text(
                '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
                style: textTheme.subtitle2,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// --------------------------------------------
// Below this line are helper classes and data.

const String baseAssetUrl = 'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/';
const String headerImage = '${baseAssetUrl}assets/header.jpeg';

const Map<int, DailyForecast> _kDummyData = {
  0: DailyForecast(
    id : 0,
    imageId : '${baseAssetUrl}assets/day_0jpeg',
    highTemp: 73,
    lowTemp: 52,
    description: 'Hôm nay trời đẹp quá HEHE',
  ),
  1: DailyForecast(
    id : 1,
    imageId : '${baseAssetUrl}assets/day_1.jpeg',
    highTemp: 20,
    lowTemp: -8,
    description: 'Hôm nay lạnh và lonely',
  ),
  2: DailyForecast(
    id : 2,
    imageId : '${baseAssetUrl}assets/day_2.jpeg',
    highTemp: 100,
    lowTemp: 70,
    description: 'Hôm nay nóng đến chết',
  ),
  3: DailyForecast(
    id : 3,
    imageId : '${baseAssetUrl}assets/day_3.jpeg',
    highTemp: 60,
    lowTemp: 42,
    description: 'WELL ELL ƯLLL',
  ),
  4: DailyForecast(
    id : 4,
    imageId : '${baseAssetUrl}assets/day_4.jpeg',
    highTemp: 50,
    lowTemp: 30,
    description: 'Hôm nay thời tiết ok nên đi ngủ sớm <3',
  ),
  5: DailyForecast(
    id : 5,
    imageId : '${baseAssetUrl}assets/day_5.jpeg',
    highTemp: 70,
    lowTemp: 40,
    description: 'Hôm nay đi chơi là sướng hihi',
  ),
  6: DailyForecast(
    id : 6,
    imageId : '${baseAssetUrl}assets/day_6.jpeg',
    highTemp: 50,
    lowTemp: 20,
    description: 'Hôm nay Lạnh quá muốn đi ngủ ghê',
  ),
};

class Server{
  static List<DailyForecast> getDailyForecastList() => _kDummyData.values.toList();

  static DailyForecast getDailyForecastByID(int id){
    assert(id >= 0 && id <= 6);
    return _kDummyData[id]!;
  }
}

class DailyForecast {
  const DailyForecast({
    required this.id,
    required this.imageId,
    required this.highTemp,
    required this.lowTemp,
    required this.description});
  final int id;
  final String imageId;
  final int highTemp;
  final int lowTemp;
  final String description;

  static const List<String> _weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String getWeekdays(int today){
    final int offset = today + id;
    final int day = offset >= 7 ? offset - 7 : offset;
    return _weekdays[day];
  }

  int getDate (int today) => today + id;
}

class ConstantScrollBehavior extends ScrollBehavior{
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.android;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}