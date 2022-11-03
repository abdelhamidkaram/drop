import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../domain/entities/compound.dart';

class CompoundCardItem extends StatefulWidget {
  final List<Compound> compounds;

  final int index;

  const CompoundCardItem({Key? key,
    required this.index,
    required this.compounds})
      : super(key: key);

  @override
  State<CompoundCardItem> createState() => _CompoundCardItemState();
}

class _CompoundCardItemState extends State<CompoundCardItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 64.h,
                  width: 64.h,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            widget.compounds[widget.index].imgUrl ?? "",
                            height: 30,
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.compounds[widget.index].name ?? "..",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.compounds[widget.index].address ?? ".."),
                    ],
                  ),
                ),
                 IconButton(onPressed: (){
                   ProfileCubit.get(context)
                       .getDeleteCompounds(widget.compounds[widget.index].name)
                       .then((value){});
                 } , icon: const Icon(Icons.delete_forever),)
              ],
            ),
            SizedBox(
              height: 16.h,
            )
          ],
        );
      },
    );
  }
}