# ------- Version 0.3.1 ------- 

2026-04-09  Steven Boker    <smb3u@virginia.edu>

    1. wccPlot.R:
        a. call wccCalc and wccPeakPick from within the function rather than loading data from disk.
        b. Change the arguments list to match the arguments to wccAggregate.
        c. Remove the pdffile argument and always plot to the current device.
        d. Change default to windcross=TRUE
        d. Add argument error checking.
        e. Add a legend.
    
    2. wccAggregate.R:
        a. Remove the option to save the result of wccCalc and wccPeakPick to disk.
        b. Remove argument savefile
        c. Add argument embedD=9
        d. Change defaults to samplespersecond=1 and windcross=TRUE
        e. Add an aggregation of the 2nd derivative of the peakpicking lag timeseries.
        f. Add "d2lagMean", "d2lagVar" to wccAggNames

    3. wccFindDyadParam.R:
        a. Change defaults to samplespersecond=1 and windcross=TRUE
        b. Add argument embedD=9
        c. Change call to wccAggregate to include embedD
        d. Add "d2lagMeanKS", "d2lagVaKSr", "d2lagMeanQdiff", "d2lagVarQdiff" to wccTestNames
        e. Calculate values for "d2lagMeanKS", "d2lagVaKSr", "d2lagMeanQdiff", and "d2lagVarQdiff" 
    
    4. wccSurrogateDyads.R:
        a. Change defaults to windcross=TRUE
        c. Add argument embedD=9
        d. Change call to wccAggregate to include embedD
        
    5. wccCalc.R:
        a. Change defaults to windcross=TRUE
    
# ------- Version 0.3.0 ------- 

2026-04-03  Steven Boker    <smb3u@virginia.edu>

    1. windcross.c
        a. Rewrote to directly connect to R.
    2. wccCalc.R
        a. Added call to windcross.

