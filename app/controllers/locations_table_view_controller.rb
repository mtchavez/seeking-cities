class LocationsTableViewController < UITableViewController

  def viewDidLoad
    super
    self.navigationItem.title = self.title
    @locations = []
    # Uncomment the following line to preserve selection between presentations.

    # self.clearsSelectionOnViewWillAppear = false

    # Uncomment the following line to display an Edit button in the navigation
    # bar for this view controller.

    # self.navigationItem.rightBarButtonItem = self.editButtonItem
    # Dispatch::Queue.concurrent('home-data').async do
      # BW::HTTP.get('http://seekingcities.com/?json=get_recent_posts') do |response|
      #   result_data = BW::JSON.parse(response.body.to_str)
      #   @articles = result_data['posts'].map do |post|
      #     post.dup
      #   end
    # end
    load_locations
  end

  def load_locations
    # Dispatch::Queue.concurrent.async do
      @locations = []
      Location.index do |posts|
        @locations = posts.dup
        view.reloadData
      end
    #   Dispatch::Queue.main.sync { view.reloadData }
    # end
  end

  def title
    'Locations'
  end

  def viewDidUnload
    super

    # Release any retained subviews of the main view.
    # e.g. self.myOutlet = nil
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

## Table view data source

  def numberOfSectionsInTableView(tableView)
    # Return the number of sections.
    1
  end

  def tableView(tableView, numberOfRowsInSection:section)
    # Return the number of rows in the section.
    @locations ? @locations.size : 0
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = 'ListCell'
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) || begin
      cell = ListViewCell.alloc.initWithStyle UITableViewCellStyleValue1, reuseIdentifier: cellIdentifier
      cell
    end

    location = @locations[indexPath.row]
    # darkFont = [26, 22, 49].uicolor(1.0)
    darkFont = BubbleWrap.rgb_color(26, 22, 49)

    cell.nameLabel.text = location.title
    cell.nameLabel.font = UIFont.fontWithName 'StMarie-Thin', size: 18.0
    cell.nameLabel.color = darkFont

    cell.descriptionLabel.text = "#{location.post_count} Article(s)"
    cell.descriptionLabel.font = UIFont.fontWithName 'Helvetica-Bold', size: 12.0
    cell.descriptionLabel.color = darkFont


    selectionView = UIView.alloc.init
    selectionView.backgroundColor = BubbleWrap.rgb_color(193, 255, 254) #[193, 255, 254].uicolor(1.0)
    cell.selectedBackgroundView = selectionView
    cell
  end

=begin
  # Override to support conditional editing of the table view.
  def tableView(tableView, canEditRowAtIndexPath:indexPath)
    # Return false if you do not want the specified item to be editable.
    true
  end
=end

=begin
  # Override to support editing the table view.
  def tableView(tableView, commitEditingStyle:editingStyle forRowAtIndexPath:indexPath)
    if editingStyle == UITableViewCellEditingStyleDelete
      # Delete the row from the data source
      tableView.deleteRowsAtIndexPaths(indexPath, withRowAnimation:UITableViewRowAnimationFade)
    elsif editingStyle == UITableViewCellEditingStyleInsert
      # Create a new instance of the appropriate class, insert it into the
      # array, and add a new row to the table view
    end
  end
=end

=begin
  # Override to support rearranging the table view.
  def tableView(tableView, moveRowAtIndexPath:fromIndexPath, toIndexPath:toIndexPath)
  end
=end

=begin
  # Override to support conditional rearranging of the table view.
  def tableView(tableView, canMoveRowAtIndexPath:indexPath)
    # Return false if you do not want the item to be re-orderable.
    true
  end
=end

## Table view delegate

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    location = @locations[indexPath.row]
    self.performSegueWithIdentifier 'PostsTableSegue', sender: location
  end

  def prepareForSegue segue, sender:sender
    segue.destinationViewController.location = sender
  end

end
