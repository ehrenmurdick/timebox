import UIKit

class TableViewController: UITableViewController {
    var timers: [Timer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        timers.append(Timer())
    }
    
    @IBAction func timerButtonTapped(button: UIButton) {
        timers[button.tag] = timers[button.tag].toggle()
        let indexPath = NSIndexPath(forRow: button.tag, inSection: 0)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("timer") as? TimerCell else {
            fatalError("no cell found with identifier 'timer'")
        }
        
        let timer = timers[indexPath.row]
        
        cell.configureWithTimer(timer, tag: indexPath.row)
        
        return cell
    }
}
