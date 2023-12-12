//
//  ViewController.swift
//  ToDoApp
//
//  Created by Preeti Kesarwani on 12/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    var contactArray = [Contact]()
    @IBOutlet var contactTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configuraion()
    }


    @IBAction func addContactButtonTab(_ sender: UIBarButtonItem) {
    
    contactConfiguartion(isAdd: true)
        
        
    }
}

extension ViewController {
    func configuraion(){
        contactTableView.dataSource = self
        contactTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contactTableView.delegate = self
        contactArray = DataBaseHelper.shared.getAllContact()
        
    }
    // Messgae Alert (add and upadte)
    func contactConfiguartion(isAdd : Bool, index : Int = 0){
        
        let alertController = UIAlertController(title: isAdd ? "Add Contact" : "Update Contact", message: isAdd ? "Please Enter Your Details" : "please Update your details", preferredStyle: .alert)
        
        let save = UIAlertAction(title: isAdd ? "Save" : "Update", style: .default) { _ in
            if let firstName = alertController.textFields?.first?.text,
               let lastName = alertController.textFields?[1].text,
               let phoneNo = alertController.textFields?[2].text {
                let contact = Contact(firstName: firstName, SecondName: lastName, PhoneNo: phoneNo)
                
                
                if isAdd {
                    // add
                    DataBaseHelper.shared.save(contact: contact)
                    self.contactArray.append(contact)
                    
                }else {
                    // update
                    self.contactArray[index] =  contact
                    DataBaseHelper.shared.updateData(oldContact: self.contactArray[index], newContact: contact)
                    
                }
                
                self.contactTableView.reloadData()
                
            }
            
            
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alertController.addTextField { [self] firstName in
            firstName.placeholder = isAdd ? "Enter Your First Name " : self.contactArray[index].firstName
            
        }
        alertController.addTextField { secondName in
            secondName.placeholder = isAdd ? "Enter your Last Name" : self.contactArray[index].SecondName
            
            
        }
        alertController.addTextField { Phone in
            Phone.placeholder = isAdd ? "Enter Your Phone Number" : self.contactArray[index].PhoneNo
            
        }
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        present(alertController, animated: true)
        
        
        
        
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = contactArray[indexPath.row].firstName
        cell.detailTextLabel?.text = contactArray[indexPath.row].SecondName
        return cell
    }
    
    
    
}
extension ViewController : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { [self] _, _, _ in
            self.contactConfiguartion(isAdd: false, index: indexPath.row)
            
            
        }
            
        
        edit.backgroundColor = .systemMint
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, _ in
            DataBaseHelper.shared.DeleteContact(contact: contactArray[indexPath.row])
            self.contactArray.remove(at: indexPath.row)
           
            self.contactTableView.reloadData()
            
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [edit , delete])
        return swipeConfiguration
    }
    
}

