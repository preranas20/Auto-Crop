
function [sx, sy, sWidth, sHeight] = auto_crop ( f )

f=rgb2hsv(f);

%converting to gray level
g=rgb2gray(im2double(f));

%applying Gaussian filter to smoothen the image
h=imgaussfilt(g,10);

%calculating threshold value and applying it to image
level = graythresh(h);
segmented = imbinarize(h,level);

%Dimensions of the image
Ro = size(g,1);
Co = size(g,2);

%Initial position of the points
sx=1;
sy=1;
sx2=Ro;
sy2=Co;


meanValue=mean(mean(segmented(:)));

%for every row and column in the image to find out the black region
for row=1:Ro
    
     if mean(segmented(row,:),2)<meanValue 
          ypix=Co;
          start=(ypix/2)-500;
          endTag=(ypix/2)+500;
          A=segmented(row,start:endTag);
          if sum(numel(find(A==0)))>800
            sy=row;
            break;
          end
     end
end


for col=1:Co
   
    if mean(segmented(:,col))<meanValue
         xpix=Ro;
         start=(xpix/2)-500;
         endTag=(xpix/2)+500;
         A=segmented(start:endTag,col);
         if sum(numel(find(A==0)))>800
            sx=col;
            break;
         end
    end
    
end


for col2 = Co:-1:sx
    
    if mean(segmented(:,col2))<meanValue
         xpix=Ro;
         start=(xpix/2)-500;
         endTag=(xpix/2)+500;
         A=segmented(start:endTag,col2);
         if sum(numel(find(A==0)))>500
          sx2=col2;  
          break;
        end
    end
   
end


for row2=Ro:-1:sy
   
        if mean(segmented(row2,:),2)<meanValue
            ypix=Co;
            start=(ypix/2)-500;
            endTag=(ypix/2)+500;
            A=segmented(row2,start:endTag);
            if sum(numel(find(A==0)))>500
               sy2=row2;
               break;
            end
        end
end

%computing the width and height of the image
sWidth=sx2-sx;
sHeight=sy2-sy;







