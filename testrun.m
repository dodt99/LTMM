clc, clear all
%plain(1,:)=round(rand(1,64));
%key=round(rand(1,64));
plain='123456ABCD132536';
key = 'AABB09182736CCDD';
cipher = enkripsi_des(plain, key);
plain_after=dekripsi_des(cipher, key); 



%123456ABCD132536
%AABB09182736CCDD  =======>  C0B7A8D05F3A829C
