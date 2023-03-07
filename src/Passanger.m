classdef Passanger<handle
    %PASSANGER 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        passangerId
        passangerName
        bookTrain
        myStatus
            % IDLE=0
            % BOOKED=1
            % ONBOARD=2
        myTickets
    end
    
    methods (Access = public)
        function obj = Passanger(id,name)
            obj.passangerId=id;
            obj.myStatus=0;
            obj.passangerName=name;            
        end
    end
    methods (Access = public)
        function obj = bookTicket(app,ticket)
            fprintf("Passanger %s books ticket from %s to %s\n",app.passangerName,ticket.fromStation.stationName,ticket.toStation.stationName)
            if ticket.isOcupied==0
                app.myTickets=[app.myTickets;ticket];
                ticket.isOcupied=true;
                ticket.bookPassanger=app;
            end
        end

    end
end

