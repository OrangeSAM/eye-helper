import Foundation
import UserNotifications

class TimerManager: ObservableObject {
    @Published var timeRemaining = 20 * 60 // 20分钟工作时间，以秒为单位
    @Published var isRunning = false
    @Published var isRestTime = false
    
    private var timer: Timer?
    
    // 工作时间和休息时间的常量
    private let workDuration = 20 * 60 // 20分钟 = 1200秒
    private let restDuration = 20      // 20秒
    
    var formattedTimeRemaining: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        pauseTimer()
        timeRemaining = isRestTime ? restDuration : workDuration
    }
    
    private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            pauseTimer()
            
            if isRestTime {
                // 休息结束，回到工作时间
                isRestTime = false
                timeRemaining = workDuration // 20分钟工作时间
                showNotification(title: "休息结束", body: "继续工作吧！")
            } else {
                // 工作结束，开始休息
                isRestTime = true
                timeRemaining = restDuration // 20秒休息时间
                showNotification(title: "休息时间", body: "请看20英尺(约6米)远的物体20秒")
            }
        }
    }
    
    private func showNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}

