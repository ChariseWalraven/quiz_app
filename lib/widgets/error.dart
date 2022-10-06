import 'package:flutter/material.dart';

class ErrorGif extends StatelessWidget {
  const ErrorGif({super.key, this.children});

  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Whoops, something went wrong...",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Image.asset("assets/ohno.gif"),
          ...?children,
        ],
      ),
    );
  }
}
