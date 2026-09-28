import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/auth/presentation/models/splash_data.dart';
import 'package:big_cart/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// The welcome slides, shown on the first launch only. The photo and text
/// swipe; the dots and button sit on a fixed layer above them, so a tap always
/// lands on the button, even mid-slide.
class SplashScreen extends StatefulWidget {
  final int index;
  const SplashScreen(this.index, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController pageController = PageController();
  static final _lastPage = splashDataList.length - 1;

  // The slide the button is heading to. Counted here rather than read off the
  // controller, so quick taps each move exactly one slide instead of landing
  // on a half-finished one.
  int _page = 0;
  // set while a tap's animation runs, so the slides it passes don't reset _page
  int _animation = 0;
  bool _animating = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> onClick() async {
    if (_page == _lastPage) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const WelcomePage()),
        (route) => false,
      );
      return;
    }
    setState(() => _page++);
    final animation = ++_animation;
    _animating = true;
    await pageController.animateToPage(
      _page,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
    // a newer tap may have taken over this animation
    if (animation == _animation) _animating = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: splashDataList.length,
            // swipes move _page too; a tap's own animation doesn't
            onPageChanged: (page) {
              if (!_animating) setState(() => _page = page);
            },
            itemBuilder: (context, index) => Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    splashDataList[index].imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50.r, 90.h, 50.r, 0),
                    child: Column(
                      children: [
                        Text(
                          splashDataList[index].title,
                          style: Fonts.titleBold(size: 30),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        if (index == 0)
                          Image.asset(
                            'assets/logo.png',
                            width: 150.w,
                          ),
                        Text(
                          splashDataList[index].subtitle,
                          style: Fonts.paragraphRegular(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // pinned to the bottom, so the button sits in the same place on
          // every slide and every phone height
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(50.r, 0, 50.r, 30.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: splashDataList.length,
                      effect: ScaleEffect(
                        scale:
                            1, //no animation intended, just want to reach the inner parameters
                        dotColor: Colors.grey,
                        activeDotColor: Colors.green,
                        dotHeight: 10.r,
                        dotWidth: 10.r,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    GreenGradientButton(
                      onClick,
                      _page == _lastPage ? 'Get Started' : 'Next',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
