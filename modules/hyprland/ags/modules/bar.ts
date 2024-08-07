import { Workspaces } from "./workspaces";
import { RoundedCorner } from "./roundedCorner";
import { Clock } from "./clock";
import { Inhibitor } from "./inhibitor";
import { PowerProfiles } from "./powerProfiles";
import { Tray } from "./tray";

function LeftContainer() {
  return Widget.Box({
    className: "leftContainer",
    children: [Tray()],
  });
}

function Left() {
  return Widget.Box({
    className: "barLeft",
    hpack: "start",
    children: [
      LeftContainer(),
      RoundedCorner("bottom_left", { className: "corner" }),
    ],
  });
}

function Center(monitor: number) {
  return Widget.Box({
    className: "barCenter",
    hpack: "center",
    children: [
      RoundedCorner("bottom_right", { className: "corner" }),
      Workspaces(monitor),
      RoundedCorner("bottom_left", { className: "corner" }),
    ],
  });
}

function ToolBar() {
  return Widget.Box({
    className: "toolbar",
    children: [PowerProfiles(), Inhibitor()],
  });
}

function Right() {
  return Widget.Box({
    className: "barRightContainer",
    hpack: "end",
    children: [
      RoundedCorner("bottom_right", { className: "barRightCorner" }),
      Widget.Box({
        className: "barRight",
        children: [ToolBar(), Clock()],
      }),
    ],
  });
}

export const Bar = async (monitor = 0) => {
  return Widget.Window({
    monitor,
    name: `agsbar-${monitor}`,
    className: "bar",
    anchor: ["bottom", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(monitor),
      end_widget: Right(),
    }),
  });
};
