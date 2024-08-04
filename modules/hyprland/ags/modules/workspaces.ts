const hyprland = await Service.import("hyprland");

const dispatch = (arg: number) => {
  Utils.execAsync(`hyprctl dispatch workspace ${arg}`);
};

export const Workspaces = Widget.Box({
  className: "workspaceBox",
  children: Array.from({ length: 10 }, (_, i) => i + 1).map((i) =>
    Widget.Button({
      cursor: "pointer",
      onPrimaryClick: () => dispatch(i),
      attribute: i,
      child: Widget.Label({ label: `${i}` }),

      setup: (self) =>
        self.hook(hyprland, () => {
          self.toggleClassName("active", hyprland.active.workspace.id === i);
          self.toggleClassName(
            "occupied",
            (hyprland.getWorkspace(i)?.windows || 0) > 0 &&
              !(hyprland.active.workspace.id === i)
          );
          self.toggleClassName(
            "empty",
            (hyprland.active.workspace.id != i) &&
            !(hyprland.getWorkspace(i)?.windows || 0) > 0
          )
        }),
    })
  ),
});
