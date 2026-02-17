
import SwiftUI

struct ContentView: View {
    
    @State private var result = "0"
    
    var body: some View {
        VStack {
            Text("Ma calculatrice")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            VStack(alignment: .trailing){
                Text(result)
                    .font(.title)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,maxHeight: 60 )
            }
            .background(Color.gray.opacity(0.3))
            .frame(height: 100)
            
            VStack (spacing: 20){
                HStack{
                    Button("7"){
                        result = "7"
                    }
                   
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.red)
                        .clipShape(Circle())
                    
                    Button("8"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.red)
                        .clipShape(Circle())
                    
                    Button("9"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.red)
                        .clipShape(Circle())
                    
                    Button("+"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.gray)
                        .clipShape(Circle())
                        .padding(.leading, 40)
                }
                HStack{
                    Button("7"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.red)
                        .clipShape(Circle())
                    
                    Button("8"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.red)
                        .clipShape(Circle())
                    
                    Button("9"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.red)
                        .clipShape(Circle())
                    
                    Button("+"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.gray)
                        .clipShape(Circle())
                        .padding(.leading, 40)
                }
                HStack{
                    Button("1"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.red)
                        .clipShape(Circle())
                    
                    Button("3"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.red)
                        .clipShape(Circle())
                    
                    Button("3"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.red)
                        .clipShape(Circle())
                    
                    Button("+"){}
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(.gray)
                        .clipShape(Circle())
                        .padding(.leading, 40)
                }
            }
            .padding(.top, 40)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
