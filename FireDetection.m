% This class defines a template for creating a custom label automation
% algorithm, to be used in labeling apps (Image Labeler, Video Labeler and
% Ground Truth Labeler). To access help for this class, enter the following
% at the MATLAB command prompt:
%
%   >> doc vision.labeler.AutomationAlgorithm
%
% For reference, see the following AutomationAlgorithm class:
%
%   >> edit vision.labeler.PeopleDetectorACF
%
%
% To use this algorithm from within the Image Labeler, Video Labeler or
% Ground Truth Labeler App, follow the steps outlined below and complete
% the class definition. Then, save this file as follows.
%
%  Create a +vision/+labeler folder within a folder that is already
%  on the MATLAB path. For example, if the folder /local/MyProject is on
%  the MATLAB path, then create a +vision/+labeler folder hierarchy as
%  follows:
%
%           projectFolder = fullfile('local','MyProject');
%           automationFolder = fullfile('+vision','+labeler');
%
%           mkdir(projectFolder, automationFolder)
%
%  Saving the file to the package directory is required to use your custom
%  algorithm from within the labeling apps. You can add a folder to the
%  path using the ADDPATH function.
%
%  Save your algorithm class in the folder created in step 1. Refresh the
%  algorithm list from within the app to start using your custom algorithm.

classdef FireDetection < vision.labeler.AutomationAlgorithm
    
    %----------------------------------------------------------------------
    % Step 1: Define required properties describing the algorithm. This
    %         includes Name, Description and UserDirections.
    properties(Constant)
        
        % Name: Give a name for your algorithm.
        Name = 'Fire Detection';
        
        % Description: Provide a one-line description for your algorithm.
        Description = 'This is a automatic fire labeling algorithm.';
        
        % UserDirections: Provide a set of directions that are displayed
        %                 when this algorithm is invoked. The directions
        %                 are to be provided as a cell array of character
        %                 vectors, with each element of the cell array
        %                 representing a step in the list of directions.
        UserDirections = {...
            ['Automation algorithms are a way to automate manual labeling ' ...
            'tasks. This AutomationAlgorithm is a template for creating ' ...
            'user-defined automation algorithms. Below are typical steps' ...
            'involved in running an automation algorithm.'], ...
            ['Run: Press RUN to run the automation algorithm. '], ...
            ['Review and Modify: Review automated labels over the interval ', ...
            'using playback controls. Modify/delete/add ROIs that were not ' ...
            'satisfactorily automated at this stage. If the results are ' ...
            'satisfactory, click Accept to accept the automated labels.'], ...
            ['Change Settings and Rerun: If automated results are not ' ...
            'satisfactory, you can try to re-run the algorithm with ' ...
            'different settings. In order to do so, click Undo Run to undo ' ...
            'current automation run, click Settings and make changes to ' ...
            'Settings, and press Run again.'], ...
            ['Accept/Cancel: If results of automation are satisfactory, ' ...
            'click Accept to accept all automated labels and return to ' ...
            'manual labeling. If results of automation are not ' ...
            'satisfactory, click Cancel to return to manual labeling ' ...
            'without saving automated labels.']};
    end
    
    %---------------------------------------------------------------------
    % Step 2: Define properties to be used during the algorithm. These are
    % user-defined properties that can be defined to manage algorithm
    % execution.
    properties
        
        AllCategories = {'background'};
        FireName
        count
        
        
    end
    
    %----------------------------------------------------------------------
    % Step 3: Define methods used for setting up the algorithm.
    methods
        % a) Use the checkLabelDefinition method to specify whether a label
        %    definition is valid for the algorithm. This method is invoked
        %    on each ROI and Scene label definition to determine whether it
        %    is valid for the specified algorithm.
        %
        %    For more help,
        %    >> doc vision.labeler.AutomationAlgorithm.checkLabelDefinition
        %
        function isValid = checkLabelDefinition(algObj, labelDef)
            
            disp(['Executing checkLabelDefinition on label definition "' labelDef.Name '"'])
            
            if (strcmpi(labelDef.Name, 'Fire') && labelDef.Type == labelType.Rectangle)
                isValid = true;
                algObj.FireName = labelDef.Name;
                algObj.AllCategories{end+1} = labelDef.Name;
            end 
            
            
            
        end
        
        % b) Use the checkSetup method to specify whether the algorithm is
        %    ready and all required set up is complete. If your algorithm
        %    requires no setup from the user, remove this method.
        %
        %    For more help,
        %    >> doc vision.labeler.AutomationAlgorithm.checkSetup
        %
        function isReady = checkSetup(algObj)
            
            isReady = ~isempty(algObj);          

            
            
        end
        
        % c) Optionally, specify what settings the algorithm requires by
        %    implementing the settingsDialog method. This method is invoked
        %    when the user clicks the Settings button. If your algorithm
        %    requires no settings, remove this method.
        %
        %    For more help,
        %    >> doc vision.labeler.AutomationAlgorithm.settingsDialog
        %
        function settingsDialog(algObj)
            
            disp('Executing settingsDialog')
            
            %--------------------------------------------------------------
            % Place your code here
            %--------------------------------------------------------------
            
            
        end
    end
    
    %----------------------------------------------------------------------
    % Step 4: Specify algorithm execution. This controls what happens when
    %         the user presses RUN. Algorithm execution proceeds by first
    %         executing initialize on the first frame, followed by run on
    %         every frame, and terminate on the last frame.
    methods
        % a) Specify the initialize method to initialize the state of your
        %    algorithm. If your algorithm requires no initialization,
        %    remove this method.
        %
        %    For more help,
        %    >> doc vision.labeler.AutomationAlgorithm.initialize
        %
        function initialize(algObj, I)
            
            disp('Executing initialize on the first image frame')
            
            %--------------------------------------------------------------
            % Place your code here
            %--------------------------------------------------------------
            
            
            
        end
        
        % b) Specify the run method to process an image frame and execute
        %    the algorithm. Algorithm execution begins at the first image
        %    frame and is invoked on all image frames selected for
        %    automation. Algorithm execution can produce a set of labels
        %    which are to be returned in autoLabels.
        %
        %    For more help,
        %    >> doc vision.labeler.AutomationAlgorithm.run
        %
        function autoLabels = run(algObj, I)
            
            disp('Executing run on image frame')
            
            [labelCord, label] = objectlabel(I, algObj);                
            autoLabels.Name = char(label);
            autoLabels.Type = labelType('Rectangle');
            autoLabels.Position = labelCord;               
            algObj.count = algObj.count+1;
            
        end
        
        % c) Specify the terminate method to clean up state of the executed
        %    algorithm. If your method requires no clean up, remove this
        %    method.
        %
        %    For more help,
        %    >> doc vision.labeler.AutomationAlgorithm.terminate
        %
        function terminate(algObj)
            
            disp('Executing terminate')
            
            %--------------------------------------------------------------
            % Place your code here
            %--------------------------------------------------------------
            
            
            
        end
    end
end