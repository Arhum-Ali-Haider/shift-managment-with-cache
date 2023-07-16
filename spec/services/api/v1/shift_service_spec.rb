# spec/services/api/v1/shift_service_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::ShiftService do
  describe '#shifts' do
    context 'with cache' do
      it 'caches data and retrieves it from cache' do

        start_time = Time.zone.parse('2023-07-15 08:00:00')
        end_time = Time.zone.parse('2023-07-15 16:00:00')
        shift_service = Api::V1::ShiftService.new(start_time, end_time)

        # Set up the test data for shifts
        shifts_in_db = []
        5.times do
          shift = Shift.new(start_time: start_time, end_time: end_time)
          shift.save
          shifts_in_db << shift
        end

        # Expect the Rails.cache to receive :fetch and return the shifts_in_db
        expect(Rails.cache).to receive(:fetch).with("shifts/#{start_time}/#{end_time}", expires_in: 2.hours).and_return(shifts_in_db)

        # Call the shifts method and check if it returns the cached data
        shifts = shift_service.shifts
        expect(shifts).to eq(shifts_in_db)
        
      end
    end
  end
end
