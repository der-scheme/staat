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

##
#

module Staat
  module Event
    class Incidence
      def initialize(args: nil, object: nil, options: nil)
        @args = args
        @object = object
        @options = options
      end

      attr_reader :args
      attr_reader :object
      attr_reader :options

      class Invocation < Incidence
      end

      class Failure < Incidence
        def initialize(error: nil, **options)
          @error = error
          super(**options)
        end

        attr_reader :error
      end

      class Completion < Incidence
        def initialize(result: nil, **options)
          @result = result
          super(**options)
        end

        attr_reader :result
      end

    end
  end
end
