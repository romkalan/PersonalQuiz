//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 19.02.2023.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var emojiAnimalLabel: UILabel!
    @IBOutlet var definitionAnimalLabel: UILabel!
    
    var answersChosen: [Answer]!
    
    private var catCount = 0
    private var dogCount = 0
    private var turtleCount = 0
    private var rabbitCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
        let animals = collectAnimals(from: answersChosen)
        
        calculateAnimals(from: animals)
        identifyAnimal()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    deinit {
        print("\(type(of: self)) has been deallocated")
    }
}

//MARK: - Private Methods
private extension ResultViewController {
    
    func collectAnimals(from answers: [Answer]) -> [Animal] {
        var animals: [Animal] = []
        
        for answer in answers {
            animals.append(answer.animal)
        }
        
        return animals
    }
    
    func calculateAnimals(from animals: [Animal]) {
        
        for animal in animals {
            switch animal {
            case .cat: catCount += 1
            case .dog: dogCount += 1
            case .turtle: turtleCount += 1
            case .rabbit: rabbitCount += 1
            }
        }
    }
        
    func identifyAnimal() {
        
        let animalsCount: [Animal: Int] = [
            .cat: catCount,
            .dog: dogCount,
            .turtle: turtleCount,
            .rabbit: rabbitCount
        ]
        
        let animalSorted = animalsCount.sorted { $0.value > $1.value }
        guard let currentAnimal = animalSorted.first?.key else { return }
        
        definitionAnimalLabel.text = currentAnimal.definition
        emojiAnimalLabel.text = "Вы - \(currentAnimal.rawValue)"
    }
    
    func identifyAnimalComparison() {
        let currentAnimal: Animal
        
        if catCount >= dogCount && catCount >= turtleCount && catCount >= rabbitCount {
            currentAnimal = .cat
        } else if dogCount >= catCount && dogCount >= turtleCount && dogCount >= rabbitCount {
            currentAnimal = .dog
        } else if turtleCount >= catCount && turtleCount >= dogCount && turtleCount >= rabbitCount {
            currentAnimal = .turtle
        } else {
            currentAnimal = .rabbit
        }
        
        definitionAnimalLabel.text = currentAnimal.definition
        emojiAnimalLabel.text = "Вы - \(currentAnimal.rawValue)"
    }
}



