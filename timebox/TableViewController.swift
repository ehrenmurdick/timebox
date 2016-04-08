import UIKit

class TableViewController: UITableViewController, UITextFieldDelegate {
    let timerStore: TimerStore = TimerStore.sharedStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerStore.appendNewTimer()
    }
    
    @IBAction func addButtonTapped() {
        timerStore.appendNewTimer()
        tableView.reloadData()
    }
    
    @IBAction func timerButtonTapped(button: UIButton) {
        timerStore.toggleTimer(button.tag)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return timerStore.count
        case 1: return 1
        default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCellWithIdentifier("timer") as? TimerCell else {
                return UITableViewCell()
            }
            
            guard let timer = timerStore.timerAtIndex(indexPath.row) else { return UITableViewCell() }
            cell.configureWithTimer(timer, tag: indexPath.row)
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCellWithIdentifier("addCell") else { return UITableViewCell() }
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.section == 0
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            timerStore.deleteAtIndex(indexPath.row)
            tableView.reloadData()
        default:
            break
        }
    }
    
    // MARK: - Text field delegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        guard let timer = timerStore.timerAtIndex(textField.tag) else { return }
        timerStore.updateTimerAtIndex(textField.tag, newTimer: timer.rename(textField.text ?? ""))
        tableView.reloadData()
    }
}
