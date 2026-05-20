class Loomcycle < Formula
  desc "Agentic runtime — one Go binary owning the LLM tool-use loop"
  homepage "https://github.com/denn-gubsky/loomcycle"
  version "0.8.20"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/denn-gubsky/loomcycle/releases/download/v#{version}/loomcycle-darwin-arm64.tar.gz"
      sha256 "8e34d684d61f3b92b4d49f6e9b0702e55cd5ebbfc39fd45d2b1133decf2542ac"
    end
    on_intel do
      url "https://github.com/denn-gubsky/loomcycle/releases/download/v#{version}/loomcycle-darwin-amd64.tar.gz"
      sha256 "110e59dc13864ca5bc5d087559a2f9d80ac932cba2005adb8178c2ce3e552bca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/denn-gubsky/loomcycle/releases/download/v#{version}/loomcycle-linux-arm64.tar.gz"
      sha256 "ea28700824c3ab438c6e38a312a85036d83ab7774a7487bb954241df5a7ea6d7"
    end
    on_intel do
      url "https://github.com/denn-gubsky/loomcycle/releases/download/v#{version}/loomcycle-linux-amd64.tar.gz"
      sha256 "5523e340624eba5b50f290984040d620f4194868981f5c3fd1d6c28c28869871"
    end
  end

  def install
    bin.install "loomcycle"
  end

  def caveats
    <<~EOS
      loomcycle ships as a single Go binary that reads configuration from
      a YAML file. Quick start:

        mkdir -p ~/.config/loomcycle
        # Drop your loomcycle.yaml into ~/.config/loomcycle/
        # See https://github.com/denn-gubsky/loomcycle for examples.
        loomcycle --config ~/.config/loomcycle/loomcycle.yaml

      For background-service operation on macOS, see Homebrew's
      `brew services` (a launchd plist isn't bundled because operator
      configuration varies; the upstream README documents the systemd
      unit shape for Linux).
    EOS
  end

  test do
    # --version exits 0 and prints "version=" — the simplest smoke
    # that exercises the embedded VCS stamp + flag parser without
    # needing any config.
    assert_match "version=", shell_output("#{bin}/loomcycle --version")
  end
end
