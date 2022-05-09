import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool indicatorTopPosition;
  final Color primaryColor;
  final Color secondaryColor;
  const Slideshow({
    Key? key,
    required this.slides,
    this.indicatorTopPosition = false,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideShowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              Provider.of<_SlideShowModel>(context).primaryColor = primaryColor;
              Provider.of<_SlideShowModel>(context).secondaryColor =
                  secondaryColor;
              return _CreateSlideShow(
                  indicatorTopPosition: indicatorTopPosition,
                  slides: slides,
                  primaryColor: primaryColor,
                  secondaryColor: secondaryColor);
            },
          ),
        ),
      ),
    );
  }
}

class _CreateSlideShow extends StatelessWidget {
  const _CreateSlideShow({
    Key? key,
    required this.indicatorTopPosition,
    required this.slides,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  final bool indicatorTopPosition;
  final List<Widget> slides;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (indicatorTopPosition)
          _Dots(
              totalSlides: slides.length,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor),
        Expanded(
          child: _Slides(slides: slides),
        ),
        if (!indicatorTopPosition)
          _Dots(
              totalSlides: slides.length,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor)
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;
  final Color primaryColor;
  final Color secondaryColor;
  const _Dots(
      {Key? key,
      required this.totalSlides,
      required this.primaryColor,
      required this.secondaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      /* color: Colors.red, */
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            totalSlides,
            (index) => _Dot(
                index: index,
                primaryColor: this.primaryColor,
                secondaryColor: this.secondaryColor)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final Color primaryColor;
  final Color secondaryColor;
  const _Dot({
    Key? key,
    required this.index,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slideShowModel = Provider.of<_SlideShowModel>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: (slideShowModel.currentPage >= index - 0.5 &&
                slideShowModel.currentPage <= index + 0.5)
            ? slideShowModel.primaryColor
            : slideShowModel.secondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();
  @override
  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<_SlideShowModel>(context, listen: false).currentPageValue =
          pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: PageView(
        controller: pageViewController,
        children: widget.slides
            .map((slide) => _Slide(
                  slide: slide,
                ))
            .toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide({Key? key, required this.slide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      child: slide,
    );
  }
}

class _SlideShowModel with ChangeNotifier {
  double currentPage = 0;
  Color primaryColor = Colors.blue;
  Color secondaryColor = Colors.white;

  double get currentPageValue => currentPage;
  set currentPageValue(double value) {
    currentPage = value;
    notifyListeners();
  }

  Color get primaryColorValue => primaryColor;
  set primaryColorValue(Color value) {
    primaryColor = value;
    notifyListeners();
  }

  Color get secondaryColorValue => secondaryColor;
  set secondaryColorValue(Color value) {
    secondaryColor = value;
    notifyListeners();
  }
}
