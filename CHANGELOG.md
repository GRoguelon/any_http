# Changelog

## v0.3.0 (2023-12-08)

* **New features:**
  * Added an exception module `Error`

* **Changes:**
  * Used `AnyHttp.Adapters.Httpc` as default adapter
  * Added specific Elixir type for `headers` depending of Elixir version

## v0.2.0 (2023-12-07)

* **New features:**
  * Added the adapter `:httpc`

* **Changes:**
  * Set Elixir to the version 1.13.4
  * Set Erlang to the version 25.3.2.7
  * Setup Github actions to use `.tool-versions` file
  * Refactored the module `AnyHttp` and its type specificiations

* **Bug fixes:**
  * Ensured the application `Req` is started during `dev` and `test`

## v0.1.1 (2022-07-22)

* **Changes:**
  * Added some documentations

## v0.1.0 (2022-07-22)

* **New features:**
  * Added a single interface to make HTTP calls
  * Implemented `Req` as adapter.
