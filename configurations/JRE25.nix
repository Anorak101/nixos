{pkgs,...}:
{
  environment.systemPackages = [
    pkgs.javaPackages.compiler.temurin-bin.jre-25
  ];

}
