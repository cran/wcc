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

\name{wccCalc}
\alias{wccCalc}

\title{Windowed Cross Correlation function}

\description{
This function calculates a windowed cross correlation matrix from two time series
}

\usage{
wccCalc(inSeries1, inSeries2, wMax=50, tMax=50, wInc=1, tInc=1, windcross=TRUE) 
}

\arguments{
\item{inSeries1}{A vector of numeric values. This is the first time series on which windowed cross correlation is calculated.  Must be of the same length as inSeries2}
\item{inSeries2}{A vector of numeric values. This is the second time series on which windowed cross correlation is calculated. Must be of the same length as inSeries1}
\item{wMax}{A numeric indicating the number of samples in a window.  This must be greater or equal to 5 samples.  It is recommended that wMax be greater than 15.}
\item{tMax}{The maximum number of samples to lag the windows.  The cross correlation is calculated for windows that are time lagged against each other, allowing for processes than require some time to evolve.  For instance, if the two time series are from motion capture of two individuals conversing with one another, the speaker's movements are likely to occur prior to the responses of the listener.  tMax should be set to be greater than the number of samples that represents the maximum time lag that is likely to occur. }
\item{wInc}{The number of samples incremented between successive windows.  This is most often set to 1.  If the sample rate is very high and the time series is long, wInc may be increased.  However, wccCalc's maximum sensitivity to nonstationary change in the time series occurs when wInc is 1.}
\item{tInc}{The number of samples incremented between successive lags.  This is most often set to 1.  If the sample rate is high and the maximum lag is high then tInc may be increased.  However, wccCalc's maximum sensitivity to changes in lags occurs when the tInc is set to 1.}
\item{windcross}{The default windcross=TRUE then the compiled windcross binary is used.  If windcross=FALSE uses native R code to calculate the windowed cross correlation. The native R code is the most portable across many machines and operating systems.  However, the compiled windcross library runs about 2 times faster, so if the binary is available on your machine, it is recommended.}
}

\details{
wccCalc calculates cross correlations between windows, i.e., sampled sections of two time series.  These windows are sampled at time lagged intervals from one another so that the association between the time series can be estimated even though the time lag of maximum association between the two time series may be itself time varying.  For instance, when two individuals converse, their body motions may be associated such that the leader and follower take turns as speaker and listener.  This same kind of nonstationary association has been observed between many physiological time series.  At any particular elapsed time, the maximum correlation closest to a lag of zero (whether a positive or negative lag) is taken to be the lagged offset between the two time series.  For series that have oscillatory structure (such as head nodding in conversation)  the maximum correlation closest to a lag of zero can be interpreted as the phase lag between the series.
}
    
\value{
Returns an N x P matrix of numeric values of cross correlations, where N is the number of windows calculated and P is 2*floor(tMax/tInc) + 1, the total lagged values of each window.  Each row of the returned matrix represents one elapsed time at sample t.  The number of columns is always odd and the center column, C = floor(tMax/tInc) + 1 is the cross correlation for zero lag for the windows from inSeries1 and inSeries2 whose last element occurs at elapsed sample t.  Columns l less than the center column contain the cross correlation values for the windows where the window from inSeries1 occurs l*tInc samples earlier than the window from inSeries2 whose last value is at sample t.  Similarly columns l greater than the center column contain cross corrlations for windows where the window from inSeries2 occurs l*tInc samples earlier than the window from inSeries1 whose last value is at sample t.
}

\references{
Boker, S. M., Rotondo, J. L., Xu, M., & King, K. (2002). Windowed cross-correlation and peak picking for the analysis of variability in the association between behavioral time series. Psychological methods, 7(3), 338.}


\examples{
#Calculate windowed cross correlation between two time series
tSeries1 <- sin(c(1:1000)/10) + rnorm(1000, mean=0, sd=.5)
tSeries2 <- sin(c(1:1000)/15) + rnorm(1000, mean=0, sd=.5)
wccCalcOut <- wccCalc(inSeries1=tSeries1, inSeries2=tSeries2, wMax=50, tMax=50, wInc=1,
     tInc=1, windcross=FALSE)

}
