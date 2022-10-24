import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/bloc/compound_register_cuibt.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/bloc/compound_register_states.dart';
import 'package:dropeg/features/auth/presentation/widgets/sign_up_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/compound.dart';

class CompoundsScreen extends StatefulWidget {
  const CompoundsScreen({Key? key}) : super(key: key);

  @override
  State<CompoundsScreen> createState() => _CompoundsScreenState();
}

class _CompoundsScreenState extends State<CompoundsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompoundCubit, CompoundRegisterStates>(
      builder: (context, state) {
        List<Compound> compounds = CompoundCubit.get(context).compounds;
        Widget compoundsView(
            CompoundRegisterStates state, List<Compound> compounds) {
          if (state is CompoundRegisterLoading) {
            return const SafeArea(
                child: Center(child: CircularProgressIndicator()));
          } else if (state is CompoundRegisterSuccess) {
            List<Widget> list = List.generate(
              compounds.length,
              (index) {
                return BuildCompoundItem(
                  compounds: compounds,
                  index: index,
                );
              },
            );
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      AppStrings.registeredCompoundsSubtitle,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Column(
                      children: list +
                          [
                            const SizedBox(
                              height: 16,
                            ),
                            SignUpBTN(
                                value: 0.30,
                                onTap: () {
                                  CompoundCubit.get(context)
                                          .choseCompounds
                                          .isEmpty
                                      ? AppToasts.errorToast(
                                          AppStrings.pleaseChooseAnyCompound)
                                      : Navigator.pushNamed(
                                          context, AppRouteStrings.addCar);
                                }),
                          ]),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(AppStrings.errorInternal),
            );
          }
        }

        return Scaffold(
          appBar: CustomAppbars.loginAppbar(
              context: context, height: 233, isAddCompoundsScreen: true),
          body: compoundsView(state, compounds),
        );
      },
    );
  }
}

class BuildCompoundItem extends StatefulWidget {
  final List<Compound> compounds;
  final int index;

  const BuildCompoundItem(
      {Key? key, required this.compounds, required this.index})
      : super(key: key);

  @override
  State<BuildCompoundItem> createState() => _BuildCompoundItemState();
}

class _BuildCompoundItemState extends State<BuildCompoundItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
                if (CompoundCubit.get(context)
                    .choseCompounds
                    .contains(widget.compounds[widget.index])) {
                  CompoundCubit.get(context)
                      .choseCompounds
                      .remove(widget.compounds[widget.index]);
                } else {
                  CompoundCubit.get(context)
                      .choseCompounds
                      .add(widget.compounds[widget.index]);
                }
              });
            },
            child: Card(
              color: isSelected ? AppColors.blueLight : AppColors.white,
              child: Container(
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(
                          color: AppColors.primaryColor,
                          width: 2,
                          style: BorderStyle.solid)
                      : null,
                  borderRadius: isSelected ? BorderRadius.circular(12) : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.compounds[widget.index].name.toString(),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(widget.compounds[widget.index].address
                                .toString()),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 155,
                        height: 84,
                        child: Center(
                            child: Image.network(widget
                                .compounds[widget.index].imgUrl
                                .toString())),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
