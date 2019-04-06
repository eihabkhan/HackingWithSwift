//
//  ViewController.swift
//  Challenge 4 Codable
//
//  Created by Eihab Khan on 3/25/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPicture))
        
        let defaults = UserDefaults.standard
        if let picturesData = defaults.object(forKey: "pictures") as? Data {
            let decoder = JSONDecoder()
            do {
                pictures = try decoder.decode([Picture].self, from: picturesData)
            } catch {
                print("Unable to decode data")
            }
            
        }
        
    }

    @objc func addNewPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        let path = getDocumentDirectory().appendingPathComponent(picture.image)
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        cell.textLabel?.text = picture.caption
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.picture = pictures[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

}


extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Fetch the image from the info
        
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let ac = UIAlertController(title: "Add Caption", message: "Add a caption to the image", preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?[0].placeholder = "Add Caption"
        ac.addAction(UIAlertAction(title: "OK", style: .default) {
            [weak self, weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            let picture = Picture(image: imageName, caption: caption)
            self?.add(picture)
            self?.dismiss(animated: true, completion: nil)
        })
        picker.present(ac, animated: true)
    }
    
    func add(_ picture: Picture) {
        pictures.insert(picture, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let savedPictures = try? encoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedPictures, forKey: "pictures")
        } else {
            print("Unable to save")
        }
    }
    
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
