class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    application.setStatusBarStyle :black.uistatusbarstyle, animated: 'YES'
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    storyboard = if is_iphone5?
      UIStoryboard.storyboardWithName 'Storyboard5', bundle: nil
    else
      UIStoryboard.storyboardWithName 'Storyboard', bundle: nil
    end
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController storyboard.instantiateInitialViewController
    @window.makeKeyAndVisible
    true
  end

  def is_iphone5?
    return unless Device.iphone?
    return false if Device.screen.height <= 480.0
    true
  end

  def applicationWillResignActive(application)
    # Sent when the application is about to move from active to inactive state. This can occur for certain types of
    # temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application
    # and it begins the transition to the background state. Use this method to pause ongoing tasks, disable timers, and
    # throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  end

  def applicationDidEnterBackground(application)
    # Use this method to release shared resources, save user data, invalidate timers, and store enough application
    # state information to restore your application to its current state in case it is terminated later.If your
    # application supports background execution, this method is called instead of applicationWillTerminate: when the
    # user quits.
  end

  def applicationWillEnterForeground(application)
    # Called as part of the transition from the background to the inactive state; here you can undo many of the
    # changes made on entering the background.
  end

  def applicationDidBecomeActive(application)
    # Restart any tasks that were paused (or not yet started) while the application was inactive. If the application
    # was previously in the background, optionally refresh the user interface.
  end

  def applicationWillTerminate(application)
    # Called when the application is about to terminate. Save data if appropriate. See also
    # applicationDidEnterBackground
  end

=begin
  # Optional UITabBarControllerDelegate method.
  def tabBarController(tabBarController, didSelectViewController:viewController)
  end
=end

=begin
  # Optional UITabBarControllerDelegate method.
  def tabBarController(tabBarController, didEndCustomizingViewControllers:viewControllers, changed:changed)
  end
=end
end
