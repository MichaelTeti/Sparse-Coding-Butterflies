function r=dict_update(X, D_temp, alpha_temp)

Y=[];
alpha_comp=[];
[p]=find(alpha_temp~=0);
for j=1:length(p);
	Xcols=X(:, p(j))';
	Y=[Y; Xcols];
	alpha_comp=[alpha_comp; alpha_temp(p(j))'];
end
	
r=alpha_comp'*D_temp'-Y';
r=sum(sum(r.^2));

end

