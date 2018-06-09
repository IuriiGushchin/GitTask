//
//  RegisterViewController.swift
//  Frontend
//
//  Created by iMac27 on 29.05.2018.
//  Copyright © 2018 iMac27. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var ConnectionError = false
    var username = ""
    var password = ""
    
    
    //Отсчитываем время на загрузку
    func run(after seconds: Int,complition: @escaping () -> Void){
        let deadline  = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            complition()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var ImageView: UIImageView!
        
    // разобраться как получить image
    
    @IBAction func ImportImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image,animated: true)
        {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            ImageView.image = image
        } else
        {
            //error
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var SecondPasswordField: UITextField!
    @IBOutlet weak var FamilyField: UITextField!
    @IBOutlet weak var NameField: UITextField!
    
    
    @IBAction func RegisterButtonAction(_ sender: Any) {
        
        if(UsernameField.text!.isEmpty){
            let loginAlert = UIAlertController(title: "Введите имя пользователя", message: nil, preferredStyle: .alert)
            
            let enter = UIAlertAction(title: "Ввести", style: .default)
            loginAlert.addAction(enter)
            present(loginAlert, animated: true, completion: nil)
        }else if(PasswordField.text!.isEmpty){
            let loginAlert = UIAlertController(title: "Введите пароль", message: nil, preferredStyle: .alert)
            
            let enter = UIAlertAction(title: "Ввести", style: .default)
            loginAlert.addAction(enter)
            present(loginAlert, animated: true, completion: nil)
        }else if(SecondPasswordField.text!.isEmpty){
            let loginAlert = UIAlertController(title: "Повторите пароль", message: nil, preferredStyle: .alert)
            
            let enter = UIAlertAction(title: "Ввести", style: .default)
            loginAlert.addAction(enter)
            present(loginAlert, animated: true, completion: nil)
        }else if(FamilyField.text!.isEmpty){
            let loginAlert = UIAlertController(title: "Введите фамилию", message: nil, preferredStyle: .alert)
            
            let enter = UIAlertAction(title: "Ввести", style: .default)
            loginAlert.addAction(enter)
            present(loginAlert, animated: true, completion: nil)
        }else if(NameField.text!.isEmpty){
            let loginAlert = UIAlertController(title: "Введите имя", message: nil, preferredStyle: .alert)
            
            let enter = UIAlertAction(title: "Ввести", style: .default)
            loginAlert.addAction(enter)
            present(loginAlert, animated: true, completion: nil)
        }else if (PasswordField.text != SecondPasswordField.text)
        {
            let loginAlert = UIAlertController(title: "Пароли не совпадают", message: nil, preferredStyle: .alert)
            
            let enter = UIAlertAction(title: "Попробовать еще раз!", style: .default)
            loginAlert.addAction(enter)
            present(loginAlert, animated: true, completion: nil)
        } else {
            self.username = self.UsernameField.text!
            self.password = self.PasswordField.text!
            
            
            // Здесь код для отправки данных на сервер, при успешной регистрации клиента получаем пользователя получаем true, иначе пилим ошибку.
            
            let url = URL(string: "http://localhost:8080/signup")!
            
            var request = URLRequest(url: url)
            request.setValue("qqq", forHTTPHeaderField: "eto 4e")
            request.httpMethod = "POST"
            let postString = "q"
            request.httpBody = postString.data(using: .utf8)
            //собрали request
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                self.ConnectionError = false
                if error != nil {
                    self.ConnectionError = true
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // Проверяем статус-код
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    self.ConnectionError = true
                }
                print("responseString = \(String(describing: response))")
            }.resume()// `сделали пост заброс
        }
        run (after: 2) {
            if self.ConnectionError != true {
                self.performSegue(withIdentifier: "register", sender: self)
            
            }else {
                DispatchQueue.main.async {
                    let loginAlert = UIAlertController(title: "Соединение не установлено", message: nil, preferredStyle: .alert)
            
                    let enter = UIAlertAction(title: "Попробовать позже", style: .default)
                    loginAlert.addAction(enter)
                    self.present(loginAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "register" {
            let vc = segue.destination as! LoginViewController
            vc.use = self.username
            vc.pas = self.password
        }
    }
    
}
