import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:flutter/material.dart';
import '../base/base.dart';
import 'package:provider/provider.dart';

import '../presentation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
        viewModel: HomeViewModel(repository: Provider.of(context)),
        onViewModelReady: (viewModel) {
          viewModel.init();
        },
        builder: (context, viewModel, child) {
          return _buildBody(context);
        });
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.bgHome), fit: BoxFit.cover)),
        ),
        SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildAppBar(),
                      _buildBoardQuestion(),
                      _buildAnswers()
                    ],
                  ),
                ),
              ),
              WidgetVictory(),
              WidgetLost()
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildAnswers() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 25, 15, 35),
      child: Column(
        children: [
          WidgetAnswer(),
          WidgetAnswer(),
          WidgetAnswer(),
          WidgetAnswer(),
        ],
      ),
    );
  }

  Widget _buildBoardQuestion() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 25, 15, 35),
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.bgBoardQuestion),
                    fit: BoxFit.scaleDown)),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container();
  }
}
