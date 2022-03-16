//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 14.03.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultAnimalLabel: UILabel!
    @IBOutlet var resultDescriptionLabel: UILabel!
    
    var ansversChosen: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        getResultAndUpdateUI()
    }
    
    private func getResultAndUpdateUI() {
        var animalCounts: [Animal : Int] = [ : ]
        
        for animal in Animal.allCases {
            for answer in ansversChosen {
                if answer.animal == animal {
                    animalCounts[answer.animal] = (animalCounts[answer.animal] ?? 0) + 1
                }
            }
        }
        
        let sortedAnimalCounts = animalCounts.sorted { $0.value > $1.value }
        
        var resultAnimal = "Вы – "
        var resultDescription = ""
        var currentAnimalValue = 0
        var counterOfResultAnimals = 0
        
        for animal in sortedAnimalCounts {
            if currentAnimalValue == 0 {
                resultAnimal += String(animal.key.rawValue)
                resultDescription = animal.key.definition
            } else if currentAnimalValue == animal.value {
                resultAnimal += " и " + String(animal.key.rawValue)
                resultDescription += "\n\n" + animal.key.definition
            }
            currentAnimalValue = animal.value
            counterOfResultAnimals += 1
        }
        
        let fontSizeCorrectionCoefficient = (10 + CGFloat(counterOfResultAnimals)) / 10
        
        resultAnimalLabel.font = resultAnimalLabel.font.withSize(
            resultAnimalLabel.font.pointSize / fontSizeCorrectionCoefficient
        )
        resultAnimalLabel.text = resultAnimal
        resultDescriptionLabel.text = resultDescription
        
    }
}
