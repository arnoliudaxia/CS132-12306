classdef test_counter < handle & matlab.unittest.TestCase

    methods (Test)

        function test_increment(tc)

            tc.verifyEqual(0, 0);

            tc.verifyEqual(2, 1);

        end

    end

end
