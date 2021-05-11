//
//  ContentView.swift
//  Bullseye
//
//  Created by Juliana Leon on 10/20/20.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .modifier(Shadow())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }


    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                // Target row
                HStack {
                    Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                    Text("\(target)").modifier(ValueStyle())
                }
                Spacer()
                
                // Slider row
                HStack {
                    Text("1").modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                    Text("100").modifier(LabelStyle())
                }
                Spacer()
                
                // Button row
                Button(action: {
                    print("button pressed")
                    self.alertIsVisible = true // need the self. because we are in the button action
                   
                }) {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Hit Me!")/*@END_MENU_TOKEN@*/.modifier(ButtonLargeTextStyle())
                }
                .alert(isPresented: $alertIsVisible) { () -> Alert in
                    return Alert(title: Text("\(alertTitle())"),
                                 message: Text("The slider's value is \(sliderValueRounded()).\n" + "You scored \(pointsForCurrentRound()) points this round."), dismissButton: .default(Text("Awesome")) {
                                    self.score = self.score + self.pointsForCurrentRound()
                                    self.target = Int.random(in: 1...100)
                                    self.round = self.round + 1
                                 })
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                
                // Score row
                HStack {
                    Button(action: {
                        self.resetGame()
                    }) {
                        HStack {
                            Image("StartOverIcon")
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Start over")/*@END_MENU_TOKEN@*/.modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")).modifier(Shadow())
                    Spacer()
                    Text("Score:").modifier(LabelStyle())
                    Text("\(score)").modifier(ValueStyle())
                    Spacer()
                    Text("Round:").modifier(LabelStyle())
                    Text("\(round)").modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image("InfoIcon")
                            Text("Info").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")).modifier(Shadow())
                }
                .padding(.bottom, 20)
            }
            .background(Image("Background"), alignment: .center)
            .accentColor(midnightBlue)
            .navigationBarTitle("Bullseye")
        }
    }
    
    func sliderValueRounded() -> Int {
        // return Int(sliderValue.rounded()) // If there is only one line of code you don't have to use return, it's inferred
        Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(Int(target - sliderValueRounded()))
    }
    
    func pointsForCurrentRound() -> Int {
        let maxScore = 100
        let difference = amountOff()
        var bonus = 0
        
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        }
        return  maxScore - difference + bonus
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func resetGame() {
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(
            .fixed(width: 896, height: 414))
    }
}
