#    Staat – Scheme's totally awesome assistant for tutors
#    Copyright (c) 2015 Sebastian Dufner
#
#    This file is part of Staat.
#
#    Staat is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    TARR is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

module Staat
  module Serializable

    ##
    #

    def extended

      ##
      # Serialize self.

      define_method(:serialize) do |file = nil|
        case file
        when nil
          @@serializer.call(self)
        when IO
          file << serialize
        else
          File.open(file.to_s) {|f| serialize(f)}
        end
      end

      define_serializer do
        Marshal.dump(self)
      end

      define_unserializer do
        Marshal.load(self)
      end
    end

    def define_serializer(&serializer)
      fail ArgumentError, 'expected block to be given' unless serializer

      @@serializer = serializer
    end

    def define_unserializer(&unserializer)
      fail ArgumentError, 'expected block to be given' unless unserializer

      @@unserializer = unserializer
    end

    ##
    # Unserialize from the given +file+ whatever data has been serialized
    # before.

    def unserialize(file)
      case file
      when IO
        @@unserializer.call(file.each_char.to_a.join(''))
      else
        @@unserialzer.call(IO.binread(file.to_s))
      end
    end

  end
end
