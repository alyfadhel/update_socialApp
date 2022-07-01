import 'package:flutter/material.dart';
import 'package:new_social_app/compontents/compontents.dart';
import 'package:new_social_app/modules/login/login_screen.dart';
import 'package:new_social_app/shared/network/local/cache_helper.dart';
import 'package:new_social_app/shared/styles/cubit/cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel
{
  String? image;
  String? body;
  String? title;

  BoardingModel({
   required this.image,
   required this.body,
   required this.title,
  });
}
List<BoardingModel>boarding =
[
  BoardingModel(
      image: 'assets/images/image_start.png',
      body: 'On Boarding first Body',
      title: 'On Boarding first Title',
  ),
  BoardingModel(
      image: 'assets/images/image_middle.jpg',
      body: 'On Boarding second Body',
      title: 'On Boarding second Title',
  ),
  BoardingModel(
      image: 'assets/images/image_end.png',
      body: 'On Boarding third Body',
      title: 'On Boarding third Title',
  ),
];

bool isLast = false;

var boardingController = PageController();

void onSubmit(context)
{
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
  {
    if(value)
    {
      navigateAndFinish(context, const SocialLoginScreen());
    }
  });
}


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: TextButton(
                onPressed: ()
                {
                  onSubmit(context);
                },
                child:  Text(
                  'SKIP',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  ),
                ),
            ),

          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState(()
                    {
                      isLast = true;
                    });
                  }else{
                    setState(()
                    {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                      spacing: 4,
                      expansionFactor: 1.1,

                    ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      onSubmit(context);
                    }else{
                      boardingController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
   // mainAxisAlignment: MainAxisAlignment.center,
    children:
    [
      SizedBox(
        width: double.infinity,
        height: 300.0,
        child: Image(
         fit: BoxFit.cover,
         image: AssetImage(
           '${model.image}',
         ),
        ),
      ),
      const SizedBox(
        height: 70.0,
      ),
      Text(
        '${model.body}',
        style: Theme.of(context).textTheme.headline5,
      ),
      const SizedBox(
        height: 40.0,
      ),
      Text(
        '${model.title}',
        style: Theme.of(context).textTheme.headline6,
      ),
    ],
  );
}
