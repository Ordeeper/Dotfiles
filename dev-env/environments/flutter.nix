{ pkgs }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    toolsVersion = "26.1.1";
    buildToolsVersions = [ "34.0.0" ];
    platformVersions = [ "34" "36" ];
    ndkVersions = [ "27.0.12077973" ];
    abiVersions = [ "x86_64" ];
    cmakeVersions = [ "3.22.1" ];

    includeNDK = true;
    includeEmulator = false;
    includeSystemImages = false;
    includeSources = false;

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
in
pkgs.mkShell {
  packages = with pkgs; [
    flutter
    androidSdk
    jdk17
  ];

  shellHook = ''
    export ANDROID_SDK_ROOT="${androidSdk}/libexec/android-sdk"
    export ANDROID_HOME="$ANDROID_SDK_ROOT"
    export JAVA_HOME="${pkgs.jdk17}/lib/openjdk"
    export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=$ANDROID_SDK_ROOT/build-tools/34.0.0/aapt2"
    export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
    export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH"
    export PATH="$HOME/.pub-cache/bin:$PATH"
    export CHROME_EXECUTABLE="${pkgs.chromium}/bin/chromium"

    cat > android/local.properties <<EOF
      flutter.sdk=${pkgs.flutter}/share/flutter
      sdk.dir=$ANDROID_SDK_ROOT
      ndk.dir=$ANDROID_SDK_ROOT/ndk/27.0.12077973
      flutter.buildMode=release
      flutter.versionName=1.0.0
      flutter.versionCode=1
    EOF
  '';
}
