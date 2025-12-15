import SwiftUI

struct KeyboardView: View
{
    @Environment(\.dismissWindow) private var dismissWindow
    
    let keys = ["1", "2", "3", "C",
                "4", "5", "6", "D",
                "7", "8", "9", "E",
                "A", "B", "F", "0"]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), 
                   GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View
    {
        VStack(spacing: 12)
        {
            Text("Chip8 Keyboard")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 16)
            
            LazyVGrid(columns: columns, spacing: 12)
            {
                ForEach(keys, id: \.self) { key in
                    Button(action: {
                        handleKeyPress(key)
                    }) {
                        Text(key)
                            .font(.system(size: 18, weight: .semibold, design: .monospaced))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(16)
            
            Spacer()
        }
        .frame(minWidth: 300, minHeight: 350)
    }
    
    private func handleKeyPress(_ key: String)
    {
        print("Key pressed: \(key)")
    }
}

#Preview
{
    KeyboardView()
}
