import SwiftUI

struct UserInfoView: View {
    var body: some View {
        VStack {
            Text("User Info")
                .font(.title)
                .fontWeight(.bold)

            Spacer()
        }
        .padding()
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
