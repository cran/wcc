%
%   Copyright 2001-2026 by the individuals mentioned in the source code history
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
% 
%        http://www.apache.org/licenses/LICENSE-2.0
% 
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.

\name{wccPlot}
\alias{wccPlot}

\title{wccPlot}

\description{
This function plots a Windowed Cross Correlation heatmap.
}

\usage{
wccPlot(inSeries1=NA, inSeries2=NA, startwindow=1, endwindow=200, wMax=50, tMax=50, 
    wInc=1, tInc=1, Lsize=8, pspan=.25, type="Max", samplespersecond=1, windcross=TRUE) 
}

\arguments{
\item{inSeries1}{A vector of numeric values. This is the first time series on which windowed cross correlation is calculated.  Must be of the same length as inSeries2}
\item{inSeries2}{A vector of numeric values. This is the second time series on which windowed cross correlation is calculated. Must be of the same length as inSeries1}
\item{startwindow}{A numeric value specifying the first window to plot.  Windows are plotted as vertical stripes in the heatmap and the elapsed time of this window is wMax + tMax + (startwindow * wInc / samplespersecond)}
\item{endwindow}{A numeric value specifying the last window to plot.}
\item{wMax}{A numeric indicating the number of samples in a window.  This must be greater or equal to 5 samples.  It is recommended that wMax be greater than 15.}
\item{tMax}{The maximum number of samples to lag the windows.  The cross correlation is calculated for windows that are time lagged against each other, allowing for processes than require some time to evolve.  For instance, if the two time series are from motion capture of two individuals conversing with one another, the speaker's movements are likely to occur prior to the responses of the listener.  tMax should be set to be greater than the number of samples that represents the maximum time lag that is likely to occur. }
\item{wInc}{The number of samples incremented between successive windows.  This is most often set to 1.  If the sample rate is very high and the time series is long, wInc may be increased.  However, wccCalc's maximum sensitivity to nonstationary change in the time series occurs when wInc is 1.}
\item{tInc}{The number of samples incremented between successive lags.  This is most often set to 1.  If the sample rate is high and the maximum lag is high then tInc may be increased.  However, wccCalc's maximum sensitivity to changes in lags occurs when the tInc is set to 1.}
\item{Lsize}{An integer specifying the width required for a peak to be identified by wccPeakPick.  An Lsize that is too small may find spurious peaks that are just noise, whereas an Lsize that is too large may miss actual peaks.}
\item{pspan}{A numeric specifying the amount of smoothing applied by the loess function within wccPeakPick.}
\item{type}{A character string indicating whether a maximum, \sQuote{Max}, or minimum, \sQuote{Min}, should be detected by wccPeakPick.}
\item{samplespersecond}{A numeric indicating the sampling rate of the time series.  This will determine the units of the first derivative aggregate statistics.}
\item{windcross}{The default \sQuote{TRUE} then the compiled windcross binary is used.  If \sQuote{FALSE} then native R code is used to calculate the windowed cross correlation.  The native R code is the most portable across many machines and operating systems.  However, the compiled windcross library runs about 2 times faster, so if the binary is available on your machine, it is recommended.}
}

\details{
This function runs wccCalc and wccPeakPick using the arguments passed in and plots a heatmap of a selected section of windows.  The vertical axis is labeled with the lags in the units of seconds.  Each calculated window is plotted as a vertical slice of the heat map and correlations near 1 are plotted in yellow and correlations near -1 are plotted in red.  Lags of inSeries1 are plotted as positive and lags of inSeries2 are plotted as negative lags.  The horizontal black line in the middle of the plot represents a lag of zero.  The result of wccPeakPick is overlayed as a black line that traces the peak correlation closest to a lag of zero.  The horizontal axis is labeled with the elapsed time to the right edge of two windows when they are at zero lag.  

It is recommended that the  plot includes no more than 1000 windows since if a large number of windows are plotted, the resulting heatmap will overwrite one window with the next window.  
}
    
\value{
Returns nothing.
}

\references{
Boker, S. M., Rotondo, J. L., Xu, M., & King, K. (2002). Windowed cross-correlation and peak picking for the analysis of variability in the association between behavioral time series. Psychological methods, 7(3), 338.}

\seealso{
\link{wccCalc} and \link{wccPeakPick} for the calculation of the wccCalc matrix and wccPeakPick timeseries that are used by this function. 
}

\examples{
#Create a windowed cross correlation plot for two simulated time series with a phase offset
tSeries1 <- sin(c(1:1000)/10) + rnorm(1000, mean=0, sd=.5)
tSeries2 <- sin(1+c(1:1000)/10) + rnorm(1000, mean=0, sd=.5)
wccPlot(inSeries1=tSeries1, inSeries2=tSeries2, startwindow=1, endwindow=500, 
    wMax=100, tMax=100, wInc=1, tInc=1, Lsize=8, pspan=.25, type="Max", 
    samplespersecond=10)
    

}
