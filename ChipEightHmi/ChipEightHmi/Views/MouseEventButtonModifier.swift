import SwiftUI

struct MouseEventButtonModifier: ViewModifier
{
    let key: String
    let onKeyDown: () -> Void
    let onKeyUp: () -> Void
    
    @State private var isMouseOver = false
    @State private var mouseMonitor: Any?
    
    func body(content: Content) -> some View
    {
        content
            .onContinuousHover
            {
                phase in
                switch phase
                {
                    case .active(let location):
                        isMouseOver = true
                    case .ended:
                        isMouseOver = false
                }
            }
            .onAppear
            {
                setupMouseMonitoring()
            }
            .onDisappear
            {
                removeMouseMonitoring()
            }
    }
    
    private func setupMouseMonitoring()
    {
        mouseMonitor = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .leftMouseUp])
        {
            event in
            if isMouseOver
            {
                if event.type == .leftMouseDown
                {
                    onKeyDown()
                }
                else if event.type == .leftMouseUp
                {
                    onKeyUp()
                }
            }
            return event
        }
    }
    
    private func removeMouseMonitoring()
    {
        if let monitor = mouseMonitor {
            NSEvent.removeMonitor(monitor)
        }
    }
}
