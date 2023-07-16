class CacheManager
  def self.fetch(key, expires_in , &block)
    Rails.cache.fetch(key, expires_in: expires_in, &block)
  end

  def self.write(key, value, options = {})
    Rails.cache.write(key, value, options)
  end

  def self.delete_matched(key)
    Rails.cache.delete_matched(key)
  end
end
