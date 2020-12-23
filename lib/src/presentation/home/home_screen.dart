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

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel _viewModel;

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
                children: [_buildAppBar(), _buildGameBoard()],
              ),
              WidgetVictory(
                victorySubject: _viewModel.victorySubject,
                callback: _viewModel.updateWin
              ),
              WidgetLost(
                lostSubject: _viewModel.lostSubject,
                callback: _viewModel.updateLost
              )
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
    List<Widget> widgets = [
      WidgetAnswer(
        value: model.a,
        action: () {
          print("Is answer");
          _viewModel.victorySubject.add(true);
        },
      ),
      WidgetAnswer(
        value: model.b,
        action: () {
          _viewModel.lostSubject.add(true);
        },
      ),
      WidgetAnswer(
        value: model.c,
        action: () {
          _viewModel.lostSubject.add(true);
        },
      ),
      WidgetAnswer(
        value: model.d,
        action: () {
          _viewModel.lostSubject.add(true);
        },
      ),
    ];
    widgets.sort((a, b) => _viewModel.rd.nextBool() ? 1 : -1);
    return AnimatedPositioned(
      duration: Duration(milliseconds: 250),
      top: Get.height / 3,
      left: status ? Get.width / 10 : -Get.width,
      child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          children: widgets,
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
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
                    "LV: ${snapshot.data?.score ?? "1"}",
                    style: AppStyles.DEFAULT_MEDIUM_BOLD
                        .copyWith(color: Colors.white),
                  );
                }),
            Text(
              question ?? "",
              style:
                  AppStyles.DEFAULT_MEDIUM_BOLD.copyWith(color: Colors.white),
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 55,
      width: double.maxFinite,
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   HomeViewModel _viewModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseWidget<HomeViewModel>(
//         viewModel: HomeViewModel(repository: Provider.of(context)),
//         onViewModelReady: (viewModel) {
//           _viewModel = viewModel..init();
//         },
//         builder: (context, viewModel, child) {
//           return _buildBody(context);
//         });
//   }
//
//   Widget _buildBody(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: [
//         Container(
//           width: double.maxFinite,
//           height: double.maxFinite,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(AppImages.bgHome), fit: BoxFit.cover)),
//         ),
//         SafeArea(
//           child: Stack(
//             children: [
//               Column(
//                 children: [_buildAppBar(), _buildGameBoard()],
//               ),
//               WidgetVictory(
//                 victorySubject: _viewModel.victorySubject,
//               ),
//               WidgetLost(
//                 lostSubject: _viewModel.lostSubject,
//                 callback: ()=>setState((){}),
//               )
//             ],
//           ),
//         ),
//       ],
//     ));
//   }
//
//   Widget _buildGameBoard() {
//     return Expanded(
//         child: FutureBuilder<QuestionModel>(
//             future: _viewModel.randomQuestion(),
//             builder: (context, snapshot) {
//               bool status = snapshot.connectionState == ConnectionState.done;
//               QuestionModel question = snapshot.data ?? QuestionModel();
//               print(status);
//               return Container(
//                 width: double.maxFinite,
//                 height: double.maxFinite,
//                 child: Stack(
//                   children: [
//                     _buildBoardQuestion(status, question.cauHoi),
//                     _buildAnswers(status, question),
//                     status ? SizedBox() : Center(child: WidgetCircleProgress())
//                   ],
//                 ),
//               );
//             }));
//   }
//
//   Widget _buildAnswers(bool status, QuestionModel model) {
//     print(model.a);
//     List<Widget> widgets = [
//       WidgetAnswer(
//         value: model.a,
//         action: () {
//           print("Is answer");
//           _viewModel.victorySubject.add(true);
//         },
//       ),
//       WidgetAnswer(
//         value: model.b,
//         action: () {
//           _viewModel.lostSubject.add(true);
//         },
//       ),
//       WidgetAnswer(
//         value: model.c,
//         action: () {
//           _viewModel.lostSubject.add(true);
//         },
//       ),
//       WidgetAnswer(
//         value: model.d,
//         action: () {
//           _viewModel.lostSubject.add(true);
//         },
//       ),
//     ];
//     widgets.sort((a, b) => _viewModel.rd.nextBool() ? 1 : -1);
//     return AnimatedPositioned(
//       duration: Duration(milliseconds: 250),
//       top: Get.height / 3,
//       left: status ? Get.width / 10 : -Get.width,
//       child: Container(
//         padding: const EdgeInsets.only(top: 15, bottom: 15),
//         child: Column(
//           children: widgets,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBoardQuestion(bool status, String question) {
//     return AnimatedPositioned(
//       duration: Duration(milliseconds: 350),
//       top: status ? 0 : -Get.height / 3,
//       left: Get.width / 20,
//       child: Container(
//         width: Get.width * 9 / 10,
//         height: Get.height / 3,
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(AppImages.bgBoardQuestion),
//                 fit: BoxFit.scaleDown)),
//         child: Center(
//             child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             StreamBuilder<ProcessModel>(
//                 stream: AppShared.watchProcess(),
//                 builder: (context, snapshot) {
//                   return Text(
//                     "LV: ${snapshot.data?.score ?? "1"}",
//                     style: AppStyles.DEFAULT_MEDIUM_BOLD
//                         .copyWith(color: Colors.white),
//                   );
//                 }),
//             Text(
//               question ?? "",
//               style:
//                   AppStyles.DEFAULT_MEDIUM_BOLD.copyWith(color: Colors.white),
//             ),
//           ],
//         )),
//       ),
//     );
//   }
//
//   Widget _buildAppBar() {
//     return Container(
//       height: 55,
//       width: double.maxFinite,
//     );
//   }
// }
