import Foundation
import NetworkExtension
import UserNotifications

class AtivacaoViewModel: ObservableObject {
    @Published var perfilInstalado: Bool = UserDefaults.standard.bool(forKey: "perfilInstalado")

    func ativarMonitoramento() {
        requestNotificationPermission()
        startTunnel()
    }

    func desativarMonitoramento() {
        stopTunnel()
        perfilInstalado = false
        UserDefaults.standard.set(false, forKey: "perfilInstalado")
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Erro ao solicitar permissão de notificação: \(error.localizedDescription)")
            } else {
                print("Permissão de notificação: \(granted ? "Concedida" : "Negada")")
            }
        }
    }

    private func startTunnel() {
        let manager = NETunnelProviderManager()
        manager.loadFromPreferences { error in
            guard error == nil else {
                print("Erro ao carregar preferências: \(error!.localizedDescription)")
                return
            }

            let tunnelProtocol = NETunnelProviderProtocol()
            tunnelProtocol.providerBundleIdentifier = "com.seuprojeto.DNSBlockerExtension"
            tunnelProtocol.serverAddress = "127.0.0.1"
            tunnelProtocol.providerConfiguration = [:]

            manager.protocolConfiguration = tunnelProtocol
            manager.localizedDescription = "ZeroBet Monitor"
            manager.isEnabled = true

            manager.saveToPreferences { error in
                if let error = error {
                    print("Erro ao salvar preferências: \(error.localizedDescription)")
                } else {
                    do {
                        try manager.connection.startVPNTunnel()
                        print("Túnel iniciado com sucesso")
                        DispatchQueue.main.async {
                            self.perfilInstalado = true
                            UserDefaults.standard.set(true, forKey: "perfilInstalado")
                        }
                    } catch {
                        print("Erro ao iniciar túnel: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    private func stopTunnel() {
        let manager = NETunnelProviderManager()
        manager.loadFromPreferences { _ in
            manager.removeFromPreferences { error in
                if let error = error {
                    print("Erro ao desativar túnel: \(error.localizedDescription)")
                } else {
                    print("Monitoramento desativado")
                }
            }
        }
    }
}
