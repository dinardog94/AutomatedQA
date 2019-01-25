global imgpath olddir
fid=fopen('imgPath.txt');
imgpath3=textscan(fid,'%s','delimiter','\n');
fclose(fid);
imgpath2=imgpath3{1};
imgpath = strrep(imgpath2,'/','\');
imgpath=strcat(imgpath,'\');
olddir   = dir(imgpath{1});
while true
  pause(5)
  newdir = dir(imgpath{1});
  if ~isequal(newdir, olddir)
    fprintf('new files found\n');
    olddir = newdir;
  else
    fprintf('no new files\n')
  end
end