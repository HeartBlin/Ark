import Cairo from "gi://cairo?version=1.0";
import { RoundedCorner } from "./roundedCorner";

const region = new Cairo.Region();
const click = (self) => self.input_shape_combine_region(region);

export const RounedBottomRight = (monitor: number = 0) =>
  Widget.Window({
    monitor,
    name: `rbr-${monitor}`,
    className: "transparent",
    layer: "top",
    anchor: ["bottom", "right"],
    exclusivity: "normal",
    visible: true,
    child: RoundedCorner("bottom_right", { className: "corner" }),
    setup: click,
  });

export const RounedBottomLeft = (monitor: number = 0) =>
  Widget.Window({
    monitor,
    name: `rbl-${monitor}`,
    className: "transparent",
    layer: "top",
    anchor: ["bottom", "left"],
    exclusivity: "normal",
    visible: true,
    child: RoundedCorner("bottom_left", { className: "corner" }),
    setup: click,
  });
