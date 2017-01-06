# dead_urls
This simple application scans all Markdown and ReStructedText
documents in the current directory recursievely. After get a list
of URLs, it uses cURL to check the response header for valid status
codes (2xx or 3xx).Successful, invalid and URLs that did not return
responses are listed as part of stats at the end of the run.
