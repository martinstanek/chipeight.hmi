import SwiftUI

struct SettingsView: View
{
    @Environment(\.dismissWindow) private var dismissWindow
    @AppStorage("port") private var port = "8090"
    @AppStorage("chip8Mapping") private var useChip8KeyboardMapping = false
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            VStack(alignment: .leading, spacing: 8)
            {
                Text("Server port")
                    .font(.caption)
                
                TextField("Server port", text: $port)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8)
            {
                Toggle("Use Chip8 keyboard mapping", isOn: $useChip8KeyboardMapping)
            }
            .padding(.horizontal)
        }
    }
}

#Preview
{
    SettingsView()
}
