# Multi Hash allows you to iterate through multiple hashes at the same time.
# The values will be an array of values from each hash. If a hash contains
# no value for the key, it will be nil.
#
class MultiHash

  def initialize *hashes
    @hashes = hashes
    @memo = {}
  end

  # Enumerate for each key.
  # Returns an enumerator if block is not present
  #
  def each
    return enum_for(:each) unless block_given?

    # iterate through the memo first
    @memo.each do |k, v|
      yield k, v
    end

    count = @hashes.length
    count.times do |i|
      @hashes[i].each do |key, v|
        next if @memo[key]

        values = [].fill(nil, 0, i)
        values << v
        ((i+1)...count).each do |j|
          values << @hashes[j][key]
        end

        yield key, values if block_given?
        @memo[key] = values
      end
    end
  end


  def [] key
    @memo[key] ||= @hashes.collect { |h| h[key] }
  end

end


# Shortcut to do the iteration
#
def multi_hash *hashes
  MultiHash.new(*hashes).each
end
