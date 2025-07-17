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
                AchievementsView()
            }
        }
    }
}
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

// MARK: - Achievement Row
struct AchievementRow: View {
    let achievement: Achievement
    @State private var isExpanded = false

    var body: some View {
        VStack(spacing: 8) {
            Button(action: {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            }) {
                VStack(spacing: 4) {
                    Image(achievement.unlocked ? achievement.imageName : "achievement_locked")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .grayscale(achievement.unlocked ? 0 : 1)
                        .opacity(achievement.unlocked ? 1 : 0.5)

                    Text(achievement.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
            }

            if isExpanded {
                Text(achievement.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Achievements View (Auto-Load)
struct AchievementsView: View {
    @State private var scannedCount: Int = UserDefaults.standard.integer(forKey: "scannedCount")
    @State private var achievements: [Achievement] = []

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(achievements) { achievement in
                    AchievementRow(achievement: achievement)
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            scannedCount = UserDefaults.standard.integer(forKey: "scannedCount")
            achievements = generateAchievements(scannedCount: scannedCount)
        }
        .navigationTitle("Achievements")
    }

    func generateAchievements(scannedCount: Int, count: Int = 50) -> [Achievement] {
        var achievements = [Achievement]()
        for i in 1...count {
            let threshold = i * 6
            let unlocked = scannedCount >= threshold
            let imageName = "achievement_\(i)" // Your assets should include these

            achievements.append(
                Achievement(
                    index: i,
                    title: "Scan \(threshold) items ",
                    description: "Unlocked by scanning \(threshold) objects.",
                    threshold: threshold,
                    imageName: imageName,
                    unlocked: unlocked
                )
            )
        }
        return achievements
    }
}






        
        
    #Preview {
        AchievementsView()
    }
        
        
    
