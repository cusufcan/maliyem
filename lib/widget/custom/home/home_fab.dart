import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gelir_gider_takibi/constant/base_color.dart';
import 'package:gelir_gider_takibi/constant/base_icon.dart';
import 'package:gelir_gider_takibi/constant/base_size.dart';
import 'package:gelir_gider_takibi/constant/base_string.dart';
import 'package:gelir_gider_takibi/service/provider/index.dart';
import 'package:provider/provider.dart';

class HomeFab extends StatefulWidget {
  const HomeFab({
    super.key,
    required this.addIncome,
    required this.addExpense,
    required this.addTransfer,
  });

  final VoidCallback addIncome;
  final VoidCallback addExpense;
  final VoidCallback addTransfer;

  @override
  State<HomeFab> createState() => _HomeFabState();
}

class _HomeFabState extends State<HomeFab> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _scaleAnimationValues;
  late Animation<double> _baseRotateAnimationValues;
  late Animation<double> _childRotateAnimationValues;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: BaseSize.animationNormal.toInt(),
      ),
    );

    _scaleAnimationValues = Tween<double>(
      begin: BaseSize.none,
      end: 1.0,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _baseRotateAnimationValues = Tween<double>(
      begin: BaseSize.none,
      end: pi / 4,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _childRotateAnimationValues = Tween<double>(
      begin: -pi,
      end: BaseSize.none,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  Widget _buildFab() {
    return Stack(
      children: [
        if (Provider.of<FabModel>(context, listen: false).isFabOpen)
          GestureDetector(
            onTap: () {
              Provider.of<FabModel>(context, listen: false).closeFab();
            },
            child: Container(
              color: Colors.black.withOpacity(0.3),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: BaseSize.fabBottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                  angle: _childRotateAnimationValues.value,
                  child: Transform.scale(
                    scale: _scaleAnimationValues.value,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: BaseSize.md,
                      ),
                      child: FloatingActionButton(
                        heroTag: BaseString.transfer,
                        onPressed: widget.addTransfer,
                        shape: const CircleBorder(),
                        tooltip: BaseString.transfer,
                        backgroundColor: BaseColor.transfer,
                        child: BaseIcon.transferWhite,
                      ),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _childRotateAnimationValues.value,
                  child: Transform.scale(
                    scale: _scaleAnimationValues.value,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: BaseSize.md,
                      ),
                      child: FloatingActionButton(
                        heroTag: BaseString.income,
                        onPressed: widget.addIncome,
                        shape: const CircleBorder(),
                        tooltip: BaseString.income,
                        backgroundColor: BaseColor.income,
                        child: BaseIcon.incomeWhite,
                      ),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _childRotateAnimationValues.value,
                  child: Transform.scale(
                    scale: _scaleAnimationValues.value,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: BaseSize.md,
                      ),
                      child: FloatingActionButton(
                        heroTag: BaseString.expense,
                        onPressed: widget.addExpense,
                        shape: const CircleBorder(),
                        tooltip: BaseString.expense,
                        backgroundColor: BaseColor.expense,
                        child: BaseIcon.expenseWhite,
                      ),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _baseRotateAnimationValues.value,
                  child: Consumer<FabModel>(
                    builder: (context, value, child) {
                      return FloatingActionButton(
                        heroTag: BaseString.add,
                        onPressed: value.changeFabOpen,
                        shape: const CircleBorder(),
                        tooltip: BaseString.add,
                        child: BaseIcon.add,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FabModel>(
      builder: (context, value, child) {
        if (value.isFabOpen) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
        return _buildFab();
      },
    );
  }
}
