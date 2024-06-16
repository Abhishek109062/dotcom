import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class RetryPage extends StatelessWidget {
  final VoidCallback retryCallback;

  RetryPage({required this.retryCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No internet connectivity.'),
            ElevatedButton(
              onPressed: retryCallback,
              child: Text('Retry'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

//FUNCTION TO MAKE API CAlLS  ||  ACCEPTS API CALL AS CALLBACK FUNCTION WITH CONTEXT

Future<T?> makeApiCall<T>(BuildContext context, Future<T> Function() apiCallFunction,
    {fail = 0}) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    fail = fail + 1;
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => RetryPage(
    //       retryCallback: () async {
    //         await makeApiCall(context, apiCallFunction, fail: fail);
    //         Navigator.pop(context);
    //       },
    //     ),
    //   ),
    // );
    fail = fail - 1;
  }

  if (fail == 0) return await apiCallFunction();
}

//FUNCTION TO CHECK NETWORK CONNECTIVITY || CAN BE CALLED BEFORE API CALL WITH CONTEXT

Future<void> checkNetwork(BuildContext context, {fail = 0}) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    fail = fail + 1;
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => RetryPage(
    //       retryCallback: () async {
    //         await checkNetwork(context, fail: fail);
    //         Navigator.pop(context);
    //       },
    //     ),
    //   ),
    // );
    fail = fail - 1;
  }
  if (fail == 0) return;
}

Future<bool> checkNetworkBool() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
  return true;
}

class ConnectionStatus extends StatefulWidget {
  @override
  State<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> {
  static final Connectivity _connectivity = Connectivity();
  static ConnectivityResult connectivityResult = ConnectivityResult.none;

  Future<void> _updateConnectivityStatus(ConnectivityResult result) async {
    setState(() {
      connectivityResult = result;
      print("$connectivityResult  connection status update");
    });
  }

  @override
  void initState() {
    super.initState();
    print('object');
    // _connectivity.onConnectivityChanged.listen((_updateConnectivityStatus));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return connectivityResult.name == 'none'
        ? Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.zero, color: Colors.black,
              shape: Border.symmetric(horizontal: BorderSide.none, vertical: BorderSide.none),
              // elevation: 2,

              child: Text(
                'No Internet',
                style: TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : SizedBox();
  }

  Widget wholeLoader() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No internet connectivity.'),
            ElevatedButton(
              onPressed: () {},
              child: Text('Retry'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/no-internet.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            "No Internet Connection",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "You are not connected to the internet. Make sure Wi-Fi is on, Airplane Mode is Off and try again.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
