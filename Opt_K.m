function [K S K_mat] = Opt_K(Sil)

S1 = mean(Sil(:,2));
S2 = mean(Sil(:,3))
S3 = mean(Sil(:,4));
S4 = mean(Sil(:,5));
S5 = mean(Sil(:,6));
S6 = mean(Sil(:,7));


S = [S1 S2 S3 S4 S5 S6 ];
K_mat = [2 3 4 5 6 7 ];

if S1==max(S)
    K = 2
elseif S2==max(S)
    K = 3
elseif S3==max(S)
    K = 4
elseif S4==max(S)
    K = 5
elseif S5==max(S)
    K = 6
else
    K = 7
end


end
