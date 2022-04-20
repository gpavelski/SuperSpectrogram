function TF = Nstft(f,wd)

cntr = length(f)/2;
sigma = wd;
fsz = length(f);
X = zeros(1,fsz);
TF = zeros(fsz,fsz);

gwin = exp(-((1:fsz)-fsz/2).^2/(2*sigma^2))/(sqrt(2*pi)*sigma);

x = zeros(1,2*fsz); % zero padding
x(cntr+1:cntr+fsz) = f;

for j = 1:fsz
   for k = 1:fsz
      X(1,k) = gwin(k)*x(j+k);  
   end             
   TF(:,j) = fft(X).';
end