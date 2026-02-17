import SwiftUI

struct DragonGame: View {
    
    @State private var nourriture = 50
    @State private var humeur = "😐"
    @State private var message = "Le dragon te regarde..."
    
    var body: some View {
        VStack(spacing: 20) {
            
            // 1. Titre
            Text("🐉 DragonAppétit")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 2. Dragon (emoji humeur)
            Text(humeur)
                .font(.system(size: 100))
            
            // 3. Message
            Text(message)
                .font(.title2)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
            
            // 4. Barre de nourriture
            VStack {
                Text("Nourriture: \(nourriture)")
                ProgressView(value: Double(nourriture), total: 100)
                    .tint(.green)
            }
            .padding(.horizontal)
            
            // 5. Boutons Nourrir
            HStack(spacing: 20) {
                
                Button("🍎 Donner 10") {
                    nourrir(quantite: 10)
                }
                .buttonStyle(.borderedProminent)
                
                Button("⭐ Donner 20") {
                    nourrir(quantite: 20)
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
            
            // BONUS : Promener
            Button("🐾 Promener") {
                promener()
            }
            .buttonStyle(.bordered)
            
            Button("🎮 Nouvelle partie") {
                reset()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
    
    // MARK: - Nourrir
    
    func nourrir(quantite: Int) {
        
        nourriture += quantite
        
        if nourriture > 100 {
            nourriture = 100
        }
        
        updateHumeur()
    }
    
    // MARK: - Promener (Bonus)
    
    func promener() {
        
        nourriture -= 15
        
        if nourriture < 0 {
            nourriture = 0
        }
        
        message = "Le dragon adore sa promenade 🐾"
        humeur = "🙂"
        
        updateHumeur()
    }
    
    // MARK: - Mise à jour humeur
    
    func updateHumeur() {
        
        if nourriture < 30 {
            humeur = "😠"
            message = "Le dragon a très faim ! 🔥"
            
        } else if nourriture < 60 {
            humeur = "😐"
            message = "Il attend encore un snack..."
            
        } else if nourriture < 90 {
            humeur = "🙂"
            message = "Miam ! Il est content ! 🐉"
            
        } else {
            humeur = "😊"
            message = "Il est très heureux et prêt à voler ! ✨"
        }
    }
    
    // MARK: - Reset
    
    func reset() {
        nourriture = 50
        humeur = "😐"
        message = "Le dragon te regarde..."
    }
}

#Preview {
    DragonGame()
}
