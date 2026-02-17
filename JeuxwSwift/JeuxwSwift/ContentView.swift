import SwiftUI

struct ContentView: View {
    
    // MARK: - States
    
    @State private var playerScore = 0
    @State private var phoneScore = 0
    
    @State private var usedNumbers: Set<Int> = []
    @State private var phoneUsedNumbers: Set<Int> = []
    
    @State private var playerButtonStates: [Int: Color] = [:]
    @State private var phoneButtonStates: [Int: Color] = [:]
    
    @State private var showRules = false
    @State private var showCongrats = false
    @State private var showEndGame = false
    
    @State private var endMessage = ""
    
    @State private var playerName: String = ""
    @State private var bestScore: Int = 0
    @State private var bestPlayer: String = "Aucun"
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.blue, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("Duel des Chiffres")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Meilleur score : \(bestScore) – \(bestPlayer)")
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("👤 Joueur : \(playerScore)")
                        Text("📱 Téléphone : \(phoneScore)")
                    }
                    .foregroundColor(.white)
                    
                    Text("Votre clavier")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    gridView(isPlayer: true)
                    
                    Text("Clavier du téléphone")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    gridView(isPlayer: false)
                    
                    Button("📘 Règlement") {
                        showRules.toggle()
                    }
                    .foregroundColor(.white)
                    .padding(.top, 10)
                }
                .padding()
            }
            
            if showRules {
                RulesView(showRules: $showRules)
            }
            
            if showCongrats {
                CongratsView(name: playerName, score: playerScore)
            }
            
            if showEndGame {
                EndGameView(message: endMessage) {
                    resetGame()
                }
            }
        }
        .onAppear {
            loadBestScore()
            askPlayerName()
        }
    }
    
    // MARK: - Grid
    
    @ViewBuilder
    func gridView(isPlayer: Bool) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
            ForEach(0..<20) { number in
                Button(action: {
                    if isPlayer {
                        playRound(number)
                    }
                }) {
                    Text("\(number)")
                        .frame(width: 55, height: 55)
                        .background(
                            isPlayer ?
                            (playerButtonStates[number] ?? Color.white)
                            :
                            (phoneButtonStates[number] ?? Color.white.opacity(0.3))
                        )
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .disabled(isPlayer ? usedNumbers.contains(number) : true)
            }
        }
    }
    
    // MARK: - Game Logic
    
    func playRound(_ number: Int) {
        
        // Téléphone choisit uniquement parmi les chiffres non utilisés
        let availablePhoneNumbers = (0...19).filter { !phoneUsedNumbers.contains($0) }
        guard let phoneNumber = availablePhoneNumbers.randomElement() else { return }
        
        phoneUsedNumbers.insert(phoneNumber)
        usedNumbers.insert(number)
        
        phoneButtonStates = [:]
        
        if number > phoneNumber {
            playerScore += 1
            playerButtonStates[number] = .green
            phoneButtonStates[phoneNumber] = .red
        } else if number < phoneNumber {
            phoneScore += 1
            playerButtonStates[number] = .red
            phoneButtonStates[phoneNumber] = .green
        } else {
            playerButtonStates[number] = .gray
            phoneButtonStates[phoneNumber] = .gray
        }
        
        if usedNumbers.count == 20 {
            endGame()
        }
    }
    
    func endGame() {
        
        if playerScore > phoneScore {
            endMessage = "🎉 Vous avez gagné !"
            
            if playerScore > bestScore {
                bestScore = playerScore
                bestPlayer = playerName
                UserDefaults.standard.set(bestScore, forKey: "bestScore")
                UserDefaults.standard.set(bestPlayer, forKey: "bestPlayer")
                
                showCongrats = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showCongrats = false
                }
            }
            
        } else if playerScore < phoneScore {
            endMessage = "📱 Le téléphone a gagné !"
        } else {
            endMessage = "⚖️ Match nul !"
        }
        
        showEndGame = true
    }
    
    func resetGame() {
        playerScore = 0
        phoneScore = 0
        usedNumbers.removeAll()
        phoneUsedNumbers.removeAll()
        playerButtonStates.removeAll()
        phoneButtonStates.removeAll()
        showEndGame = false
    }
    
    func loadBestScore() {
        bestScore = UserDefaults.standard.integer(forKey: "bestScore")
        bestPlayer = UserDefaults.standard.string(forKey: "bestPlayer") ?? "Aucun"
    }
    
    func askPlayerName() {
        playerName = UIDevice.current.name
    }
}

// MARK: - Rules View

struct RulesView: View {
    @Binding var showRules: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Règlement")
                .font(.title)
                .bold()
            
            Text("""
Choisissez un chiffre entre 0 et 19.
Le téléphone choisit un chiffre aléatoire différent à chaque manche.
Le plus grand chiffre gagne 1 point.
Égalité = aucun point.
La partie se termine quand tous les boutons sont utilisés.
""")
            .multilineTextAlignment(.center)
            
            Button("Fermer") {
                showRules = false
            }
            .padding()
        }
        .frame(width: 320)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

// MARK: - End Game View

struct EndGameView: View {
    
    var message: String
    var onRestart: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(message)
                .font(.largeTitle)
                .bold()
            
            Button("Nouvelle Partie") {
                onRestart()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.85))
        .foregroundColor(.white)
    }
}

// MARK: - Congrats View

struct CongratsView: View {
    var name: String
    var score: Int
    
    var body: some View {
        VStack {
            Text("🏆 Nouveau Record !")
                .font(.largeTitle)
                .bold()
            
            Text("\(name)")
                .font(.title)
            
            Text("Score : \(score)")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
        .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
}
