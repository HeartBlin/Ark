const hyprland = await Service.import("hyprland");

const dispatch = (arg: number) => {
  Utils.execAsync(`hyprctl dispatch workspace ${arg}`);
};

export function Workspaces(monitor: number) {
  const Symbols = {
    "activeLabel": "",
    "occupiedLabel": "",
    "emptyLabel": "",
  };

  function correctLabel(i: number) {
    var type = "";

    if (hyprland.active.workspace.id === i) {
      type = "activeLabel";
    } else if (
      (hyprland.getWorkspace(i)?.windows || 0) > 0 &&
      !(hyprland.active.workspace.id === i)
    ) {
      type = "occupiedLabel";
    } else type = "emptyLabel";

    return type;
  };

  const WorkspaceComponent = Widget.Box({
    className: "workspaceBox",
    children: Array.from({ length: 10 }, (_, i) => i + 1).map((i) =>
      Widget.Button({
        cursor: "pointer",
        onPrimaryClick: () => dispatch(i),
        attribute: i,
        className: "workspaceButtons",
        child: Widget.Label({}),

        setup: (self) =>
          self.hook(hyprland, () => {
            self.child.label = Symbols[correctLabel(i)],
            self.child.class_name = correctLabel(i),
            self.toggleClassName("activeButton", hyprland.active.workspace.id === i);
            self.toggleClassName(
              "occupiedButton",
              (hyprland.getWorkspace(i)?.windows || 0) > 0 &&
                !(hyprland.active.workspace.id === i)
            );
            self.toggleClassName(
              "emptyButton",
              hyprland.active.workspace.id != i &&
                !(hyprland.getWorkspace(i)?.windows || 0)
            );
          }),
      })
    ),

    setup: (self) =>
      self.hook(hyprland, () =>
        self.children.forEach((btn) => {
          if (!monitor) btn.visible = btn.attribute <= 5;
          else btn.visible = btn.attribute > 5;
        })
      ),
  });

  return Widget.Box({
    className: "workspaceContainer",
    child: WorkspaceComponent,
  });
}
