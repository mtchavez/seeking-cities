class HomeViewController < UIViewController
  def viewDidLoad
    super
    navigationController.navigationBar.tintColor = :black.uicolor
    # Do any additional setup after loading the view.
    # A light grey background to separate the Tag table from the Color info
    width = self.view.frame.size.width
    image_width = 52

    location_image = 'globe@2x'.uiimage
    location_btn = UIButton.custom
    location_btn.setBackgroundImage location_image, forState: :normal.uicontrolstate
    location_btn.frame = [[(width / 2) - (image_width / 2), 60], [52, 52]]
    location_btn.when(UIControlEventTouchUpInside) do
      locations_controller = LocationsTableViewController.alloc.init
      self.navigationController.pushViewController locations_controller, animated: true
    end
    self.view.addSubview location_btn

    activity_image = 'people_family@2x'.uiimage
    activity_btn = UIButton.custom
    activity_btn.setBackgroundImage activity_image, forState: :normal.uicontrolstate
    activity_btn.frame = [[(width / 2) - (image_width / 2), 160], [52, 52]]
    activity_btn.when(UIControlEventTouchUpInside) do
      activities_controller = ActivitiesTableViewController.alloc.init
      self.navigationController.pushViewController activities_controller, animated: true
    end
    self.view.addSubview activity_btn

    itinerary_image = 'page_empty@2x'.uiimage
    image_width = 52
    itinerary_view = UIImageView.alloc.initWithImage itinerary_image
    itinerary_view.frame = [[(width / 2) - (image_width / 2), 260], [52, 52]]
    self.view.addSubview itinerary_view
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
