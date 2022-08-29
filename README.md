[![MELPA](https://melpa.org/packages/mos-mode-badge.svg)](https://melpa.org/#/mos-mode)
# mos-mode - Emacs mode for working with MOS 6502
Emacs support for [mos](https://github.com/datatrash/mos) using lsp-mode and dap-mode (as well as some utility functions).


Created as a separate project to have both all config related to it in one place. 


## Dependencies
You should have the follow programs installed:
- [mos](https://github.com/datatrash/mos)
- [Vice](https://vice-emu.sourceforge.io/) (needed if you want to debug your Commodore machine programs)


## Usage
If mos is in your path, you should be able to use this package right out of the box. If not, you need to configure `mos-executable-path` to point to the location of the mos executable. 

If you want to debug Commodore programs using VICE, you also need to configure `mos-vice-executable-path` if x64sc is not in your path (you can also use x64). 


To use the extension, you simply activate `mos-mode` in an assembly language buffer. Works like any other Emacs extension using lsp-mode and dap-mode (`dap-breakpoint-toggle` to toggle breakpoints etc.). So far only code lenses are used to run/debug the programs, but utility functions for doing it without those will also be available shortly. 


Interactive functions available:
- `mos-build`: Build the program (based on mos.toml settings)
- `mos-run-all-tests`: Run all the unit tests in the project (depends on presense of mos.toml)
- `mos-run-program` / `mos-debug-program`: Run or debug the program.
