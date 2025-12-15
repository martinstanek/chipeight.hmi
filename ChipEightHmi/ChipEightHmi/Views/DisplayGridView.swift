import SwiftUI

struct DisplayGridView: View
{
    @ObservedObject var display: PixelDisplay
    
    let pixelWidth: CGFloat = 12
    let pixelHeight: CGFloat = 12
    let pixelSpacing: CGFloat = 1
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            ZStack
            {
                display.backgroundColor.ignoresSafeArea()
                
                VStack(spacing: pixelSpacing)
                {
                    ForEach (0..<DisplayConfig.height, id: \.self)
                    { y in
                        HStack(spacing: pixelSpacing)
                        {
                            ForEach(0..<DisplayConfig.width, id: \.self)
                            { x in
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(display.pixels[y][x] ? display.foregroundColor : display.backgroundColor)
                                    .frame(width: pixelWidth, height: pixelHeight)
                                    .border(Color.gray.opacity(0.3), width: 0.5)
                            }
                        }
                    }
                }
                .padding(8)
            }
            .frame(height: 430)
            .cornerRadius(8)
            .shadow(radius: 4)
        }
        .padding()
    }
}

#Preview
{
    DisplayGridView(display: PixelDisplay())
}
