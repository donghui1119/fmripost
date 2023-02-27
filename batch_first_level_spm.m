%% First level analysis SPM

%% set scans parameters
numScans = 197; % number of volumes or scans
TR = 2;     % Repetition time, in seconds
unit='secs'; % onset times in secs (seconds) or scans (TRs)

%% Outputdirs

outputdir='/home/donghui/Public/dh_test/fmriprep/spm_glm/firstlevel' ; % outputdir for sublist
filedir="/home/donghui/Public/dh_test/fmriprep/spm_glm"; % scans files dir
sublist=dir(fullfile(filedir,'sub*'));
isFile   = [sublist.isdir]; % if exist dir
sublist = {sublist(isFile).name};
spm_mkdir(outputdir,char(sublist)); % make output dirs for each subjects

%% Task id

taskid='social';

%% mask
mask_file="/home/donghui/Public/dh_test/fmriprep/rMNI152_T1_2mm_brain_mask.nii";


%% Loop for sublist

for i=1 :length(sublist);
    
% Inputdirs and files 

sub_file=fullfile(filedir,sublist{i});
p1=spm_select('ExtFPList',sub_file,...
   ['s' sublist{i} '_task-social_run-1_space-MNI152NLin2009cAsym_desc-preproc_bold.nii'], 1:numScans); % select run1

p2=strvcat(p1,spm_select('ExtFPList',sub_file, ...
    ['s' sublist{i} '_task-social_run-2_space-MNI152NLin2009cAsym_desc-preproc_bold.nii'],1:numScans));% adding run2
 
%% Output dirs where you save SPM.mat

subdir=fullfile(outputdir,sublist{i});

%% Basic parameters

matlabbatch{1}.spm.stats.fmri_spec.dir = {subdir};
matlabbatch{1}.spm.stats.fmri_spec.timing.units =  'secs'; % 'secs' or 'scans'
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = TR;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 5; % before min onset
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1; % reference time
    
%% Load input files for task specilized 

matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = cellstr(p2);
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'social';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = [42.113
                                                         80.175
                                                         156.13
                                                         270.13
                                                         346.15
                                                         436.113
                                                         474.175
                                                         550.13
                                                         664.13
                                                         740.15];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = [19.906
                                                            19.853
                                                            19.905
                                                            19.899
                                                            19.883
                                                            19.906
                                                            19.853
                                                            19.905
                                                            19.899
                                                            19.883];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).orth = 1;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'random';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = [4.9557
                                                         118.13
                                                         194.13
                                                         232.16
                                                         308.14
                                                         398.9557
                                                         512.13
                                                         588.13
                                                         626.16
                                                         702.14];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = [19.069
                                                            19.889
                                                            19.898
                                                            19.856
                                                            19.878
                                                            19.069
                                                            19.889
                                                            19.898
                                                            19.856
                                                            19.878];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).orth = 1;
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 100;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = cellstr(mask_file);
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';   
matlabbatch{3}.spm.stats.fmri_spec.delete = 1
%% Model estimation (Default)

matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).sname = 'fMRI model specification: SPM.mat File';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_output = substruct('.','spmmat');
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
%% Contrasts

matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep;
matlabbatch{3}.spm.stats.con.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.stats.con.spmmat(1).sname = 'Model estimation: SPM.mat File';
matlabbatch{3}.spm.stats.con.spmmat(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.stats.con.spmmat(1).src_output = substruct('.','spmmat');
    
% Set contrasts of interest. For example,you can define the contrast social VS random by inputing a vector [1 -1].

matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'social-random';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1 -1];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none'; %'none'
matlabbatch{3}.spm.stats.con.delete = 1;
    
%% Run matlabbatch jobs

spm_jobman('run',matlabbatch);

end