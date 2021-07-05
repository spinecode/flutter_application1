
void main() => runApp(
  MaterialApp(
     title: "Weather App",
     home: Home(),
     )
  );

class _Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState () {
    return _HomeState();
 }
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;


future getWeather () async {
http.Response response = await http.get("https://api.openweathermap.org/data/2.5/weather?q=Abuja,{state%20code},{country%20code}&units=NG&appid=143dd10b2657ba2d2a681c69cbe626fa");
var results = JsonDecode(response.body);
setState(() {
  this.temp = results['main']['temp'];
  this.description = results ['weather'][0]['description'];
  this.currently = results ['weather'][0]['main'];
  this.humidity = results['main']['humidity'];
  this.windSpeed = results['wind']['speed'];
});
}

@override
void initState (){
  super.initState();
  this.getWeather();
}
  
  @override 
   Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height /3,
            width: MediaQuery.of(context).size.width,
            color: Colors.pink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently  in Abuja",
                    style: TextStyle(
                      color: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      fontSize: 21.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  temp!= null ? temp.toString() +"\u00B0" : "Loading",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  ),
              ],
            ),
          )
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    loading: Falcon(Font AwesomeIcons.thermotherHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ?temp.toString() +"\u00B0" : "Loading"),
                  ),
                     ListTile(
                    loading: Falcon(Font AwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null ? description.toString() : "Loading"),
                     ),
                     ListTile(
                    loading: Falcon(Font AwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                     ),
                     ListTile(
                    loading: Falcon(Font AwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windspeed != null ? windspeed.toString() : "Loading"),)
                ]: ,))
            )
        ],
        )
      );
  }
}