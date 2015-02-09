class CalsController < BaseController
	before_filter :find_cal, only: [:show, :update, :destroy]

	def index
		render status: 200, json: Cal.all
	end

	def show
		render json: @cal
	end

	def create
		render status: 200, json: Cal.create!(cal_params)
	end

	def update
		@cal.update_attributes!(cal_params)
		render status: 200, json: @cal
	end

	def destroy
		@cal.destroy
		render status: 200, json: @cal
	end

	private
	def cal_params
		params.require(:cal).permit(:name, :description)
	end

	def find_cal
		@cal = Cal.find(params[:id])
	end
end