module Algorithm
  module Search
    class << self
      # Finds specific element in a given sorted array through iteration.
      #
      # Accepts:
      #   array   - Array of elements to be search
      #   element - Integer/Float
      #
      # Examples:
      #   iterative_binary([1,2,3,4,5,6,7,8,9,10], 2)
      #   #=> 1
      #
      #   iterative_binary([1,2,3,4,5,6,7,8,9,10], 20)
      #   #=> nil
      #
      # Returns:
      #   index of element if found
      #   else nil
      #
      def iterative_binary(array, element)
        low_index  = 0
        high_index = array.size-1

        # loop through till low_index > high_index, i.e. no match is found
        while low_index <= high_index

          # cut array down middle, we'll then compare the middle_value
          # to see element is in which of the two cut arrays
          #
          middle_index  = (high_index+low_index)/2
          middle_value  = array[middle_index]

          # if element is greater than middle_value, element is in right
          # side, run again with middle+1 as low
          #
          # [1,2,3,4,5], 4
          # 4 > 3
          #
          # if element is less than middle_value, element is in left
          # side, run again with middle-1 as high
          #
          # [1,2,3,4,5], 2
          # 2 < 3
          #
          # we do `middle+1/middle-1` since we already compared the
          # middle_value
          #
          if element > middle_value
            low_index  = middle_index + 1
          elsif element < middle_value
            high_index = middle_index - 1
          else
            return middle_index
          end
        end
      end

      # Finds specific element in a given sorted array through recursion.
      #
      # Accepts:
      #   array   - Array of elements to be search
      #   element - Integer/Float
      #   or
      #   args    - Hash of options
      #     :element
      #     :high
      #     :low
      #
      # Examples:
      #   recursive_binary([1,2,3,4,5,6,7,8,9,10], 2)
      #   #=> 1
      #
      #   recursive_binary([1,2,3,4,5,6,7,8,9,10], 20)
      #   #=> nil
      #
      # Returns:
      #   index of element if found
      #   else nil
      #
      def recursive_binary(array, *args)
        hash       = args.last.is_a?(Hash) ? args.pop : {}

        element    = hash[:element] || args.first
        low_index  = hash[:low]     || 0
        high_index = hash[:high]    || array.size-1

        return nil unless element

        # low > high means we searched entire array & no match was found
        return nil if low_index > high_index

        # cut array down middle, we'll then compare the middle value to
        # see element is in which of the two cut arrays
        #
        middle_index = (high_index+low_index)/2
        middle_value = array[middle_index]

        # if element is greater than middle_value, element is in right
        # side, run again with middle+1 as low
        #
        # [1,2,3,4,5], 4
        # 4 > 3
        #
        # if element is less than middle_value, element is in left
        # side, run again with middle-1 as high
        #
        # [1,2,3,4,5], 2
        # 2 < 3
        #
        # we do middle+1/middle-1 since we already compared the
        # middle_value
        #
        if element > middle_value
          recursive_binary(array,
                          :element => element,
                          :low     => middle_index+1,
                          :high    => high_index)
        elsif element < middle_value
          recursive_binary(array,
                          :element => element,
                          :low     => low_index,
                          :high    => middle_index-1)
        else
          return middle_index
        end
      end
    end
  end
end
