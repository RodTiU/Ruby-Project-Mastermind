module Mastermind
  require "colorize"

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
      sequence
    end

    def self.get_blocks
      @@blocks
    end
  end

  class Game
    def initialize
    end
  end
end

block_sequence = Mastermind::Blocks.print_blocks_sequence(1,4,4,5,6,2,3)
puts block_sequence
