//
//  ActivityIndicator.swift
//  ios_assignment
//
//  Created by Shivam Chawla on 21/08/23.
//

import SwiftUI

struct ActivityIndicatorView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)

                }
                
                .frame(width: 100,
                       height: 100)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)


            }
        }
    }

}
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        DispatchQueue.main.async {
            isAnimating ? uiView.startAnimating() : uiView.stopAnimating()

        }
    }
}
