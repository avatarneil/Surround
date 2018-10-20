//
//  ViewController.swift
//  health_kit_test
//
//  Created by Neil Goldader on 10/19/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import UIKit
import HealthKit
import Foundation

enum SleepState: String {
    case asleep = "asleep"
    case awake = "awake"
}

class ViewController: UIViewController {
    let healthStore = HKHealthStore()
    var net = NetworkLayer()
    var sleepState = SleepState.awake
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let typestoRead = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
            ])
        
        let typestoShare = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
            ])
        
        self.healthStore.requestAuthorization(toShare: typestoShare, read: typestoRead) { (success, error) -> Void in
            if success == false {
                NSLog(" Display not allowed")
            }
        }
        
        let timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }
    
    @objc func updateData() {
        retrieveSleepAnalysis()
    }
    
    func retrieveSleepAnalysis() {
        
        // first, we define the object type we want
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            // Use a sortDescriptor to get the recent data first
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            // we create our query with a block completion to execute
            let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    
                    // something happened
                    return
                    
                }
                
                if let result = tmpResult {
                    
                    // do something with my data
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            let value = (sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue || sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? SleepState.asleep : SleepState.awake
                            print("Sleep loop")
                            var now = Date()
                            if (sample.startDate ... sample.endDate).contains(Calendar.current.date(byAdding: .minute, value: -5, to: now) ?? now) {
                                if (self.sleepState != value) {
                                    print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                                    self.sleepState = value;
                                    self.net.httpPost(type: "sleep", state: self.sleepState.rawValue)
                                } else {
                                    print("No change in sleepState")
                                }
                            } else {
                                self.sleepState = .awake // we asssume awakeness as a base state
                            }
                        }
                    }
                }
            }
            
            // finally, we execute our query
            healthStore.execute(query)
        }
    }
    
    func saveSleepAnalysis() {
        
        var alarmTime: Date!
        var endTime: Date!
        // alarmTime and endTime are NSDate objects
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            // we create our new object we want to push in Health app
            let object = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.inBed.rawValue, start: alarmTime, end: endTime)
            
            // at the end, we save it
            healthStore.save(object, withCompletion: { (success, error) -> Void in
                
                if error != nil {
                    // something happened
                    return
                }
                
                if success {
                    print("My new data was saved in HealthKit")
                    
                } else {
                    // something happened again
                }
                
            })
            
            
            let object2 = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.asleep.rawValue, start: alarmTime, end: endTime)
            
            healthStore.save(object2, withCompletion: { (success, error) -> Void in
                if error != nil {
                    // something happened
                    return
                }
                
                if success {
                    print("My new data (2) was saved in HealthKit")
                } else {
                    // something happened again
                }
                
            })
            
        }
        
    }
}
