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
    var animalsCount: [Animal: Int] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        let animals = collectAnimals(from: answersChosen)
        calculateAnimal(from: animals)
        identifyAnimal()
        navigationItem.setHidesBackButton(true, animated: false)
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
    
    // Сложный способ
    func calculateAnimals(from animals: [Animal]) {
        animalsCount = animals.reduce(into: [:], { animalsCount, animal in animalsCount[animal] = 0 })

        for animal in animals {
            animalsCount[animal]! += 1
        }
    }
    
    
    // Простой способ
    func calculateAnimal(from animals: [Animal]) {
        for animal in animals {
            if let animalCount = animalsCount[animal] {
                animalsCount.updateValue(animalCount + 1, forKey: animal)
            } else {
                animalsCount.updateValue(1, forKey: animal)
            }
        }
    }
        
    func identifyAnimal() {

        let animalSorted = animalsCount.sorted { $0.value > $1.value }
        guard let currentAnimal = animalSorted.first?.key else { return }

        definitionAnimalLabel.text = currentAnimal.definition
        emojiAnimalLabel.text = "Вы - \(currentAnimal.rawValue)"
    }
}



