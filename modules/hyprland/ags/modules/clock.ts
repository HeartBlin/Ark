export function Clock() {
  const date = Variable("", {
    poll: [1000, 'date "+%H:%M"'],
  });

  return Widget.Label({
    className: "clock",
    label: date.bind(),
  });
}
