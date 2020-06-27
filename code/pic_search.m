%page is the interger that save the image page
function varargout = pic_search(varargin)
% PIC_SEARCH MATLAB code for pic_search.fig
%      PIC_SEARCH, by itself, creates a new PIC_SEARCH or raises the existing
%      singleton*.
%
%      H = PIC_SEARCH returns the handle to a new PIC_SEARCH or the handle to
%      the existing singleton*.
%
%      PIC_SEARCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIC_SEARCH.M with the given input arguments.
%
%      PIC_SEARCH('Property','Value',...) creates a new PIC_SEARCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pic_search_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pic_search_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pic_search

% Last Modified by GUIDE v2.5 28-Jun-2020 00:34:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @pic_search_OpeningFcn, ...
    'gui_OutputFcn',  @pic_search_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before pic_search is made visible.
function pic_search_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pic_search (see VARARGIN)

% Choose default command line output for pic_search
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pic_search wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pic_search_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


 rows=80;
 cols=120;
 img=zeros(rows,cols,3,370);
 index=[1 2 3 4 5 6 7 8 9 10];
 for i=1:440
     img(:,:,:,i)=imresize(imread(['C:\Users\Hans Yu\Documents\MATLAB\collection_for_1082\1 (' num2str(i) ').jpg']),[rows cols]);
 end
 save img.mat img;

global index;
global page;
global allindex;
global number;
load img.mat img;

allindex=1:440;
allindex = reshape(allindex,[],1);
number=1:440;
number = reshape(number,[],1);
index=1;
page=1;
display(hObject, eventdata, handles, index, page,allindex,number);

function display(hObject, eventdata, handles, index, page, allindex,number)
%ruler=index:1:index+10;
ruler=[allindex(index:index+10,1)];
load img.mat img;
numberuler=[number(index:index+10,1)];


axes(handles.axes1);
imshow(uint8(img(:,:,:,ruler(1))));
axes(handles.axes2);
imshow(uint8(img(:,:,:,ruler(2))));
axes(handles.axes3);
imshow(uint8(img(:,:,:,ruler(3))));
axes(handles.axes4);
imshow(uint8(img(:,:,:,ruler(4))));
axes(handles.axes5);
imshow(uint8(img(:,:,:,ruler(5))));
axes(handles.axes6);
imshow(uint8(img(:,:,:,ruler(6))));
axes(handles.axes7);
imshow(uint8(img(:,:,:,ruler(7))));
axes(handles.axes8);
imshow(uint8(img(:,:,:,ruler(8))));
axes(handles.axes9);
imshow(uint8(img(:,:,:,ruler(9))));
axes(handles.axes10);
imshow(uint8(img(:,:,:,ruler(10))));
set(handles.edit1,'String',['page ' num2str(page) ' of 44'])

set(handles.edit6,'String',numberuler(1))
set(handles.edit7,'String',numberuler(2))
set(handles.edit8,'String',numberuler(3))
set(handles.edit9,'String',numberuler(4))
set(handles.edit10,'String',numberuler(5))
set(handles.edit11,'String',numberuler(6))
set(handles.edit12,'String',numberuler(7))
set(handles.edit13,'String',numberuler(8))
set(handles.edit14,'String',numberuler(9))
set(handles.edit15,'String',numberuler(10))





% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load img.mat img;
%below is the code of the hist
if get(handles.radiobutton1,'Value')==1
    
    global findpicnum;
    findpicnum=get(handles.edit5,'String');
    findpicnum=str2double(findpicnum);
    axes(handles.axes12);
    imshow(uint8(img(:,:,:,findpicnum)));
    
    
    
    find_gray=rgb2gray(uint8(img(:,:,:,findpicnum)));
    find_16 = fix(double(find_gray)/16)+1;
    axes(handles.axes13);
    hist_num = histogram(find_16,16);
    feature_host = hist_num.Values;
    for i = 1:440
        img_gray = rgb2gray(uint8(img(:,:,:,i)));
        gray_16 = fix(double(img_gray)/16)+1;
        feature_find = histcounts(gray_16,16);
        num(i,1) = sum(abs(feature_host - feature_find));
    end
    [out,idx] = sort(num);
    
    global allindex;
    global index;
    global page;
    global number;
    number=out;
    allindex=idx;
    index=1;
    page=1;
    display(hObject, eventdata, handles, index, page, allindex,number);
    
    
    
    
end

%below is the code of the hsv
if get(handles.radiobutton2,'Value')==1
    %取得m*m
    global m;
    m=get(handles.edit2,'String');
    m=str2double(m);
    global n;
    n=get(handles.edit3,'String');
    n=str2double(n);
    
    %figure;imshow(uint8(img(:,:,:,2)));測試讀取的圖片是否正確
    
    img_hsv=zeros(m,n,3,365);
    
    %resize picture
    for piccount=1:1:440
        imgprocessing=uint8(imresize(img(:,:,:,piccount),[300,300]));
        newpiccloumn=1;
        newpicrow=1;
        for i=1:300/m:300%,newpiccloumn=1:1:m;
            for j=1:300/n:300%,newpicrow=1:1:n;
                imgcrop=imgprocessing(i:i+300/m-1,j:j+300/n-1,:);
                imgcrophsv=rgb2hsv(imgcrop);
                img_hsv(newpiccloumn,newpicrow,1,piccount)=max(imgcrophsv(:,:,1),[],'all');
                img_hsv(newpiccloumn,newpicrow,2,piccount)=max(imgcrophsv(:,:,2),[],'all');
                img_hsv(newpiccloumn,newpicrow,3,piccount)=max(imgcrophsv(:,:,3),[],'all');
                newpicrow=newpicrow+1;
            end
            newpicrow=1;
            newpiccloumn=newpiccloumn+1;
        end
    end
    save hsv.mat img_hsv;
    %
    % [filename, pathname] = uigetfile({'*.jpg';'*.png'},'Select an image');
    % global findpic;
    % findpic=imread([pathname,filename]);
    global findpicnum;
    findpicnum=get(handles.edit5,'String');
    findpicnum=str2double(findpicnum);
    axes(handles.axes12);
    imshow(uint8(img(:,:,:,findpicnum)));
    
    
    picoverallsave=[];
    picoverallbiggest=(-1000000000000000);
    for piccount=1:1:440
        picdiffsum=0;
        for i=1:1:m
            for j=1:1:n
                picdiffsum=picdiffsum+abs((img_hsv(i,j,1,findpicnum))-(img_hsv(i,j,1,piccount)));
                picdiffsum=picdiffsum+abs((img_hsv(i,j,2,findpicnum))-(img_hsv(i,j,2,piccount)));
                picdiffsum=picdiffsum+abs((img_hsv(i,j,3,findpicnum))-(img_hsv(i,j,3,piccount)));
            end
        end
        if picdiffsum>picoverallbiggest
            picoverallbiggest=picdiffsum;
        end
        picoverallsave=[picoverallsave;picdiffsum];
    end
    
    for i=1:1:piccount
        picoverallsave(i)= picoverallsave(i)./picoverallbiggest;
    end
    
    global allindex;
    global index;
    global page;
    global number;
    [number,position]=sort(picoverallsave);
    allindex=position;
    index=1;
    page=1;
    display(hObject, eventdata, handles, index, page, allindex,number);
end



%Local Binary Pattern
if get(handles.radiobutton3,'Value')==1
    global findpicnum;
    findpicnum=get(handles.edit5,'String');
    findpicnum=str2double(findpicnum);
    axes(handles.axes12);
    imshow(uint8(img(:,:,:,findpicnum)));
    
    findpicgray=rgb2gray(uint8(img(:,:,:,findpicnum)));
    findpiclbp=extractLBPFeatures(findpicgray,'Upright',false);
    
    localbp=[];
    for i=1:440
        currentpic=uint8(img(:,:,:,i));
        currentpicgray=rgb2gray(currentpic);
        findpiccurrent=extractLBPFeatures(currentpicgray,'Upright',false);
        localbp=[localbp,sum(abs(findpiclbp-findpiccurrent))];
   
        
        [out,idx] = sort(localbp);

    end
    global allindex;
    global index;
    global page;
    global number;
    number=out;
    allindex=idx;
    index=1;
    page=1;
    allindex = reshape(allindex,[],1);
    number= reshape(number,[],1);
    display(hObject, eventdata, handles, index, page, allindex,number);
end
    
if get(handles.radiobutton4,'Value')==1
    %取得m*m
    global m;
    m=get(handles.edit2,'String');
    m=str2double(m);
    global n;
    n=get(handles.edit3,'String');
    n=str2double(n);
    
    global findpicnum;
    findpicnum=get(handles.edit5,'String');
    findpicnum=str2double(findpicnum);
    axes(handles.axes12);
    imshow(uint8(img(:,:,:,findpicnum)));
    
    findpicgray=rgb2gray(uint8(img(:,:,:,findpicnum)));
    maskcolumn=300/m;
    maskrow=300/n;
    findpicgray=imresize(findpicgray,[300,300]);
    findpiclbp=extractLBPFeatures(findpicgray,'CellSize',[maskcolumn maskrow],'Upright',false);

        localbp=[];
    for i=1:440
        currentpic=uint8(img(:,:,:,i));
        currentpicgray=rgb2gray(currentpic);
        currentpicgray=imresize(currentpicgray,[300,300]);
        findpiccurrent=extractLBPFeatures(currentpicgray,'CellSize',[maskcolumn maskrow],'Upright',false);
        localbp=[localbp,sum(abs(findpiclbp-findpiccurrent))];
        [out,idx] = sort(localbp);
    end
    
    global allindex;
    global index;
    global page;
    global number;
    number=out;
    allindex=idx;
    index=1;
    page=1;
    allindex = reshape(allindex,[],1);
    number= reshape(number,[],1);
    display(hObject, eventdata, handles, index, page, allindex,number);
end

%correlogram
if get(handles.radiobutton5,'Value')==1
    
load colorcount.mat colorcount;

    global findpicnum;
    findpicnum=get(handles.edit5,'String');
    findpicnum=str2double(findpicnum);
    axes(handles.axes12);
    imshow(uint8(img(:,:,:,findpicnum)));
    different=[];
    
    for i=1:440
        checkdifferent=0;
        for r=1:9
            for g=1:9
                for b=1:9  
                    for k=1:9
                        checkdifferent=checkdifferent+abs(colorcount(findpicnum,r,g,b,k)-colorcount(i,r,g,b,k));
                    end
                end
            end 
        end
        different=[different,checkdifferent/90000];
    end
    
    [out,idx] = sort(different);

    
    global allindex;
    global index;
    global page;
    global number;
    number=out;
    allindex=idx;
    index=1;
    page=1;
    allindex = reshape(allindex,[],1);
    number= reshape(number,[],1);
    display(hObject, eventdata, handles, index, page, allindex,number);

end

%localbinarypattern RGB
if get(handles.radiobutton6,'Value')==1
    %取得m*m
    global m;
    m=get(handles.edit2,'String');
    m=str2double(m);
    global n;
    n=get(handles.edit3,'String');
    n=str2double(n);
    
    global findpicnum;
    findpicnum=get(handles.edit5,'String');
    findpicnum=str2double(findpicnum);
    axes(handles.axes12);
    imshow(uint8(img(:,:,:,findpicnum)));
    
    findpicgray=uint8(img(:,:,:,findpicnum));
    maskcolumn=300/m;
    maskrow=300/n;
    findpicgray=imresize(findpicgray,[300,300]);
    findpicR=findpicgray(:,:,1);
    findpicG=findpicgray(:,:,2);
    findpicB=findpicgray(:,:,3);
    findpiclbpR=extractLBPFeatures(findpicR,'CellSize',[maskcolumn maskrow],'Upright',false);
    findpiclbpG=extractLBPFeatures(findpicG,'CellSize',[maskcolumn maskrow],'Upright',false);
    findpiclbpB=extractLBPFeatures(findpicB,'CellSize',[maskcolumn maskrow],'Upright',false);
        localbp=[];
    for i=1:440
        currentpic=uint8(img(:,:,:,i));
        %currentpicgray=rgb2gray(currentpic);
        %currentpicgray=imresize(currentpicgray,[300,300]);
        currentpic=imresize(currentpic,[300,300]);
        currentpicR=currentpic(:,:,1);
        currentpicG=currentpic(:,:,2);
        currentpicB=currentpic(:,:,3);
        findpiccurrentR=extractLBPFeatures(currentpicR,'CellSize',[maskcolumn maskrow],'Upright',false);
        findpiccurrentG=extractLBPFeatures(currentpicG,'CellSize',[maskcolumn maskrow],'Upright',false);
        findpiccurrentB=extractLBPFeatures(currentpicB,'CellSize',[maskcolumn maskrow],'Upright',false);
        localbp=[localbp,sum(abs(findpiclbpR-findpiccurrentR)+abs(findpiclbpG-findpiccurrentG)+abs(findpiclbpB-findpiccurrentB))];
        [out,idx] = sort(localbp);
    end
    
    global allindex;
    global index;
    global page;
    global number;
    number=out;
    allindex=idx;
    index=1;
    page=1;
    allindex = reshape(allindex,[],1);
    number= reshape(number,[],1);
    display(hObject, eventdata, handles, index, page, allindex,number);
end

%xception netxception netxception netxception netxception netxception netxception netxception net
if get(handles.radiobutton7,'Value')==1
    
    global findpicnum;
    findpicnum=get(handles.edit5,'String');
    findpicnum=str2double(findpicnum);
    axes(handles.axes12);
    imshow(uint8(img(:,:,:,findpicnum)));
    
    net = xception();
    
    h=waitbar(0,'AI loading...');
  
    net.Layers
    I=uint8(img(:,:,:,findpicnum));
    I=imresize(I,[299 299]);
    [label probability]= classify(net, I);
    [value class]=max(probability);
    deep_rank=[];
    for i=1:440
        I=uint8(img(:,:,:,i));
        I=imresize(I,[299 299]);
        [label probability]= classify(net, I);
        deep_rank(i,:)=probability(class);
        waitbar(i/440,h);
    end
    delete(h);
    deep_rank = reshape(deep_rank,[],1);
    ranking=[];
    for i=1:440
        ranking=[ranking,abs(deep_rank(findpicnum)-deep_rank(i))];
    end
    
    [out,idx] = sort(ranking);
    global allindex;
    global index;
    global page;
    global number;
    number=out;
    allindex=idx;
    index=1;
    page=1;
    allindex = reshape(allindex,[],1);
    number= reshape(number,[],1);
    display(hObject, eventdata, handles, index, page, allindex,number);
end

%VGGnetVGGnetVGGnetVGGnetVGGnetVGGnetVGGnetVGGnetv
if get(handles.radiobutton8,'Value')==1

    global findpicnum;
    findpicnum=get(handles.edit5,'String');
    findpicnum=str2double(findpicnum);
    axes(handles.axes12);
    imshow(uint8(img(:,:,:,findpicnum)));    
    
net = xception();
net.Layers;
f=[];
for i=1:440
    picnow=uint8(img(:,:,:,i));
    sz=net.Layers(1).InputSize;
    picnow=imresize(picnow,[sz(1) sz(2)]);
    layer='block14_sepconv2_point-wise';
    f=[f;activations(net,picnow,layer,'OutputAs','rows')];
end
[y,x]=size(f);
save f.mat f;
load f.mat f;

ranking=[];
% for m=1:440
%     difference=0;
%     for n=1:x
%        difference=difference+abs(f(findpicnum,n)-f(m,n));
%     end
%     ranking=[ranking,difference];
% end

    [out,idx] = sort(ranking);
    global allindex;
    global index;
    global page;
    global number;
    number=out;
    allindex=idx;
    index=1;
    page=1;
    allindex = reshape(allindex,[],1);
    number= reshape(number,[],1);
    display(hObject, eventdata, handles, index, page, allindex,number);

end

%Xception-net featureXception-net featureXception-net featureXception-net featureXception-net feature
if get(handles.radiobutton9,'Value')==1
    
    global findpicnum;
    findpicnum=get(handles.edit5,'String');
    findpicnum=str2double(findpicnum);
    axes(handles.axes12);
    imshow(uint8(img(:,:,:,findpicnum)));    
    h=waitbar(0,'AI loading...');
net=vgg16;
net.Layers;
fx=[];
% for i=1:440
%     picnow=uint8(img(:,:,:,i));
%     sz=net.Layers(1).InputSize;
%     picnow=imresize(picnow,[sz(1) sz(2)]);
%     layer='fc6';
%     fx=[fx;activations(net,picnow,layer,'OutputAs','rows')];
%     waitbar(i/440,h);
% end

delete(h);
save fx.mat fx;
load fx.mat fx;

ranking=[];
for m=1:440
    difference=0;
    for n=1:4096
       difference=difference+abs(fx(findpicnum,n)-fx(m,n));
    end
    ranking=[ranking,difference];
end

    [out,idx] = sort(ranking);
    global allindex;
    global index;
    global page;
    global number;
    number=out;
    allindex=idx;
    index=1;
    page=1;
    allindex = reshape(allindex,[],1);
    number= reshape(number,[],1);
    display(hObject, eventdata, handles, index, page, allindex,number);

end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in pushbutton5.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global page;
global index;
global allindex;
global number;
if page==1
    display(hObject, eventdata, handles, index, page,allindex,number);
else
    page=page-1;
    index=index-10;
    display(hObject, eventdata, handles, index, page, allindex,number);
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global page;
global index;
global allindex;
global number;
if page==37
    display(hObject, eventdata, handles, index, page,allindex,number);
else
    page=page+1;
    index=index+10;
    display(hObject, eventdata, handles, index, page,allindex,number);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
