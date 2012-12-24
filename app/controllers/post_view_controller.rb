class PostViewController < UIViewController

  include SugarCube::CoreGraphics

  # extend IB

  attr_accessor :post

  # outlet :title, UILabel

  def init_with_post(_post)
    init
    @post = _post
    self
  end

  def loadView
    views = NSBundle.mainBundle.loadNibNamed 'PostView', owner: self, options: nil
    self.view = views[0]
  end

  def title
    @post ? @post.title : 'Article'
  end

  def viewDidLoad
    super
    label_font = UIFont.fontWithName 'Georgia-Bold', size: 17
    label_size = @post.title.sizeWithFont label_font, constrainedToSize: Size(250, 10), lineBreakMode: UILineBreakModeWordWrap
    @title_label = UILabel.alloc.initWithFrame [[10, 30], [label_size.width, label_size.height + 20]]
    @title_label.font = label_font
    @title_label.numberOfLines = 0
    @title_label.lineBreakMode = UILineBreakModeWordWrap
    @title_label.text = @post.title
    self.view.addSubview @title_label

    @post.find do |p|
      @post = p
      update_view
    end
  end

  def update_view
    label_font = UIFont.fontWithName 'Georgia-Bold', size: 17
    label_size = @post.title.sizeWithFont label_font, constrainedToSize: Size(250, 10), lineBreakMode: UILineBreakModeWordWrap
    @web_view = UIWebView.alloc.init
    @web_view.delegate = self
    @web_view.scrollView.bounces = false
    # @web_view.canGoForward = false
    # @web_view.scrollView.backgroundColor = UIColor.clearColor
    # @web_view.setBackgroundColor UIColor.clearColor
    # @web_view.setOpaque false
    @web_view.loadHTMLString @post.content, baseURL: nil
    @web_view.stringByEvaluatingJavaScriptFromString %Q{
      var a = getDivId.getElementsByTagName("a");
      for(var i=0; i< a.length; i++) {
        a[i].onclick(e){ e.stopPropagation(); return false; }
      }
    }
    @web_view.frame = Rect(Point(10, label_size.height + 20 + 50), Size(300, 300))
    self.view.addSubview @web_view
  end

  def webView(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
    # p request.inspect
    # p navigationType.inspect
    # p request.URL.query.inspect
    # return false if request.URL.query.to_s.match(/\.(jpe?g|gif|png)$/i)
    # true
    
    if navigationType == UIWebViewNavigationTypeLinkClicked
        UIApplication.sharedApplication.openURL(request.URL)
      return false
    end

    true
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

end
