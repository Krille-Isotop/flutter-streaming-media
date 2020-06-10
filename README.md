# Navigation i Flutter

Detta är en guide för hur man kan göra navigering i Flutter. Problemet det ska lösa är att kunna använda sig av flera navigationsstackar och låta användaren växla mellan dessa utan att tappa sin navigationshistorik.

## Uppbyggnad

Här är en lista som förklarar de bitar som vi kommer behöva för navigeringen.

#### bottom_navigation.dart
Detta är en Widget som kommer bygga utseende och funktion för vår Bottom Navigation Bar.

#### route_generator.dart
Denna class hanterar alla routes som vår app kan navigera till och bygger upp den Widget som ska visas vid respektive route.

#### router.dart
Denna Widget hanterar uppbyggnaden av våra navigationsstackar och hanterar vilken stack som ska presenteras för användaren

#### screens/
Denna mapp hanterar alla sidor som vi ska kunna hantera i navigeringen.

## Steg för steg

Vi kan börja med att titta i appens ``main.dart`` fil.
Detta är roten till en Flutter app och vi ger appen en titel och den Widget som ska laddas in först, i vårat fall vår Router Widget.

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

Så då kan vi se vad som händer i Router Widgeten i ``router.dart``
``Router`` är en StatefulWidget med ett state. Den kommer behöva hålla reda på vilken navigations-tab som är aktiv just nu.
Vi sätter att initsialt så är det den röda sidan som är aktiv.

``
TabItem currentTab = TabItem.red;
``

Efter det så kommer vi behöva två nycklar. Beskrivning kommer...

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
Beskrivning kommer om Callback...

```
@override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[currentTab].currentState.maybePop(),
      
      child: Scaffold(
        body: {...},
        bottomNavigationBar: {...},
      ),
    );
  }
```

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
