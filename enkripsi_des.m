function  [outputciph_des] = enkripsi_des(inputplain_des, kunci_des)
%-------chuyen input dang hexa ve mang binary----------
M = inputplain_des;
Ma = [];
for i=1:16 
  Mi = reshape(str2num(char(num2cell(dec2bin(hex2dec(M(i)),4)))),1,[]);
  Ma = cat(1,Ma,Mi);
end 
y=reshape(Ma',1,16*4); %y la input dang nhi phan

%y=inputplain_des;
%-----------chuyen key dang hexa ve mang binary---------
K = kunci_des;
Ka = [];
for i=1:16 
  Ki = reshape(str2num(char(num2cell(dec2bin(hex2dec(K(i)),4)))),1,[]);
  Ka = cat(1,Ka,Ki);
end 
x=reshape(Ka',1,16*4); %x la key input dang nhi phan

%x=kunci_des;
load data;
% pembuatan PC-1 ------------------------------------
pc1=reshape(pc1',1,8*7); 
for i=1:8*7
    xa(i)=x(pc1(i)); %xoa bit parity, key tu 64 bit thanh 56 bit
end
c(1,:)=xa(1:4*7); %key left
d(1,:)=xa(4*7+1:8*7); %key right

% pembuatan key PC-2
% tao cac round key, cho vao mang k co kich thuoc 16x48
for j=1:16
    c(j+1,:)=[c(j,it(j)+1:4*7) c(j,1:it(j))];
    d(j+1,:)=[d(j,it(j)+1:4*7) d(j,1:it(j))];
    xb=[c(j+1,:) d(j+1,:)];
    pc2=reshape(pc2',1,8*6);
    for i=1:8*6
        xc(i)=xb(pc2(i));
    end
    k(j,:)=xc;
end

%-------------------------------------------------------
% process plaintext -------------------------------------
pa=reshape(pa',1,8*8); %pa là initial permutation 8x8
for i=1:8*8
    ya(i)=y(pa(i)); %y la plaintext dang nhi phan
end

L(1,:)=ya(1:4*8);        %%%%%Yang beda di dekripsi
R(1,:)=ya(4*8+1:8*8);


%----------------------------------------------------
for j=2:17
    
    %----------------------------------------------------
    % pembuatan Tabel-E
    te=reshape(te',1,8*6); %te là expansion p-box trong hàm des. Bien 32 bit plaintext__right thanh 48 bit
    for i=1:8*6
        Ra(i)=R(j-1,te(i)); %Ra là dau ra cua expansion p-box
    end
    %return
    A=xor(Ra,k(j-1,:)); %XOR voi khóa k cua tung round
    % pembuatan subtitusi
    % Dua vào s-box
    for i=1:8
        baris=num2str([A(6*i-5) A(6*i)]); %baris la chi so hang
        kolom=num2str([A(6*i-4:6*i-1)]);   %kolom la chi so cot
        barisx=bin2dec([baris(1) baris(4)]);
        kolomx=bin2dec([kolom(1) kolom(4) kolom(7) kolom(10)]);
        if i==1
            sa=s1(barisx+1,kolomx+1); %sa la tham chieu cua baris và kolom trong s-box
        elseif i==2
            sa=s2(barisx+1,kolomx+1);
        elseif i==3
            sa=s3(barisx+1,kolomx+1);
        elseif i==4
            sa=s4(barisx+1,kolomx+1);
        elseif i==5
            sa=s5(barisx+1,kolomx+1);
        elseif i==6
            sa=s6(barisx+1,kolomx+1);
        elseif i==7
            sa=s7(barisx+1,kolomx+1);
        elseif i==8
            sa=s8(barisx+1,kolomx+1);
        end
        B(1,4*i-3:4*i)=dec2bin(sa,4); %B là 32bit sau khi qua s-box
    end
    % pembuatan P(B)
    %pb là straight p-box trong des func
    pb=reshape(pb',1,8*4);
    for i=1:8*4
        Ba(i)=str2num(B(pb(i))); 
        %Ba(i)=B(pb(i));
    end
    
    % nilai L & R
    %L và R là ma tran chua tat ca các bien doi cua plaintext moi round
    L(j,:)=R(j-1,:);            %swap
    R(j,:)=xor(Ba,L(j-1,:));
    
    %----------------------------------------------------
end
%---------------------------------------------------
yb=[R(17,:) L(17,:)]; %vi round cuoi khong swap nên ta swap them lan nua de ket qua dung
px=reshape(px',1,8*8); %px là final permutation
for i=1:8*8
    Out(i)=yb(px(i));
end

outputciph_des=Out;
