{ pkgs }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    toolsVersion = "26.1.1";
    buildToolsVersions = [ "34.0.0" "35.0.0" ];
    platformVersions = [ "34" "35" "36" ];
    ndkVersions = [ "28.2.13676358" ];
    abiVersions = [ "x86_64" ];
    cmakeVersions = [ "3.22.1" ];

    includeNDK = true;
    extraLicenses = [
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "android-sdk-license"
      "android-sdk-preview-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
  };

  androidSdk = androidComposition.androidsdk;

  patchedFlutter = pkgs.runCommand "flutter-patched" {
    nativeBuildInputs = [ pkgs.lndir ]; # Use 'lndir' se o seu nixpkgs for recente
  } ''
    mkdir -p $out
    lndir -silent ${pkgs.flutter} $out

    rm -rf $out/bin/cache/artifacts/engine/linux-x64/font-subset
    cp ${pkgs.flutter}/bin/cache/artifacts/engine/linux-x64/font-subset $out/bin/cache/artifacts/engine/linux-x64/font-subset

    rm -rf $out/bin/flutter
    cp ${pkgs.flutter}/bin/flutter $out/bin/flutter

    rm -f $out/bin/cache/engine.realm
    echo -n "" > $out/bin/cache/engine.realm
    mkdir -p $out/share/flutter/bin/cache
    echo -n "" > $out/share/flutter/bin/cache/engine.realm

    chmod +x $out/bin/flutter
    chmod +x $out/bin/cache/artifacts/engine/linux-x64/font-subset
  '';

in
pkgs.mkShell {
  packages = with pkgs; [
    patchedFlutter
    androidSdk
    jdk17
  ];

  shellHook = ''
    export FLUTTER_ROOT="${patchedFlutter}"
    export PATH="${patchedFlutter}/bin:$PATH"
    export ANDROID_SDK_ROOT="${androidSdk}/libexec/android-sdk"
    export ANDROID_HOME="$ANDROID_SDK_ROOT"
    export JAVA_HOME="${pkgs.jdk17}/lib/openjdk"

    # Truque para a NDK: Linkamos as duas versões para a pasta que o Nix tem
    mkdir -p .ndk_path/ndk
    ln -sfn ${androidSdk}/libexec/android-sdk/ndk-bundle .ndk_path/ndk/28.2.13676358
    ln -sfn ${androidSdk}/libexec/android-sdk/ndk-bundle .ndk_path/ndk/27.0.12077973

    export GRADLE_OPTS="-Dorg.gradle.project.android.ndkpath=$(pwd)/.ndk_path/ndk -Dorg.gradle.project.android.aapt2FromMavenOverride=$ANDROID_SDK_ROOT/build-tools/34.0.0/aapt2"

    export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"

    cat > android/local.properties <<EOF
        flutter.sdk=${patchedFlutter}
        sdk.dir=$ANDROID_SDK_ROOT
        flutter.buildMode=release
    EOF
  '';
}
