require 'nokogiri'
require 'open-uri'
require 'watir-webdriver'
require 'phantomjs'

class UnitTrustsController < ApplicationController
  before_action :set_unit_trust, only: [:edit, :update, :destroy, :show]
	def index
		if !current_user.nil?
			@unit_trusts = current_user.unit_trusts
		else
			@unit_trusts = []
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

	private 

	def unit_trust_params
		params.require(:unit_trust).permit(:name,:price,:num_units,:original_price,:original_num_units,:url,:start_month)
	end

	def set_unit_trust
	  @unit_trust = UnitTrust.find(params[:id]) 
	end
end
