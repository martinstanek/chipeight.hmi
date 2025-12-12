import SwiftUI

struct ContentView: View
{
    @StateObject private var display = PixelDisplay()
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            DisplayGridView(display: display)
        }
        .backgroundStyle(.background)
    }
}

#Preview
{
    ContentView()
}
