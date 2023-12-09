# Changelog

## v0.4.1 (2023-12-09)

### Changes

  * Added test to the adapter `:httpc`
  * Reformated the `CHANGELOG.md`
  * Improved documentation

### Bug fixes

  * Improved the internal headers management for `httpc`
  * Added an exception `ArgumentError` if body is present when doing `:get` request

## v0.4.0 (2023-12-09)

### New features

  * Added the adapter for `:hackney`
  * Added URL scheme validation

### BREAKING CHANGES

  * Renamed the error type from `socket_closed` to `conn_refused`

## v0.3.2 (2023-12-09)

### Bug fixes

  * Fixed an issue related to `AnyHttp.to_rfc1123_date/1` which was converting dates to local time

## v0.3.1 (2023-12-08)

### New features

  * Added the functions `AnyHttp.to_rfc1123_date/1` and `AnyHttp.to_rfc1123_date/2` to convert
  from a `NaiveDateTime` struct to a valid date as RFC1123 value
  * Added a function `AnyHttp.from_rfc1123_date!/1` to convert from a
  RFC1123 date to a `NaiveDateTime` struct

### Changes

  * Unified the errors between the adapters
    * Added support for:
      * `nxdomain`: Non-existing domain
      * `socket_closed`: When the server responded with an error (i.e. a port isn't opened)
      * `unknown_ca`: Unable to verificate TLS certificate
      * `unknown_error`: Used when error not supported

## v0.3.0 (2023-12-08)

### New features

  * Added an exception module `Error`

### Changes

  * Used `AnyHttp.Adapters.Httpc` as default adapter
  * Added specific Elixir type for `headers` depending of Elixir version

## v0.2.0 (2023-12-07)

### New features

  * Added the adapter `:httpc`

### Changes

  * Set Elixir to the version 1.13.4
  * Set Erlang to the version 25.3.2.7
  * Setup Github actions to use `.tool-versions` file
  * Refactored the module `AnyHttp` and its type specificiations

### Bug fixes

  * Ensured the application `Req` is started during `dev` and `test`

## v0.1.1 (2022-07-22)

### Changes

  * Added some documentations

## v0.1.0 (2022-07-22)

### New features

  * Added a single interface to make HTTP calls
  * Implemented `Req` as adapter.
