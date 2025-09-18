import 'package:car_wash_app/providers/my_cars_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class MyCarDetailScreen extends StatefulWidget {
  final String id;
  const MyCarDetailScreen({super.key, required this.id});

  @override
  State<MyCarDetailScreen> createState() => _MyCarDetailScreenState();
}

class _MyCarDetailScreenState extends State<MyCarDetailScreen> {


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){
      context.read<MyCarsProvider>().fetchCarDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold();
  }
}
