# multi_hash_iterator

Iterate through multiple hashmaps. Values from multiple hashmaps are presented
in an array. If a hash does not contain a value for that key, a `nil`
will be used. See Example.


## Installation

    gem install multi_hash_iterator


## Example

    require 'multi_hash_iterator'

    h1 = { a: 1, c: 11 }
    h2 = { a: 2, b: 2 }
    h4 = { a: 3, c: 10 }
    multi_hash(h1, h2, h3).each do |k, v|
      # 1st iteration: k = a, v = [1, 2, 3]
      # 2nd iteration: k = c, v = [11, nil, 10]
      # 3rd iteration: k = b, v = [nil, 2, nil]
    end

Or direct access

    mh = MultiHash.new(h1, h2, h3)
    mh[:c]  # => [11, nil, 10]
