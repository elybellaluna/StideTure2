//
//  badgesPage.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/9/25.
//

import SwiftUI
struct badgesPage: App {
    var body: some Scene {
        WindowGroup{
            NavigationView {
                AchievementsGridView()
            }
        }
    }
}
import SwiftUI

// MARK: - Achievement Model
struct Achievement: Identifiable {
    let id = UUID()
    let index: Int
    let title: String
    let description: String
    let threshold: Int
    let imageName: String
    var unlocked: Bool
}
  

// MARK: - Main Grid View
struct AchievementsGridView: View {
    @State private var scannedCount: Int = UserDefaults.standard.integer(forKey: "scannedCount")
    @State private var achievements: [Achievement] = []
    @State private var selectedAchievement: Achievement?
    @State private var showDetail = false

    // 3-column grid
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(achievements) { achievement in
                    VStack(spacing: 8) {
                        Button(action: {
                            selectedAchievement = achievement
                            showDetail = true
                        }) {
                            VStack {
                                Image(achievement.unlocked ? achievement.imageName : "achievement_locked")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .grayscale(achievement.unlocked ? 0 : 1)
                                    .opacity(achievement.unlocked ? 1 : 0.5)

                                Text(achievement.title)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            achievements = generateAchievements(scannedCount: scannedCount)
        }
        .sheet(item: $selectedAchievement) { achievement in
            AchievementDetailView(achievement: achievement)
        }
        .navigationTitle("Achievements")
    }

    // Generate dynamic list
    func generateAchievements(scannedCount: Int, count: Int = 50) -> [Achievement] {
        var achievements = [Achievement]()
        for i in 1...count {
            let threshold = i * 6
            let unlocked = scannedCount >= threshold
            let imageName = "achievement_\(i)" // make sure these are in Assets

            achievements.append(
                Achievement(
                    index: i,
                    title: "Scanned \(threshold) items!",
                    description: "Unlocked by scanning \(threshold) items.",
                    threshold: threshold,
                    imageName: imageName,
                    unlocked: unlocked
                )
            )
        }
        return achievements
    }
}

// MARK: - Detail View on Tap
struct AchievementDetailView: View {
    let achievement: Achievement

    var body: some View {
        VStack(spacing: 20) {
            Image(achievement.unlocked ? achievement.imageName : "achievement_locked")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .grayscale(achievement.unlocked ? 0 : 1)
                .opacity(achievement.unlocked ? 1 : 0.5)

            Text(achievement.title)
                .font(.title2)
                .bold()
                .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))

            Text(achievement.description)
                .font(.body)
                .foregroundColor(.gray)
                .padding()

            Spacer()
        }
        .padding()
    }
}







        
        
    #Preview {
        AchievementsGridView()
    }
        
        
    
