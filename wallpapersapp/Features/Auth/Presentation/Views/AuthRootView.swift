import SwiftUI
import PhotosUI

struct AuthRootView: View {
	@State private var nameText = ""
	@State private var surnameText = ""
	@State private var emailText = ""
	@State private var passwordText = ""
	@State private var avatar: UIImage?
	
	@Environment(\.dismiss) private var dismiss
	@Environment(AuthViewModel.self) private var model
	
	private var isSignUp: Bool { model.authFlow == .signUp }
	private var isFormValid: Bool {
		let isEmailValid = !emailText.isEmpty && emailText.contains("@")
		let isPasswordValid = !passwordText.isEmpty && passwordText.count >= 6
		
		if isSignUp {
			return isEmailValid &&
			isPasswordValid &&
			!nameText.isEmpty &&
			!surnameText.isEmpty
		} else {
			return isEmailValid && isPasswordValid
		}
	}
	
	var body: some View {
		NavigationStack {
			ScrollView {
				VStack(alignment: .center) {
					AuthHeaderView(authFlow: model.authFlow, avatar: $avatar)
						.frame(maxWidth: .infinity)
					
					if let error = model.errorMessage {
						Text(error)
							.foregroundStyle(.red)
							.font(.footnote)
							.multilineTextAlignment(.center)
							.frame(maxWidth: .infinity)
							.padding(.vertical, 10)
					}
					
					AuthFormFields(
						isSignUp: isSignUp,
						nameText: $nameText,
						surnameText: $surnameText,
						emailText: $emailText,
						passwordText: $passwordText,
					)
					
					Button {
						Task {
							if model.authFlow == .signIn {
								await model.login(email: emailText, password: passwordText)
							} else {
								await model.register(
									email: emailText,
									password: passwordText,
									name: nameText,
									lastName: surnameText,
									avatar: avatar
								)
							}
						}
					} label: {
						if model.isLoading {
							ProgressView()
								.tint(.primary)
						} else {
							Text("Continue with email")
						}
					}
					.foregroundStyle(.white)
					.frame(maxWidth: .infinity)
					.padding()
					.background(.black.opacity(model.isLoading ? 0.1 : 0.9))
					.clipShape(RoundedRectangle(cornerRadius: 14))
					.padding(.top, 10)
					.disabled(model.isLoading || !isFormValid)
					
					AuthSocialRow()
				}
				.padding(25)
				.toolbar {
					ToolbarItem(placement: .topBarLeading) {
						Button { dismiss() } label: {
							Image(systemName: "chevron.left")
								.font(.system(size: 14, weight: .semibold))
								.foregroundStyle(.gray)
								.padding(10)
								.background(.gray.opacity(0.1))
								.clipShape(Circle())
						}
					}
				}
				.navigationBarBackButtonHidden(true)
			}
		}
	}
}

private struct AuthSocialRow: View, Equatable {
	static func == (lhs: Self, rhs: Self) -> Bool { true }
	
	var body: some View {
		HStack(spacing: 12) {
			Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1)
			Text("or").font(.footnote).foregroundStyle(.gray)
			Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 1)
		}
		.padding(.vertical, 12)
		
		HStack {
			SocialAuthButton(icon: .system("apple.logo"))
			SocialAuthButton(icon: .asset("google"))
		}
		.frame(maxWidth: .infinity)
	}
}


#Preview {
	AuthRootView()
		.environment(AuthViewModel())
}
