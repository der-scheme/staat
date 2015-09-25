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
    # Manages Anticipations.

    class Manager

      ##
      # Return the default manager.

      def self.default
        @@default_manager ||= Manager.new
      end

      ##
      #

      def initialize
        @events = {}
      end

      ##
      # Add the +anticipation+ and return *self*.

      def <<(anticipation)
        expand_scope(anticipation.scope).each do |scope|
          by_scope = (@events[scope] ||= {})
          put_by_scope(by_scope, anticipation)
        end

        self
      end

      ##
      # Return a Set with all Anticipations matching the given parameters, or
      # +nil+ if none match.
      #
      # Omitting or passing a false-evaluating parameter is equivalent to `gimme
      # everything of that type'.

      def [](scope: nil, action: nil, name: nil, type: nil)
        scope ||= BasicObject
        type  = expand_type(type)

        result = Set.new(@events.values_at(*scope))
        result.delete(nil)

        if action
          reduce(result.map {|events| events.values_at(nil, *action)}, result)
        else
          reduce(result.map(&:values), result)
        end

        if type
          reduce(result.map {|events| events.values_at(*type)}, result)
        else
          reduce(result.map(&:values), result)
        end

        if name
          reduce(result.map {|events| events.values_at(*name)}, result)
        else
          reduce(result.map(&:values), result)
        end
        result.map!{|e| e.is_a?(Array) ? Set.new(e) : e}.flatten!

        result unless result.empty?
      end

      ##
      # Throw away all stored Anticipations and return +self+.

      def clear
        @events.clear
        self
      end

      ##
      # Return a Dispatch for the given parameters.

      def prime(object, name, args, options)
        Event::Dispatch.new(self, name, args, options)
      end

    private

      def reduce(collection, result)
        collection.reduce(result.clear, &:merge).delete(nil)
      end

      def expand_scope(scope)
        [BasicObject, *scope].flat_map(&:ancestors).uniq
      end

      def expand_type(type)
        case type
        when :all, nil
          [:invocation, :failure, :completion]
        when :invocation, :failure, :completion
          [type]
        end
      end

      def put_by_scope(events, event)
        by_action = (events[event.action] ||= {})
        put_by_action(by_action, event)
      end

      def put_by_action(events, event)
        [*expand_type(event.type)].each do |type|
          by_type = (events[type] ||= {})
          put_by_type(by_type, event)
        end
      end

      def put_by_type(events, event)
        if event.name
          events[event.name] = event
        else
          (events[nil] ||= []) << event
        end
      end

    end
  end
end
