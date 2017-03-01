# DeepLikingDemo
Deep Linking demo
# iOS中的深层链接(Deep Linking in iOS)
src: [http://blog.originate.com/blog/2014/04/22/deeplinking-in-ios/]
demoSrc: [https://github.com/vipulvpatil/deeplinking-in-ios]
---- 

深度链接是使用一个超链接直接定位到app中的特定内容。这个特定的内容可以使一个特定的视图，一个特别的页面或者是一个特定的标签。

## 深度链接的效果
1. AppStroe 下载 Twitter app；
2. 打开 Twitter app，登陆后关闭它；（如果搞不定，你懂得😉）
3. 接下来，在你的手机Safari中打开 *twitter://timeline*链接；
4. iOS 系统会直接切换到你的 Twitter app并且前往你的时间轴（timeline）;
5. 现在，在手机的Safari中打开链接*twitter://post?message=using%20deeplinking. *，这次Twitter会直接打开已经使用的深度链接并且准备发送推文。

## 深度链接有哪些用途
1. 在app启动后展示不同的登陆页面；
2. 通过从其他应用启动并且传递消息，实现应用内部通信；
3. 在整个应用程序中创建基于URI（没错就是URI，不是URL奥）的导航方案；
4. 通过让其他应用直接打开我们的应用来集成两个应用；
5. 记录和分析用户行为，确定该用户是从哪里登陆你的应用的

## 深度链接实现

### 1. 创建app并且启用深度链接（Create an app and enable deep linking）
首先，在Xcode中创建一应用程序，并添加一个导航控制器。当然也需要创建一些其他的VC以备后用。
想让deep linking 生效，需要套Xcode的 **Info**选项卡中的 **URL Types**中，点击 + 号，之后添加一个标识和一个url scheme。**注意，你要保证你选择的 url scheme 和 标识是唯一的。**记住你输入的url scheme，因为这是iOS系统知道如何打开你app的唯一方式。实例中注册的url scheme为：
'' dlapp

如果你要想确认你的 url scheme有没有生效，可以通过 Info.plist 文件查看一下有没有 *URL Types*的条目。展开他你就会看到你刚才注册的url scheme方案。现在Xcode运行你的应用，然后在 Safari Mobile 中输入 dlapp://，如果能打开你的应用，那么证明你已经将url scheme设置成功了。

### 2. 处理你的深度链接 URL
现在，你已经确认你的 deep linking 可以正常工作，我们需要处理用于登陆app的这个url。目前的状态时，你的app可以通过使用这个简单的url登陆，但是它除此之外还不能做些其他的事情。如果想要做更多的事情，我们需要复写AppDelegate中的一个函数：

```objc
 // 处理 url scheme（iOS 4.2 ~ iOS 9）
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
     return YES;
 }
 //iOS 9 之后使用这个方法
 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
 
     return YES;
}
```

**注意：上面的方法并非默认存在，需要我们自己添加。**这个方法在你的app使用url-scheme方式登陆的时候调用。传入的参数依次为：
- **url**： 用于启动应用程序完成的url；
- **sourceApplication**： 调用URL的应用程序的ID
- **annotation**：一个属性列表对象可以用来传递一些额外的信息

url 的格式如下：
`scheme：//host/path`

分别作出解释：
- **scheme**: iOS 系统通过 url scheme 识别应该打开哪个app。注意，这里的url scheme 事先必须注册过了，否则不起作用。（其实就是我们之前做的那件事情）；
- **host**: 类似于网络上网站/服务器的名称。你可以在应用程序中处理多个host；
- **path**: 通过这个 path ，app可以定位到某个页面或者某个标签；
通常情况下，你是使用**host**和**path**来定位用户打开的页面的。

这个方法实际的内容可以依据你的特殊需要来定，基于本篇文章的目的，我们的需求是：根据不同的host和path加载一个特定的 ViewController

```objc
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
	   if([[url host] isEqualToString:@"page"]){
	     if([[url path] isEqualToString:@"/page1"]){
	       [self.mainController pushViewController:[[OneVC alloc] init] animated:YES];
	     }
	return YES;
}
```

在第 2 行检查 url 中host和我们程序中定义的是否一致，也就是是否和“page”相同。匹配之后，就会根据不同的path来加载不同的控制器了。通过这种方式我们就可以处理任何一个我们定义过的url来展示不同的页面。但是有一点需要注意，app可以通过url启动，无论这个函数是否可以处理这个url。在这种情况下，我们在该方法中返回 NO 告诉iOS，这个网址不是有该应用程序来处理的。

在示例中，我们处理了四个不同的url：
- dlapp：// page / main
- dlapp：// page / page1
- dlapp：// page / page2
- dlapp：// page / page

这里是处理上述网址的完整demo：
```objc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    UINavigationController *nav = (UINavigationController *)application.keyWindow.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if([[url host] isEqualToString:@"page"]){
        if([[url path] isEqualToString:@"/main"]){
            [nav popToRootViewControllerAnimated:YES];
        }
        else if([[url path] isEqualToString:@"/page1"]){
            UIViewController    *oneVC = [storyboard instantiateViewControllerWithIdentifier:@"one"];
            [nav  pushViewController:oneVC animated:YES];
        }
        else if([[url path] isEqualToString:@"/page2"]){
            UIViewController    *twoVC = [storyboard instantiateViewControllerWithIdentifier:@"two"];
            [nav pushViewController:twoVC animated:YES];
        }
        else if([[url path] isEqualToString:@"/page3"]){
            UIViewController    *threeVC = [storyboard instantiateViewControllerWithIdentifier:@"three"];
            [nav pushViewController:threeVC animated:YES];
        }
        else{
            return NO;
        }
        return YES;
    }
    else{
        return NO;
    }
    
}

//ios9以后用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    NSString *sourceApp = [options objectForKey:UIApplicationOpenURLOptionsSourceApplicationKey];
    return [self application:app openURL:url sourceApplication:sourceApp annotation:options];
}

```
## 结论
文章中一app处理url跳转到不同的页面展示了URl Scheme 的基础功能。通过拆分 url 我们可以做更多的事情：

1. 自定义打开页面的外观
2. 预先填充到页面上某些元素
3. 跟踪用户如何访问你的应用 
4. … …

