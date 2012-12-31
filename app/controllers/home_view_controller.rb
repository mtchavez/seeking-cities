class HomeViewController < UIViewController

  extend IB

  outlet :location_btn
  outlet :activity_btn
  outlet :itinerary_btn
  outlet :location_label
  outlet :activity_label
  outlet :itinerary_label

  def viewDidLoad
    super
    navColor = [29, 36, 52].uicolor(1.0)
    darkFont = [26, 22, 49].uicolor(1.0)
    stMarie  = UIFont.fontWithName 'StMarie-Thin', size: 32.0
    navigationController.navigationBar.tintColor = navColor

    location_label.setTitleColor darkFont, forState: :normal.uicontrolstate
    location_label.setTitleColor darkFont, forState: :highlighted.uicontrolstate
    location_label.titleLabel.font = stMarie

    activity_label.setTitleColor darkFont, forState: :normal.uicontrolstate
    activity_label.setTitleColor darkFont, forState: :highlighted.uicontrolstate
    activity_label.titleLabel.font = stMarie

    itinerary_label.setTitleColor darkFont, forState: :normal.uicontrolstate
    itinerary_label.setTitleColor darkFont, forState: :highlighted.uicontrolstate
    itinerary_label.titleLabel.font = stMarie
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

  def nav_btn_touched sender
    segue = case sender.tag
    when 1
      'LocationsSegue'
    when 2
      'ActivitiesSegue'
    when 3
      'PostsTableSegue'
    else
      return false
    end
    self.performSegueWithIdentifier segue, sender: self
  end

  def prepareForSegue segue, sender:sender
    if segue.identifier.match(/poststablesegue/i)
      segue.destinationViewController.tag = Activity.new title: 'Itinerary', id: 18, description: '', slug: 'itinerary', post_count: 3
    end
  end

end
