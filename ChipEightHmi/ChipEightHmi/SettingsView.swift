import SwiftUI

struct SettingsView: View
{
    @StateObject private var settings = ServerSettings()
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View
    {
        VStack(spacing: 16)
        {
            Text("Settings")
                .font(.title)
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 8)
            {
                Text("Server URL")
                    .font(.headline)
                
                TextField("Server URL", text: $settings.serverURL)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
                
                Text("Example: http://localhost:8090")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            
            HStack(spacing: 12)
            {
                Button("Reset to Default")
                {
                    settings.reset()
                }
                
                Spacer()
                
                Button("Cancel")
                {
                    dismissWindow()
                }
                .keyboardShortcut(.cancelAction)
                
                Button("Save")
                {
                    settings.save()
                    dismissWindow()
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .frame(minWidth: 400, maxWidth: 500)
        .padding()
    }
}

#Preview
{
    SettingsView()
}
