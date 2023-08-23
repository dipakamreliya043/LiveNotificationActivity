//
//  ViewController.swift
//  WidgetDemo
//
//  Created by ios-m2 on 01/06/23.
//

import UIKit
import ActivityKit

@available(iOS 16.1, *)
class ViewController: UIViewController {

//    var activity: Activity<PizzaDeliveryAttributes>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnStartAction(_ sender: UIButton) {
        self.startActivity()
    }
    
    @IBAction func btnUpdateAction(_ sender: UIButton) {
        self.updateActivity()
    }
    
    @IBAction func btnEndAction(_ sender: UIButton) {
        self.endActivity()
    }
}

extension ViewController {
    func startActivity() {
        let pizzaDeliveryAttributes = PendingDeliveryAttributes(numberOfPizzas: 1, totalAmount:"$99")

        let initialContentState = PendingDeliveryAttributes.PendingDeliveryStatus(driverName: "DH 👨‍⚕️", estimatedDeliveryTime: Date()...Date().addingTimeInterval(1 * 60))
                                                  
        do {
            let deliveryActivity = try Activity<PendingDeliveryAttributes>.request(
                attributes: pizzaDeliveryAttributes,
                contentState: initialContentState,
                pushType: nil)
            print("Requested a pizza delivery Live Activity \(deliveryActivity.id)")
        } catch (let error) {
            print("Error requesting pizza delivery Live Activity \(error.localizedDescription)")
        }
    }
    func updateActivity() {
        Task {
            let updatedDeliveryStatus = PendingDeliveryAttributes.PendingDeliveryStatus(driverName: "DH 👨‍⚕️", estimatedDeliveryTime: Date()...Date().addingTimeInterval(60 * 60))
            
            for activity in Activity<PendingDeliveryAttributes>.activities{
                await activity.update(using: updatedDeliveryStatus)
            }
        }
    }
    func endActivity() {
        Task {
            for activity in Activity<PendingDeliveryAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
    func showAllDeliveries() {
        Task {
            for activity in Activity<PendingDeliveryAttributes>.activities {
                print("Pizza delivery details: \(activity.id) -> \(activity.attributes)")
            }
        }
    }
}


