% Entrypoint for your project.

trainDispath=TrainDispatch();
% Initialize the UI
mainapp= mainApp();
mainapp.trainDispatch=trainDispath;
mainapp.usrID="小明";
trainDispath.usrIDs=["小明"];
debugUI= DebugApp();
trainDispath.debugApp=debugUI;
mainapp.debugApp=debugUI;
debugUI.trainDispatch=trainDispath;
debugUI.display_update_systime();
debugUI.displaySeatTrain=trainDispath.Trains(2);
% init a basic env
% Xiaoming=Passanger(0,"XiaoMing");
% ui.bindPassanger(Xiaoming);

% testTicket=Ticket(train1,shanghai,hangzhou);
% Xiaoming.bookTicket(testTicket);
% ui.DisplayTrains()
