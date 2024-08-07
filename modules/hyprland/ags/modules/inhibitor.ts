export function Inhibitor() {
  var status: number;
  const classNames = {
    0: "inhibitorOff",
    1: "inhibitorOn",
  };
  const labels = {
    0: "",
    1: "",
  };
  switch (Utils.exec("systemctl --user is-active hypridle.service")) {
    case "active":
      status = 0;
      break;

    default:
      status = 1;
      break;
  }

  return Widget.Button({
    child: Widget.Label(labels[status]),
    className: classNames[status],
    attribute: status,
    onClicked: (self) => {
      if (!self.attribute) {
        self.attribute = 1;
        self.class_name = "inhibitorOn";
        self.child.label = "";
        Utils.execAsync("systemctl --user stop hypridle.service ");
      } else {
        self.attribute = 0;
        self.class_name = "inhibitorOff";
        self.child.label = "";
        Utils.execAsync("systemctl --user start hypridle.service");
      }
    },
  });
}
