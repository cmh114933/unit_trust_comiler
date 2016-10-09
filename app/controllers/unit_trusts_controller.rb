

class UnitTrustsController < ApplicationController
  before_action :set_unit_trust, only: [:edit, :update, :destroy, :show]
	def index
		if !current_user.nil?
			@unit_trusts = current_user.unit_trusts
			@total_ori_value = 0
			@total_current_value = 0
			@total_comparison_value=0
			@unit_trusts.each do |ut|
				@total_ori_value = @total_ori_value + (ut.original_price * ut.original_num_units)
				@total_current_value = @total_current_value + ut.calculate_value.round(2)
				@total_comparison_value =  @total_comparison_value + (ut.calculate_value - (ut.original_price * ut.original_num_units))
			end
		else
			render '/plainpage/login.html.erb', layout:false
		end

	end

	def new
		@unit_trust = UnitTrust.new
	end

	def create

		@unit_trust = current_user.unit_trusts.new(unit_trust_params)
 
		if @unit_trust.save
			@unit_trust.update(num_units:@unit_trust.original_num_units)
			redirect_to unit_trusts_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		@unit_trust.update(unit_trust_params)
		redirect_to unit_trusts_path
	end

	def show

	end

	def new_price_update
		@unit_trusts = UnitTrust.all
		@unit_trusts.each do |ut|
			ut.price_update
		end

		redirect_to unit_trusts_path
	end

	def single_price_update
		ut = UnitTrust.find(params[:id])
		ut.price_update

		redirect_to unit_trusts_path
	end

	def search_history

		@unit_trust = UnitTrust.find(params[:unit_trust_id]) 
		ut_history = @unit_trust.ut_histories
		result = ut_history.find_by(date:params[:date])
		render :json => result
	end

	private 

	def unit_trust_params
		params.require(:unit_trust).permit(:name,:price,:num_units,:original_price,:original_num_units,:url,:start_date)
	end

	def set_unit_trust
	  @unit_trust = UnitTrust.find(params[:id]) 
	end
end
