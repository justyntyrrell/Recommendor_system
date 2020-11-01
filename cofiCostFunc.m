function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

J = 1/2 * sum(sum((X*Theta'.*R - Y).^2)) + lambda/2 * sum(sum(Theta.^2)) + sum(sum(lambda/2 * X.^2));

for i = 1:num_movies
idx = find(R(i, :)==1);
ThetaTemp = Theta(idx, :);
Ytemp = Y(i, idx);

X_grad(i, :) = (X(i, :)*ThetaTemp' - Ytemp)*ThetaTemp + lambda * X(i, :);

end

for j= 1:num_users
 
idx = find(R(:, j)==1);
Xtemp = X(idx, :);
Ytemp = Y(idx, j);


Theta_grad(j, :) = Xtemp'*(Xtemp*Theta(j, :)' - Ytemp) + lambda * Theta(j, :)';

end


%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%
















% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
