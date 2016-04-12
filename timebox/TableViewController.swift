import UIKit

class TableViewController: UITableViewController, UITextFieldDelegate {
    var timers: TimerStore = TimerStore()
    
    @IBAction func addButtonTapped() {
        self.timers.append()
        self.tableView.reloadData()
    }
    
    @IBAction func timerButtonTapped(button: UIButton) {
        timers.toggle(button.tag)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return timers.count
        case 1: return 1
        default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard timers.inRange(indexPath.row) else { fatalError("tried to create a cell for a timer index greater than size of timers") }
            guard let cell = tableView.dequeueReusableCellWithIdentifier("timer") as? TimerCell else {
                fatalError("no cell found with identifier 'timer'")
            }
            
            let timer = timers.get(indexPath.row)
            
            cell.configureWithTimer(timer, tag: indexPath.row)
            
            return cell
        default:
            return tableView.dequeueReusableCellWithIdentifier("addCell")!
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.section == 0
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        guard timers.inRange(indexPath.row) else { return }
        switch editingStyle {
        case .Delete:
            timers.delete(indexPath.row)
            tableView.reloadData()
        default:
            break
        }
    }
    
    // MARK: - Text field delegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        guard timers.inRange(textField.tag) else { return }
        timers.rename(textField.tag, newName: textField.text ?? "")
        tableView.reloadData()
    }
}
