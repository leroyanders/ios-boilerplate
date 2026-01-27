import SwiftUI

struct AuthFormFields: View {
    let isSignUp: Bool

    @Binding var nameText: String
    @Binding var surnameText: String
    @Binding var emailText: String
    @Binding var passwordText: String

    var body: some View {
        VStack(spacing: 16) {
            if isSignUp {
                HStack {
                    AuthTextField(
                        icon: "person",
                        placeholder: "Name",
                        text: $nameText
                    )

                    AuthTextField(
                        icon: "person",
                        placeholder: "Surname",
                        text: $surnameText
                    )
                }
            }

            AuthTextField(
                icon: "envelope",
                placeholder: "Email Address",
                keyboardType: .emailAddress,
                textContentType: .emailAddress,
                text: $emailText
            )

            AuthSecureField(
                icon: "lock",
                placeholder: "Password",
                text: $passwordText
            )
        }
    }
}
