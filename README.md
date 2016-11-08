# Tokenate

Tokenate helps you generate test or other personal tokens from your
[Token Endpoint][tokenendpoint] with a specified scope. The authorization and token endpoints fields in the form are preset to the
[Indieauth][] defaults.

Read more about authorization using your own website at
[IndieWeb.org][indieweb].

## Installation

1. `$ bundle install`
1. `$ foreman start`
1. Visit http://localhost:5000/ in your browser.

You can probably also run this on Heroku or another public web server but make
sure you run over a secure (https) connection.

---

[Barry Frost][barryf].


[tokenendpoint]: https://indieweb.org/token-endpoint
[indieauth]: https://indieauth.com
[indieweb]: https://indieweb.org
[barryf]: https://barryfrost.com