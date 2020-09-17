require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/blackjack_score'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe 'Blackjack Score' do

  it "hand cannot exceed 5 values" do
    expect {blackjack_score([9, 2, 3, 4, 5, 6])}.must_raise ArgumentError
  end

  it 'can calculate the score for a pair of number cards' do

    # Arrange
    hand = [3, 4]

    # Act
    score = blackjack_score(hand)

    # Assert
    expect(score).must_equal 7

  end

  it 'facecards have values calculated correctly' do
    expect(blackjack_score(["King", "Queen"])).must_equal 20
    expect(blackjack_score(["Queen", 4, 2])).must_equal 16
  end

  it 'calculates aces as 11 where it does not go over 21' do
    expect(blackjack_score([2, 2, "Ace"])).must_equal 15
  end

  it 'calculates aces as 1, if an 11 would cause the score to go over 21' do
    expect(blackjack_score(["King", "Queen", "Ace"])).must_equal 21
    expect(blackjack_score(["Jack", "Ace"])).must_equal 21
  end

  it 'raises an ArgumentError for invalid cards' do
    expect {blackjack_score(["banana"])}.must_raise ArgumentError
    expect {blackjack_score([0, 8])}.must_raise ArgumentError
    expect {blackjack_score([-1, 3, "King"])}.must_raise ArgumentError
  end

  it 'raises an ArgumentError for scores over 21' do
    expect {blackjack_score(["Queen", "King", 4])}.must_raise ArgumentError
  end
end
