classdef testServerAPP < matlab.uitest.TestCase

    properties
        App
    end

    methods (TestMethodSetup)

        function launchApp(testCase)
            testCase.App = ServerUI;
        end

    end

    methods (Test)

        function test_SelectButtonPushed(testCase)
            % State: No order for the table and no dish selected
            % Input: Choose appetizer 1 and press select button
            % Expected Output: OrderList has appetizer 1's name, amount and
            % unit price
            testCase.choose(testCase.App.appetizer1Node);
            pause(0.5)
            testCase.press(testCase.App.SelectButton);
            pause(0.5)
            testCase.verifyEqual(testCase.App.OrderList.Data{1}, testCase.App.appetizer1Node.Text);

        end

        function orderID = buyTicket(int passengerID, int trainID, int depStationID, int arrStationID):
            % passenger can only buy one ticket per train, but can buy tickets of different trains without quantitative limitation.
            % we will setTime before call this function, so there no time parameter, just take system time
            % buying transfer ticket will call this function twice
            % return 0 when no ticket available
            % return an arbitrary orderID, as long as no same ID even if refunding happens
            


        end

    end

end
