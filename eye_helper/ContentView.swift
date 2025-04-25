// ContentView.swift - 保留您现有的文件，但修改内容
import SwiftUI

struct ContentView: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        VStack(spacing: 25) {
            if timerManager.showRestPrompt {
                // 休息提示界面
                Image(systemName: "eye.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .font(.system(size: 70))
                    .symbolEffect(.bounce)
                    .padding(.bottom, 10)
                
                Text("该休息眼睛了！")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.vertical)
                
                Text("请看20英尺(约6米)远的物体20秒")
                    .font(.system(size: 18))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Button("开始休息") {
                    withAnimation {
                        timerManager.showRestPrompt = false
                        timerManager.isRestTime = true
                        timerManager.timeRemaining = 20
                        timerManager.startTimer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .shadow(radius: 3)
            } else {
                // 常规计时界面
                Image(systemName: "eye")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .font(.system(size: 50))
                    .symbolEffect(.pulse)
                    .padding(.bottom, 5)
                
                Text("20-20-20 眼睛休息提醒")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("剩余时间: \(timerManager.formattedTimeRemaining)")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(.secondary)
                    .monospacedDigit()
                    .padding(.vertical)
                
                HStack(spacing: 25) {
                    Button(timerManager.isRunning ? "暂停" : "开始") {
                        withAnimation {
                            if timerManager.isRunning {
                                timerManager.pauseTimer()
                            } else {
                                timerManager.startTimer()
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    
                    Button("重置") {
                        withAnimation {
                            timerManager.resetTimer()
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
                .padding(.top, 10)
                
                Divider()
                    .padding(.vertical)
                
                StatisticsView(timerManager: timerManager)
            }
        }
        .padding(30)
        .frame(width: 400, height: 600)
        .background(
            timerManager.isRestTime ?
            Color.green.opacity(0.1) : // 休息时使用淡绿色
            Color(NSColor.windowBackgroundColor) // 工作时使用默认背景色
        )
        .animation(.easeInOut, value: timerManager.showRestPrompt)
        .animation(.easeInOut, value: timerManager.isRestTime)
    }
}
//1. contentview 就是应用程序主体会显示的内容吗
