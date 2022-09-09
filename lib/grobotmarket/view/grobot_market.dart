import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/grobotmarket/cubit/grobot_market_cubit.dart';
import 'package:flutter_project/grobotmarket/cubit/grobot_market_state.dart';
import 'package:flutter_project/grobotmarket/view/widget/grobot_item.dart';

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
        child: BlocBuilder<GrobotMarketCubit, GrobotMarketState>(
            buildWhen: (previous, current) {
          return previous != current;
        }, builder: (context, state) {
          final listGrobot =
              BlocProvider.of<GrobotMarketCubit>(context).listGrobot;
          switch (state) {
            case GrobotMarketState.success:
              {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: listGrobot!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (1 / 1.3),
                        crossAxisCount: 2,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                      ),
                      itemBuilder: (context, index) =>
                          GroBotItem(listGrobot[index].grobot!.gmodel!),
                    ));
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
