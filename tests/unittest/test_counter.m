classdef test_counter < handle & matlab.unittest.TestCase

    methods (Test)

        function test_increment(tc)

            c = counter();

            tc.verifyEqual(c.count, 0);

            c.increment();

            tc.verifyEqual(c.count, 1);

        end

    end

end
