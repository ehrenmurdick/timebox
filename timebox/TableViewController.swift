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
        let timer = timers[button.tag].toggle()
        timers = timers.map {
            (timer) -> Timer in
            return timer.stop()
        }
        timers[button.tag] = timer
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
            guard indexPath.row < timers.endIndex else { fatalError("tried to create a cell for a timer index greater than size of timers") }
            guard let cell = tableView.dequeueReusableCellWithIdentifier("timer") as? TimerCell else {
                fatalError("no cell found with identifier 'timer'")
            }
            
            let timer = timers[indexPath.row]
            
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
        guard indexPath.row < timers.endIndex else { return }
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
        guard textField.tag < timers.endIndex else { return }
        timers[textField.tag] = timers[textField.tag].rename(textField.text ?? "")
        tableView.reloadData()
    }
}
