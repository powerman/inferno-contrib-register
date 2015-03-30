This command will try to keep service named 'addr' with given attributes ('attr' and 'val' pairs) registered in default registry(4) (which should be available at `/mnt/registry`). When registry is not available retry attempt to (re-)register service every 1 second.


Dependencies:
  * http://code.google.com/p/inferno-contrib-logger/


---


To install make directory with this app available in /opt/powerman/register/, for ex.:

```
# hg clone https://inferno-contrib-register.googlecode.com/hg/ $INFERNO_ROOT/opt/powerman/register
```

or in user home directory:

```
$ hg clone https://inferno-contrib-register.googlecode.com/hg/ $INFERNO_USER_HOME/opt/powerman/register
$ emu
; bind opt /opt
```


---


Usage:

```
; register [-v] [[-a attr val] …] addr &
```