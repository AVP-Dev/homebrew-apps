cask "nyx-vox" do
  version "1.6.2"
  sha256 "22ccdfbc7316a1a53d888fd2cdb7e9074bf779d6600bd40d55f7015b6fae6511"

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
