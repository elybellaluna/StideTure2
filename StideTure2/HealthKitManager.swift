//
//  HealthKitManager.swift
//  StideTure2
//
//  Created by 54GOParticipant on 7/24/25.
//

import HealthKit

class HealthKitManager {
    let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let exerciseType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
        let typesToRead: Set = [stepType, exerciseType]
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { success, _ in
            completion(success)
        }
    }

    func fetchSteps(for date: Date, completion: @escaping (Double) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        fetchSum(for: stepType, date: date, unit: .count(), completion: completion)
    }

    func fetchExerciseTime(for date: Date, completion: @escaping (Double) -> Void) {
        let timeType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
        fetchSum(for: timeType, date: date, unit: .minute(), completion: completion)
    }

    private func fetchSum(for type: HKQuantityType, date: Date, unit: HKUnit, completion: @escaping (Double) -> Void) {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)!

        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            let sum = result?.sumQuantity()?.doubleValue(for: unit) ?? 0
            DispatchQueue.main.async {
                completion(sum)
            }
        }

        healthStore.execute(query)
    }
}
