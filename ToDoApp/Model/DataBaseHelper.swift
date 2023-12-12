//
//  DataBaseHelper.swift
//  ToDoApp
//
//  Created by Preeti Kesarwani on 12/11/23.
//

import UIKit
import RealmSwift

class DataBaseHelper {
    
    static let shared = DataBaseHelper()
    
    
    private var realm = try! Realm()
    
    // crate path where our data store
    func getDataBaseURL() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
        
    }
  
    func save(contact : Contact){
        
        try! realm.write {
            realm.add(contact)
        }
    }
    
    // get data
    func getAllContact () -> [Contact] {
        return Array(realm.objects(Contact.self))
    }
    // delete data
    func DeleteContact(contact : Contact){
        try! realm.write {
            realm.delete(contact)
        }
        
    }
    
    
    // update Data
    
    func updateData(oldContact : Contact, newContact : Contact ){
        try! realm.write{
            
            
            oldContact.firstName =  newContact.firstName
            oldContact.SecondName =  newContact.SecondName
            oldContact.PhoneNo =  newContact.PhoneNo
        }
    }
}


