require 'colorize'

class Bucket
  attr_accessor :value

  def initialize
    @value = nil
  end

  def can_add?(number, left_buckets, right_buckets)
    if @value.nil?
      if left_buckets.any? { |bucket| bucket.value && bucket.value > number }
        return false
      elsif right_buckets.any? { |bucket| bucket.value && bucket.value < number }
        return false
      end
      return true
    elsif @value == number
      return true
    end
    false
  end
end

class Game
  attr_accessor :buckets, :range

  def initialize(upper_range, num_buckets)
    @range = (0..upper_range).to_a
    @buckets = Array.new(rand(2..num_buckets)) { Bucket.new }
  end

  def display_buckets
    @buckets.each_with_index do |bucket, index|
      print "[#{index.to_s.ljust(2)}:".colorize(:default)
      if bucket.value
        print "#{bucket.value.to_s.ljust(5)}] ".colorize(:yellow)
      else
        print "EMPTY] ".colorize(:green)
      end
      print "\n" if (index + 1) % 8 == 0
    end
    puts "\n"
  end

  def play
    loop do
      system("clear")
      number = @range.sample

      puts "\n------------------------".colorize(:blue)
      puts "The drawn number is #{number.to_s.colorize(:red)} out of #{@range.max.to_s.colorize(:yellow)}"
      puts "------------------------\n".colorize(:blue)
      
      display_buckets

      unless valid_bucket_exists?(number)
        puts "Game Over. No valid bucket for the number #{number}."
        say "Oh no! This is sad news. Game Over."
        break
      end

      index, left_buckets, right_buckets = nil, nil, nil

      loop do
        index = get_bucket_index
        left_buckets = @buckets[0...index].select { |bucket| bucket.value }
        right_buckets = @buckets[index + 1..-1].select { |bucket| bucket.value }

        break if @buckets[index].can_add?(number, left_buckets, right_buckets)

        puts "Invalid bucket choice. Please choose a valid bucket."
      end

      @buckets[index].value = number

      if game_won?
        puts "Congratulations! You have won the game."
        say "Congratulations! You have won the game."
        break
      end
    end
  end

  def valid_bucket_exists?(number)
    @buckets.each_with_index.any? do |bucket, index|
      left_buckets = @buckets[0...index].select { |bucket| bucket.value }
      right_buckets = @buckets[index + 1..-1].select { |bucket| bucket.value }
      bucket.can_add?(number, left_buckets, right_buckets)
    end
  end

  def get_bucket_index
    index = nil
    loop do
      puts "Enter the index of the bucket to place the number in (0 to #{@buckets.size - 1}):"
      index = gets.chomp.to_i
      break if index.between?(0, @buckets.size - 1)
      puts "Invalid index. Please choose a number between 0 and #{@buckets.size - 1}."
    end
    index
  end

  def game_won?
    @buckets.all?{ |bucket| !bucket.value.nil? }
  end

  def say(message)
    if /darwin/ =~ RUBY_PLATFORM
      `say #{message}`
    else
      puts "Speech synthesis not available. Message: #{message}"
    end
  end
end

puts "Enter the upper range for numbers:"
upper_range = gets.chomp.to_i
puts "Enter the upper range of buckets:"
num_buckets = gets.chomp.to_i

game = Game.new(upper_range, num_buckets)
game.play
