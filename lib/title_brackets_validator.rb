class TitleBracketsValidator < ActiveModel::Validator
  def validate(title)
    if brackets_validate(title)
      true
    else
      title.errors[:title] << 'Invalid'
    end
  end

  def brackets_validate(hash) # Rspec test validator returns hash
    stack  = []
    lookup = { '(' => ')', '[' => ']', '{' => '}' }
    left   = lookup.keys
    right  = lookup.values
    str = hash.title[:title].to_s # turn hash from Rspec test to string, so we are able to use  .each_char and .chars methods
    arr = str.chars # return array of chars in string

    arr.each_index do |i| # loop trough index of lookup and check if there is content between brackets
      if lookup.has_key?(str[i])
        return false if lookup[str[i]] == str[i+1]
      end
    end

    str.each_char do |char|  # loop trough each char to check for brackets
      if left.include? char
        stack << char
      elsif right.include? char
        return false if stack.empty? || (lookup[stack.pop] != char)
      end
    end

    stack.empty? # if stack is empty, there is no 'leftovers' and test is valid

  end


#  end of class
end


