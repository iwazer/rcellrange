# Rcellrange

It converts cell specification and X/Y position to each other in Excel and Google spreadsheet.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rcellrange', git: "https://github.com/iwazer/rcellrange.git"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install specific_install
    $ gem specific_install https://github.com/iwazer/rcellrange.git

## Usage

```
Rcellrange.new.coord2cell(1, 1)
#=> "A1"

Rcellrange.new.coord2cell(999, 18278)
#=> "ZZZ999"

Rcellrange.new.cell2coord("A1")
#=> [1..1, 1..1]

Rcellrange.new.cell2coord("ZZX5:ZZZ10")
#=> [5..10, 18276..18278]
```
