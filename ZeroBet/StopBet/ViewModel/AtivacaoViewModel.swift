import Foundation
import NetworkExtension
import UserNotifications

class AtivacaoViewModel: ObservableObject {
    @Published var perfilInstalado: Bool = UserDefaults.standard.bool(forKey: "perfilInstalado")
    @Published var mensagemErro: ErroDeAtivacao? = nil

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
                print("❌ Erro ao carregar preferências: \(error!.localizedDescription)")
                DispatchQueue.main.async {
                    self.mensagemErro = ErroDeAtivacao(mensagem: "Não foi possível ativar o monitoramento. Tente novamente mais tarde.")
                }
                return
            }

            let tunnelProtocol = NETunnelProviderProtocol()
            tunnelProtocol.providerBundleIdentifier = "com.stopbet.DNSBlockerExtension"
            tunnelProtocol.serverAddress = "127.0.0.1"
            tunnelProtocol.providerConfiguration = [:]

            manager.protocolConfiguration = tunnelProtocol
            manager.localizedDescription = "StopBet Monitor"
            manager.isEnabled = true

            manager.saveToPreferences { error in
                if let error = error {
                    print("❌ Erro ao salvar preferências: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.mensagemErro = ErroDeAtivacao(mensagem: "Não foi possível ativar o monitoramento. Tente novamente mais tarde.")
                    }
                } else {
                    do {
                        try manager.connection.startVPNTunnel()
                        print("✅ Túnel iniciado com sucesso")

                        DispatchQueue.main.async {
                            self.perfilInstalado = true
                            UserDefaults.standard.set(true, forKey: "perfilInstalado")
                        }

                    } catch {
                        print("❌ Erro ao iniciar túnel: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.mensagemErro = ErroDeAtivacao(mensagem: "Não foi possível ativar o monitoramento. Tente novamente mais tarde.")
                        }
                        
                        // ⚠️ DEBUG: força ativar status mesmo se falhar (temporário)
                        DispatchQueue.main.async {
                            self.perfilInstalado = true
                            UserDefaults.standard.set(true, forKey: "perfilInstalado")
                        }
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

struct ErroDeAtivacao: Identifiable {
    let id = UUID()
    let mensagem: String
}
