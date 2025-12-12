import SwiftUI

struct ContentView: View
{
    @EnvironmentObject private var display: PixelDisplay
    
    var body: some View
    {
        VStack(spacing: 4)
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
