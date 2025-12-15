import SwiftUI

struct KeyboardView: View
{
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View
    {
        VStack
        {
            Text("Keyboard")
                .font(.title)
        }
        .frame(minWidth: 400, minHeight: 300)
    }
}

#Preview
{
    KeyboardView()
}
