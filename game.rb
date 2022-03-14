module Mastermind
  require "colorize"

  $code_length = 4
  $max_value = 6

  class Blocks
    @@blocks = {
      block1: " 1 ".colorize(:color => :black, :background => :red),
      block2: " 2 ".colorize(:color => :black, :background => :green),
      block3: " 3 ".colorize(:color => :black, :background => :blue),
      block4: " 4 ".colorize(:color => :black, :background => :magenta),
      block5: " 5 ".colorize(:color => :black, :background => :cyan),
      block6: " 6 ".colorize(:color => :black, :background => :white),
    }

    def self.print_blocks_sequence(*args)
      sequence = String.new
      for arg in args
        arg_to_sym = "block#{arg.to_s}".to_sym
        @@blocks.each do |key, value|
          if key == arg_to_sym
            sequence += value
          end
        end
      end
      puts sequence
    end

    def self.get_blocks
      @@blocks
    end
  end

  class GameMaker
    def initialize
      puts "Create a #{$code_length} digit code:"
      @code_to_break = gets.chomp
      if CodeChecker.check_errors(@code_to_break) != 0
        puts "Invalid digit code or length"
        restore()
      end
    end

    def restore
      initialize()
    end
  end

  class GameBraker
    def initialize
      puts "Computer generates a #{$code_length} digit code!"
      @code_to_break = random_code($code_length, $max_value)
      loop_to_solve()
    end

    def random_code(code_length, max_value)
      code = String.new
      iteration = 0
      while iteration < code_length
        code += (rand(max_value) + 1).to_s
        iteration += 1
      end
      code
    end

    def loop_to_solve
      count = 0
      loop do
        count += 1
        puts "#{count} attempt(s). Input your #{$code_length} digit code:"
        code_input = gets.chomp
        if CodeChecker.check_errors(code_input) != 0
          puts "Wrong input. Repeat."
          count -= 1
          next
        end
        code_input_array = code_input.split("")
        Blocks.print_blocks_sequence(*code_input_array)
        break puts "Congrats, you solve the code" if code_input == @code_to_break
        break puts "You lose" if count == 12
      end
    end
  end

  class CodeChecker
    def self.check_errors(code)
      @code_to_break = code
      code_split = @code_to_break.split("")
      code_split.map! do |char|
        if char.match(/[1-6]/) && @code_to_break.length == $code_length
          char = 0
        else
          char = 1
        end
      end
      count_errors = code_split.reduce { |sum, n| sum += n }
      count_errors
    end
  end

  class Game
    def initialize(code_length = $code_length, max_value = $max_value)
      puts "Select the type of game (Maker = 1, Braker = 2)"
      @game_selection = gets.chomp
      if @game_selection != "1" && @game_selection != "2"
        puts "Error typing. Select an available option"
        restore_game()
      end
    end

    def restore_game
      initialize()
    end

    def start
      if @game_selection == "1"
        @game = GameMaker.new
      elsif @game_selection == "2"
        @game = GameBraker.new
      end
    end
  end
end

game = Mastermind::Game.new()
game.start
