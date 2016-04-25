function error=sparse(X, D, alpha)


lambda=.15;
error=.5*(((sum((D*alpha-X).^2))^.5)^2)+(lambda*(sum(alpha)));

end
