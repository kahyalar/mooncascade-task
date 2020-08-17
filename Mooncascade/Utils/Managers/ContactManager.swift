//
//  ContactManager.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 14.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import Contacts
import ContactsUI

class ContactsManager {
    private init() { }
    static let shared = ContactsManager()
    private let store = CNContactStore()
    
    /// Asks permission to access user's contact data.
    /// - Parameter completed: Closure for completed task which returns Boolean value and Error
    func requestAccess(_ completed: @escaping (Bool, Error?) -> Void) {
        store.requestAccess(for: .contacts, completionHandler: completed)
    }
    
    /// Fetches the native contact list.
    /// - Parameter completion: Closure for completed task which returns fetched contacts array
    func fetchContacts(_ completion: ([CNContact]) -> Void) throws {
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactViewController.descriptorForRequiredKeys()
            ] as [Any]

        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        var contacts = [CNContact]()
        try store.enumerateContacts(with: request) { contact, _ in
            contacts.append(contact)
        }
        
        completion(contacts)
    }
    
    /// Navigates to the native contacts page for given contact.
    /// - Parameters:
    ///   - contact: Contact to fetch native page
    ///   - viewController: Page to present the native contact page
    func showContactPage(for contact: CNContact?, from viewController: UIViewController) {
        guard let contact = contact else {
            DispatchQueue.main.async {
                viewController.present(AlertManager.shared.alert(for: .systemError), animated: true)
            }
            return
        }
        
        let contactViewController: CNContactViewController = {
            let contactViewController = CNContactViewController(for: contact)
            contactViewController.allowsEditing = false
            contactViewController.allowsActions = false
            return contactViewController
        }()
        
        DispatchQueue.main.async {
            viewController.navigationController?.pushViewController(contactViewController, animated: true)
        }
    }

}


