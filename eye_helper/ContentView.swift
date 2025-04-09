// ContentView.swift - 保留您现有的文件，但修改内容
import SwiftUI

struct ContentView: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        VStack(spacing: 20) {
            if timerManager.showRestPrompt {
                // 休息提示界面
                Image(systemName: "eye.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .font(.system(size: 60))
                
                Text("该休息眼睛了！")
                    .font(.title)
                    .padding(.vertical)
                
                Text("请看20英尺(约6米)远的物体20秒")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Button("开始休息") {
                    timerManager.showRestPrompt = false
                    timerManager.isRestTime = true
                    timerManager.timeRemaining = 20 // 20秒休息时间
                    timerManager.startTimer()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            } else {
                // 常规计时界面
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
        }
        .padding()
        .frame(width: 500, height: 700)
    }
}
//1. contentview 就是应用程序主体会显示的内容吗
