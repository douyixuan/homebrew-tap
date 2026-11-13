# Verified source: 1d515e4c2909fbe57269d48317ef197f6cc69c1d; CI run: 43407900900
class Istk < Formula
  desc "Command-line access to iStickies2 note profiles"
  homepage "https://github.com/douyixuan/stickies"
  url "https://github.com/douyixuan/stickies/releases/download/cli-v1.0.1/istk-1.0.1-macos-arm64.zip"
  version "1.0.1"
  sha256 "bbc869794d82786a6723bc9a6b2b9517069063bea1b180725fe20ce90b067bbf"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    bin.install "istk"
    pkgshare.install "manifest.json", "USAGE.txt"
  end

  def caveats
    <<~EOS
      Every data command requires --dir. Use a separate trial profile first.
      App-held profile locks allow reads and reject writes.
      First writes upgrade older profiles; back up the whole closed profile first.
      Rolling back the binary alone does not roll back the data format.
    EOS
  end

  test do
    profile = testpath/"isolated profile"
    system bin/"istk", "--dir", profile, "add", "Homebrew synthetic note"
    assert_match "Homebrew synthetic note", shell_output("#{bin}/istk --dir '#{profile}' list")
    assert_match "Homebrew synthetic note", shell_output("#{bin}/istk --dir '#{profile}' search synthetic")
  end
end
