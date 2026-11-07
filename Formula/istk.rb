# Verified source: 2b473c2fe2a898a661519efa2462a2fd9c7217f6; CI run: 42389530538
class Istk < Formula
  desc "Command-line access to iStickies2 note profiles"
  homepage "https://github.com/douyixuan/stickies"
  url "https://github.com/douyixuan/stickies/releases/download/cli-v1.0.0/istk-1.0.0-macos-arm64.zip"
  version "1.0.0"
  sha256 "fe6e37f7719b154552078ee1227fc9b1979ae32bd51b0544851268377e4fcbf2"

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
