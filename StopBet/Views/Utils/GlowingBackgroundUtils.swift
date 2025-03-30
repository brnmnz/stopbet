import SwiftUI

struct GlowingBackgroundUtils: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            GlowCircle(color: .orange, size: 300, blur: 100)
                .offset(x: -60, y: -120)

            GlowCircle(color: .purple, size: 250, blur: 100)
                .offset(x: 100, y: 80)

            GlowCircle(color: .blue, size: 200, blur: 80)
                .offset(x: -100, y: 150)
        }
    }
}

struct GlowCircle: View {
    var color: Color
    var size: CGFloat
    var blur: CGFloat

    var body: some View {
        Circle()
            .fill(color.opacity(0.4))
            .frame(width: size, height: size)
            .blur(radius: blur)
    }
}
