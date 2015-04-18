# Tealeaf Academy / Introduction to Ruby and Web Development / Lesson 1
# Assignment : Calculator


# This method asks the user for a number
def get_user_number(number_order)
  err_message = "You have not entered a valid number!"
  puts "--- Please enter your #{number_order} number"
  print "=> "
  number = ""
  # Ask the user until the entered number is valid
  loop do
    number = gets.chomp
    if verify_number(number)
      break
    else
      puts err_message
    end
  end
  number.to_f
end

# This method verifies if the user's input is a valid number
def verify_number(str_number)
  # Initialize the method to false
  return_value = false

  # Arrange the user's input in order to make it into a verificable array
  # containing each character separately
  str_number.delete!(' ')
  arr_number = str_number.split(//)

  # Verify if user entered a float or a fixnum and proceed with the 
  # verification of each character of the user's input
  if arr_number.count(".") == 0 || arr_number.count(".") == 1
    arr_number.each do |x|
      if x.match(/\d/) == nil && x != "." && x != "-"
        return_value = false
        break
      else
        return_value = true
      end
    end
  end
  return_value
end

# This method returns the operation to apply to the numbers
# as selected by the user
def get_operation
  puts "--- Type in your selection"
  puts "--- 1 -> (+) || 2 -> (-) || 3 -> (x) || 4 -> (/)"
  print "=> "

  # Get user's input
  operation = validate_user_input("1", "4")
end

# This method validates if the user's choice is valid. It returns
# the choice if it's valid
def validate_user_input(low, high)
  input = ""
  loop do
    input = gets.chomp
    if !(low..high).include?(input)
      puts "--- You have entered an invalid selection!"
      print "=> "
    else
      break
    end
  end
  input
end

# This method verifies if the number is worth converting to an integer
# without loosing important decimals and then returns that number
# Ex:. 7.0 -> 7 | 7.876 -> 7.876
def convert_to_integer(number)
  if number.rationalize.denominator == 1
    number = number.to_i
  else
    number
  end
end

# This method asks the user what he wants to do at the end of the calculation.
def get_user_choice(result)
  puts "--- Type in your selection"
  puts "--- 1 -> do another operation on #{result}\n" \
       "--- 2 -> start a new calculation\n" \
       "--- 3 -> exit the program"
  print "=> "
  choice = validate_user_input("1", "3")
end

# Main method for the calculator app
def calculator
  puts "--- Welcome to my calculator application!"
  user_choice = ""
  result = 0

  # Run the program until the user decides to stop
  while user_choice != "3"
    # Ask the user to input his numbers
    if user_choice == "2" || user_choice == ""
      first_num = get_user_number("first")
      second_num = get_user_number("second")
    else
      first_num = result
      second_num = get_user_number("next")
    end

    # Ask the user which operation to apply
    operation = get_operation

    # Calculate!
    case operation
    when "1"
      result = first_num + second_num
      operator = "+"
    when "2"
      result = first_num - second_num
      operator = "-"
    when "3"
      result = first_num * second_num
      operator = "*"
    when "4"
      # Verify if user is dividing first_num by 0
      if second_num == 0.0
        puts "You can't divide by 0!"
        next
      else
        result = first_num / second_num
      end
      operator = "/"
    end

    # Convert the numbers to integer if needed
    first_num = convert_to_integer(first_num)
    second_num = convert_to_integer(second_num)
    result = convert_to_integer(result)


    # Print out the result
    puts ""
    puts "=> #{first_num} #{operator} #{second_num} = #{result}"
    puts ""

    # Verify with the user what to do next
    user_choice = get_user_choice(result)
  end
end

calculator