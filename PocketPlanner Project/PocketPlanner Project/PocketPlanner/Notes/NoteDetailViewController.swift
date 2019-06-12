import UIKit

import Foundation
class NoteDetailViewController: UITableViewController, UITextFieldDelegate {
    //New ToDo controls to change
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //property will be nil until properties are set and save button enabled
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //CURRENT DATE FORMATTER
        let dateFormatter : DateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        //EEEE, MMM d, yyyy
        
        if let note = note {
            navigationItem.title = "Edit Task"
            titleTextField.text = note.title
            currentDateLabel.text = note.currentDate
            notesTextView.text = note.notes
        } else {
            //when the date picker is displayed, the date picker displays a starting value 24 hours after the current time
            currentDateLabel.text = dateString

        }
        
        updateSaveButtonState()
        
        self.titleTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //need to verify the saveUnwind segue is being performed
        guard segue.identifier == "showNoteDetails" else { return }
        
        //reads the values from the controls, storing as constants and passing values into your model's initalizers
        let title = titleTextField.text!
        let notes = notesTextView.text!
        let currentDate = currentDateLabel.text!
        
        
        note = Note(title: title, notes: notes, currentDate: currentDate)
    }
}


