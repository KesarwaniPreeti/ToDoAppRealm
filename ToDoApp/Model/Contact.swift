//
//  Contact.swift
//  ToDoApp
//
//  Created by Preeti Kesarwani on 12/11/23.
//

import Foundation
import RealmSwift



class Contact : Object {
    
   @Persisted var firstName : String
    @Persisted var SecondName : String
    @Persisted var PhoneNo : String
   convenience init(firstName: String, SecondName: String, PhoneNo: String) {
       self.init()
        self.firstName = firstName
        self.SecondName = SecondName
        self.PhoneNo = PhoneNo
    }
}
