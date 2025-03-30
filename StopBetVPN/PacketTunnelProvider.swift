import NetworkExtension;

class PacketTunnelProvider: NEPacketTunnelProvider {

    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        let settings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: "127.0.0.1")
        settings.ipv4Settings = NEIPv4Settings(addresses: ["192.168.100.1"], subnetMasks: ["255.255.255.0"])
        settings.ipv4Settings?.includedRoutes = [NEIPv4Route.default()]
        settings.dnsSettings = NEDNSSettings(servers: ["1.1.1.1"])

        setTunnelNetworkSettings(settings) { error in
            if let error = error {
                completionHandler(error)
            } else {
                self.startMonitoring()
                completionHandler(nil)
            }
        }
    }

    func startMonitoring() {
        packetFlow.readPackets { [weak self] packets, protocols in
            for packet in packets {
                if let domain = DNSMonitorService.extractDomain(from: packet) {
                    print("Usuário acessou: \(domain)")
                    SessionMonitorService.shared.registrarAcesso(dominio: domain)

                }
            }
            self?.startMonitoring()
        }
    }

    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
