//
//  LoginViewController.swift
//  instagraham-cracker
//
//  Created by Stef Epp on 3/8/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var inButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: AnyObject) {
//        PFUser.logInWithUsername(usernameField.text!, passField.text!) {
//            (user: PFUser?, error: NSError) -> Void in
//            if user != nil {
//                print("You logged in")
//                self.performSegueWithIdentifier("loginSegue", sender: nil)
//            }
//        }
//        
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("You logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
        /*PFUser.logInWithUsername(usernameField.text!, password: passField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("you are logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }*/
    }

    @IBAction func signUp(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("User created yay!!!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            else {
                print(error?.localizedDescription)
                if error?.code == 202 {
                    print("Username is taken")
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
