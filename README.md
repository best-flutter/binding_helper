# binding_helper

Helper for WidgetsBinding.It is a easy way to use WidgetsBinding, 
for example: Get the size of a widget after the widget is rendered.

## Getting Started

### Install

add 
```
    binding_helper:
```

to your pubspec.yaml 


### Get the size of the widget


Using `GetRectMinxin`
```

class MyState extends State<MyWidget> width GetRectMinxin<MyWidget>{

    // The rect includs size and position of the widget
    @override
    void onGetRect(Rect rect) {
        ...you code
    }

}

```

Using `RectProvider`

```

 new RectProvider(child: myWidget,onGetRect: (Rect rect){
            /// rect is the `Rect` of myWidet
          _rect = rect;

},)

```


![](https://github.com/jzoom/images/raw/master/get_rect.gif)


### More easy way to use `WidgetsBinding` is coming soon.

