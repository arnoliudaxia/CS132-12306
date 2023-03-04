% Create a counter object
% @property {int} count - The current count
classdef counter < handle

    properties (SetAccess = private)
        count = 0
    end

    methods

        % @constructor
        % @return {Self} self
        function self = counter()
        end

        % Increment the counter
        % @param {Self} self
        % @return {int} count - The current count
        function count = increment(self)
            self.count = self.count + 1;
            count = self.count;
            return;
        end

        % Decrement the counter
        % @param {Self} self
        % @return {int} count - The current count
        function count = decrement(self)
            self.count = self.count - 1;
            count = self.count;
            return;
        end

    end

end
