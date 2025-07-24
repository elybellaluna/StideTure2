//
//  ProgressViewModel.swift
//  StideTure2
//
//  Created by 54GOParticipant on 7/24/25.
//

import Foundation

class ProgressViewModel: ObservableObject {
    private let healthManager = HealthKitManager()

    @Published var steps: [Double] = []
    @Published var time: [Double] = []

    func loadWeeklyData() {
        healthManager.requestAuthorization { success in
            guard success else { return }

            let calendar = Calendar.current
            let today = Date()
            var stepTemp: [Double] = []
            var timeTemp: [Double] = []

            let group = DispatchGroup()

            for i in 0..<7 {
                let day = calendar.date(byAdding: .day, value: -i, to: today)!

                group.enter()
                self.healthManager.fetchSteps(for: day) { value in
                    stepTemp.append(value)
                    group.leave()
                }

                group.enter()
                self.healthManager.fetchExerciseTime(for: day) { value in
                    timeTemp.append(value)
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self.steps = stepTemp.reversed()
                self.time = timeTemp.reversed()
            }
        }
    }
}

