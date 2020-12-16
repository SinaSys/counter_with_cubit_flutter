import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:counter_with_cubit_flutter/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/enum.dart';
import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/internet_cubit.dart';
import 'logic/cubit/internet_state.dart';
import 'logic/cubit/counter_state.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  const MyApp({
    Key key,
    @required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) =>
              CounterCubit(internetCubit: context.bloc<InternetCubit>()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlocListener in Bloc To Bloc Communication"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
                  return Text('Wi-Fi',style: Theme.of(context).textTheme.headline4,);
                } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile) {
                  return Text('Mobile',style: Theme.of(context).textTheme.headline4,);
                } else if (state is InternetDisconnected) {
                  return Text('Disconnected',style: Theme.of(context).textTheme.headline4,);
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 4,),
            BlocBuilder<CounterCubit, CounterState>(builder: (context, state) {
              return Text(state.counterValue.toString(),style: Theme.of(context).textTheme.headline2,);
            })
          ],
        ),
      ),
    );
  }
}
