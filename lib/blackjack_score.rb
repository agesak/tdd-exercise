# blackjack_score.rb

# is 10 a valid card?
VALID_CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']


def add_in_aces(sum)
  if sum + 11 > 21
    return sum += 1
  else
    return sum += 11
  end
end

def blackjack_score(hand)

  if hand.length > 5
    raise ArgumentError.new("hand greater than 5")
  end

  # if it's a string, capitalize 1st value only
  hand = hand.map{|value| value.is_a?(String) ? value.capitalize : value}

  # handles test for invalid card
  unless (hand - VALID_CARDS).empty?
    raise ArgumentError.new("You have entered an invalid card value")
  end

  sum = 0
  # get the total for all numeric cards
  sum += hand.select{|value| value.is_a?(Integer)}.reduce(:+).to_i

  # add the values for face cards
  sum += hand.select{|value| ["Jack", "Queen", "King"].include?(value)}.length * 10.to_i

  # deal with aces
  hand.select{|value| value == "Ace"}.length.times do
    sum = add_in_aces(sum)
  end

  if sum > 21
    raise ArgumentError.new("Score exceeds 21")
  end

  return sum
end