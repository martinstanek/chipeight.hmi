import SwiftUI

struct SettingsView: View
{
    @Environment(\.dismissWindow) private var dismissWindow
    @AppStorage("chip8Mapping") private var useChip8KeyboardMapping = false
    @AppStorage("port") private var port = "8090"

    var body: some View
    {
        VStack(alignment: .leading, spacing: 16)
        {
            Text("Server port")
                .font(.caption)
            
            TextField("Server port", text: $port)
                .textFieldStyle(.roundedBorder)
            
            Toggle("Use Chip8 keyboard mapping", isOn: $useChip8KeyboardMapping)
            
            Spacer()
        }
        .padding()
    }
}

#Preview
{
    SettingsView()
}
