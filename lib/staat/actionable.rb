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

require 'staat/event/dispatch'

##
#

module Staat
  module Actionable

    ##
    #

    def define_action(name, &body)
      define_method(name) do |*args, **options|
        dispatch = Event::Manager.default.prime(self, name, args, options)
        dispatch.event :invocation

        begin
          result = lambda(&body).call(*args, **options)
        rescue StandardError => error
          dispatch.event :failure, error: error
        end

        dispatch.event :completion, result: result
      end
    end

  end
end
