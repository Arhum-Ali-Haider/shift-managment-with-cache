module Api
  module V1
    class ShiftsController <  BaseController
      def index
        # Check if both 'start_time' and 'end_time' parameters are present in the request.
        # If not, return a bad request response with an error message.
        unless params[:start_time].present? && params[:end_time].present?
          return render json: { message: "Required parameters are 'start_time' and 'end_time'." }, status: :bad_request
        end

        shifts = fetch_shifts        
        if shifts.blank?
          render json: { message: "No shifts found." }, status: :not_found
        else
          render json: shifts, status: :ok
        end

      end

      private
      
      # Helper method to fetch shifts using ShiftService based on the start and end times.
      def fetch_shifts
        ShiftService.new(start_time_param, end_time_param).shifts
      end

      def start_time_param
        params[:start_time].to_datetime.beginning_of_day
      end

      def end_time_param
        params[:end_time].to_datetime.end_of_day
      end
    end
  end
end