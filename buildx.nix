{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "docker-buildx";
  version = "0.13.1-lint";

  src = fetchFromGitHub {
    owner = "slimslenderslacks";
    repo = "buildx";
    rev = "master";
    hash = "sha256-PT79klQhKRr7DG23xPbuZI0yTWUYtZaG/P4etVe33zw=";
  };

  doCheck = false;

  vendorHash = null;

  ldflags = [
    "-w" "-s"
    "-X github.com/docker/buildx/version.Package=github.com/docker/buildx"
    "-X github.com/docker/buildx/version.Version=v${version}"
  ];

  installPhase = ''
    runHook preInstall
    install -D $GOPATH/bin/buildx $out/libexec/docker/cli-plugins/docker-buildx

    mkdir -p $out/bin
    ln -s $out/libexec/docker/cli-plugins/docker-buildx $out/bin/docker-buildx
    runHook postInstall
  '';

  meta = with lib; {
    description = "Docker CLI plugin for extended build capabilities with BuildKit";
    mainProgram = "docker-buildx";
    homepage = "https://github.com/slimslenderslacks/buildx";
    license = licenses.asl20;
    maintainers = with maintainers; [ slimslenderslacks ];
  };
}

