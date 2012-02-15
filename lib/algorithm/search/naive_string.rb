module Algorithm
  module Search
    class << self

      # Iterates through each letter of string & matches to pattern.
      # (Its called naive for a reason.)
      #
      # Accepts:
      #   string
      #   pattern - String to be matched
      #
      # Examples:
      #   naive_search('ABCDEF', 'B')
      #   #=> 1
      #
      #   naive_search('ABCDEF', 'BC')
      #   #=> [1,2]
      #
      # Returns:
      #   index of pattern if found in string,
      #   Array if pattern has more one character and exists in string,
      #   else nil.
      #
      def naive_search(string, pattern)
        return nil if pattern.size > string.size

        string_length  = string.length
        pattern_length = pattern.length

        string_index   = 0
        pattern_index  = 0

        while string_index <= string_length

          # if string letter & pattern letter are same, check if
          # pattern index is same as pattern length, i.e. see if
          # pattern has more characters to be match.
          #
          #   if true, run through loop again
          #   if false, return index
          #
          # TODO: clarify on returns
          #
          if string[string_index] == pattern[pattern_index]
            if pattern_index == pattern_length-1
              if pattern_index > 0
                return [string_index-(pattern_length-1), pattern_index+1]
              else
                return string_index-(pattern_length-1)
              end
            else
              pattern_index += 1
            end
          else

            # reset pattern index if match not found i.e. half pattern
            # match
            #
            pattern_index    = 0
          end

          string_index      += 1
        end
      end
    end
  end
end
