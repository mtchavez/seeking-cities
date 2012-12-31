class PostViewController < UIViewController

  extend IB
  include SugarCube::CoreGraphics

  attr_accessor :post

  outlet :titleLabel
  outlet :webView

  def init_with_post(_post)
    init
    @post = _post
    self
  end

  def title
    @post ? @post.title : 'Article'
  end

  def viewDidLoad
    super
    self.navigationItem.title = self.title
    label_font = UIFont.fontWithName 'Georgia-Bold', size: 17
    titleLabel.font = label_font
    titleLabel.text = @post.title

    # webView.scrollView.backgroundColor = UIColor.clearColor
    webView.scrollView.bounces = false
    webView.setOpaque false

    @post.find do |p|
      @post = p
      update_view
    end
  end

  def update_view
    webView.scrollView.bounces = false
    # webView.canGoForward = false
    # webView.scrollView.backgroundColor = UIColor.clearColor
    webView.setBackgroundColor UIColor.clearColor
    webView.setOpaque false
    style   = %Q{
      <style type="text/css" media="screen">
        body {
          color: #333;
          font-family: 'StMarie-Thin', Helvetica, sans-serif;
          font-size: 0.9em;
        }
        a, a:visited, a:-webkit-any-link {
          color: rgb(167, 81, 26,) !important;
        }
      </style>
    }
    script  = %Q{
      <script type="text/javascript" charset="utf-8">
        var linkImages = document.querySelectorAll("a[href*='http://seekingcities.com/wp-content/uploads']");
        for (i = 0; i < linkImages.length; i++) {
          var parent = linkImages[i].parentElement;
          parent.removeChild(linkImages[i]);
        }
        var linkImages = document.querySelectorAll("a[href*='http://selenainthecity.files.wordpress.com']");
        for (i = 0; i < linkImages.length; i++) {
          var parent = linkImages[i].parentElement;
          parent.removeChild(linkImages[i]);
        }
        var images = document.querySelectorAll("img[src*='http://seekingcities.com/wp-content/uploads']");
        for(i=0; i< images.length; i++){
          var parent = images[i].parentElement;
          parent.removeChild(images[i]);
        }
      </script>
    }
    content = "#{style}#{@post.content}#{script}"
    webView.loadHTMLString content, baseURL: nil
    # webView.frame = Rect(Point(10, titleLabel.frame.height + 20 + 50), Size(300, 300))
    # self.view.addSubview @web_view
  end

  def webView(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
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
