//
//  ContentView.swift
//  RGBBullsEye
//


import SwiftUI

struct ContentView: View {
    
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    
    @ObservedObject var timer = TimeCounter()
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1.0 - diff) * 100.0 + 0.5)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Color(red: rTarget, green: gTarget, blue: bTarget)
                        //Text("Match this color")
                        self.showAlert ? Text("R: \(Int(rGuess * 255.0))" + " G: \(Int(gGuess * 255.0))" + " B: \(Int(bGuess * 255.0))") : Text("Match this color")
                    }
                    VStack {
                        ZStack(alignment: .center) {
                            Color(red: rGuess, green: gGuess, blue: bGuess)
                            Text(String(timer.counter))
                                .foregroundColor(Color.black)
                                .padding(.all, 5)
                                .background(Color.white)
                                .mask(Circle())
                            
                        }
                        
                        Text("R: \(Int(rGuess * 255.0))" + " G: \(Int(gGuess * 255.0))" + " B: \(Int(bGuess * 255.0))")
                    }
                }
                Button(action: { self.showAlert = true }) {
                    Text("Hit Me!")
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Your Score"), message: Text(String(computeScore())))
                }.padding()
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
            .previewLayout(.fixed(width: 568, height: 320))
            .environment(\.colorScheme, .dark)
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    var body: some View {
        HStack{
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
                .background(textColor)
                .cornerRadius(10)
            Text("255").foregroundColor(textColor)
        }.padding(.horizontal)
    }
}
