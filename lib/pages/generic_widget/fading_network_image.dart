import 'package:flutter/material.dart';

class FadingNetworkImage extends StatefulWidget {
  final String url;

  const FadingNetworkImage({Key? key, required this.url}) : super(key: key);

  @override
  _FadingNetworkImageState createState() => _FadingNetworkImageState();
}

class _FadingNetworkImageState extends State<FadingNetworkImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.url,
      // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
      //   _controller.reset();
      //   _controller.forward();
      //   return FadeTransition(opacity: _animation, child: child);
      // },
      loadingBuilder: (context, child, loadingProgress) {
        final totalBytes = loadingProgress?.expectedTotalBytes;
        final bytesLoaded = loadingProgress?.cumulativeBytesLoaded;
        if (totalBytes != null && bytesLoaded != null) {
          return LinearProgressIndicator(
            value: bytesLoaded / totalBytes,
          );
        } else {
          return child;
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return Text('Error!');
      },
    );
  }
}
