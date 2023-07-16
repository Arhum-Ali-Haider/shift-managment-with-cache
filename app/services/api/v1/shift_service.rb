# The ShiftService class in the Api::V1 module provides a method called shifts
# that retrieves shifts data either from the cache or the database,
# using a cache key based on start_time_param and end_time_param.
# The data is cached for 2 hours to optimize subsequent requests.

module Api
  module V1
    class ShiftService
      def initialize(start_time_param, end_time_param)
        @start_time_param = start_time_param
        @end_time_param = end_time_param
      end

      def shifts
        CacheManager.fetch(cache_key, 2.hours ) do
          Shift.where("start_time >= ? AND end_time <= ?", @start_time_param, @end_time_param).to_a
        end
      end
      
      private

      def cache_key
        "shifts/#{@start_time_param}/#{@end_time_param}"
      end
    end
  end
end
