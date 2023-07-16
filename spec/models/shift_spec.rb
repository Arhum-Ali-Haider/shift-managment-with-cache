# spec/models/shift_spec.rb
require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe '#shifts' do

    context 'with cache invalidation' do
      it 'invalidates cache after creating a new shift' do
        shift = Shift.new(start_time: Time.current.beginning_of_day, end_time: rand(1..8).hours.after(Time.current.beginning_of_day))
        shift.save

        # Expect the Rails.cache to receive :delete_matched with 'shifts/*'
        expect(Rails.cache).to receive(:delete_matched).with('shifts/*')

        shift.invalidate_shifts_cache
      end

      it 'invalidates cache after destroying a shift' do
        shift = Shift.new(start_time: Time.current.beginning_of_day, end_time: rand(1..8).hours.after(Time.current.beginning_of_day))
        shift.save

        # Clear the cache expectation set in the previous test case
        allow(Rails.cache).to receive(:delete_matched).with('shifts/*')

        shift.destroy

        # Expect the Rails.cache to receive :delete_matched with 'shifts/*'
        expect(Rails.cache).to have_received(:delete_matched).with('shifts/*').once
      end

      it 'invalidates cache after updating a shift' do
        shift = Shift.new(start_time: Time.current.beginning_of_day, end_time: rand(1..8).hours.after(Time.current.beginning_of_day))
        shift.save

        # Clear the cache expectation set in the previous test cases
        allow(Rails.cache).to receive(:delete_matched).with('shifts/*')

        shift.update(start_time: Time.current.beginning_of_day + 2.hours)

        # Expect the Rails.cache to receive :delete_matched with 'shifts/*'
        expect(Rails.cache).to have_received(:delete_matched).with('shifts/*').once
      end

    end
  end
end
