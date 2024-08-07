import Gdk from "gi://Gdk";
import Window from "types/widgets/window";

import { Bar } from "./modules/bar";
import {
  RounedBottomRight,
  RounedBottomLeft,
} from "./modules/corners/barRounedCorners";

const scss = `${App.configDir}/styles/main.scss`;
const css = `/tmp/style.css`;
const range = (length: number, x = 0) =>
  Array.from({ length }, (_, i) => i + x);

function allMonitors(x: (i: number) => Window<any, any>): Window<any, any>[] {
  const y = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(y, 0).map(x).flat(1);
}

function allMonitorsAsync(x: (y: number) => Promise<Window<any, any>>) {
  const z = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(z, 0).forEach((z) => x(z).catch(print));
}

const Corners = () => [
  //allMonitors(RounedBottomLeft),
  //allMonitors(RounedBottomRight),
];

App.config({
  windows: Corners().flat(1),
});

function BuildReloadSCSS() {
  Utils.exec(`sassc ${scss} ${css}`);
  App.resetCss();
  App.applyCss(css);
}

Utils.monitorFile(`${App.configDir}/styles`, BuildReloadSCSS);

allMonitorsAsync(Bar);
BuildReloadSCSS();
