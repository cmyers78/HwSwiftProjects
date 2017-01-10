//
//  ViewController.swift
//  NameToFaces
//
//  Created by Christopher Myers on 1/9/17.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("setup")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
        
//        let person = people[indexPath.item]
//        
//        cell.name.text  = person.name
//        
//        let path = getDocumentsDirectory().appendingPathComponent(person.image)
//        cell.imageView.image = UIImage(contentsOfFile: path.path)
//        
//        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
//        cell.imageView.layer.borderWidth = 2
//        cell.imageView.layer.cornerRadius = 3
//        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(image, 80) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unkown", image: imageName)
        people.append(person)
        collectionView?.reloadData()
        
        dismiss(animated: true)
    }

}
