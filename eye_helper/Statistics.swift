import Foundation

struct DailyStatistics: Codable {
    let date: Date
    var focusTime: TimeInterval
    var restCount: Int
    
    static func today() -> DailyStatistics {
        DailyStatistics(date: Date(), focusTime: 0, restCount: 0)
    }
}

class Statistics: ObservableObject {
    @Published private(set) var dailyStats: DailyStatistics
    private let userDefaults = UserDefaults.standard
    private let statsKey = "daily_statistics"
    
    init() {
        if let data = userDefaults.data(forKey: statsKey),
           let stats = try? JSONDecoder().decode(DailyStatistics.self, from: data) {
            // 如果存储的统计数据是今天的，就使用它
            if Calendar.current.isDateInToday(stats.date) {
                self.dailyStats = stats
                return
            }
        }
        // 如果没有今天的数据，创建新的
        self.dailyStats = DailyStatistics.today()
    }
    
    func addFocusTime(_ interval: TimeInterval) {
        dailyStats.focusTime += interval
        saveStats()
    }
    
    func incrementRestCount() {
        dailyStats.restCount += 1
        saveStats()
    }
    
    private func saveStats() {
        if let data = try? JSONEncoder().encode(dailyStats) {
            userDefaults.set(data, forKey: statsKey)
        }
    }
    
    var formattedFocusTime: String {
        let hours = Int(dailyStats.focusTime) / 3600
        let minutes = Int(dailyStats.focusTime) / 60 % 60
        return String(format: "%d小时%d分钟", hours, minutes)
    }
}