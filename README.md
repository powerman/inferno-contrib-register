# Description

This command will try to keep service named 'addr' with given attributes
('attr' and 'val' pairs) registered in default registry(4) (which should
be available at `/mnt/registry`). When registry is not available retry
attempt to (re-)register service every 1 second.


# Install

Make directory with this app available in /opt/powerman/register/.

Install system-wide:

```
# git clone https://github.com/powerman/inferno-contrib-register.git $INFERNO_ROOT/opt/powerman/register
```

or in your home directory:

```
$ git clone https://github.com/powerman/inferno-contrib-register.git $INFERNO_USER_HOME/opt/powerman/register
$ emu
; bind opt /opt
```

or locally for your project:

```
$ git clone https://github.com/powerman/inferno-contrib-register.git $YOUR_PROJECT_DIR/opt/powerman/register
$ emu
; cd $YOUR_PROJECT_DIR_INSIDE_EMU
; bind opt /opt
```

If you want to run commands and read man pages without entering full path
to them (like `/opt/VENDOR/APP/dis/cmd/NAME`) you should also install and
use https://github.com/powerman/inferno-opt-setup 

## Dependencies

* https://github.com/powerman/inferno-contrib-logger


# Usage

```
; register [-v] [[-a attr val] …] addr &
```

