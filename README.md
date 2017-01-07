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
documents in the current directory recursievely for valid URLs.
After getting a list of URLs, it uses cURL to check the response
header for valid status codes (2xx or 3xx). Successful, invalid and
URLs that did not return responses are listed as part of stats at
the end of the run.
