class Idzip < Formula
  desc "The idzip file format allows seeking in gzip files, for compress and decompress dictzip file."
  homepage "https://github.com/fidlej/idzip"
  head "https://github.com/fidlej/idzip.git"

  def install
    libexec.install Dir["*"]
    (bin/"idzip").write <<EOF
#!/bin/sh
export PYTHONPATH="#{libexec}"
exec python -m idzip.command "$@"
EOF
  end

  test do
    system bin/"idzip", "--help"
  end
end
