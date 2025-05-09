//
//  BaseFormField.swift
//  SwiftLearnHub
//
//  Created by Lauv Edward on 5/6/25.
//

import SwiftUI

struct BaseFormField<Content: View>: View {
    var name: String?
    var title: String?
    var helpText: String?
    var errorText: String?
    var isRequired: Bool = false
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                HStack {
                    Text(title)
                        .font(.system(size: 14))
                    if isRequired {
                        Text("*")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
            }
            
            content()
            
            if let helpText, helpText.isEmpty == false {
                Text(helpText)
                    .font(.system(size: 13))
                    .foregroundColor(.yellow)
            }
            
            if let errorText {
                Text(errorText)
                    .font(.system(size: 14))
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    @State var text = ""
    BaseFormField(name: "abc", title: "Title", helpText: "HelpText", errorText: "ErrorText", isRequired: true) {
        TextField(text: $text) {
            Text("")
        }.overlay {
            RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1)
        }.padding(.leading, 10)
            .padding(.trailing, 10)
    }
}
