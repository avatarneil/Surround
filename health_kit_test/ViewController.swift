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
    var lastDate: Date? = nil
    var sleepState = SleepState.asleep
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
        
//        let t = DispatchSource.makeTimerSource()
//        t.schedule(deadline: .now(), repeating: 10.0)
//        t.setEventHandler(handler: {[weak self] in self!.updateData()})
        
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }
    
    @objc func updateData() {
        var category:HKCategoryValueSleepAnalysis
        if sleepState == .awake {
            category = .asleep
        } else {
            category = .awake
        }
        saveSleepAnalysis(category: category)
        saveSleepAnalysis(category: category)
        retrieveSleepAnalysis()
    }
    
    func retrieveSleepAnalysis() {
        
        // first, we define the object type we want
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            // Use a sortDescriptor to get the recent data first
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            // we create our query with a block completion to execute
            let sorter = NSSortDescriptor(key: "startDate", ascending: false)
            let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 1, sortDescriptors: [sorter]) { (query, tmpResult, error) -> Void in
                
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
                            print(sample)
                            print(self.sleepState, value, sample.value)
                            if (self.sleepState != value) {
                                var delay = 0.0;
                                if (self.sleepState == .asleep) {
                                    delay = 10.0;
                                }
                                if (self.lastDate == nil) {
                                    self.lastDate = sample.startDate
                                }
                                if (Date() >= (self.lastDate! + delay)) {
                                    print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                                    self.sleepState = value;
                                    self.net.httpPost(type: "sleep", state: self.sleepState.rawValue)
                                    self.lastDate = nil;
                                }
                            } else {
                                print("No change in sleepState")
                            }
                        }
                    }
                }
            }
            
            // finally, we execute our query
            healthStore.execute(query)
        }
    }
    
    func saveSleepAnalysis(category: HKCategoryValueSleepAnalysis) {
        
        let startTime = Date(timeIntervalSinceNow: -1.0)
        let endTime = Date()
        
        // alarmTime and endTime are NSDate objects
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            
            if category == .inBed || category == .asleep {
            
            // we create our new object we want to push in Health app
            let object = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.inBed.rawValue, start: startTime, end: endTime)
            
            // at the end, we save it
            healthStore.save(object, withCompletion: { (success, error) -> Void in
                
                if error != nil {
                    // something happened
                    return
                }
                
                if success {
                    print("inBed saved to Healthkit")
                    
                } else {
                    // something happened again
                }
                
            })
            }
            
            if category == .asleep {
            let object2 = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.asleep.rawValue, start: startTime, end: endTime)
            
            healthStore.save(object2, withCompletion: { (success, error) -> Void in
                if error != nil {
                    // something happened
                    return
                }
                
                if success {
                    print("asleep saved to health kit")
                } else {
                    // something happened again
                }
                
            })
            }
            
            if category == .awake {
                let object2 = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.awake.rawValue, start: startTime, end: endTime)
                
                healthStore.save(object2, withCompletion: { (success, error) -> Void in
                    if error != nil {
                        // something happened
                        return
                    }
                    
                    if success {
                        print("awake saved the health kit")
                    } else {
                        // something happened again
                    }
                    
                })
            }
            
        }
        
    }
}
