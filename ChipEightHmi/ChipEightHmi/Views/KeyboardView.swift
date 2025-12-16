import SwiftUI

struct KeyboardView: View
{
    @ObservedObject var keyMatrix: KeyMatrix
    @AppStorage("chip8Mapping") private var useChip8KeyboardMapping = false
    @State private var pressedKey: String?
    @State private var heldKeys: Set<String> = []
    @State private var keyboardMonitors: [Any] = []
    
    private let columns =
    [
        GridItem(.flexible()), GridItem(.flexible()),
        GridItem(.flexible()), GridItem(.flexible())
    ]
    
    private let keys =
    [
        "1", "2", "3", "C",
        "4", "5", "6", "D",
        "7", "8", "9", "E",
        "A", "B", "F", "0"
    ]
    
    let keyboardToChip8Mapping: [String: String] =
    [
        "1": "1", "2": "2", "3": "3", "4": "C",
        "q": "4", "w": "5", "e": "6", "r": "D",
        "a": "7", "s": "8", "d": "9", "f": "E",
        "z": "A", "x": "B", "c": "F", "v": "0"
    ]
    
    let keyboardMapping: [String: String] =
    [
        "1": "1", "2": "2",
        "3": "3", "4": "4",
        "5": "5", "6": "6",
        "7": "7", "8": "8",
        "9": "9", "0": "0",
        "a": "A", "b": "B",
        "e": "E", "f": "F"
    ]
    
    var body: some View
    {
        VStack(spacing: 16)
        {
            LazyVGrid(columns: columns, spacing: 12)
            {
                ForEach(keys, id: \.self)
                {
                    key in
                    Button(action: {})
                    {
                        Text(key)
                            .font(.system(size: 18, weight: .semibold, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .aspectRatio(3, contentMode: .fit)
                            .background(pressedKey == key ? Color.blue.opacity(0.7) : Color.blue)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    .mouseEventButton(key: key, onKeyDown: { handleKeyDown(key) }, onKeyUp: { handleKeyUp(key) })
                }
            }
            .padding(16)
            
            VStack
            {
                Text(keyMatrix.binaryArray)
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
                    .foregroundColor(.primary)
                    .frame(height: 60)
            }
            .frame(maxWidth: .infinity)
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(8)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            VStack
            {
                Text(keyMatrix.lastPressedHex)
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
                    .foregroundColor(.primary)
                    .frame(height: 60)
            }
            .frame(maxWidth: .infinity)
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(8)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            Spacer()
        }
        .frame(minWidth: 300, minHeight: 350)
        .onAppear
        {
            setupKeyboardMonitoring()
        }
        .onDisappear
        {
            removeKeyboardMonitoring()
        }
    }
    
    private func setupKeyboardMonitoring()
    {
        let downMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown)
        {
            event in
            return self.handlePhysicalKeyPress(event, isKeyDown: true) ? nil : event
        }
        
        let upMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyUp)
        {
            event in
            return self.handlePhysicalKeyPress(event, isKeyDown: false) ? nil : event
        }
        
        keyboardMonitors = [downMonitor, upMonitor]
    }
    
    private func removeKeyboardMonitoring()
    {
        for monitor in keyboardMonitors
        {
            NSEvent.removeMonitor(monitor)
        }
        
        keyboardMonitors.removeAll()
    }
    
    private func handlePhysicalKeyPress(_ event: NSEvent, isKeyDown: Bool) -> Bool
    {
        guard let characters = event.characters?.lowercased()
        else
        {
            return false
        }
        
        for char in characters
        {
            if let chip8Key = useChip8KeyboardMapping
                ? keyboardToChip8Mapping[String(char)]
                : keyboardMapping[String(char)]
            {
                if isKeyDown
                {
                    handleKeyDown(chip8Key)
                    return true
                }
                
                handleKeyUp(chip8Key)
                return true
            }
        }
        
        return false
    }
    
    private func handleKeyDown(_ key: String)
    {
        heldKeys.insert(key)
        pressedKey = key
        keyMatrix.keyDown(key: key)
    }
    
    private func handleKeyUp(_ key: String)
    {
        heldKeys.remove(key)
        pressedKey = nil
        keyMatrix.keyUp(key: key)
    }
}

#Preview
{
    KeyboardView(keyMatrix: KeyMatrix())
}
