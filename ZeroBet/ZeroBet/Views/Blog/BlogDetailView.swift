import SwiftUI

struct BlogDetailView: View {
    let post: BlogPost

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(post.titulo)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)

                Text(post.conteudo + "\n\n(Conteúdo completo viria aqui...)")
                    .font(.body)
                    .foregroundColor(.primary)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Artigo")
        .navigationBarTitleDisplayMode(.inline)
    }
}
