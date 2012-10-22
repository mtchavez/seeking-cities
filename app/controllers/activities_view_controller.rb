class ActivitiesTableViewController < UITableViewController

  def viewDidLoad
    super
    @activities = []
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
    load_activities
  end

  def load_activities
    # Dispatch::Queue.concurrent.async do
      @activities = []
      Activity.index do |posts|
        @activities = posts.dup
        view.reloadData
      end
    #   Dispatch::Queue.main.sync { view.reloadData }
    # end
  end

  def title
    'Activities'
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
    @activities ? @activities.size : 0
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:cellIdentifier)
      cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton
      cell
    end

    activity = @activities[indexPath.row]
    cell.textLabel.text = activity.title
    cell.detailTextLabel.text = "(#{activity.post_count}) Articles"
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
    tag = @activities[indexPath.row]
    posts_controller = PostsTableViewController.alloc.init_with_tag(tag)
    navigationController.pushViewController(posts_controller, animated:true)
  end
end
