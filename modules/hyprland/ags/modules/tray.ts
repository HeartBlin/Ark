const systemTray = await Service.import("systemtray");

export function Tray() {
  function TrayItem(item: import("types/service/systemtray").TrayItem) {
    return Widget.Button({
      className: 'trayButton',
      child: Widget.Icon({ className: "trayIcon" }).bind("icon", item, "icon"),
      tooltip_markup: item.bind("tooltip_markup"),
      onPrimaryClick: (_, event) => item.activate(event),
      onSecondaryClick: (_, event) => item.openMenu(event),
    });
  }

  return Widget.Box({
    className: "trayBox",
    children: systemTray.bind("items").as((i) => i.map(TrayItem)),
  });
}
