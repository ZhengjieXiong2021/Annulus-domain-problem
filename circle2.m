clearvars; close all;
iseed = 8675309;
rng(iseed);

% discretize domain

cparams = [];
cparams.eps = 1.0e-10;
cparams.nover = 0;
cparams.maxchunklen = 0.1; % setting a chunk length helps when the
                              % frequency is known
                              
pref = []; 
chnkr1 = chunkerfunc(@(t) circle1(t,1),cparams,pref); 
chnkr1 = chnkr1.refine;
chnkr1.n = chnkr1.normals;
chnkr2 = chunkerfunc(@(t) circle1(t,0.5),cparams,pref); 
chnkr2 = reverse(chnkr2);
chnkr2 = chnkr2.refine;
chnkr2.n = chnkr2.normals;
chnkrs = [chnkr1,chnkr2];
chnkr = merge(chnkrs);
chnkr = chnkr.refine();

[~,~,info] = sortinfo(chnkr);
assert(info.ier == 0);




% plot geometry and data

figure(1)
clf
plot(chnkr,'-x')
hold on
quiver(chnkr)
axis equal



% fkern = @(s,t) chnk.lap2d.kern(s,t,'D');
% opts = [];
% D = chunkermat(chnkr,fkern,opts);
% sys = -0.5*eye(chnkr.npt) + D;
% size(sys)

