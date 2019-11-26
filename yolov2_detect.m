function [bbox,score, label] = yolov2_detect(in, th)

% A persistent object yolov2Obj is used to load the YOLOv2ObjectDetector object.
% At the first call to this function, the persistent object is constructed and
% setup. When the function is called subsequent times, the same object is reused 
% to call detection on inputs, thus avoiding reconstructing and reloading the
% network object.

persistent yolov2Obj;

if isempty(yolov2Obj)
    yolov2Obj = coder.loadDeepLearningNetwork('yoloFire3.mat');
end

% pass in input
[bbox,score, label] = yolov2Obj.detect(in,'Threshold',th);
%   Copyright 2019 The MathWorks, Inc.

