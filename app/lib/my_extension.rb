module MyExtension

  def mini_measure
    start = Time.now
    yield if block_given?
  ensure
    return Time.now - start
  end


end