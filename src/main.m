% Entrypoint for your project.

% Below is an example application created by teaching staff. You can use it as
% a reference and remove it when you start your own project.

% Initialize the UI and the controller.
% ui = view();
% controller = counter();
% ui.constructor(counter);
ui= query();
% init a basic env
trainDispath=TrainDispatch();
shanghai=Station("Shanghai");
hangzhou=Station("Hangzhou");
train1=Train("G112",trainDispath);
Xiaoming=Passanger(0,"XiaoMing");
ui.bindPassanger(Xiaoming);

testTicket=Ticket(train1,shanghai,hangzhou);
Xiaoming.bookTicket(testTicket);
ui.DisplayTrains()

% * YOUR CODE HERE *
