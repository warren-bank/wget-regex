### [wget-regex](https://github.com/warren-bank/wget-regex/tree/dev-git)

#### Branch:

* adds all of the tooling necessary to:
  * optionally:
    * pull in `wget` source code at a specific git tag
    * generate a patch file containing any changes made to the `wget` source code
  * install and configure an entire `mingw` compiler toolchain in `MSYS2`
  * compile `wget` w/ patches for Windows (32-bit or 64-bit)
  * run tests

#### Source Code:

* [wget project home](https://savannah.gnu.org/git/?group=wget)
* [official git repo](https://git.savannah.gnu.org/git/wget.git)

#### Toolchain:

* [MSYS2](https://sourceforge.net/projects/msys2)

#### Scripts:

* [`4-scripts/1-src/1-git-pull-wget.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/1-src/1-git-pull-wget.sh)
  * __optional__
  * configs:
    * `git_version='1.20.1'`
      * semversion must correspond to a git tag:
        * git_tag="v${git_version}"
  * purpose:
    * creates a new branch:
      * git_dev_branch="dev-git-tag-${git_version}"
    * pulls a snapshot of `wget` at the configured tag to path:
      * `1-src/wget`
    * adds a tag:
      * git_tag="v${git_version}"
* [`4-scripts/2-msys2-mingw-package/1-prepare-package/1-download.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/1-prepare-package/1-download.sh)
  * __do not run__
  * configs:
    * N/A
  * purpose:
    * pulls a snapshot of the MSYS2 package [`mingw-w64-wget`](https://github.com/Alexpux/MINGW-packages/tree/master/mingw-w64-wget) to path:
      * `2-msys2-mingw-package/mingw-w64-wget`
  * notes:
    * the branch already contains these files
    * the file [`2-msys2-mingw-package/mingw-w64-wget/PKGBUILD`](https://github.com/warren-bank/wget-regex/blob/dev-git/2-msys2-mingw-package/mingw-w64-wget/PKGBUILD):
      * has been modified to apply an additional patch file that optionally contains any changes made to the `wget` source code:
        * `2-msys2-mingw-package/mingw-w64-wget/git-diff.patch`
      * current configs:
        * `pkgver=1.20.1`
        * `'0f63e84dd23dc53ab3ab6f483c3afff8301e54c165783f772101cdd9b1c64928'`
          * SHA-256 hash of file:
            * [`wget-1.20.1.tar.lz`](https://ftp.gnu.org/gnu/wget/wget-1.20.1.tar.lz)
* [`4-scripts/2-msys2-mingw-package/1-prepare-package/2-generate-patch.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/1-prepare-package/2-generate-patch.sh)
  * __optional__
  * configs:
    * `git_version='1.20.1'`
      * semversion must correspond to a git tag:
        * git_tag="v${git_version}"
  * purpose:
    * generates patch file:
      * `2-msys2-mingw-package/mingw-w64-wget/git-diff.patch`
* [`4-scripts/2-msys2-mingw-package/2-msys2-environment/1-msys2-clean-install.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/2-msys2-environment/1-msys2-clean-install.sh)
  * __run once, if needed__
  * configs:
    * N/A
  * purpose:
    * downloads [`MSYS2` x64](https://sourceforge.net/projects/msys2/files/Base/x86_64/msys2-base-x86_64-20180531.tar.xz/download) to:
      * `C:\PortableApps\msys2-base-x86_64-20180531.tar.xz`
    * decompresses archive to:
      * `C:\PortableApps\msys64`
    * deletes archive
* [`4-scripts/2-msys2-mingw-package/2-msys2-environment/2-msys2-run-here.bat`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/2-msys2-environment/2-msys2-run-here.bat)
  * purpose:
    * opens `MSYS2` bash shell
      * working directory = `4-scripts/2-msys2-mingw-package/2-msys2-environment`
* [`4-scripts/2-msys2-mingw-package/2-msys2-environment/3-msys2-update.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/2-msys2-environment/3-msys2-update.sh)
  * __run in `MSYS2` bash shell__
    * run repeatedly, until `pacman` reports that: `there is nothing to do`
    * may require restarting the `MSYS2` bash shell
  * purpose:
    * updates all installed packages
* [`4-scripts/2-msys2-mingw-package/2-msys2-environment/4-msys2-install-deps-x64.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/2-msys2-environment/4-msys2-install-deps-x64.sh)
  * __run in `MSYS2` bash shell__
  * purpose:
    * installs the `mingw` toolchain to compile for Windows x64
* [`4-scripts/2-msys2-mingw-package/2-msys2-environment/5-msys2-install-deps-x32.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/2-msys2-environment/5-msys2-install-deps-x32.sh)
  * __run in `MSYS2` bash shell__
  * purpose:
    * installs the `mingw` toolchain to compile for Windows x32
* [`4-scripts/2-msys2-mingw-package/2-msys2-environment/6-msys2-install-gpg-pubkey-wget.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/2-msys2-environment/6-msys2-install-gpg-pubkey-wget.sh)
  * __run in `MSYS2` bash shell__
  * purpose:
    * installs the GPG public key associated with the `wget` tarball signature
  * interactive commands required:
    ```bash
      gpg> trust
        Your decision? 5
        Do you really want to set this key to ultimate trust? (y/N) y
      gpg> quit
    ```
* [`4-scripts/2-msys2-mingw-package/2-msys2-environment/7-msys2-run-where-build.bat`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/2-msys2-environment/7-msys2-run-where-build.bat)
  * purpose:
    * opens `MSYS2` bash shell
      * working directory = `4-scripts/2-msys2-mingw-package/3-msys2-build`
* [`4-scripts/2-msys2-mingw-package/3-msys2-build/1-msys2-clean.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/3-msys2-build/1-msys2-clean.sh)
  * purpose:
    * deletes the files produced when the `MSYS2` package is built
* [`4-scripts/2-msys2-mingw-package/3-msys2-build/2-msys2-build-x64.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/3-msys2-build/2-msys2-build-x64.sh)
  * __run in `MSYS2` bash shell__
  * purpose:
    * uses the `mingw` toolchain to compile `wget` for Windows x64
  * output:
    * `MSYS2` package
      * `2-msys2-mingw-package/mingw-w64-wget/mingw-w64-*-wget-*-any.pkg.tar.xz`
    * `wget` executable
      * `5-bin/x64/wget.exe`
      * `5-bin/x64/*.dll`
* [`4-scripts/2-msys2-mingw-package/3-msys2-build/3-msys2-build-x32.sh`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/2-msys2-mingw-package/3-msys2-build/3-msys2-build-x32.sh)
  * __run in `MSYS2` bash shell__
  * purpose:
    * uses the `mingw` toolchain to compile `wget` for Windows x32
  * output:
    * `MSYS2` package
      * `2-msys2-mingw-package/mingw-w64-wget/mingw-w64-*-wget-*-any.pkg.tar.xz`
    * `wget` executable
      * `5-bin/x32/wget.exe`
      * `5-bin/x32/*.dll`
* [`4-scripts/3-test/1-test-generic-arch.bat`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/3-test/1-test-generic-arch.bat)
  * __do not run__
* [`4-scripts/3-test/2-test-x64.bat`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/3-test/2-test-x64.bat)
  * purpose:
    * runs tests in x64 `wget` executable
  * dependencies:
    * assumes that [`devd` web server](https://github.com/cortesi/devd/releases/download/v0.8/devd-0.8-windows64.zip) can be found at:
      * `C:\PortableApps\devd\devd.exe`
* [`4-scripts/3-test/3-test-x32.bat`](https://github.com/warren-bank/wget-regex/blob/dev-git/4-scripts/3-test/3-test-x32.bat)
  * purpose:
    * runs tests in x32 `wget` executable
  * dependencies:
    * assumes that [`devd` web server](https://github.com/cortesi/devd/releases/download/v0.8/devd-0.8-windows64.zip) can be found at:
      * `C:\PortableApps\devd\devd.exe`

#### Legal:

* copyright: [Warren Bank](https://github.com/warren-bank)
* license: [GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
