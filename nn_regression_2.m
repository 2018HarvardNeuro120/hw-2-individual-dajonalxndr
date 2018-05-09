clear all

nh_1 = [1:40];
for i = 1:length(nh_1)
    %% Set up parameters
    N = 40; % Number of training samples
    epsilon = 0.2; % label noise
    Nh = nh_1(i);
    lambda = 1e-4;
    nh_rep = 500;

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
    
    mse_nh(i) = mean(mean_squared_error);
    mse_nh_med(i) = median(mean_squared_error);

end
figure 
plot(nh_1,mse_nh)
