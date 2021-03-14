function collatedData(militaryDat, bioDat, epiDat)
    historyScore = militaryHistoryData(militaryDat);
    biomarkerScore = biomarkerData(bioDat);
    epiScore = epigeneticsData(epiDat);

    cellDat = readcell(epiDat);
    names = cellDat(3:end, 2);

    collatedDat = [names, historyScore, biomarkerScore, epiScore];

    curRow = [];
    collatedStrings = [];
    for i = 1:size(collatedDat, 1)
        curRow = collatedDat(i, :);
        curString = strcat(curRow{1}, ';');
        for k = 2:length(curRow)
            curNum = curRow{k};
            curNum = string(curNum);
            curString = strcat(curString, curNum, ';');
        end
        collatedStrings = [collatedStrings; {curString}];
    end
    
    fid = fopen('Veteran Risk Data.txt', 'wt');
    for a = 1:length(collatedStrings)
        printCur = collatedStrings{a};
        printCur = strcat(printCur, '\n');
        fprintf(fid, printCur);
    end
    fclose(fid);
    
    cellHeaders = [{'Names'}, {'Military History Score'}, {'Biomarker Score'}, {'Epigenetics Score'}];
    collatedDat = [cellHeaders; collatedDat];
    writecell(collatedDat, 'Veteran Suicide Risk Data.xlsx');
end

function [historyScore] = militaryHistoryData(dataSheet)
    dataSheetCell = readcell(dataSheet);
    pureData = dataSheetCell(2:end, 3:end);
    pureRowNum = size(pureData, 1);
    historyScore = [];
    for n = 1:pureRowNum
        rowScore = 0;
        for m = 1:9
                if m == 1 
                    switch pureData{n, m}
                        case 'Male'
                            rowScore = rowScore + 3.13;
                        case 'Female'
                            rowScore = rowScore + 1;
                    end
                elseif m == 2
                    switch pureData{n, m}
                        case '17 - 19'
                            rowScore = rowScore + 4.46;
                        case '20 - 24'
                            rowScore = rowScore + 3.62;
                        case '25-29'
                            rowScore = rowScore + 2.57;
                        case '30 - 34'
                            rowScore = rowScore + 2.42;
                        case '35 - 39'
                            rowScore = rowScore + 2.02;
                        case '40+'
                            rowScore = rowScore + 1;
                    end
                elseif m == 3
                    switch pureData{n, m}
                        case 'White'
                            rowScore = rowScore + 1;
                        case 'Black or African American'
                            rowScore = rowScore + 0.69;
                        case 'Asian or Native Hawaiian or Pacific Islander'
                            rowScore = rowScore + 0.95;
                        case 'Native American or Alaskan Native'
                            rowScore = rowScore + 1.18;
                    end
                elseif m == 4
                    switch pureData{n, m}
                        case 'Non-Hispanic'
                            rowScore = rowScore + 1;
                        case 'Hispanic'
                            rowScore = rowScore + 0.70;
                    end
                elseif m == 5
                    switch pureData{n, m}
                        case 'Non-High School Graduate'
                            rowScore = rowScore + 1.71;
                        case 'High School Graduate'
                            rowScore = rowScore + 1.32;
                        case 'Bachelor''s Degree'
                            rowScore = rowScore + 1;
                        case 'Higher Degree'
                            rowScore = rowScore + 0.94;
                    end
                elseif m == 6
                    switch pureData{n, m}
                        case 'Never Married or Single'
                            rowScore = rowScore + 1.21;
                        case 'Married'
                            rowScore = rowScore + 1;
                        case 'Divorced or Separated or Widowed'
                            rowScore = rowScore + 1.43;
                    end
                elseif m == 7
                    switch pureData{n, m}
                        case 'Marine Corps'
                            rowScore = rowScore + 1.55;
                        case 'Army'
                            rowScore = rowScore + 1.48;
                        case 'Navy'
                            rowScore = rowScore + 1.05;
                        case 'Air Force'
                            rowScore = rowScore + 1;
                        case 'Coast Guard'
                            rowScore = rowScore + 1.09;
                    end
                elseif m == 8
                    switch pureData{n, m}
                        case 'Active'
                            rowScore = rowScore + 1.29;
                        case 'Reserve'
                            rowScore = rowScore + 1;
                    end
                elseif m == 9
                    switch pureData{n, m}
                        case 'Less than 2 Years'
                            rowScore = rowScore + 1.26;
                        case 'More than 2 Years'
                            rowScore = rowScore + 1;
                    end
                end
        end
        rowScore = round(rowScore ./ 17.01, 3);
        historyScore = [historyScore; {rowScore}];
    end
end

function [biomarkerScore] = biomarkerData(dataSheet)
    dataSheetCell = readcell(dataSheet);
    pureData = dataSheetCell(3:end, 3:end);
    pureRowNum = size(pureData, 1);
    biomarkerScore = [];
    bioScoreRatings = readcell('Biomarker Importance.xlsx');
    for n = 1:pureRowNum
        rowBioScore = 0;
        for m = 1:28
            if m == 1
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{13, 3};
                end
            elseif m == 2
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{18, 3};
                end
            elseif m == 3
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{16, 3};
                end
            elseif m == 4
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{28, 3};
                end
            elseif m == 5
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{2, 3};
                end
            elseif m == 6
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{17, 3};
                end
            elseif m == 7
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{10, 3};
                end
            elseif m == 8
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{26, 3};
                end
            elseif m == 9
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{15, 3};
                end
            elseif m == 10
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{25, 3};
                end
            elseif m == 11
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{6, 3};
                end
            elseif m == 12
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{3, 3};
                end
            elseif m == 13
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{9, 3};
                end
            elseif m == 14
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{5, 3};
                end
            elseif m == 15
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{4, 3};
                end
            elseif m == 16
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{7, 3};
                end
            elseif m == 17
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{12, 3};
                end
            elseif m == 18
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{8, 3};
                end
            elseif m == 19
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{23, 3};
                end
            elseif m == 20
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{22, 3};
                end
            elseif m == 21
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{14, 3};
                end
            elseif m == 22
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{20, 3};
                end
            elseif m == 23
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{1, 3};
                end
            elseif m == 24
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{19, 3};
                end
            elseif m == 25
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{11, 3};
                end
            elseif m == 26
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{21, 3};
                end
            elseif m == 27
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{24, 3};
                end
            elseif m == 28
                switch pureData{n,m}
                    case 'Yes'
                        rowBioScore = rowBioScore + bioScoreRatings{27, 3};
                end
            end
        end
        rowBioScore = round((rowBioScore ./ bioScoreRatings{29, 3}), 3);
        biomarkerScore = [biomarkerScore; {rowBioScore}];
    end
end

function [epiScore] = epigeneticsData(dataSheet)
    dataSheetCell = readcell(dataSheet);
    pureData = dataSheetCell(3:end, 3:end);
    pureRowNum = size(pureData, 1);
    epiScore = [];
    epiRatings = readcell('SuicideBiomarkers.xlsx');
    for n = 1:pureRowNum
        rowEpiScore = 0;
        for m = 1:44
                switch pureData{n,m}
                    case 'Yes'
                        rowEpiScore = rowEpiScore + epiRatings{m, 2};
                end
        end
        rowEpiScore = round((rowEpiScore ./ epiRatings{45, 2}), 3);
        epiScore = [epiScore; {rowEpiScore}];
    end
end