% Entrypoint for your project.

% Initialize the UI
ui= mainApp();
debugUI= DebugApp();
% init a basic env
trainDispath=TrainDispatch(ui,debugUI);

% train1=Train("G112",trainDispath);
% Xiaoming=Passanger(0,"XiaoMing");
% ui.bindPassanger(Xiaoming);

% testTicket=Ticket(train1,shanghai,hangzhou);
% Xiaoming.bookTicket(testTicket);
% ui.DisplayTrains()

% * YOUR CODE HERE *
