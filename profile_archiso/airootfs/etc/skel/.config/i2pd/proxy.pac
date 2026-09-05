function FindProxyForURL(url, host) {
    if (shExpMatch(host, "*.i2p")) {
        return "PROXY 127.0.0.1:4444";
    }
    return "DIRECT";
}
