// ContentView.swift - 保留您现有的文件，但修改内容
import SwiftUI

struct ContentView: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "eye")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .font(.system(size: 40))
            
            Text("20-20-20 眼睛休息提醒")
                .font(.title)
            
            Text("剩余时间: \(timerManager.formattedTimeRemaining)")
                .font(.headline)
            
            HStack(spacing: 20) {
                Button(timerManager.isRunning ? "暂停" : "开始") {
                    if timerManager.isRunning {
                        timerManager.pauseTimer()
                    } else {
                        timerManager.startTimer()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("重置") {
                    timerManager.resetTimer()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .frame(width: 300, height: 200)
    }
}
//1. contentview 就是应用程序主体会显示的内容吗
