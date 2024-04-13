//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Valeriia Rohatynska on 05/04/2024.
//

import SwiftUI

struct ContentView: View {
//    @State private var possibleMoves = ["Rock", "Paper", "Scissors"]
    @State private var possibleMoves = ["🪨", "📄", "✂️"]
    @State private var winningMoves = ["📄", "✂️", "🪨"]
    
    @State private var appCurrentChoice = Int.random(in: 0...2)
    @State private var playerShouldWin = Bool.random()
    
    @State private var userChoice = ""
    @State private var userScore = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var questionCount = 1
    @State private var showingFinalScore = false
    
    @State private var showingRules = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    Text("❓")
                        .font(.largeTitle)
                        .onTapGesture {
                            self.showingRules = true
                        }
                        .alert("Game rules", isPresented: $showingRules) {
                            Button("OK", role: .cancel) {}
                        }
                        message: {
                            Text("The app chooses rock, paper, or scissors each turn. Your goal changes each round: you'll be asked to either win or lose against the app's choice. Select the correct option to win or lose the game.")
                        }
                }
                
                Spacer()
                    .frame(height: 180)
                
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.red)
                
                VStack(spacing: 10) {
                    VStack {
                        
                        Text("App's move: \(possibleMoves[appCurrentChoice])")
                            .font(.title3)
                            .padding(1)
                        
                        Text("Try to ")
                            .font(.title3)
                        +
                        Text(playerShouldWin ? "win" : "lose")
                            .font(.title3.weight(.heavy))
                    
                        HStack{
                            ForEach(possibleMoves, id: \.self) { move in
                                Button {
                                    buttonTapped(move)
                                    
                                } label: {
                                    Text(move)
                                        .font(.system(size: 60, weight: .regular))
                                }
                                .buttonStyle(.bordered)
                                .padding(15)
                            }
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    Text("Score: \(userScore)")
                        .font(.title3.bold())
                    Spacer()
                    
                }
                .padding()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Next round", action: startNextRound)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("Game over!", isPresented: $showingFinalScore) {
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is \(userScore)/\(questionCount)")
        }
    }
    
    func buttonTapped(_ userChoice: String) {
        if playerShouldWin && possibleMoves[appCurrentChoice] == "🪨" && userChoice == winningMoves[0] {
            userScore += 1
            scoreTitle = "Correct"
        } else if playerShouldWin && possibleMoves[appCurrentChoice] == "📄" && userChoice == winningMoves[1] {
            userScore += 1
            scoreTitle = "Correct"
        } else if playerShouldWin  && possibleMoves[appCurrentChoice] == "✂️" && userChoice == winningMoves[2] {
            userScore += 1
            scoreTitle = "Correct"
        } else if !playerShouldWin && possibleMoves[appCurrentChoice] == "🪨" && userChoice == winningMoves[1]  {
            userScore += 1
            scoreTitle = "Correct"
        } else if !playerShouldWin && possibleMoves[appCurrentChoice] == "📄" && userChoice == winningMoves[2]  {
            userScore += 1
            scoreTitle = "Correct"
        } else if !playerShouldWin && possibleMoves[appCurrentChoice] == "✂️" && userChoice == winningMoves[0]  {
            userScore += 1
            scoreTitle = "Correct"
        } else if possibleMoves[appCurrentChoice] == userChoice {
            userScore = userScore
            scoreTitle = "It's a draw!"
        } else {
            userScore -= 1
            scoreTitle = "Wrong!"
        }
        
        if questionCount < 10 {
            showingScore = true
            questionCount += 1
        } else {
            showingFinalScore = true
        }
        
        print("The played tapped \(userChoice), the player was trying to \(playerShouldWin), and the app chose \(appCurrentChoice)")
    }
    
    func startNextRound() {
        appCurrentChoice = Int.random(in: 0...2)
        playerShouldWin.toggle()
    }
    
    func reset() {
        appCurrentChoice = Int.random(in: 0...2)
        playerShouldWin.toggle()
        userScore = 0
        questionCount = 1
        showingScore = false
        showingFinalScore = false
    }
}

#Preview {
    ContentView()
}
