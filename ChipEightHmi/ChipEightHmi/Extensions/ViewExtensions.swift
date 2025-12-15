import SwiftUI

extension View
{
    func mouseEventButton(key: String, onKeyDown: @escaping () -> Void, onKeyUp: @escaping () -> Void) -> some View
    {
        modifier(MouseEventButtonModifier(key: key, onKeyDown: onKeyDown, onKeyUp: onKeyUp))
    }
}
