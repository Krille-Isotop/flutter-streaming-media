# Navigation i Flutter

Detta är en guide för hur man kan göra navigering i Flutter. Problemet det ska lösa är att kunna använda sig av flera navigationsstackar och låta användaren växla mellan dessa utan att tappa sin navigationshistorik.

## Uppbyggnad

Här är en lista som förklarar de bitar som vi kommer behöva för navigeringen.

__bottom_navigation.dart__<br>Detta är en Widget som kommer bygga utseende och funktion för vår Bottom Navigation Bar.

__route_generator.dart__<br>Denna class hanterar alla routes som vår app kan navigera till och bygger upp den Widget som ska visas vid respektive route.

__router.dart__<br>Denna Widget hanterar uppbyggnaden av våra navigationsstackar och hanterar vilken stack som ska presenteras för användaren

__screens/__<br>Denna mapp hanterar alla sidor som vi ska kunna hantera i navigeringen.

## Steg för steg

#### BottomNavigation

Vi kan börja med att titta på navigationsbaren.

Högst upp i filen har vi våra TabItems, alltså de små ikonerna i botten navigationen.
Här har vi denna enum i ``bottom_navigation.dart`` för att den hör till botten navigationen.

Här har vi två TabItems, "red" och "blue" som kommer vara de två valen användaren har i botten navigationen.
Vi ger varje TabItem ett namn och en ikon.

```
enum TabItem { red, blue }

Map<TabItem, String> tabName = {
  TabItem.red: 'Red',
  TabItem.blue: 'Blue',
};

Map<TabItem, IconData> tabIcon = {
  TabItem.red: Icons.home,
  TabItem.blue: Icons.person,
};
```

Då kan vi först titta på BottomNavigation i sin helhet:

```
class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.red),
        _buildItem(tabItem: TabItem.blue),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    return BottomNavigationBarItem(
      icon: Icon(
        tabIcon[tabItem],
        color: _setActiveColor(item: tabItem),
      ),
      title: Text(
        tabName[tabItem],
        style: TextStyle(
          color: _setActiveColor(item: tabItem),
        ),
      ),
    );
  }

  Color _setActiveColor({TabItem item}) {
    return currentTab == item ? Colors.black87 : Colors.grey;
  }
}
```

Denna class kommer att bygga navigationsbaren och kommer behöva veta vilket som är den aktiva tab:en, samt vad som händer när användaren klickar på en tab. Därför ber vi om det i konstruktorn:
```
final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
```

Sedan så ser vi att den här classen returnerar som förväntat en `BottomNavigationBar` och vi ser till att funktionen vi tagit emot i konstruktorn kommer köras i samband med att användaren klickar på en tab.<br>Alla TabItems som ska visas ska placeras i `items: [...]` och här har vi en liten hjälpfunktion för att bygga upp dom baserat på enumen vi skapade tidigare.

```
return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.red),
        _buildItem(tabItem: TabItem.blue),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
```

Hjälpfunktionen `_buildItem` returnerar ett ``BottomNavigationItem`` och tar informationen från det TabItem som vi gett som argument.<br>Vi har även en liten ``_setActiveColor`` funktion som sätter antingen en aktiv eller inaktiv färg till TabItem:et.

```
  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    return BottomNavigationBarItem(
      icon: Icon(
        tabIcon[tabItem],
        color: _setActiveColor(item: tabItem),
      ),
      title: Text(
        tabName[tabItem],
        style: TextStyle(
          color: _setActiveColor(item: tabItem),
        ),
      ),
    );
  }

  Color _setActiveColor({TabItem item}) {
    return currentTab == item ? Colors.black87 : Colors.grey;
  }
```

#### RouteGenerator

Vår RouteGenerator ansvarar för två saker:
* Hantera alla routes som vår app kan visa.
* Hantera uppbyggnaden av de Widgets som ska visas vid en specifik route.

Men vi kan börja med att titta på hela ``route_genterator.dart``

```
class RouteGenerator {
  static const String red = 'red';
  static const String blue = 'blue';
  static const String lightRed = 'LightRed';
  static const String lightBlue = 'lightBlue';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case red:
        return MaterialPageRoute(builder: (_) => RedScreen());
      case blue:
        return MaterialPageRoute(builder: (_) => BlueScreen());
      case lightRed:
        return MaterialPageRoute(builder: (_) => LightRedScreen());
      case lightBlue:
        return MaterialPageRoute(builder: (_) => LightBlueScreen());
      default:        
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('ERROR')),
      );
    });
  }
}
```

Högst upp ser vi fyra konstanter som ska representera de routes vår app kan visa. Vi kommer senare att behöva dessa strängar vid navigering.

Sedan har vi ``generateRoute(RouteSettings settings)`` funktionen. Den tar emot ``RouteSettings`` som kommer innehålla all information vi kommer behöva sköta navigeringen.<br>
Här ser vi att vi kan komma åt vilken route som vi ska ta genom ``settings.name`` och kan sen bygga upp en Widget efter det.

Eftersom det är en switch så måste ett default case läggas in och vi har skapat en liten ``_errorRoute`` som ska byggas om något går fel.

#### main.dart

Nu när vi har både vår `RouteGenerator` och `BottomNavigation` så kan vi sätta ihop det med vår `Router`.
Men Vi kan börja med att titta i appens ``main.dart`` fil.<br>
Detta är roten till en Flutter app och vi ger appen en titel och den Widget som ska laddas in först, i vårat fall vår `Router` Widget.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      home: Router(),
    );
  }
}
```

#### Router

Så då kan vi se vad som händer i Router Widgeten i ``router.dart``
``Router`` är en StatefulWidget med ett state. Den kommer behöva hålla reda på vilken navigationstab som är aktiv just nu.

Först kan vi titta på den i sin helhet:

```
class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  TabItem currentTab = TabItem.red;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[currentTab].currentState.maybePop(),
          child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.red, initalRoute: RouteGenerator.red),
          _buildOffstageNavigator(TabItem.blue,
              initalRoute: RouteGenerator.blue)
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem, {String initalRoute}) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: Navigator(
        key: navigatorKeys[tabItem],
        initialRoute: initalRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

```

Vår Routers state är vilken som är den aktiva tab:en. Vi kan initialt sätta den till den röda routen.

```
TabItem currentTab = TabItem.red;
```

Efter det så kommer vi behöva två nycklar. Dessa kommer att behövas för att hålla reda på hur state ser ut för navigationen.

```
Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };
```

Vi skapar även en funktion som vi vill köra när användaren väljer en tab. Här så sätter vi state för den aktiva tab:en till den som användaren valt.

```
void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }
```

Sedan i byggcontextet så händer det grejer.
Vår Router returnerar ett `WillPopScope`. Denna Widget har vi för att hantera "Bakåt-knappen" på Android enheter.
Utan denna så kommer klicket på knappen resultera i att appen göms och sätts i bakgrundsläge men vi vill fånga det eventet och istället navigera tillbaka till den förra skärmen i navigeringen.

`WillPopScope` ger oss tillgång till en `onWillPop` property. Om denna callback resulterar i false så kommer appen inte sättas i bakgrundsläge.

`WillPopScope` lägger sig runt den `Scaffold` som användaren alltid kommer se. Vi kommer alltid vilja att användaren har tillgång till vår BottomNavigation, så vi passar in den med argumenten den frågar efter.
I `body` så vill vi ha de Navigationsvägar som användaren kan ta. I vårt fall har vi två, röd och blå, och vi kan använda oss av vår hjälpfunktion `_buildOffstageNavigator()` för att skapa upp egna Navigationscontext till dessa.

```
@override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[currentTab].currentState.maybePop(),
      
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.red, initalRoute: RouteGenerator.red),
          _buildOffstageNavigator(TabItem.blue, initalRoute: RouteGenerator.blue)
        ]),
        
        bottomNavigationBar: BottomNavigation(
          currentTab: currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }
```

Då kan vi titta på vad `_buildOffstageNavigator()` gör.

Vi kan se att den returnerar en `Offstage` Widget.<br>
Denna Widget används för att behålla sin child i minnet, men vi kan gömma den så vi inte ser den om vi vill.
Vi bör gömma den om den aktiva tab:en inte är den som användaren valt: `offstage: currentTab != tabItem`.

Sen kan vi sätta upp en `Navigator` för den här routen.<br>
Vi ger Navigatorn en `key` för att spara navigations-state när vi växlar tabs och vi säger vilken route som den ska börja på.

Och nu får vi användning av vår RouteGenerator för här kan vi säga till Navigatorn att när vi vill navigera så kan du använda dig av de routes vi switchar på i `RouteGenerator.generateRoute`.

```
Widget _buildOffstageNavigator(TabItem tabItem, {String initalRoute}) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: Navigator(
        key: navigatorKeys[tabItem],
        initialRoute: initalRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
```

## Dags att se hur det fungerar

Vi startar upp appen med `flutter run` och ser att vi har en röd sida aktiv och kan ta oss till den blå sidan via botten navigationen.

Då ska vi se om vi kan navigera inuti de båda sidorna.

Varje sida har en knapp i mitten som sköter navigeringen. Vi kikar på knappen i den röda sidan, `red_screen.dart`.<br>
Vi har här en `RaisedButton` som kommer sköta navigationen i sin `onPressed` callback.<br>
`Navigator.of(context)` kommer titta på det närmaste Navigationscontextet för den här Widgeten och det är det Navigationscontextet vi skapade för den röda routen.

På den kan vi använda `pushNamed` som förväntar sig en sträng att matcha en route till, och det satte vi upp som statiska konstanter högst upp i `RouteGenerator`.

```
RaisedButton(
    onPressed: () => Navigator.of(context).pushNamed(RouteGenerator.lightRed),
    color: { ... },
    child: { ... }
  ),
```
Nu så tar ett klick på knappen oss till `light_red_screen.dart` och `LightRed` Widgeten.<br>Vi testar att klicka på den blå ikonen i botten navigationen och vi möts enligt förväntat av en blå sida.

När vi sen väljer den röda sidan igen, så ser vi fortfarande `LightRed` Widgeten.
