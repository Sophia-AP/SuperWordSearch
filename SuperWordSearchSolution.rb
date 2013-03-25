#
#
#  Created by Sophia Parker
#  December, 2013
#
#
  
=begin

File format:

  M N
  M rows of N letters
  "WRAP" or "NO_WRAP"
  P
  P words with 1 word per line
  
Description:

  This program reads a file of the above format and extracts m, n, and p variables. 
  m, n, and p are used to create a grid (containing m rows of n characters) 
  and a list of p words to search for in the grid.

  I wanted m to represent rows and n to represent columns, instead of the other way 
  around, because m x n matrix dimensions are more intuitive to me.

=end

class SuperWordSearch
  class << self

  # set constant containing each of 8 possible directions to move around grid
  DIRECTIONS = [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]]
  
  def initialize
    @@grid = []
    @@words = []
  end

  def get_file
    path = '/Users/Desktop/input1.txt'    # append file path here
    if File.exist?(path)
      f = File.read(path)   
    else
      raise "Error: Incorrect file path. Append path name on line 41 of SuperWordSearch.rb"
    end
    
    # set all characters as upper case 
    input = f.upcase
    # extract all digits and assign them to an array of integers
    numbers = input.scan(/\d+/).collect!(&:to_i)
    
    # make sure file has only three numbers
    if numbers.size != 3
      raise "Error: File should contain 3 numbers, not #{numbers.size}."
    end
    
    # assign numbers to m, n, and p instance variables:
      # @m = number of rows in grid
      # @n = number of columns in grid
      # @p = number of words to search for
    @m, @n, @p = numbers

    # split up input file, remove carriage returns, and turn into 2-D array
    a = input.split(/\n/).map { |i| i.split(//) }
    
    # create class variables for grid of characters and words list
    @@grid = a[1, @m]
    @@words = a[@m+3, @p]
    
    # make sure dimensions of grid and words arrays are correct
    if @@grid[0].length != @n
      raise "Error: Number of columns in grid are not as specified by first line of file."
    end
    
    if @@words.length != @p
      raise "Error: Number of words in list are not equal to p."
    end
    
    # make sure input file is correct length
    if a.length != @m + @p + 3
      raise "Error: File should contain #{@m + @p + 3} lines, not #{a.length} lines."
    end
    
    # create variable to indicate WRAP or NO-WRAP
    if a[@m+1].join == "WRAP" || a[@m+1].join == "NO_WRAP"
      @wrapline = a[@m+1].join
    else 
      raise "Error: Improper indication of WRAP versus NO_WRAP."
    end
  end

  def wrap
    @wrapline == "WRAP"
  end 

  def findwords 
    get_file
      @@words.each do |word|
        if word.length > @n 
          puts "NOT FOUND"
          next 
        end
        findword(word, word[0])             # makes sure 1st letter of word is in grid
      end
  end
  
  def coords(word, letter) 
    @@grid.each_with_index do |row, row_idx|
      row.each_with_index do |char, char_idx|
        if char == letter  
          @char, @row_idx, @char_idx = char, row_idx, char_idx
        end
      end  
    end
  end
  
  def findword(word, letter)
    coords(word, letter)   
      find_dir(word, @row_idx, @char_idx)   # finds direction to next letter
        @i = 1
        find_next(word, @x, @y, @dir)       # goes through rest of word using chosen direction
  end

  def find_dir(word, x, y)
    DIRECTIONS.each do |dir|                # tries to find a match in each of the 8 directions that surround the grid character
      if match(word, x, y, dir, 0) == true
        @dir = dir
      end
    end
  end
  
  def match(word, x, y, dir, i)             # determines whether next letter in word matches next character in grid
    x += dir[0]; y += dir[1]; i += 1        # moves one step in grid in chosen direction; moves to next letter in word
    if wrap == true                         # resets x & y if wrap is allowed and grid boundary is reached
      x = 0 if x >= @m; x = @m-1 if x < 0
      y = 0 if y >= @n; y = @n-1 if y < 0
    elsif wrap == false                     # stops search if wrap is not allowed and grid boundary is reached
      return false if x >= @m || x < 0
      return false if y >= @n || y < 0
    end
    if (@@grid[x][y] == word[i])
      @x, @y, @i = x, y, i
      return true
    end
  end
  
  def find_next(word, x, y, dir)
    if (@@grid[x][y] == word[@i])           # if character in grid matches letter in word
      match(word, x, y, @dir, @i)           # continues moving through grid
    end
    if @i == word.length-1                  
      puts "(#{@row_idx}, #{@char_idx}) (#{@x}, #{@y})"
    elsif @i != word.length-1
      puts "NOT FOUND"
    end
  end

  end
end

SuperWordSearch.findwords
