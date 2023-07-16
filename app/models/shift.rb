# The Shift model includes validations for shift duration and preventing duplicates based on start and end times.
# It uses a cache invalidation callback to clear the cache after each shift record change.
class Shift < ApplicationRecord
  after_commit :invalidate_shifts_cache
  validate :valid_shift_duration
  validate :no_duplicate_shifts
  
  def valid_shift_duration
    if end_time <= start_time || (end_time - start_time) > 8.hours
      errors.add(:end_time, "Shift duration must be between 0 and 8 hours.")
    end
  end

  def invalidate_shifts_cache
    CacheManager.delete_matched("shifts/*")
  end

  def no_duplicate_shifts
    if Shift.exists?(start_time: start_time, end_time: end_time)
      errors.add(:base, "A shift with the same start time and end time already exists.")
    end
  end

end