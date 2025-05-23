import 'package:examenmobile/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:flutter/cupertino.dart';

class TCurveEdgedWidget extends StatelessWidget {
  const TCurveEdgedWidget({
    super.key, this.child,
  });

  final Widget?child ;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: child,
    );
  }
}