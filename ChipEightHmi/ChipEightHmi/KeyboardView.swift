import SwiftUI

struct KeyboardView: View
{
    @Environment(\.dismissWindow) private var dismissWindow
    @State private var pressedKey: String?
    @State private var keyboardMonitor: Any?
    
    private let useChip8Mapping = false
    
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
        VStack(spacing: 12)
        {
            LazyVGrid(columns: columns, spacing: 12)
            {
                ForEach(keys, id: \.self)
                {
                    key in
                    Button(action:
                            {
                        handleKeyPress(key)
                    })
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
                }
            }
            .padding(16)
            
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
        keyboardMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown)
        {
            event in
            handlePhysicalKeyPress(event)
            return event
        }
    }
    
    private func removeKeyboardMonitoring()
    {
        if let monitor = keyboardMonitor
        {
            NSEvent.removeMonitor(monitor)
        }
    }
    
    private func handlePhysicalKeyPress(_ event: NSEvent)
    {
        guard let characters = event.characters?.lowercased()
        else
        {
            return
        }
        
        for char in characters
        {
            if let chip8Key = useChip8Mapping
                ? keyboardToChip8Mapping[String(char)]
                : keyboardMapping[String(char)]
            {
                handleKeyPress(chip8Key)
                break
            }
        }
    }
    
    private func handleKeyPress(_ key: String)
    {
        pressedKey = key
        
        print("Key pressed: \(key)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
        {
            pressedKey = nil
        }
    }
}

#Preview
{
    KeyboardView()
}
