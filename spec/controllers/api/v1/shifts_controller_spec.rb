# spec/controllers/api/v1/shifts_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :controller do
  describe 'GET #index' do

    # It tests the behavior when the required parameters start_time and end_time are missing in the request.
    context 'with missing parameters' do
      it 'returns a bad request response' do
        get :index

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'message' => "Required parameters are 'start_time' and 'end_time'." })
      end
    end
    
    # It simulates the scenario where shifts are found for the given start_time and end_time
    context 'with shifts found' do
      let(:start_time) { Time.current.beginning_of_day }
      let(:end_time) { start_time + 4.hours }

      before do
        Shift.create(start_time: start_time, end_time: end_time)
      end

      it 'returns the shifts with a successful response' do
        get :index, params: { start_time: start_time, end_time: end_time }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).not_to be_empty
      end
    end

    # It simulates the scenario where no shifts are found for the given start_time and end_time.
    context 'with no shifts found' do
      let(:start_time) { Time.current.beginning_of_day }
      let(:end_time) { start_time + 4.hours }
      it 'returns a not found response' do
        # Stub the fetch_shifts method to return an empty array
        allow_any_instance_of(Api::V1::ShiftsController).to receive(:fetch_shifts).and_return([])

        get :index, params: { start_time: start_time, end_time: end_time }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ 'message' => 'No shifts found.' }.to_json)
      end
    end
  end
end
