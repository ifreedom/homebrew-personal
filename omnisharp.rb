class Omnisharp < Formula
  desc "Cross platform .NET development in the editor of your choice"
  homepage "http://www.omnisharp.net/"
  url "https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.6.7.9/omnisharp.tar.gz"
  version "1.6.7.9"
  sha256 "8d50f84134ae96be6cf79a6694508118e87e68346b51b99dde51a34fd56d8d7f"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/omnisharp"
  end
end
