# Dead URLs

          ____    U _____ u     _        ____       ____        _
         |  _"\   \| ___"|/ U  /"\  u   |  _"\   U |  _"\ u    |"|
        /| | | |   |  _|"    \/ _ \/   /| | | |   \| |_) |/  U | | u
        U| |_| |\  | |___    / ___ \   U| |_| |\   |  _ <     \| |/__
         |____/ u  |_____|  /_/   \_\   |____/ u   |_| \_\     |_____|
          |||_     <<   >>   \\    >>    |||_      //   \\_    //  \\ 
         (__)_)   (__) (__) (__)  (__)  (__)_)    (__)  (__)  (_")("_) ")"


               *A dead simple URL verifier for RST and MD docs*

[![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)

This simple application scans all Markdown and ReStructedText
documents in the current directory by default recursively for valid URLs.
If you want to give a specific location to search for, you can
give that as an argument as well.

After getting a list of URLs, it uses cURL to check the response
header for valid status codes (2xx or 3xx). Successful, invalid and
URLs that did not return responses are listed as part of stats at
the end of the run.

Examples,

To search the current directory for md/rst docs and scan the URLs in them use,

```
./check.sh
```

To search a specific path, use,

```
./check.sh /opt/path_to_doc
```

Both commands will act recursively, scanning all directories for rst/md docs.

