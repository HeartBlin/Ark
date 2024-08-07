import { Workspaces } from "./workspaces";
import { RoundedCorner } from "./roundedCorner";
import { Clock } from "./clock";
import { Inhibitor } from "./inhibitor";
import { PowerProfiles } from "./powerProfiles";

function Left() {
  return Widget.Box({
    className: "bar-left",
    hpack: "start",
    children: [],
  });
}

function Center(monitor: number) {
  return Widget.Box({
    className: "bar-center",
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
    children: [
      PowerProfiles(),
      Inhibitor(),
    ],
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
        children: [ ToolBar(), Clock()],
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
