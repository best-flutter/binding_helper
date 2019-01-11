library binding_helper;

import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

abstract class AfterRenderingMixin<T extends StatefulWidget> extends State<T> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback(onAfterRendering);
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback(onAfterRendering);
  }

  void onAfterRendering(Duration timeStamp);
}

///
/// Provide a Rect after the widget is rendered.
///
/// Easy to use ,
///
/// class MyState extends State<MyWidget> width GetRectMinxin<MyWidget>{
///
///   ...
///    @override
///      void onGetRect(Rect rect) {
///        ... you code
///      }
///   ...
///
/// }
///
mixin GetRectMinxin<T extends StatefulWidget> on State<T> {
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback(onAfterRendering);
  }

  BuildContext get context;

  void didUpdateWidget(T oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback(onAfterRendering);
  }

  void onAfterRendering(Duration timeStamp) {
    RenderObject renderObject = context?.findRenderObject();
    if (renderObject != null) {
      Size size = renderObject.paintBounds.size;
      Vector3 vector3 = renderObject.getTransformTo(null)?.getTranslation();
      onGetRect(
          new Rect.fromLTWH(vector3?.x, vector3?.y, size?.width, size?.height));
    }else{
     // onGetRect(new Rect.fromLTWH(0.0, 0.0, 0.0, 0.0));
    }

  }

  void onGetRect(Rect rect);
}

typedef void OnGetRect(Rect rect);

/// This widget is useful when you want to get the Rect of the child widget
///
class RectProvider extends StatefulWidget {
  ///
  final Widget child;

  /// Get rect callback
  final OnGetRect onGetRect;

  RectProvider({@required this.child, @required this.onGetRect})
      : assert(child != null),
        assert(onGetRect != null);

  @override
  State<StatefulWidget> createState() {
    return new _RectProviderState();
  }
}

class _RectProviderState extends State<RectProvider>
    with GetRectMinxin<RectProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void onGetRect(Rect rect) {
    widget.onGetRect(rect);
  }
}
