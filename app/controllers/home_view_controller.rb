class HomeViewController < UIViewController

  def viewDidLoad
    super
    navigationController.navigationBar.tintColor = :black.uicolor
    # Do any additional setup after loading the view.
    # A light grey background to separate the Tag table from the Color info
    bgColor = [252, 244, 227].uicolor(1.0)
    darkFont = [26, 22, 49].uicolor(1.0)
    view.backgroundColor = bgColor
    width = view.frame.size.width
    image_width = 75

    mapImage = 'map@2x'.uiimage
    mapImageView  = UIImageView.alloc.initWithImage mapImage
    mapImageView.frame = [[-10,0], [339, 218]]
    view.addSubview mapImageView

    location_image = 'location@2x'.uiimage
    location_btn = UIButton.custom
    location_btn.setBackgroundImage location_image, forState: :normal.uicontrolstate
    location_btn.frame = [[10, 190], [image_width, image_width]]
    location_btn.when(UIControlEventTouchUpInside) do
      locations_controller = LocationsTableViewController.alloc.init
      self.navigationController.pushViewController locations_controller, animated: true
    end
    view.addSubview location_btn

    locLabel = UILabel.new
    locLabel.text = 'by location'
    locLabel.textColor = darkFont
    locLabel.font = UIFont.fontWithName 'StMarie-Thin', size: 32.0
    locLabel.frame = [[10 + image_width + 10, 190], [view.frame.width, image_width]]
    locLabel.backgroundColor = bgColor
    view.addSubview locLabel

    activity_image = 'activity@2x'.uiimage
    activity_btn = UIButton.custom
    activity_btn.setBackgroundImage activity_image, forState: :normal.uicontrolstate
    activity_btn.frame = [[10, 260], [image_width, image_width]]
    activity_btn.when(UIControlEventTouchUpInside) do
      activities_controller = ActivitiesTableViewController.alloc.init
      self.navigationController.pushViewController activities_controller, animated: true
    end
    view.addSubview activity_btn

    locLabel = UILabel.new
    locLabel.text = 'by activity'
    locLabel.textColor = darkFont
    locLabel.font = UIFont.fontWithName 'StMarie-Thin', size: 32.0
    locLabel.frame = [[10 + image_width + 10, 260], [view.frame.width, image_width]]
    locLabel.backgroundColor = bgColor
    view.addSubview locLabel

    itinerary_image = 'itinerary@2x'.uiimage
    itinerary_view = UIImageView.alloc.initWithFrame [[10, 330], [image_width, image_width]]
    itinerary_view.setImage itinerary_image
    view.addSubview itinerary_view

    locLabel = UILabel.new
    locLabel.text = 'by itinerary'
    locLabel.textColor = darkFont
    locLabel.font = UIFont.fontWithName 'StMarie-Thin', size: 32.0
    locLabel.frame = [[10 + image_width + 10, 330], [view.frame.width, image_width]]
    locLabel.backgroundColor = bgColor
    view.addSubview locLabel
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

  def title
    'Seeking Cities'
  end

end
