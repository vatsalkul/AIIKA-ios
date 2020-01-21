//
//  RegistrationViewController.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 29/12/19.
//  Copyright © 2019 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import CoreLocation
import SafariServices
import AWSCognito
import AWSCore
import AWSS3
class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var fathernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var occupationTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    let imagePicker = UIImagePickerController()
    var profileImageName: String = ""
    var profileImageUrl: URL = URL(fileURLWithPath: "")
    var s3Url: URL!
    let awsBucketName = "aiika-directory"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.APSouth1,
           identityPoolId:"ap-south-1:72a2cf1f-428e-4b2e-b813-951cf0d8e69c")

        let configuration = AWSServiceConfiguration(region:.APSouth1, credentialsProvider:credentialsProvider)

        AWSServiceManager.default().defaultServiceConfiguration = configuration
        s3Url = AWSS3.default().configuration.url
        
    }
    
    func uploadImage(with resource: String, type: String){
        
        let key = "directory/\(resource).\(type)"
        let localImageUrl = profileImageUrl
        let request = AWSS3TransferManagerUploadRequest()!
        request.bucket = awsBucketName
        request.key = key
        request.body = localImageUrl
        request.acl = .publicReadWrite
        
        let transferManager = AWSS3TransferManager.default()
        transferManager.upload(request).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
            
            if let error = task.error{
                print(error)
            }
            if task.result != nil{
                print("uploaded \(key)")
            }
            
            
            return nil
        }
        
        
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func submitPressed(_ sender: Any) {
        
        //post request with all parameters
        let parameters = ["name" : nameTextField.text!,
                          "father": fathernameTextField.text!,
                          "email" : emailTextField.text!,
                          "occupation" : occupationTextField.text!,
                          "city" : cityTextField.text!,
                          "state" : stateTextField.text!,
                          "country" : countryTextField.text!,
                          "mobile" : mobileTextField.text!,
                          "imageUrl" : profileImageName
            ] as [String : Any]
        uploadImage(with: profileImageName, type: "jpg")
        guard let url = URL(string: "https://aiika.herokuapp.com/directory") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    if let error = json["error"] as? String {
                        DispatchQueue.main.async {
                            showAlert(title: "Error", message: error, in: self)
                        }
                        print(error)

                    }else {
                        if let success = json["success"] as? String{
                            DispatchQueue.main.async {
                                showAlert(title: "Thanks", message: success, in: self)
                            }
                            print("success")
                        }
                        
                    }
                }
                catch{
                    //print(error)
                }
            }
        }.resume()
        
        
        
    }
    @IBAction func termsPressed(_ sender: Any) {

        guard let url = URL(string: "https://github.com/vatsalkul") else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)

        
    }
    
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageName = UUID().uuidString
            print("ImageName: \(profileImageName)")
            let imagePath = getDocumentsDirectory().appendingPathComponent(profileImageName)
            if let jpegData = image.jpegData(compressionQuality: 0.5) {
                try? jpegData.write(to: imagePath)
            }
            profileImageUrl = imagePath
            print(imagePath)

            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
