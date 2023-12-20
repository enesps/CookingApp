//
//  RecipeCookingTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 5.12.2023.
//

import UIKit
import UserNotifications
class RecipeCookingTableViewCell: UITableViewCell {

    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var countDown: UILabel!
    @IBOutlet weak var recipeStepNumber: UILabel!
    @IBOutlet weak var recipeStepCooking: UILabel!
    var timer: Timer?
    var countdownSeconds: Int? // Örnek olarak 5 dakika
    var isCounting: Bool = false

    let notificationIdentifier = "myNotification"

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func updateUI() {
        countDown.text = formattedTime((countdownSeconds)!)
        startStopButton.setTitle(isCounting ? "Durdur" : "Başlat", for: .normal)
        startStopButton.setTitleColor(isCounting ? .systemRed : .systemBlue, for: .normal)
    }

    func formattedTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    @objc func startStopButtonTapped() {
        if isCounting {
            stopCountdown()
        } else {
            startCountdown()
        }
    }

    func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        isCounting = true
        updateUI()
    }

    func stopCountdown() {
        timer?.invalidate()
        timer = nil
        isCounting = false
        updateUI()
    }

    @objc func updateCountdown() {
        if countdownSeconds! > 0 {
            countdownSeconds! -= 1
            updateUI()
        } else {
            // Geri sayım bittiğinde timer'ı durdur
            stopCountdown()

            // Bildirim gönder
            DispatchQueue.main.async {
                self.sendNotification()
            }


        }
    }
    func sendNotification() {
        self.scheduleNotification(inSeconds: 0.1 , completion: { success in
            if success {
              print("Successfully scheduled notification")
            } else {
              print("Error scheduling notification")
            }
          })

    }
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (Bool) -> ()) {

      // Create Notification content
      let notificationContent = UNMutableNotificationContent()
    
      notificationContent.title = "Yemeğiniz yanmadan geri dönün!!!"
      notificationContent.subtitle = "Yemeğiniz sizi bekliyor."
      notificationContent.body = "Artık Yemeğinizi bitirme zamanı"


      // Create Notification trigger
      // Note that 60 seconds is the smallest repeating interval.
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)

      // Create a notification request with the above components
      let request = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: trigger)

      // Add this notification to the UserNotificationCenter
      UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
        if error != nil {
          print("\(error)")
          completion(false)
        } else {
          completion(true)
        }
      })
    }
    func extractMinutes(from timeString: String) -> Int? {
        // Gelen string'den "15" gibi sayıları çıkarmak için bir fonksiyon
        func extractNumber(from input: String) -> Int? {
            let numbers = input.components(separatedBy: CharacterSet.decimalDigits.inverted)
            return numbers.compactMap { Int($0) }.first
        }

        // "15 dakika" gibi bir ifadeyi analiz etmek
        guard let minutes = extractNumber(from: timeString) else {
            return nil
        }

        return minutes
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with instruction: Instruction) {
        
        recipeStepCooking.text = instruction.instruction
        countDown.text = instruction.time
        if instruction.time != nil{
            countDown.isHidden = false
            startStopButton.isHidden = false
            if let time = instruction.time {
                if let minutes = extractMinutes(from: time) {
                    self.countdownSeconds = minutes
                    updateUI()

                }
            }


            startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        }
        
    }

}
