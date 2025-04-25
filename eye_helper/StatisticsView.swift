import SwiftUI

struct StatisticsView: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 4) {
                Text(timerManager.statistics.formattedFocusTime)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                
                Text("专注时间")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 4) {
                Text("\(timerManager.statistics.dailyStats.restCount)次")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                
                Text("休息次数")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 10)
    }
}