//
//  badgesPage.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/9/25.
//

struct badgesPage: App {
        var body: some Scene {
            WindowGroup {
                AchievementsAndLeaderboardView()
            }
        }
    }
import SwiftUI

//Achievement Model
struct Achievement: Identifiable {
    let id = UUID()
    let index: Int
    let title: String
    let description: String
    let threshold: Int
    let imageName: String
    var unlocked: Bool
}

// Leaderboard
struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let name: String
    let score: Int
}

// Tabs
enum TabType: String, CaseIterable {
    case achievements = "Achievements"
    case leaderboard = "Leaderboard"
}

// Main View
struct AchievementsAndLeaderboardView: View {
    @State private var selectedTab: TabType = .achievements
    @State private var scannedCount: Int = UserDefaults.standard.integer(forKey: "scannedCount")
    @State private var achievements: [Achievement] = []
    @State private var selectedAchievement: Achievement?
    @AppStorage("userFirstName") var userFirstName: String = "User"
    
    var leaderboardEntries: [LeaderboardEntry]  { [
        .init(name: "Alice", score: 120),
        .init(name: "Bob", score: 90),
        .init(name: userFirstName, score: 66),
        .init(name: "Carol", score: 54)
        ]
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Badges")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                    .padding(.top, 20)
                    .padding(.leading, 20)
                
                Picker("Select View", selection: $selectedTab) {
                    ForEach(TabType.allCases, id: \.self) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Divider()
                
                if selectedTab == .achievements {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(achievements) { achievement in
                                VStack(spacing: 8) {
                                    Button(action: {
                                        selectedAchievement = achievement
                                    }) {
                                        Image(achievement.unlocked ? achievement.imageName : "achievement_locked")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 130, height: 130)
                                            .grayscale(achievement.unlocked ? 0 : 1)
                                            .opacity(achievement.unlocked ? 1 : 0.5)
                                    }
                                    
                                    Text(achievement.title)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    List {
                        ForEach(leaderboardEntries.sorted(by: { $0.score > $1.score })) { entry in
                            HStack {
                                Text(entry.name)
                                    .font(.headline)
                                    .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                                
                                Spacer()
                                
                                Text("\(entry.score)")
                                    .bold()
                                    .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                                
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                Spacer()
                
            }
            .onAppear {
                scannedCount = UserDefaults.standard.integer(forKey: "scannedCount")
                achievements = generateAchievements(scannedCount: scannedCount)
            }
            .sheet(item: $selectedAchievement) { achievement in
                AchievementDetailView(achievement: achievement)
            }
        }
    }
    
    
    
    //Generate Achievements
    func generateAchievements(scannedCount: Int, count: Int = 50) -> [Achievement] {
        var list = [Achievement]()
        for i in 1...count {
            let threshold = i * 6
            let unlocked = scannedCount >= threshold
            list.append(
                Achievement(
                    index: i,
                    title: "Scanned \(threshold) items!",
                    description: "Unlocked by scanning \(threshold) items.",
                    threshold: threshold,
                    imageName: "achievement_\(i)",
                    unlocked: unlocked
                )
            )
        }
        return list
    }
    
   
}

    
    //Detail View
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
        AchievementsAndLeaderboardView()
    }
        
    
