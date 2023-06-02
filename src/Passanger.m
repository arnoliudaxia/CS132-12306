classdef Passanger<handle
    
    properties
        passangerName
        myStatus
            % IDLE=0
            % BOOKED=1
            % ONBOARD=2
        myTickets=[]
    end
    
    methods (Access = public)
        function obj = Passanger(name)
            obj.myStatus=0;
            obj.passangerName=name;            
        end
    end
    methods (Access = public)
        
        % 检查是否已经买了票了（不能重复购买）
        % 返回值：boolean，true代表已经买过了
        function output = isHasBoughtTicket(app,ticket)
            output=false;
            % 遍历myTickets，检查每一个元素的trainCode是否和ticket.trainCode一样
            for i = 1:length(app.myTickets)
                theTicket=app.myTickets(i);
                if strcmp(theTicket.trainCode,ticket.trainCode)
                    output=true;
                    return;
                end
                
            end
        end

    end
end

