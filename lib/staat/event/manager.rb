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

    ##
    # Manages Declarations.

    class Manager

      def initialize
        @events = {}
      end

      ##
      # Adds the +declaration+ and returns *self*.

      def <<(declaration)
        expand_scope(declaration.scope)
            .each {|scope| put_by_scope(scope, declaration)}

        self
      end

      ##
      # Return a Set with all Declarations matching the given parameters, or
      # +nil+ if none match.
      #
      # Omitting or passing a false-evaluating parameter is equivalent to `gimme
      # everything of that type'.

      def [](scope: nil, action: nil, name: nil)
        result = Set.new(@events.values_at(*expand_scope(scope)))
        result.delete(nil)

        if action
          result.each_with_object(action).map!(&:[]).delete(nil)
        else
          result.map(&:values).reduce(result.clear, &:merge)
        end

        if name
          result.each_with_object(name).map!(&:[]).delete(nil)
        else
          result.map(&:values).reduce(result.clear, &:merge)
        end

        result unless result.empty?
      end

    private

      def expand_scope(scope)
        [BasicObject, *scope].flat_map(&:ancestors).uniq
      end

      def put_by_scope(scope, event)
        @events[scope] ||= {}
      end

    end
  end
end
