//
//  ViewController.swift
//  ThreeButtonsTask
//
//  Created by Andrii's Macbook  on 05.09.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Private properties
    
    var buttons: [UIButton] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStackView()
        configureButtons()
    }
}

private extension ViewController {
    // MARK: - Private methods
    
    func configureStackView() {
        stackView.arrangedSubviews.forEach { subview in
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    func configureButtons() {
        ButtonDataSource.buttons.forEach { button in
            let configuration = configureButton(with: button.title)
            let button = CustomButtom(configuration: configuration, primaryAction: nil)
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
            button.addTarget(self, action: #selector(buttonTouchUpInside(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonTouchUpOutside(_:)), for: .touchUpOutside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    func configureButton(with title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.buttonSize = .mini
        configuration.image = UIImage(systemName: "swift")
        configuration.imagePlacement = .trailing
        configuration.cornerStyle = .capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        configuration.imagePadding = 8
        return configuration
    }
}

private extension ViewController {
    // MARK: - Actions
    
    @objc func buttonTouchDown(_ sender: UIButton) {
        increaseButtonSize(with: sender)
    }
    
    @objc func buttonTouchUpInside(_ sender: UIButton) {
        decreaseButtonSize(with: sender)
        handleAction(with: sender)
    }
    
    @objc func buttonTouchUpOutside(_ sender: UIButton) {
        decreaseButtonSize(with: sender)
    }
}

private extension ViewController {
    // MARK: - Button animation
    
    func increaseButtonSize(with button: UIButton) {
        UIView.animate(withDuration: 0.2) {
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    func decreaseButtonSize(with button: UIButton) {
        UIView.animate(withDuration: 0.2) {
            button.transform = CGAffineTransform.identity
        }
    }
}

private extension ViewController {
    // MARK: - Action handling
    
    func handleAction(with button: UIButton) {
        if let index = buttons.firstIndex(of: button) {
            let buttonCase = ButtonDataSource.buttons[index]
            switch buttonCase {
            case .firstButton:
                print("First button")
            case .secondMediumButton:
                print("Second Medium Butttom")
            case .thirdButton:
                routeToSecondViewController()
            }
        }
    }
}

private extension ViewController {
    // MARK: - ButtonDataSource
    
    struct ButtonDataSource {
        static let buttons: [Buttons] = [
            .firstButton,
            .secondMediumButton,
            .thirdButton]
        
        enum Buttons {
            case firstButton
            case secondMediumButton
            case thirdButton
            
            var title: String {
                switch self {
                case .firstButton: return "First Button"
                case .secondMediumButton: return "Second Medium Butttom"
                case .thirdButton: return "Thid"
                }
            }
        }
    }
}

private extension ViewController {
    // MARK: - Routing
    
    func routeToSecondViewController() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destVC = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        destVC.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(destVC, animated: true, completion: nil)
    }
}

