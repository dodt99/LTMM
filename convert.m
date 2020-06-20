function [out] = convert(input_str)
%M = input_str;
%Ma = [];
%for i=1:16 
%  Mi = reshape(str2num(char(num2cell(dec2bin(hex2dec(M(i)),4)))),1,[]);
%  Ma = cat(1,Ma,Mi);
%end 
%out=reshape(Ma',1,16*4);



S = input_str;
S = reshape(S,4,16);
S = S';
H = num2str(S);
Out = '';
for i=1:16
    Hi = H(i,:);
   Hi(isspace(Hi)) = '';
    Hi = dec2hex(bin2dec(Hi));
    Out = strcat(Out,Hi);
end

out=Out;


end


    