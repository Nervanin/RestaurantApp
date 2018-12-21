//
//  EateryDetailViewController.swift
//  Eateries
//
//  Created by Konstantin on 19.06.2018.
//  Copyright © 2018 Konstantin Meleshko. All rights reserved.
//

import UIKit
import CoreData


class EateryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fetchResultController: NSFetchedResultsController<Restaurant>!
    
    // unwindsegue from RateViewConroller with cose rate
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var restaurant: Restaurant?
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard  let svc = segue.source as? RateViewController else  { return }
        guard let rating = svc.restRaiting else { return }
        rateButton.setImage(UIImage(named: rating), for: .normal)
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            if let rateImage = imageView.image {
                restaurant?.rateImage = UIImagePNGRepresentation(rateImage)
            }
            
            do {
                try context.save()
                print("Сохраненние удалось")
            }catch let error as NSError {
                print("данные не сохраненны \(error) \(error.userInfo)")
            }
                
            
                
            }
        }
        
    
    // method start beforeDidAppear
    // out and retern propertes when user swipe up and down secondscreen
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "rateImage", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            
            do{
                try fetchResultController.performFetch()
                //               restaurant = fetchResultController.fetchedObjects
            }catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        
        
        
        //border and color on ratebutton on secondscreen
        
        let buttons = [rateButton, mapButton]
        for button in buttons{
            guard let button = button else { break }
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            
        }
        

        //property for automatickDimension heigh of cell
        tableView.estimatedRowHeight = 38
        tableView.rowHeight = UITableViewAutomaticDimension
        
//        tableView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
//        tableView.separatorColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        // view bootom size == 0 
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = restaurant!.name
        
        imageView.image = UIImage(data: restaurant!.image! as Data)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        
    }
    
    // work with propertys in EateryDeteilTableViewCell
    // method of all information restaurant in second screen
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EateryDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Название"
            cell.valueLabel.text = restaurant!.name
        case 1:
            cell.keyLabel.text = "Тип"
            cell.valueLabel.text = restaurant!.type
        case 2:
            cell.keyLabel.text = "Адрес"
            cell.valueLabel.text = restaurant!.location
        case 3:
            cell.keyLabel.text = "Я был ?"
            cell.valueLabel.text = restaurant!.isVisited ? "Да" : "Нет"
        default:
            break
        }
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    // deselectRow animated in cell of table on secondscreen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)    }
    
    // method for segue on MapViewController from once restaurant menu 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let dvc = segue.destination as! MapViewController
            dvc.restaurant = self.restaurant
        }
    }
    
    
    
    
    
    
}

