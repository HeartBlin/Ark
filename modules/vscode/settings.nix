{ pkgs, ... }:

{
  programs.vscode.userSettings = {
    # Editor
    "editor.bracketPairColorization.enabled" = true;
    "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    "editor.cursorBlinking" = "smooth";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.fontLigatures" = true;
    "editor.guides.bracketPairs" = true;
    "editor.guides.indentation" = true;
    "editor.inlineSuggest.enabled" = true;
    "editor.linkedEditing" = true;
    "editor.lineHeight" = 22;
    "editor.minimap.enabled" = false;
    "editor.renderLineHighlight" = "all";
    "editor.semanticHighlighting.enabled" = true;
    "editor.showUnused" = true;
    "editor.smoothScrolling" = true;
    "editor.tabCompletion" = "on";
    "editor.tabSize" = 2;
    "editor.trimAutoWhitespace" = true;

    # Explorer
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;

    # Files
    "files.insertFinalNewline" = false;
    "files.trimTrailingWhitespace" = true;
    "files.exclude" = { "tsconfig.json" = true; };

    # Javascript/Typescript
    "[javascript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
    "[typescript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };

    # Nix
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";
    "nix.serverSettings"."nixd"."formatting"."command" = [ "nixfmt" ];

    # Telemetry
    "redhat.telemetry.enabled" = false;
    "telemetry.telemetryLevel" = "off";

    # Terminal
    "terminal.integrated.smoothScrolling" = true;

    # Window
    "window.autoDetectColorScheme" = true;
    "window.dialogStyle" = "custom";
    "window.menuBarVisibility" = "toggle";
    "window.titleBarStyle" = "custom";

    # Workbench
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.preferredDarkColorTheme" = "Default Dark+";
    "workbench.preferredLightColorTheme" = "Default Dark+";
    "workbench.sideBar.location" = "left";
  };

  home.packages = [ pkgs.nixd pkgs.nixfmt-classic ];
}
