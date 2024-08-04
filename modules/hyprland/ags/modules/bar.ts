import { Workspaces } from "./workspaces";

function Time() {
  const time = Variable("", {
    poll: [
      1000,
      function () {
        return Date().toString();
      },
    ],
  });

  return Widget.Label({
    hpack: "center",
    className: "time",
    label: time.bind(),
  });
}

function Left() {
  return Widget.Box({
    className: "bar-left",
    hpack: "start",
    children: [Workspaces],
  });
}

function Center() {
  return Widget.Box({
    className: "bar-center",
    hpack: "center",
    children: [Time()],
  });
}

function Right() {
  return Widget.Box({
    className: "bar-right",
    hpack: "end",
    children: [Time()],
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
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
};
