<h1 align="center"> 🏰 Ark 🏯 </h1>

<h5 align="center"> 🚧 Under Construction! 🚧 </h5>

## Live Media
There is a nixosSystem in thsi flake, named Specter, that functions as a ISO.

Use ```nix build .#nixosConfigurations.Specter.config.system.build.isoImage```, this is going to give a result folder as an output. Inside it is the ISO.

I usually test it with 2 USB Sticks (of different qualities) so it should work.

## License

All code, with exceptions (usually in the file as comments), follow the [MIT](LICENSE) license.

The licence specifies that there must exitst a copyright notice. Just a link to this repo is required.