class CalculatorController < ApplicationController
	before_action :safe_params

	def do_the_maths
		a = params[:A].to_f
		b = params[:B].to_f
			logger.debug "A  #{a}"

		if params[:op] === 'add'
			@result = a + b
		elsif params[:op] === 'sub'
			@result = a - b
		elsif params[:op] === 'mul'
			@result = a * b
		elsif params[:op] === 'div'
			@result = a / b
		end 

		if !@result.nil?
			if params[:output] === 'json'
				render text: {result: @result}.to_json, content_type: 'application/json'
			else 
				render text: @result, content_type: 'text/plain'
			end
		end
	end

	private
		def safe_params
			params.permit(:A, :B, :op, :output)
			params.each {|k,v| v.downcase!}
			nb_regex = /^-*\d+\.*\d*$/
			op_regex = /^(add|sub|mul|div)$/
			if params[:A].nil?
				bad_request "missing operand A"
			elsif params[:B].nil?
				bad_request "missing operand B"
			elsif params[:op].nil?
				bad_request "missing operator"
			elsif !(op_regex =~ params[:op])
				bad_request "unknown operator"
			elsif !(nb_regex =~ params[:A])
				bad_request "operand A not a number"
			elsif !(nb_regex =~ params[:B])
				bad_request "operand B not a number"
			end
		end

		def bad_request(msg)
			render text: msg, content_type: 'text/plain', :status => 400
		end
			
end
