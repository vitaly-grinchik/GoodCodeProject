//
//  ViewController.swift
//  GoodCodeProject
//
//  Created by Виталий Гринчик on 14.12.22.
//

import UIKit

// MARK: - ViewController

final class ViewController: UIViewController {

    // MARK: - Private properties
    
    private let label = UILabel()
    
    private let textField = UITextField()
    
    private let button = UIButton()
    
    private var textToSend = "" // Контейнер (посредник) для передачи данных
    
    // MARK: - Override UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 3-й вариант перехода: по сигвеям:
    // А:  С ПРЕДАЧЕЙ ДАННЫХ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "go22VC" else { return }
        guard let twoVC = segue.destination as? TwoViewController else { return }
        twoVC.text = textToSend
    }
    // Б: БЕЗ ПЕРЕДАЧИ по ID сегвея
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//    }
    
    // MARK: Actions
    
    @objc
    private func goToViewController() {
//  1-й вариант перехода: ПРОГРАММНЫЙ - ПРЕДПОЧТИТЕЛЬНЫЙ!
        let viewController = TwoViewController()    // Определяем - куда идём
        viewController.text = textToSend            // передача данные туда
        viewController.completion = { text in       // передача данных обратно с помощью клоужера - ОЧЕНЬ УДОБНЫЙ И ПОПУЛЯРНЫЙ СПОСОБ !
            self.label.text = text                  // вью контролера
        }
        present(viewController, animated: true)     // Переходим по команде
        
//        2-й вариант перехода: без сигвеев, но со Storyboard
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil) // название соотвтетствует имени файла (можно поменять по необходимости)
//        let twoVC = storyBoard.instantiateViewController(identifier: "TwoViewController") as! TwoViewController
//        twoVC.text = textGotten
//        present(twoVC, animated: true)
    }
}

// MARK: - Setup View
// Настройка общего представления (экрана) данного ViewController-а

private extension ViewController {
    func setupUI() {
        addViews()      // 1-й шаг: добавление элементов ...
        
        addActions()    // ... и экшенов
        
        setupSelfView() // 2-й шаг: настройка представления элемента
        setupLabel()
        setupTextField()
        setupButton()
        
        layout()        // 3-й шаг: раскладка на экране по констрейнтам
    }
}

// MARK: - Setup Views
// настройка представления кнопки: всё в одном месте

private extension ViewController {
    func addViews() {               // Расположение вьюх
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(button)
    }
    
    func addActions() {
        button.addTarget(self, action: #selector(goToViewController), for: .touchUpInside)
    }
    
    func setupSelfView() {
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    func setupLabel() {
        label.text = "Hello!"
        label.layer.cornerRadius = 3
        label.layer.borderWidth = 3
        label.layer.borderColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
    }
    
    func setupTextField() {
        textField.backgroundColor = .yellow
        textField.delegate = self
    }
    
    func setupButton() {
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .black
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.tintColor = .red
    }
}

// MARK: - Layout
// Вёрстка
private extension ViewController {
    func layout() {
        
        [label, textField, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            // и т.д. меняем нужные свойства вкупе для всех элементов, что в массиве
        }
        
//        label.translatesAutoresizingMaskIntoConstraints = false // "отключаем StoryBoard
//        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // 1-й вариант через констрейнты напрямую
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // 2-й вариант через NSLayoutConstraint массив
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 200),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textToSend = textField.text ?? ""
        return true
    }
}
