class PostsTableViewController < UITableViewController

  attr_accessor :location, :tag

  def init_with_location(_location)
    init
    @location = _location
    title = @location.title
    self
  end

  def init_with_tag(_tag)
    init
    @tag = _tag
    self
  end

  def viewDidLoad
    super
    self.title = set_title
    # Uncomment the following line to preserve selection between presentations.

    # self.clearsSelectionOnViewWillAppear = false

    # Uncomment the following line to display an Edit button in the navigation
    # bar for this view controller.

    # self.navigationItem.rightBarButtonItem = self.editButtonItem
    load_posts_from_location if @location
    load_posts_from_tag if @tag
  end

  def set_title
    description = if @location
      @location.title
    elsif @tag
      @tag.title
    else
      'Articles'
    end
    self.navigationItem.title = description
  end

  def load_posts_from_location
    Post.from_category(location) do |posts|
      @posts = posts.dup
      view.reloadData
    end
  end

  def load_posts_from_tag
    Post.from_tag(tag) do |posts|
      @posts = posts.dup
      view.reloadData
    end
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
    @posts ? @posts.size : 0
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:cellIdentifier)
      cell
    end

    post = @posts[indexPath.row]
    cell.textLabel.text = post.title
    cell.imageView.image = UIImage.imageWithData(NSData.dataWithContentsOfURL(post.thumbnail.to_s.nsurl))
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
    post = @posts[indexPath.row]
    post_controller = PostViewController.alloc.init_with_post(post)
    navigationController.pushViewController(post_controller, animated: true)
  end
end
