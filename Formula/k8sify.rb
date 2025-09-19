class K8sify < Formula
  desc "Intelligent Docker Compose to Kubernetes migration tool with cost analysis, security scanning, and production patterns"
  homepage "https://github.com/sreniatnoc/k8sify"
  license "MIT"
  head "https://github.com/sreniatnoc/k8sify.git", branch: "main"

  # This will be updated automatically by CI when we create releases
  url "https://github.com/sreniatnoc/k8sify/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2f34ace40a58747f01ac671521c6f9701e719c4215b6315d8bebaab872541a80"
  version "0.1.0"

  def install
    # Download and install the pre-built binary for the current platform
    if OS.mac?
      if Hardware::CPU.arm?
        # Apple Silicon (M1/M2/M3)
        binary_url = "https://github.com/sreniatnoc/k8sify/releases/download/v0.1.0/k8sify-macos-amd64-binary"
        binary_name = "k8sify-macos-amd64-binary"
      else
        # Intel Mac
        binary_url = "https://github.com/sreniatnoc/k8sify/releases/download/v0.1.0/k8sify-macos-amd64-binary"
        binary_name = "k8sify-macos-amd64-binary"
      end
    elsif OS.linux?
      binary_url = "https://github.com/sreniatnoc/k8sify/releases/download/v0.1.0/k8sify-linux-amd64-binary"
      binary_name = "k8sify-linux-amd64-binary"
    else
      odie "Unsupported platform"
    end

    system "curl", "-L", binary_url, "-o", binary_name
    chmod 0755, binary_name
    bin.install binary_name => "k8sify"

    # Install shell completions (if supported)
    # generate_completions_from_executable(bin/"k8sify", "--generate", base: "k8sify")

    # Install man page if available
    if (buildpath/"docs/k8sify.1").exist?
      man1.install "docs/k8sify.1"
    end
  end

  test do
    # Test that the binary was installed and runs
    assert_match "k8sify", shell_output("#{bin}/k8sify --version")

    # Test basic functionality with a simple docker-compose file
    (testpath/"docker-compose.yml").write <<~EOS
      version: '3.8'
      services:
        web:
          image: nginx:latest
          ports:
            - "80:80"
    EOS

    # Test analyze command
    output = shell_output("#{bin}/k8sify analyze -i docker-compose.yml -f json")
    assert_match "services", output
    assert_match "nginx", output
  end
end