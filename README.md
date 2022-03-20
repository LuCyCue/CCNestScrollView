# CCNestScrollView
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CCUnreadManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CCNestScrollView'
```

## How to use
* UIScrollView嵌套中在角色有
子UIScrollView 嵌套在父UIScrollView中
```Objc
/// 嵌套方案中的角色
typedef NS_ENUM(NSUInteger, CCNestScrollRole) {
    CCNestScrollRoleNone,    //无
    CCNestScrollRoleChild,   //子scrollview
    CCNestScrollRoleFather,  //父scrollview
};
```
* 父UIScrollView设置
```Objc
    self.fatherscrollView.hookGestureDelegate = YES; //开启手势代理劫持
    self.fatherscrollView.shouldRecognizeSimultaneously = YES; //开启多手势识别
    self.fatherscrollView.role = CCNestScrollRoleFather;//设置角色
    self.fatherscrollView.canScroll = YES;  //默认要开启
    self.fatherscrollView.criticalOffset =  160; //父scrollview为切换到子scrollview滚动的偏移值
```

* 子UIScrollView设置
```Objc
    self.childScrollView.role = CCNestScrollRoleChild;  //设置角色
    self.childScrollView.superSrcollView = self.fatherscrollView;//设置父UIScrollView
    self.childScrollView.criticalOffset = 0;// 子scrollview 为切换到父scrollview滚动的偏移值
    self.fatherscrollView.childScrollView = self.childScrollView; //赋值给父UIScrollView作为子scrollview
```
* 如果有多个父UIScrollView有多个嵌套多个UIScrollView
需要动态设置 childScrollView 属性，轮到哪个子UIScrollView显示的时候就设为哪个。
详情参考Example
## Author

lucc, lccjust123@163.com
