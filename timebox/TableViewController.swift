import UIKit

class TableViewController: UITableViewController {
    var timers: [Timer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        timers.append(Timer())
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("timer") else {
            fatalError("no cell found with identifier 'timer'")
        }
        
        guard let label = cell.detailTextLabel else {
            fatalError("time cell doesnt have a detailTextLabel")
        }
        
        let timer = timers[indexPath.row]
        
        label.text = "\(timer.duration)"
        
        return cell
    }
}
