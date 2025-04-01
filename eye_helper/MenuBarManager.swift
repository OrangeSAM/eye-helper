// 新建一个 MenuBarManager.swift 文件
import SwiftUI
import UserNotifications

class MenuBarManager: NSObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var timerManager: TimerManager
    
    init(timerManager: TimerManager) {
        self.timerManager = timerManager
        super.init()
        
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = self.statusItem.button {
            button.image = NSImage(systemSymbolName: "eye", accessibilityDescription: nil)
            button.action = #selector(togglePopover)
            button.target = self
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 200)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView(timerManager: timerManager))
        
        // 请求通知权限
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("通知权限已获取")
            }
        }
        
        // 启动计时器
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if let button = self?.statusItem.button, let timerManager = self?.timerManager {
                button.title = " \(timerManager.formattedTimeRemaining)"
            }
        }
    }
    
    @objc func togglePopover() {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            if let button = statusItem.button {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}
