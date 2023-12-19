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
    var countdownSeconds: Int = 300 // Örnek olarak 5 dakika
    var isCounting: Bool = false
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func updateUI() {
        countDown.text = formattedTime(countdownSeconds)
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
        if countdownSeconds > 0 {
            countdownSeconds -= 1
            updateUI()
        } else {
            // Geri sayım bittiğinde timer'ı durdur
            stopCountdown()

            // Bildirim gönder
            DispatchQueue.main.async {
                self.sendNotification()
            }

            // IndexPath'e göre tableView'yi güncelle
            NotificationCenter.default.post(name: Notification.Name("CountdownFinished"), object: indexPath)
        }
    }
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Countdown Tamamlandı!"
        content.body = "Countdown süresi bitti."

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "countdownNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with instruction: Instruction) {
        
        recipeStepCooking.text = instruction.instruction
        countDown.text = instruction.time
        if instruction.time != nil{
            print(instruction.time)
            countDown.isHidden = false
            startStopButton.isHidden = false
            updateUI()

            startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        }
        
    }

}
