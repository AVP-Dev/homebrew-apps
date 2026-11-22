cask "nyx-vox" do
  version "1.6.0"
  sha256 "c474277d66ba9e3e0fa7c5cf69a411f6e74c3f6a515297561caee98fb952fa28"

  url "https://github.com/AVP-Dev/nyx-vox/releases/download/v#{version}/NYX.Vox_#{version}_aarch64.dmg"
  name "NYX Vox"
  desc "AI-assisted voice dictation"
  homepage "https://nyx-vox.avpdev.com"

  depends_on arch: :arm64

  app "NYX Vox.app"

  postflight do
    bundle = appdir/"NYX Vox.app"
    attributes = system_command "/usr/bin/xattr", args: [bundle]
    if attributes.stdout.lines.map(&:strip).include?("com.apple.quarantine")
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", bundle]
    end
    system_command "/usr/bin/open", args: ["-a", bundle]
  end
end
