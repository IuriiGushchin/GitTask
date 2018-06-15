//
//  ViewController.swift
//  Frontend
//
//  Created by iMac27 on 28.05.2018.
//  Copyright © 2018 iMac27. All rights reserved.
//

import UIKit
import Alamofire



class LoginViewController: UIViewController {
   
    var ConnectionError = false
    var users = [Userstruct]()
    var pas = ""
    var use = ""
    var ok = false

    //Отсчитываем время на загрузку
    func run(after seconds: Int,complition: @escaping () -> Void){
        let deadline  = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            complition()
        }
    }
    
    
    
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var _loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.UsernameField.text = self.use
        self.PasswordField.text = self.pas
        
    }

    
    @IBAction func LoginButton(_ sender: Any) {
        
        
        if (UsernameField.text?.isEmpty)!{
            
            let loginAlert = UIAlertController(title: "Введите логин", message: nil, preferredStyle: .alert)
            let enter = UIAlertAction(title: "Ввести", style: .default)
            loginAlert.addAction(enter)
            present(loginAlert, animated: true, completion: nil)
            
        } else if (PasswordField.text?.isEmpty)!{
            
            let loginAlert = UIAlertController(title: "Введите пароль", message: nil, preferredStyle: .alert)
            let enter = UIAlertAction(title: "Ввести", style: .default)
            loginAlert.addAction(enter)
            present(loginAlert, animated: true, completion: nil)
            
        }
    
        let url = URL(string: "http://localhost:8080/hello")

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //чекаем подключениеб если все окб то читаем до конца
            let conerror = error
            if conerror != nil {
                self.ConnectionError = true             //est' owibka
                DispatchQueue.main.async {
                    let loginAlert = UIAlertController(title: "Ошибка соеденения с сервером", message: nil, preferredStyle: .alert)
                    let enter = UIAlertAction(title: "Попробовать позже", style: .default)
                    loginAlert.addAction(enter)
                    self.present(loginAlert, animated: true, completion: nil)
                }
            } else {
                do {
                    self.users = try JSONDecoder().decode([Userstruct].self, from: data!) //декодим
                    print(self.users)
                    self.ConnectionError = false        //net owibki
                } catch {
                    print("error", conerror as Any)
                    self.ConnectionError = true         //est' owibka
                    DispatchQueue.main.async {
                        let loginAlert = UIAlertController(title: "Ошибка работы с сервером в  извлечении пользователейъъъъъъ", message: nil, preferredStyle: .alert)
                        let enter = UIAlertAction(title: "Попробовать позже", style: .default)
                        loginAlert.addAction(enter)
                        self.present(loginAlert, animated: true, completion: nil)
                        
                    }
                }
            }
        }.resume()
        if self.ConnectionError == false{ //проверяем ошибку соединения в предыдущем подключении
            run(after: 1) {
                for user in self.users {
                    
                        if user.username == self.UsernameField.text! && user.password == self.PasswordField.text!   {
                            self.ok = true
                            self.use = user.name
                            self.pas = user.middlename
                        }
                   
                }
                if self.ok == false
                {
                    let loginAlert = UIAlertController(title: "Пользователь не зарегестрирован", message: nil,  preferredStyle: .alert)
                
                    let enter = UIAlertAction(title: "Попробовать еще раз", style: .default)
                    loginAlert.addAction(enter)
                    self.present(loginAlert, animated: true, completion: nil)
                
                } else {
                    self.ok = false
                    self.performSegue(withIdentifier: "login", sender: self)
                }
                
            }
        
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            let vc = segue.destination as! HelloTableViewController
//            vc.name = self.use
//            vc.middlename = self.pas
        }
    }
}





