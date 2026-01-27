import SwiftUI
import PhotosUI

struct AuthRootView: View {
	@State var nameText: String = ""
	@State var surnameText: String = ""
	@State var emailText: String = ""
	@State var passwordText: String = ""
	@State var avatar: UIImage?
	
	@Environment(\.dismiss) private var dismiss
	@Environment(AuthViewModel.self) private var model
	
	var body: some View {
		NavigationStack {
			VStack(alignment: .leading) {
				AuthHeaderView(authFlow: model.authFlow, avatar: $avatar).frame(maxWidth: .infinity)
				
				if let error = model.errorMessage {
					VStack {
						Text(error)
							.foregroundStyle(.red)
							.font(.footnote)
							.multilineTextAlignment(.center)
							.padding(.top, 8)
					}
					.frame(maxWidth: .infinity, alignment: .center)
					.padding()
				} else {
					EmptyView()
				}
				
				VStack(spacing: 16) {
					switch model.authFlow  {
					case .signUp:
						VStack {
							HStack {
								AuthTextField(
									placeholder: "Your name",
									keyboardType: .default,
									textContentType: .name,
									text: $nameText
								)
								
								AuthTextField(
									placeholder: "Your surname",
									keyboardType: .default,
									textContentType: .familyName,
									text: $surnameText
								)
							}
						}
						
					case .signIn:
						EmptyView()
					}
					
					
					AuthTextField(
						icon: "envelope",
						placeholder: "Email Address",
						keyboardType: .emailAddress,
						textContentType: .emailAddress,
						text: $emailText
					)
					
					AuthTextField(
						icon: "lock",
						placeholder: "Password",
						isSecure: true,
						text: $passwordText
					)
				}
				
				Button {
					if model.authFlow == .signIn {
						Task {
							await model.login(email: emailText, password: passwordText)
							
							if let user = model.user {
								print("Logged in as \(user.email)")
							}
						}
					} else {
						Task {
							await model.register(
								email: emailText,
								password: passwordText,
								name: nameText,
								lastName: surnameText,
								avatar: avatar
							)
							
							if let user = model.user {
								print("Logged in as \(user.email)")
							}
						}
					}
				} label: {
					Text("Continue with email")
						.foregroundStyle(.white)
						.frame(maxWidth: .infinity)
						.padding()
						.background(.black.opacity(0.9))
						.clipShape(RoundedRectangle(cornerRadius: 14))
				}
				.padding(.top, 10)
				
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
			.padding(25)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button {
						dismiss()
					} label: {
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

#Preview {
	AuthRootView().environment(AuthViewModel())
}
