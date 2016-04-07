import UIKit

class TableViewController: UITableViewController, UITextFieldDelegate {
    var timers: [Timer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timers.append(Timer.empty())
    }
    
    @IBAction func addButtonTapped() {
        self.timers.append(Timer.empty())
        self.tableView.reloadData()
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
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
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
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            timers.removeAtIndex(indexPath.row)
            tableView.reloadData()
        default:
            break
        }
    }
    
    // MARK: - Text field delegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        timers[textField.tag] = timers[textField.tag].rename(textField.text ?? "")
        tableView.reloadData()
    }
}
