% Entrypoint for your project.

trainDispath=TrainDispatch();
% Initialize the UI
mainapp= mainApp();
trainDispath.mainApp=mainapp;
debugUI= DebugApp();
trainDispath.debugApp=debugUI;
debugUI.trainDispatch=trainDispath;
debugUI.display_update_systime();
% init a basic env
% Xiaoming=Passanger(0,"XiaoMing");
% ui.bindPassanger(Xiaoming);

% testTicket=Ticket(train1,shanghai,hangzhou);
% Xiaoming.bookTicket(testTicket);
% ui.DisplayTrains()
