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
						placeholder: "Name",
                        icon: "person",
						keyboardType: .default,
						textContentType: .name,
                        text: $nameText
                    )

                    AuthTextField(
						placeholder: "Surname",
                        icon: "person",
						keyboardType: .default,
						textContentType: .familyName,
                        text: $surnameText
                    )
                }
            }

            AuthTextField(
				placeholder: "Email Address",
                icon: "envelope",
                keyboardType: .emailAddress,
                textContentType: .emailAddress,
                text: $emailText
            )

            AuthSecureField(
                placeholder: "Password",
				icon: "lock",
                text: $passwordText
            )
        }
    }
}
