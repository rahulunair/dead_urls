# Dead URLs

        <td id="L15" class="blob-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span></span></td>
      </tr>
      <tr>
        <td id="L16" class="blob-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>    ____    U _____ u     _        ____       ____        _</span></td>
      </tr>
      <tr>
        <td id="L17" class="blob-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>   |  _&quot;\   \| ___&quot;|/ U  /&quot;\  u   |  _&quot;\   U |  _&quot;\ u    |&quot;|</span></td>
      </tr>
      <tr>
        <td id="L18" class="blob-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>  /| | | |   |  _|&quot;    \/ _ \/   /| | | |   \| |_) |/  U | | u</span></td>
      </tr>
      <tr>
        <td id="L19" class="blob-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>  U| |_| |\  | |___    / ___ \   U| |_| |\   |  _ &lt;     \| |/__</span></td>
      </tr>
      <tr>
        <td id="L20" class="blob-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>   |____/ u  |_____|  /_/   \_\   |____/ u   |_| \_\     |_____|</span></td>
      </tr>
      <tr>
        <td id="L21" class="blob-num js-line-number" data-line-number="21"></td>
        <td id="LC21" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>    |||_     &lt;&lt;   &gt;&gt;   \\    &gt;&gt;    |||_      //   \\_    //  \\ </span></td>
      </tr>
      <tr>
        <td id="L22" class="blob-num js-line-number" data-line-number="22"></td>
        <td id="LC22" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">#</span>   (__)_)   (__) (__) (__)  (__)  (__)_)    (__)  (__)  (_&quot;)(&quot;_) &quot;)&quot;</span></td>
*A dead simple URL verifier for RST and MD docs*


This simple application scans all Markdown and ReStructedText
documents in the current directory recursievely for valid URLs.
After getting a list of URLs, it uses cURL to check the response
header for valid status codes (2xx or 3xx).Successful, invalid and
URLs that did not return responses are listed as part of stats at
the end of the run.
