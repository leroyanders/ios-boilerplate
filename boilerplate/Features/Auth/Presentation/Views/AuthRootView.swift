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
	@Environment(\.colorScheme) private var scheme
	
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
			GeometryReader { geo in
				ScrollView {
					VStack {
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
							passwordText: $passwordText
						)
						
						HStack (alignment: .center, spacing: 10) {
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
										.tint(Color.appQuinary(scheme))
								} else {
									Text("Continue with email")
										.foregroundStyle(Color.appQuinary(scheme))
								}
							}
							.frame(maxWidth: .infinity)
							.padding()
							.background(Color.appPrimary(scheme))
							.clipShape(RoundedRectangle(cornerRadius: 14))
							.padding(.top, 10)
							.disabled(model.isLoading || !isFormValid)
						}
						
						AuthSocialRow(
							textColor: Color.appSecondary(scheme),
							lineColor: Color.appQuaternary(scheme)
						)
					}
					.frame(maxWidth: .infinity)
					.padding(25)
					.frame(minHeight: geo.size.height, alignment: .center)
				}
				.background(Color.appBackground(scheme))
			}
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button {
						if model.authFlow == .signUp {
							model.authFlow = .signIn
						} else {
							dismiss()
						}
					} label: {
						Image(systemName: "chevron.left")
							.font(.system(size: 16, weight: .light))
							.foregroundStyle(Color.appPrimary(scheme))
							.padding(10)
							.background(Color.appQuinary(scheme))
							.clipShape(Circle())
					}
				}
			}
			.navigationBarBackButtonHidden(true)
		}
	}
}

private struct AuthSocialRow: View, Equatable {
	static func == (lhs: Self, rhs: Self) -> Bool { true }
	
	let textColor: Color
	let lineColor: Color
	
	var body: some View {
		VStack {
			HStack(spacing: 12) {
				Rectangle().fill(lineColor).frame(height: 1)
				Text("or")
					.font(.footnote)
					.foregroundStyle(textColor)
				Rectangle().fill(lineColor).frame(height: 1)
			}
			.padding(.vertical, 12)
			
			HStack {
				ButtonWithIcon(icon: .system("apple.logo")) {}
				ButtonWithIcon(icon: .asset("google")) {}
			}
			.frame(maxWidth: .infinity)
		}
	}
}

#Preview {
	let repository = FirebaseAuthRepository(
		authRemote: AuthRemoteService(),
		userRemote: UserRemoteStore(),
		userLocal: UserLocalStore(),
		avatarRemote: AvatarRemoteStore()
	)

	let useCase = AuthUseCase(repository: repository)
	let vm = AuthViewModel(useCase: useCase)

	AuthRootView()
		.environment(vm)
}
