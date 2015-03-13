require './test/helper.rb'

class TestMultiHashIterator < Minitest::Test


  def test_basic
    h1 = { a: 1, b: 2, c: 3 }
    h2 = { a: 2, b: 3 }
    h3 = { b: 4, d: 6 }
    mh = MultiHash.new(h1, h2, h3)
    mh.each do |k, v|
      if k == :a
        assert_equal [1, 2, nil], v
      elsif k == :b
        assert_equal [2, 3, 4], v
      elsif k == :c
        assert_equal [3, nil, nil], v
      elsif k == :d
        assert_equal [nil, nil, 6], v
      else
        raise "not supposed to happen #{k}, #{v}"
      end
    end

    assert_equal({ a: 1, b: 2, c: 3 }, h1)
    assert_equal({ a: 2, b: 3 }, h2)
    assert_equal({ b: 4, d: 6 }, h3)
  end


  def test_basic_multiple_iteration
    h1 = { a: 1, b: 2, c: 3 }
    h2 = { a: 2, b: 3 }
    h3 = { b: 4, d: 6 }
    mh = MultiHash.new(h1, h2, h3)

    iteration = 0
    mh.each do |k, v|
      iteration += 1
    end

    mh.each do |k, v|
      iteration += 1
    end

    assert_equal 8, iteration
  end


  def test_compound_values
    h1 = { a: 1, b: 2, c: [100, 200] }
    h2 = { a: 2, b: "foo" }
    h3 = { b: { k: 100, v: 200 }, d: 6 }
    mh = MultiHash.new(h1, h2, h3)
    mh.each do |k, v|
      if k == :a
        assert_equal [1, 2, nil], v
      elsif k == :b
        assert_equal [2, "foo", { k: 100, v: 200 }], v
      elsif k == :c
        assert_equal [[100, 200], nil, nil], v
      elsif k == :d
        assert_equal [nil, nil, 6], v
      else
        raise "not supposed to happen #{k}, #{v}"
      end
    end

    assert_equal({ a: 1, b: 2, c: [100, 200] }, h1)
    assert_equal({ a: 2, b: "foo" }, h2)
    assert_equal({ b: { k: 100, v: 200 }, d: 6 }, h3)
  end


  def test_no_block_should_return_enumerator
    h1 = { a: 1, b: 2, c: 3 }
    h2 = { a: 2, b: 3 }
    h3 = { b: 4, d: 6 }
    mh = MultiHash.new(h1, h2, h3)
    e = mh.each
    assert_equal Enumerator, e.class
    assert_equal [:a, [1, 2, nil]], e.next
    assert_equal [:b, [2, 3, 4]], e.next
  end


  def test_enumerator_next
    h1 = { a: 1, b: 2, c: 3 }
    h2 = { a: 2, b: 3 }
    h3 = { b: 4, d: 6 }
    mh = MultiHash.new(h1, h2, h3)
    e = mh.each
    assert_equal [:a, [1, 2, nil]], e.next
    assert_equal [:b, [2, 3, 4]], e.next
    assert_equal [:c, [3, nil, nil]], e.next
    assert_equal [:d, [nil, nil, 6]], e.next
    assert_raises StopIteration do
      e.next
    end
  end


  def test_shortcut_function
    h1 = { a: 1, b: 2, c: 3 }
    h2 = { a: 2, b: 3 }
    h3 = { b: 4, d: 6 }
    multi_hash(h1, h2, h3) do |k, v|
      if k == :a
        assert_equal [1, 2, nil], v
      elsif k == :b
        assert_equal [2, 3, 4], v
      elsif k == :c
        assert_equal [3, nil, nil], v
      elsif k == :d
        assert_equal [nil, nil, 6], v
      else
        raise "not supposed to happen #{k}, #{v}"
      end
    end

    assert_equal({ a: 1, b: 2, c: 3 }, h1)
    assert_equal({ a: 2, b: 3 }, h2)
    assert_equal({ b: 4, d: 6 }, h3)
  end


  def test_shortcut_function_with_enumerator_next
    h1 = { a: 1, b: 2, c: 3 }
    h2 = { a: 2, b: 3 }
    h3 = { b: 4, d: 6 }
    e = multi_hash(h1, h2, h3)
    assert_equal [:a, [1, 2, nil]], e.next
    assert_equal [:b, [2, 3, 4]], e.next
    assert_equal [:c, [3, nil, nil]], e.next
    assert_equal [:d, [nil, nil, 6]], e.next
    assert_raises StopIteration do
      e.next
    end
  end


end
