function [labelCord, label] = objectlabel(I, algObj)
    BW = extract_red(I);
    BW_C = imclose(BW, strel('disk', 15));
    BW_f = imfill(BW_C, 'holes');
    s = regionprops(BW_f);
    maxVals = arrayfun(@(struct)max(struct.Area(:)),s);
    [~, i] = max(maxVals);
    labelCord = s(i).BoundingBox;
    labelCord(1)= int16(labelCord(1));
    labelCord(2)= int16(labelCord(2));
    labelCord(3)= int16(labelCord(3));
    labelCord(4)= int16(labelCord(4));
    label = 'Fire';
    [a, b] = size(I);
    if labelCord(1) + labelCord(4) > a
        labelCord(4) = a - labelCord(1);
    end
    if labelCord(2) + labelCord(3) > b
        labelCord(3) = b - labelCord(2);
    end
%   Copyright 2019 The MathWorks, Inc.
