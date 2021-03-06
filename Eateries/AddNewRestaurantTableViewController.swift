//
//  AddNewRestaurantTableViewController.swift
//  Eateries
//
//  Created by Konstantin on 24.06.2018.
//  Copyright © 2018 Konstantin Meleshko. All rights reserved.
//

import UIKit

class AddNewRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    var isVisited = false
    
    
    @IBAction func toggleIsVisitedPressed(_ sender: UIButton) {
        if sender == yesButton{
            yesButton.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            noButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            isVisited = true
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            yesButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            isVisited = false
            
        }
    }
    
    // save button on screen of create new restaurant
    @IBAction func saveButtonPressed(_ sender: Any) {
        if nameTextField.text == "" || adressTextField.text == "" || typeTextField.text == "" {
            
            let mistakeAlert =  UIAlertController(title: "Ошибка", message: "Не все поля заполненны", preferredStyle: .alert)
            let cancelMistakeAlert = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            mistakeAlert.addAction(cancelMistakeAlert)
            self.present(mistakeAlert, animated: true, completion: nil)
        
        }else {
            performSegue(withIdentifier: "unwindSegueToMainScreen", sender: self)
        }
        //create context for CoreData
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            
            // save propertys context to CoreData
            let restaurant = Restaurant(context: context)
            restaurant.name = nameTextField.text
            restaurant.location = adressTextField.text
            restaurant.type = typeTextField.text
            restaurant.isVisited = isVisited
            if let image = imageView.image {
                restaurant.image = UIImagePNGRepresentation(image)
            }
            // do catch save context for CoreData
            do {
                try context.save()
                print("Сохранение удалось")
            }catch let error as NSError {
                print("Не удалось сохранить \(error), \(error.userInfo)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yesButton.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        noButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let alertController = UIAlertController(title: "Источник фотографии", message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Камера", style: .default) { (action) in
                self.chouseImagePickerAction(source: .camera)
            }
            let photoLibAction = UIAlertAction(title: "Фото из библиотеки", style: .default) { (action) in
                self.chouseImagePickerAction(source: .photoLibrary)
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
            alertController.addAction(camera)
            alertController.addAction(photoLibAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func chouseImagePickerAction(source: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            // subscribe to a protocol
            imagePicker.delegate = self
            //
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    
    
}
