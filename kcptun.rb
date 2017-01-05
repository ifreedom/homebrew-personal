class Kcptun < Formula
  desc "kcptun"
  homepage "https://github.com/xtaci/kcptun"
  url "https://github.com/xtaci/kcptun/releases/download/v20161118/kcptun-darwin-amd64-20161118.tar.gz"
  version "20161118"
  sha256 "3719bd99c4d8a1ce45890e9141414650c8d5bb7e90fdc2c997c6c298c9441ec2"

  def install
    mv "client_darwin_amd64", "kcptun_client"
    bin.install "kcptun_client"

    (buildpath/"kcptun_client.json").write <<-EOS.undent
{
    "localaddr": ":12948",
    "remoteaddr": "vps:29900",
    "key": "ahufr6qedR",
    "crypt": "salsa20",
    "mode": "fast2",
    "conn": 1,
    "autoexpire": 60,
    "mtu": 1350,
    "sndwnd": 128,
    "rcvwnd": 1024,
    "datashard": 70,
    "parityshard": 30,
    "dscp": 46,
    "nocomp": false,
    "acknodelay": false,
    "nodelay": 0,
    "interval": 40,
    "resend": 0,
    "nc": 0,
    "sockbuf": 4194304,
    "keepalive": 10
}
    EOS

    etc.install "kcptun_client.json"
  end

  plist_options :manual => "#{HOMEBREW_PREFIX}/opt/kcptun/bin/kcptun_client -c #{HOMEBREW_PREFIX}/etc/kcptun_client.json"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/kcptun_client</string>
          <string>-c</string>
          <string>#{etc}/kcptun_client.json</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <dict>
          <key>Crashed</key>
          <true/>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>ProcessType</key>
        <string>Background</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/kcptun.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/kcptun.log</string>
      </dict>
    </plist>
    EOS
  end

  test do
    assert_match "kcptun version", shell_output("#{bin}/kcptun_client -v")
  end
end
