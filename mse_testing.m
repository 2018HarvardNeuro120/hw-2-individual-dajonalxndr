clear all
Nh_1 = [40:500];
for i = 1:length(Nh_1)
    %% Set up parameters
    N = 40; % Number of training samples
    epsilon = 0.0; % label noise
    Nh = Nh_1(i);
    lambda = 0;
    nh_rep = 700;

    %% Make dataset
    target_fn = @(t) sin(t);
    x = linspace(-pi,pi,N);
    y = target_fn(x) + epsilon*randn(size(x));

    Ntest = 100;
    x_test = linspace(-pi,pi,Ntest);
    y_test = target_fn(x_test);

    Ni = 2;

    %% Compute network activity
    
    mean_squared_error = zeros(1,nh_rep);
    
    for n = 1:nh_rep
        J = randn(Nh,Ni)/Nh;

        h = J*[x; ones(1,N)];
        h(h<0)=0;

        h_test = J*[x_test; ones(1,Ntest)];
        h_test(h_test<0)=0;


        %% Now train linear regression to map from h to y

        w = (y*h')*pinv(h*h' + lambda*eye(size(h,1)));

        y_pred = w*h_test;

        mean_squared_error = norm(y_test-y_pred).^2;
    end
    
    average(i) = mean(mean_squared_error);
end

plot(Nh_1, average)
xlabel('Nh')
ylabel('average mean sq test error')