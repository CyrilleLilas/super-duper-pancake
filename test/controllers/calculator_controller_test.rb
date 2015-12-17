require 'test_helper'

class CalculatorControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
	test "should sum" do
	  get(:do_the_maths, {A: "5", B: "6", op: "add"})
	  assert_equal "11.0", @response.body
	  # Rails.logger.debug "RESPONSE #{@response.body.body.to_s}"
	  assert_response 200
	end

	test "should substract" do
	  get(:do_the_maths, {A: "5", B: "6", op: "sub"})
	  assert_equal "-1.0", @response.body
	  assert_response 200
	end

	test "should multiply" do
	  get(:do_the_maths, {A: "5", B: "6", op: "mul"})
	  assert_equal "30.0", @response.body
	  assert_response 200
	end

	test "should divide" do
	  get(:do_the_maths, {A: "5", B: "2", op: "div"})
	  assert_equal "2.5", @response.body
	  assert_response 200
	end

	test "should accept floats" do
	  get(:do_the_maths, {A: "5.48", B: "6.23", op: "mul"})
	  assert_equal "34.1404", @response.body
	  assert_response 200
	end

	test "should accept one negative number" do
	  get(:do_the_maths, {A: "-5.48", B: "6.23", op: "mul"})
	  assert_equal "-34.1404", @response.body
	  assert_response 200
	end

	test "should accept two negatives number" do
	  get(:do_the_maths, {A: "-5.48", B: "-6.23", op: "mul"})
	  assert_equal "34.1404", @response.body
	  assert_response 200
	end

	test "should accept big numbers" do
	  get(:do_the_maths, {A: "111111111111111111111111111111111111111111111111111111111", B: "2", op: "add"})
	  assert_equal "1.1111e+56", @response.body
	  assert_response 200
	end

	test "operand B is mandatory" do
	  get(:do_the_maths, {A: "5", op: "div"})
	  assert_equal "missing operand B", @response.body
	  assert_response 400
	end

	test "operand A is mandatory" do
	  get(:do_the_maths, {B: "0", op: "div"})
	  assert_equal "missing operand A", @response.body
	  assert_response 400
	end

	test "should not accept missing operator" do
	  get(:do_the_maths, {A: "5", B: "71"})
	  assert_equal "missing operator", @response.body
	  assert_response 400
	end

	test "should not accept unknown operator" do
	  get(:do_the_maths, {A: "5", B: "71", op: "lollipop"})
	  assert_equal "unknown operator", @response.body
	  assert_response 400
	end

	test "divide by zero (integer)" do
	  get(:do_the_maths, {A: "5", B: "0", op: "div"})
	  assert_equal "division by zero", @response.body
	  assert_response 400
	end

	test "divide by zero (float)" do
	  get(:do_the_maths, {A: "5", B: "0.0000", op: "div"})
	  assert_equal "division by zero", @response.body
	  assert_response 400
	end

	test "operand A should represent a number" do
	  get(:do_the_maths, {A: "5sfdguisg", B: "0", op: "add"})
	  assert_equal "operand A not a number", @response.body
	  assert_response 400
	end

	test "operand B should represent a number" do
	  get(:do_the_maths, {A: "45", B: "five", op: "add"})
	  assert_equal "operand B not a number", @response.body
	  assert_response 400
	end

	test "should render json when asked" do
	  get(:do_the_maths, {A: "-5.48", B: "-6.23", op: "mul", output: "json"})
	  assert_equal({result: 34.1404}.to_json, @response.body)
	  assert_response 200
	end

	test "should accept uppercase operators" do
	  get(:do_the_maths, {A: "-5.48", B: "-6.23", op: "MUL", output: "json"})
	  assert_equal({result: 34.1404}.to_json, @response.body)
	  assert_response 200
	end

	test "parameters values should be case insentive" do
	  get(:do_the_maths, {A: "-5.48", B: "-6.23", op: "MUL", output: "jSOn"})
	  assert_equal({result: 34.1404}.to_json, @response.body)
	  assert_response 200
	end
end
