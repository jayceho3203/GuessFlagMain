//
//  ContentView.swift
//  GuessFlag
//
//  Created by Jayce Ho on 30/07/2024.
//
// 1.Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label.
import SwiftUI

struct ContentView: View {
    
    func flagTapped(_ number: Int){
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            totalScore += 10
        } else {
            scoreTitle = "Wrong! That is the flag of \(countries[number])"
        }
        if stage < 3 {
            showingScore = true
        } else {
            showingTotal = true
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame(){
        stage = 1
        totalScore = 0
        askQuestion()
    }
    
    func nextStage(){
        stage += 1
        askQuestion()
    }
    
    func finishGame(stage: Int){
        if stage > 8{
            showingScore = false
            showingTotal = true
        }
    }
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingTotal = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var stage = 1
    var body: some View {
        ZStack {
            Spacer()
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.75, green: 0.15, blue: 0.25), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Text("Stage \(stage)")
                    .foregroundStyle(.mint)
                    .font(.title.bold())
                VStack (spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(color: .indigo, radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Total Score: \(totalScore)")
                    .font(.largeTitle)
                    .foregroundStyle(.indigo)
                    .padding(20)
                    .background(.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
            }
            
            // Show alert
            .alert(scoreTitle, isPresented: $showingScore) {
                Button{
                    resetGame()
                } label: {
                    Text("Reset game")
                }
                Button{
                    nextStage()
                } label: {
                    Text("Continute")
                }
            } message: {
                Text("Your score is \(totalScore)")
            }
            
            .alert("Finished", isPresented: $showingTotal) {
                Button{
                    resetGame()
                } label: {
                    Text("Play again")
                }
            } message: {
                Text("Your total score is \(totalScore)")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
