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

\name{wccFindDyadParam}
\alias{wccFindDyadParam}

\title{wccFindDyadParam}

\description{
This function calculates the difference between surrogate and actual dyads for a range of possible arguments to wccCalc and wccPeakPick.
}

\usage{
wccFindDyadParam(inArray1=NA, inArray2=NA, wMaxvector=c(50), tMaxvector=c(50),
    wIncvector=c(1), tIncvector=c(1), Lsizevector=c(8), pspanvector=c(.25), type="Max",
    nSurrogates=NA, samplespersecond=1, windcross=TRUE, embedD=9)
}

\arguments{
\item{inArray1}{An N by T matrix of numeric values representing N timeseries of length T. These are the first set of time series which are randomly paired with timeseries from \sQuote{inArray2} and on which windowed cross correlation are calculated.  Must be of the same order N by T as \sQuote{inArray2}}
\item{inArray2}{An N by T matrix of numeric values representing N timeseries of length T. These are the second set of time series which are randomly paired with timeseries from \sQuote{inArray1} and on which windowed cross correlation are calculated.  Must be of the same order N by T as \sQuote{inArray1}}
\item{wMaxvector}{A numeric vector indicating the number of samples in a window for each test.  This must be greater or equal to 5 samples.  It is recommended that wMax be greater than 15.}
\item{tMaxvector}{A numeric vector indicating the maximum number of samples to lag the windows for each test.  The cross correlation is calculated for windows that are time lagged against each other, allowing for processes than require some time to evolve.  For instance, if the two time series are from motion capture of two individuals conversing with one another, the speaker's movements are likely to occur prior to the responses of the listener.  tMax should be set to be greater than the number of samples that represents the maximum time lag that is likely to occur. }
\item{wIncvector}{A numeric vector indicating the number of samples incremented between successive windows for each test.  This is most often set to 1.  If the sample rate is very high and the time series is long, wInc may be increased.  However, wccCalc's maximum sensitivity to nonstationary change in the time series occurs when wInc is 1.}
\item{tIncvector}{A numeric vector indicating the number of samples incremented between successive lags for each test.  This is most often set to 1.  If the sample rate is high and the maximum lag is high then tInc may be increased.  However, wccCalc's maximum sensitivity to changes in lags occurs when the tInc is set to 1.}
\item{Lsizevector}{A numeric vector indicating  the width required for a peak to be identified by wccPeakPick for each test.  An Lsize that is too small may find spurious peaks that are just noise, whereas an Lsize that is too large may miss actual peaks.}
\item{pspanvector}{A numeric vector indicating the amount of smoothing applied by the loess function within wccPeakPick for each test.}
\item{type}{A character string vector indicating whether a maximum, \sQuote{Max}, or minimum, \sQuote{Min}, should be detected by wccPeakPick for each test.}
\item{nSurrogates}{A numeric indicating the number of surrogates to generate.  If there are N timeseries in \sQuote{inArray1}, then the maximum number of unique surrogates that can be generated is N*(N-1)/2}
\item{samplespersecond}{A numeric indicating the sampling rate of the time series.  This will determine the units of the first derivative aggregate statistics.}
\item{windcross}{The default \sQuote{TRUE} then the compiled windcross binary is used.  If \sQuote{FALSE} then native R code is used to calculate the windowed cross correlation.  The native R code is the most portable across many machines and operating systems.  However, the compiled windcross library runs about 2 times faster, so if the binary is available on your machine, it is recommended.}
\item{embedD}{A numeric indicating the embedding dimension passed to GLLAEmbed to calculate derivatives of the peak picking lag timeseries.  The default (9) will provide a medium smooth at the cost of some loss of resolution in the timing of jumps in the second derivative.  The smallest legal value is 5, which provides less smooth and the best time resolution.  If your sampling rate is low, then a smaller value of embedD is useful, while if your sampling rate is high, a larger value of embedD will provide better noise rejection by smoothing.}
}

\details{
This function iterates over vectors of possible argument values given to wccCalc and wccPeakPick and for each combination of arguments returns the difference between the surrogate dyadic null hypothesis distribution and the true distribution of each of the statistics returned by wccAggregate.  The intended use of this function is to explore the space of possible argument values using a small hold-out set of dyadic timeseries in order to inform the selection of parameters to use for the full dataset.  It is recommended that between 10 and 20 dyadic timeseries be used as the hold-out set to input to this function.  The two arguments \sQuote{wMax} and \sQuote{tMax} are the most commonly explored parameters since they tend to have the most impact on results.  

Results from combinations of parameters can be visualized using the wccHeatmap function.  For any particular hypothesis, one or more aggregate statistics may be most useful in assessing the association between a dyad's time series.  Thus, one may wish to focus in on that statistic when choosing parameters.  wccHeatmapwMaxtMax allows the visualization of the effect of selecting the  \sQuote{wMax} and \sQuote{tMax} parameters on the statistic of interest.

Note that surrogate and real dyads will be calculated for all combinations of parameters in the argument vectors.  Thus, if one wishes to explore the effects of 8 choices of  \sQuote{wMax} and  8 choices of \sQuote{tMax}, a total of 64 surrogate analyses will be run.  If one uses a holdout set of 20 and asks for 100 surrogates, this will result in 7,680 calls to wccAggregate.  Such an exploration of the parameter space can take hours to run.  Add to that 2 choices of \sQuote{wInc} and  2 choices of \sQuote{tInc} and you may be talking about days of processing.  Be careful when choosing how many combinations to explore at one time.
}
    
\value{
Returns a dataframe with the columns from the wccAggregate function and the following extra columns.  For each aggregated statistic a column giving the proportion of real dyads' statistics are greater than .95 or less than .05 of the values in the surrogate statistics distribution.  For each aggregated statistic a column giving the two sided Kolmogorov-Smirnov Test probabilities comparing the surrogate and real dyad distributions.  For each aggregated statistic a column giving the quantile difference scores for the difference between the surrogate distribution and the real distribution of dyadic timeseries.  Each row in the dataframe presents the results from one combination of chosen parameters.
}

\references{
Boker, S. M., Rotondo, J. L., Xu, M., & King, K. (2002). Windowed cross-correlation and peak picking for the analysis of variability in the association between behavioral time series. Psychological methods, 7(3), 338.

William J. Conover (1971).  Practical Nonparametric Statistics. New York: John Wiley & Sons.  Pages 295-301 (one-sample Kolmogorov test), 309-314 (two-sample Smirnov test).
}

\seealso{
\link{wccHeatmap} visualizes results selected aggregated statistics for combinations of parameters.  See \link{wccAggregate} for definitions of the statistics that are compared between surrogate and real dyads.  See \link{ks.test} for definition of the two tailed Kolmogorov-Smirnov Test.
}

\examples{
\donttest{
# Create two arrays of timeseries with dyadic dependence
array1 <- matrix(NA, nrow=10, ncol=500)
array2 <- matrix(NA, nrow=10, ncol=500)
for(i in 1:10) {
    array1[i,] <- sin(c(1:500)/runif(1, min=5, max=20)) + rnorm(500, mean=0, sd=.5)
    array2[i,] <- array1[i,] + rnorm(500, mean=0, sd=.5)
}
# Select parameters to explore
wMaxVec <- c(50,100)
tMaxVec <- c(25,50)
wccFindDyadParam(inArray1=array1, inArray2=array2, wMaxvector=wMaxVec, tMaxvector=tMaxVec,
    nSurrogates=30, samplespersecond=1, windcross=TRUE)
}
}
