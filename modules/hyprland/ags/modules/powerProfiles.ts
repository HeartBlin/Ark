const powerProfiles = await Service.import("powerprofiles");

export function PowerProfiles() {
  function correctLabel(x: any) {
    switch (x) {
      case "power-saver":
        return "Quiet";
      case "balanced":
        return "Balanced";
      case "performance":
        return "Performance";
      default:
        return "Cannot find power-profiles-daemon";
    }
  }

  function correctLabelClass(x: any) {
    switch (x) {
      case "power-saver":
        return "powerQuietLabel";
      case "balanced":
        return "powerBalancedLabel";
      case "performance":
        return "powerPerformanceLabel";
      default:
        return "unknown";
    }
  }

  function correctClass(x: any) {
    switch (x) {
      case "power-saver":
        return "powerQuietButton";
      case "balanced":
        return "powerBalancedButton";
      case "performance":
        return "powerPerformanceButton";
      default:
        return "unknown";
    }
  }

  return Widget.Button({
    child: Widget.Label({}),

    on_clicked: () => {
      switch (powerProfiles.active_profile) {
        case "power-saver":
          powerProfiles.active_profile = "balanced";
          break;
        case "balanced":
          powerProfiles.active_profile = "performance";
          break;
        case "performance":
          powerProfiles.active_profile = "power-saver";
          break;
        default:
          console.error(powerProfiles.active_profile);
          break;
      }
    },

    setup: (self) => {
      self.hook(powerProfiles, () => {
        self.child.label = correctLabel(powerProfiles.active_profile);
        self.child.class_name = correctLabelClass(powerProfiles.active_profile);
        self.class_name = correctClass(powerProfiles.active_profile);
      });
    },
  });
}
