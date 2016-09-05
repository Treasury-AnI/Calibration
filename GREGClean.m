function W = GREGClean(W,C,B,L,U)
Diff = inf;
while sum(((B - C*W').*(B - C*W'))./B) < Diff
    Tot = (B - C*W')';
    Diff = sum((Tot.*Tot)'./B);
    Mid = (C.*repmat(W,size(C,1),1))*C';
    W = max([min([W.*(1+(Tot/Mid)*C);U.*ones(1,size(C,2))]);L.*ones(1,size(C,2))]);
end
end

%GREGClean([2,3,4,8],[[3,4,0,2];[5,3,7,2]],[20,50]',2,20);