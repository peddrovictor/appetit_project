import 'package:flutter/material.dart';

push(BuildContext context, Widget page, bool replacement) {
  PageRouteBuilder pageRouter = PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
  );

  if (replacement) return Navigator.pushReplacement(context, pageRouter);

  return Navigator.push(context, pageRouter);
}

pop<T extends Object>(context, [T result]) {
  Navigator.pop(context, result);
}
