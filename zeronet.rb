class Zeronet < Formula
  desc "ZeroNet"
  homepage "https://github.com/HelloZeroNet/ZeroNet"
  url "https://github.com/HelloZeroNet/ZeroBundle/raw/master/dist/ZeroBundle-mac-osx.zip"
  version "mac"
  sha256 "aab07d27cd8f3fd307a3438a953af3bdfc7de62592c375a9463028ab7c7331e3"

  #"https://try.gogs.io/ZeroNet/ZeroNet;https://github.com/HelloZeroNet/ZeroNet;https://gitlab.com/HelloZeroNet/ZeroNet"
  resource "zeronet" do
    url "https://gitlab.com/HelloZeroNet/ZeroNet/repository/archive.zip?ref=master"
    sha256 "ac02a36bbe2faae0b766c3b96f7f9493e9336bee7124743a866b36b9343e4743"
  end

  def install
    libexec.install "ZeroBundle"

    resource("zeronet").stage do
      (libexec/"ZeroBundle/ZeroNet").install Dir["*"]
    end

    (bin/"zeronet").write <<-EOS.undent
    #!/bin/sh
    cd "#{libexec}/ZeroBundle/ZeroNet"
    exec ../Python/python zeronet.py "$@"
    EOS
  end

  plist_options :startup => true

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/zeronet</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
      </dict>
    </plist>
    EOS
  end

  test do
    true
    #system bin/"zeronet", "--version"
  end
end
