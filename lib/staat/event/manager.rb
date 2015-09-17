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

module Event
  class Manager

    ##
    #

    def initialize
      @events = {}
    end

    ##
    #

    def <<(declaration)
      self
    end

    ##
    #

    def [](scope: nil, action: nil, name: nil)
      if scope
        result = [*scope].map!{|s| expand_scope(s)}.flatten
            .map!{|scope| @events[scope]}.compact
      else
        result = [@events[BasicObject]]
      end

      if action
        result.map!{|events| events[action]}.compact!
      else
        result.map!{|events| events.values}.flatten!
      end

      if name
        result.map!{|events| events[name]}.compact!
      else
        result.map!{|events| events.values}.flatten!
      end

      result unless result.empty?
    end

  private

    ##
    #

    def expand_scope(scope)

    end

  end
end
