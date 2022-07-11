# FlowerCode 花间小作

## 项目介绍

- 一款供插画爱好者学习、动手、交流的植物生活美学App，面向不同人群提供不同服务。
- 主要采用的技术有：SwiftUI、SceneKit、CoreML、ARKit。

## 页面设计

>  基本采用SwiftUI框架，但有些地方仍然无法逃脱UIKit的影子，如采用SceneKit的View之中，只能使用UIButton和UIStackView等组件的方式添加。（不过似乎也可以全都将SwiftUI封装为UIView，我有尝试过但是两个View之间的参数难以传递）

- 许多页面都是在期末考试周前赶工而成，代码风格比较凌乱，并且有许多页面并未全部完成。为体验效果更好，建议在iPhone12的Simulator上运行。

- 程序中许多TabBar都是在官方提供的TabView基础上魔改而成，~~因为官方所提供的TabView实在无法满足页面设计需求~~，可以参考[这篇博客](http://www.demodashi.com/demo/18920.html)的处理方式。

- SwiftUI中页面的跳转有以下几种方式：
  1. `NavigationView`和`NavigationLink`配合使用（最常用）
  2. `.sheet`修饰器（只能算是个子页面，用起来很方面，但好像无法做到全屏）
  3. `.overlay`修饰器（即设置`@State`变量，让新页面覆盖在原来的页面之上）
  4. `TabView`组件（一般用于多个平行页面的点击切换）
  
- 页面的布局可以采用GeometryReader先获取整个屏幕的大小，然后按照一定比例布置，这样可以做到在不同大小的屏幕都能正常显示。

- 可以参考一些SwiftUI的组件库
  1. [SwiftUIX](https://github.com/SwiftUIX/SwiftUIX)补充SwiftUI标准库，提供各种扩展和视图，但是相关文档较少。
  1. [Introspect](https://github.com/siteline/SwiftUI-Introspect)用于补充SwiftUI控件中提供的可控选项，如`TabView`和`Navigation`等。
  1. [SwiftUIOverlayContainer](https://github.com/fatbobman/SwiftUIOverlayContainer)用于在原来View上添加新的View。
  
  SwiftUI官方提供的组件可谓是很少，想设计一些比较复杂的页面是比较麻烦的，适合的组件库能大大提高页面的开发效率。
  
- SwiftUI中常用的组件和修饰器

  这部分是我个人的一些感受和理解，就不放在这了，具体可以[参考这里](https://gxyrious.github.io/2022/07/10/移动应用创新赛有感/)。
  
- 合理使用`@State`和`@Binding`

  SwiftUI采用MVVM框架，当@State变量发生改变时，会自动更新使用了@State变量的视图，并且@State可以通过@Binding在视图中进行传递，因而如果想某个页面的按钮引起其他页面的变化，可以采用如上的方式。
  
- SceneKit的使用

  - 想在SwiftUI中构建SceneKit页面，则View需要满足`UIViewRepresentable`协议，并实现其`makeUIView()`和 `updateUIView()`函数，分别用于初始化和更新视图；此外创建一个`Coordinator`作为该视图的代理，当原场景发生属性变动时，使用`coordinator`进行相关的处理。
  - SceneKit的主体是在`makeUIView()`中返回的`SCNView`对象，设该对象为`view`，我们可以在`view`中添加光源`SCNLight`、镜头`view.pointOfView`、手势检测`view.addGestureRecognizer()`、显示场景`view.scene`；而对于`view.scene`，它由一系列`SCNNode`以树形结构组成，可以在树的根节点添加子组件来加入场景，即`scene.rootNode.addChildNode()`函数。

## 致谢与感想

​        在期末周刚结束的7.1-7.8这一周时间，我的两位队友和我一起在较短的时间内肝出了3D创作页面的基本构造、拍照识别花材等技术实现，以及复赛视频的剪辑、文档的整理等工作，感谢队友们付出，希望我们能有机会冲进决赛！
