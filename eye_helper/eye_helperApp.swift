import SwiftUI

@main
struct eye_helperApp: App {
    @StateObject private var timerManager = TimerManager()
    @State private var menuBarManager: MenuBarManager?
    
    var body: some Scene {
        WindowGroup {
            ContentView(timerManager: timerManager)
                .onAppear {
                    // 初始化菜单栏管理器
                    if menuBarManager == nil {
                        menuBarManager = MenuBarManager(timerManager: timerManager)
                    }
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
