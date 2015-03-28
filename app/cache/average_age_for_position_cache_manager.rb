class AverageAgeForPositionCacheManager
  def self.fetch(klass, position)
    Rails.cache.fetch(cache_key(klass, position)) do
      klass.average_age_for_position position
    end
  end

  private

  def self.cache_key(klass, position)
    "#{klass.name}::average_age_for_position::#{position}"
  end
end
