Librex
======

Elixir library to convert office documents to other formats using LibreOffice.

[![Build Status](https://travis-ci.org/ricn/librex.png?branch=master)](https://travis-ci.org/ricn/librex)
[![Inline docs](http://inch-ci.org/github/ricn/librex.svg?branch=master)](http://inch-ci.org/github/ricn/librex)
[![Hex.pm](https://img.shields.io/hexpm/v/librex.svg)](https://hex.pm/packages/librex)
## Requirements

You must have LibreOffice installed of course and the soffice binary must be present in your PATH.
The code has been tested with Libreoffice 4.4.

## Installation

Add this to your `mix.exs` file, then run `mix do deps.get, deps.compile`:

```elixir
  {:librex, "~> 0.1"}
```

## Examples
```elixir
  import Librex

  convert("/Users/ricn/files/example.docx", "/Users/ricn/files/example.pdf")

  convert("/Users/ricn/files/example.docx", "/Users/ricn/files/example.odt")
```
