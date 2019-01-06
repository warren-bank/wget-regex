### [wget-regex](https://github.com/warren-bank/wget-regex)

Fork of _wget 1.11.4_ that adds the ability to set regex filters to conditionally include or exclude files when downloading a website recursively

#### Background:

* I wrote this fork over a decade ago
  * at the time, patch files were sent to the project maintainer
  * he had no interest in adding new CLI options
* recently found the code
  * thought it would be fun to revisit the idea..

#### New CLI Options:

* `--regex_AD`
  * regex variation of: `--domains`
  * accepts a list of strings
  * each string is compiled to a regular expression
  * each regular expression is tested against the prospective __domain__ value
    * the value is __accepted__ if any match occurs
  * naming convention: __AD__ means _accept domain_

* `--regex_RD`
  * regex variation of: `--exclude-domains`
  * accepts a list of strings
  * each string is compiled to a regular expression
  * each regular expression is tested against the prospective __domain__ value
    * the value is __rejected__ if any match occurs
  * naming convention: __RD__ means _reject domain_

* `--regex_AP`
  * regex variation of: `--include-directories`
  * accepts a list of strings
  * each string is compiled to a regular expression
  * each regular expression is tested against the prospective __directory path__ value
    * the value is __accepted__ if any match occurs
  * naming convention: __AP__ means _accept path_

* `--regex_RP`
  * regex variation of: `--exclude-directories`
  * accepts a list of strings
  * each string is compiled to a regular expression
  * each regular expression is tested against the prospective __directory path__ value
    * the value is __rejected__ if any match occurs
  * naming convention: __RP__ means _reject path_

* `--regex_AU`
  * regex variation of: `--accept`
  * accepts a list of strings
  * each string is compiled to a regular expression
  * each regular expression is tested against the prospective __URL__ value
    * the value is __accepted__ if any match occurs
  * naming convention: __AU__ means _accept URL_

* `--regex_RU`
  * regex variation of: `--reject`
  * accepts a list of strings
  * each string is compiled to a regular expression
  * each regular expression is tested against the prospective __URL__ value
    * the value is __rejected__ if any match occurs
  * naming convention: __RU__ means _reject URL_

#### Notes:

* order of precedence is unchanged
  * blacklists always supersede whitelists

#### Example - Data Values:

* __URL__: `http://localhost:80/foo/bar/baz/file.html`
  * __domain__: `localhost`
  * __directory path__: `foo/bar/baz`

#### Example - Usage:

* [batch script: tests](https://github.com/warren-bank/wget-regex/blob/master/2-test.bat)
  * tests of particular interest: 3-9
    * variable of particular interest: `filters`

#### Toolchain:

* then:
  * MinGW
  * Msys
  * Bloodshed Dev-C++
* now:
  * [MinGW 16.1](https://nuwen.net/mingw.html)

#### Original Source Code:

* [wget 1.11.4](https://ftp.gnu.org/gnu/wget/wget-1.11.4.tar.gz)

#### Libraries:

* [OpenSSL 1.0.2q](http://slproweb.com/products/Win32OpenSSL.html)
* [libgnurx 2.5](https://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libgnurx-src-2.5.zip)
  * regex functionality from glibc 2.5
  * published by: Tor Lillqvist
  * recompiled for: x64

#### Legal:

* copyright: [Warren Bank](https://github.com/warren-bank)
* license: [GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
