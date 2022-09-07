import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/grobotmarket/cubit/grobot_market_cubit.dart';
import 'package:flutter_project/grobotmarket/cubit/grobot_market_state.dart';
import 'package:flutter_project/grobotmarket/view/widget/grobot_item.dart';
import 'package:flutter_project/models/Grobot.dart';

class GrobotMaket extends StatefulWidget {
  const GrobotMaket({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GrobotMarketState();
}

class _GrobotMarketState extends State<GrobotMaket> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GrobotMarketCubit>(
        create: (_) => GrobotMarketCubit(),
        child: BlocBuilder<GrobotMarketCubit, GrobotMarketState>(buildWhen: (previous, current) {
          return previous != current;
        }, builder: (context, state) {
          final listGrobot = BlocProvider.of<GrobotMarketCubit>(context).listGrobot;
          switch (state) {
            case GrobotMarketState.success:
              {
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(
                      listGrobot!.length,
                      (index) => (listGrobot[index].grobot != null)
                          ? GroBotItem(
                              listGrobot[index].grobot!.gmodel!.cardUrl!,
                              listGrobot[index].grobot!.gmodel!.name!)
                          : const SizedBox()),
                );
              }
            case GrobotMarketState.failure:
              {
                return const Center(child: Text("Get Grobot failed!"));
              }
            default:
              {
                return const Center(child: CircularProgressIndicator());
              }
          }
        }));
  }
}
