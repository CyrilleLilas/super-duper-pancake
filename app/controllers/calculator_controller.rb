class CalculatorController < ApplicationController
	before_action :safe_params

	def do_the_maths
		logger.debug "PARAMS #{@a}"
		a = params[:a].to_f
		b = params[:b].to_f

		if params[:op] === 'sum'
			@result = a + b
		elsif params[:op] === '-'
			@result = a - b
		elsif params[:op] === '*'
			@result = a * b
		elsif params[:op] === '/'
			@result = a / b
		else
			render :nothing => true, :status => 400
		end 

		if !@result.nil?
			render text: @result, content_type: 'text/plain'
		end
	end

	private
		def safe_params
			params.permit(:a, :b, :op)
			nb_regex = /^-*\d+\.*\d*$/
			if nb_regex =~ params[:a] && nb_regex =~ params[:b]
			else
				render :nothing => true, :status => 400
			end
			logger.debug "IS_MATCH #{nb_regex =~ params[:a]}"
			# return { :a => params[:]}
		end
end
