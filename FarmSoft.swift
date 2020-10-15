//======================
// MARK: - Logic
//======================

func calculateBarnSize(_ b: inout [String: Int]) -> Int
{
    return (b["milk"]! + b["wheat"]! + b["wool"]!)
}

func sell(_ b: inout [String: Int], _ m: inout Double) -> Double?
{
    var benefits : Double?
    if calculateBarnSize(&b) == 0
    {
        return benefits
    }
    benefits = Double(b["milk"]!) * 0.30 + Double(b["wheat"]!) * 1 + Double(b["wool"]!) * 0.30
    m += Double(b["milk"]!) * 0.30
    m += Double(b["wheat"]!) * 1
    m += Double(b["wool"]!) * 0.30
    b = ["milk": 0, "wheat": 0, "wool": 0]
    return benefits
}

func feedCows(_ m: inout Double)
{
    m -= 4.0
}

func harvest(_ b: inout [String: Int], _ q: Int)
{
    b["wheat"]! += q
}

func mowSheep(_ b: inout [String: Int], _ q: Int)
{
    b["wool"]! += q
}

func milkCows(_ b: inout [String: Int], _ q: Int)
{
    b["milk"]! += q
}

func readQuantity(_ s: String) -> Int?
{
    print("Combien de \(s) avez vous produit ?")
    if let line = readLine()
    {
        if let quantity = Int(line)
        {
            return quantity
        }
    }
    print("Je n'ai pas compris.")
    return nil
}

//======================
// MARK: - Activities
//======================

func registerActivity(_ m: inout Double, _ b: inout [String: Int])
{
    print("Qu’avez-vous fait aujourd'hui?"
            + "\n1. 🥕  J’ai nourri mes animaux"
            + "\n2. 💰  J’ai vendu mes produits"
            + "\n3. 🐄  J’ai trait mes vaches"
            + "\n4. 🌾  J’ai moissonné"
            + "\n5. 🐑  J’ai tondu mes moutons")
    
    if let choice = readLine()
    {
        switch choice {
        case "1" :
            feedCows(&m)
            print("Super ! vous avez maintenant \(m) euros en banque !")
        case "2" :
            if let sum = sell(&b, &m)
            {
                print("Super ! vous avez gagné \(sum) euros !")
            }
            else
            {
                print("Vous n'avez pas de stock !")
            }
        case "3" :
            if let q = readQuantity("bidons de lait")
            {
                milkCows(&b, q)
            }
            print("Super !")
        case "4" :
            if let q = readQuantity("bottes de blé")
            {
                harvest(&b, q)
            }
            print("Super !")
        case "5" :
            if let q = readQuantity("pelottes de laine")
            {
                mowSheep(&b, q)
            }
            print("Super !")
        default:
            print("Je ne comprends pas.")
        }
    }
}

//======================
// MARK: - Main
//======================
// using global variables cauz idk yet how to specify
// an entry point but coding as if there was a main() func...

var barn = ["milk": 0, "wheat": 0, "wool": 0]
var money = 30.0
var exit = false

repeat {
    print("Que voulez vous faire ?"
            + "\n1. 🤸  Enregistrer une nouvelle activité"
            + "\n2. 🏦  Consulter ma banque"
            + "\n3. 🏠  Consulter ma grange")
    
    if let choice = readLine()
    {
        switch choice {
        case "1" :
            print("Vous voulez enregistrer une nouvelle activité!")
            registerActivity(&money, &barn)
        case "2" :
            print("Votre banque contient \(money) euros!")
        case "3" :
            print("Votre grange contient :"
                    + "\n🍼  \(barn["milk"]!) bidons de lait"
                    + "\n🌾  \(barn["wheat"]!) bottes de blé"
                    + "\n⚪️  \(barn["wool"]!) pelottes de laine")
        case "q" :
            print("Merci salut !")
            exit = true
        default:
                print("Je ne comprends pas.")
        }
    }
} while !exit
