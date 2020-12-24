import 'package:dovuihainao_flutter/src/configs/configs.dart';
import 'package:dovuihainao_flutter/src/resource/model/model.dart';
import 'package:dovuihainao_flutter/src/utils/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../base/base.dart';
import 'package:provider/provider.dart';

import '../presentation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeViewModel _viewModel;
  AnimationController animationVictoryController;
  AnimationController animationLoseController;
  Animation animationVictory;
  Animation animationLose;

  @override
  void initState() {
    super.initState();
    animationVictoryController = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    animationVictoryController.repeat(reverse: true);
    animationVictory =
        Tween<double>(begin: 0.8, end: 1.0).animate(animationVictoryController);

    animationLoseController = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    animationLoseController.repeat(reverse: true);
    animationLose =
        Tween<double>(begin: 0.8, end: 1.0).animate(animationLoseController);
  }

  @override
  void dispose() {
    animationVictoryController.dispose();
    animationLoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
        viewModel: HomeViewModel(repository: Provider.of(context)),
        onViewModelReady: (viewModel) {
          _viewModel = viewModel..init();
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
              Column(
                children: [WidgetAppBar(), _buildGameBoard()],
              ),
              WidgetVictory(
                  victorySubject: _viewModel.victorySubject,
                  explainSubject: _viewModel.explainSubject,
                  animationHand: animationVictory,
                  callback: _viewModel.updateWin),
              WidgetLose(
                  loseSubject: _viewModel.loseSubject,
                  explainSubject: _viewModel.explainSubject,
                  animation: animationLoseController,
                  callback: _viewModel.updateLose),
              WidgetGameOver(
                  gameOverSubject: _viewModel.gameOverSubject,
                  animation: animationLoseController,
                  callback: _viewModel.gameOver)
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildGameBoard() {
    return Expanded(
        child: FutureBuilder<QuestionModel>(
            future: _viewModel.randomQuestion(),
            builder: (context, snapshot) {
              bool status = snapshot.connectionState == ConnectionState.done;
              QuestionModel question = snapshot.data ?? QuestionModel();
              print(status);
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Stack(
                  children: [
                    _buildBoardQuestion(status, question.cauHoi),
                    _buildAnswers(status, question),
                    status ? SizedBox() : Center(child: WidgetCircleProgress())
                  ],
                ),
              );
            }));
  }

  Widget _buildAnswers(bool status, QuestionModel model) {
    print(model.a);
    List<AnswerModel> answers = [
      AnswerModel(value: model.a, action: _viewModel.chooseAnswerTrue),
      AnswerModel(value: model.b, action: _viewModel.chooseAnswerFalse),
      AnswerModel(value: model.c, action: _viewModel.chooseAnswerFalse),
      AnswerModel(value: model.d, action: _viewModel.chooseAnswerFalse),
    ];
    answers.sort((a, b) => _viewModel.rd.nextBool() ? 1 : -1);
    return AnimatedPositioned(
      duration: Duration(milliseconds: 250),
      top: Get.height / 3,
      left: status ? Get.width / 10 : -Get.width,
      child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          children: answers
              .map((answer) => WidgetAnswer(
                    answer: answer,
                    icon: _viewModel.chooseImages[answers.indexOf(answer)],
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildBoardQuestion(bool status, String question) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 350),
      top: status ? 0 : -Get.height / 3,
      left: Get.width / 20,
      child: Container(
        width: Get.width * 9 / 10,
        height: Get.height / 3,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.bgBoardQuestion),
                fit: BoxFit.scaleDown)),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<ProcessModel>(
                stream: AppShared.watchProcess(),
                builder: (context, snapshot) {
                  return Text(
                    "Cấp độ ${snapshot.data?.score ?? 1}",
                    style: AppStyles.DEFAULT_LARGE_BOLD.copyWith(
                        fontFamily: AppStyles.FONT_SUNSHINEY,
                        color: AppColors.yellow,
                        fontSize: 24),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            TweenAnimationBuilder(
                tween: IntTween(begin: 0, end: question?.length ?? 0),
                duration: Duration(milliseconds: 1500),
                builder: (context, value, child) {
                  return Text(
                    value > (question?.length ?? 0)
                        ? ""
                        : question?.substring(0, value) ?? "",
                    style: AppStyles.DEFAULT_MEDIUM_BOLD
                        .copyWith(color: Colors.white),
                  );
                }),
          ],
        )),
      ),
    );
  }
}
