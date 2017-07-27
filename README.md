Librex+imgs
======

Elixir library to convert office documents to other formats using LibreOffice. This fork supports converting from image formats (JPEG and PNG)!

[![Inline docs](http://inch-ci.org/github/ricn/librex.svg?branch=master)](http://inch-ci.org/github/ricn/librex)

## Requirements

LibreOffice must be installed. It's recommended that you add the soffice binary your PATH. Otherwise you have to specify the
absolute path to the soffice binary as the last parameter.

## Installation

Add this to your `mix.exs` file, then run `mix do deps.get, deps.compile`:

```elixir
  {:librex, "~> 1.0"}
```

## Examples
```elixir
  import Librex

  convert("/Users/ricn/files/example.docx", "/Users/ricn/files/example.pdf")

  convert("/Users/ricn/files/example.docx", "/Users/ricn/files/example.odt")

  convert("/Users/ricn/files/example.docx", "/Users/ricn/files/example.pdf", "/path_to/soffice")
```

## Credits

The following people have contributed ideas, documentation, or code to Librex:

* Richard Nyström
* Sergey Chechaev

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
