# Deadrl

          ____    U _____ u     _        ____       ____        _
         |  _"\   \| ___"|/ U  /"\  u   |  _"\   U |  _"\ u    |"|
        /| | | |   |  _|"    \/ _ \/   /| | | |   \| |_) |/  U | | u
        U| |_| |\  | |___    / ___ \   U| |_| |\   |  _ <     \| |/__
         |____/ u  |_____|  /_/   \_\   |____/ u   |_| \_\     |_____|
          |||_     <<   >>   \\    >>    |||_      //   \\_    //  \\ 
         (__)_)   (__) (__) (__)  (__)  (__)_)    (__)  (__)  (_")("_) ")"


               *-A dead simple URL verifier for RST and MD docs-*

[![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)

This simple script can be used to identify broken/failing URLs
in your code doc. This idea is to make this CI compatible so that
you can use it in your testing pipeline to make sure all the links
in your document are giving appropriate responses.

The script scans recursively for dead(4XX/5XX) or stale(no response)
URLs in Markdown and ReStructedText documents in the current directory.
If you want to give a specific location to search for, you can
give that as an argument as well.

## How it works

After getting a list of URLs, it uses cURL to check the response
header for valid status codes (2xx or 3xx). Successful, invalid and
those URLs that did not return any response are listed as part of stats at
the end of the run.

## Examples

To search the current directory for md/rst docs and scan the URLs in them use:

```
./deadrl.sh
```

To search a specific path, use:

```
./deadrl.sh /opt/path_to_doc
```

Both commands will act recursively, scanning all directories for rst/md docs.

## Parallel deadrl

A parallel version of deadrl, which is much faster, is also available, it has
a few things missing in terms of stats, but works as intended. Please see
[parallel deadrl](https://github.com/rahulunair/deadrl/tree/parallel_deadrl "parallel_deadrl").

