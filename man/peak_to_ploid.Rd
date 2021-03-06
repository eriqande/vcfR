% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/peak_to_ploid.R
\name{peak_to_ploid}
\alias{peak_to_ploid}
\title{Convert allele balance peaks to ploidy}
\usage{
peak_to_ploid(x)
}
\arguments{
\item{x}{an object produced by \code{freq_peak()}.}
}
\value{
A list consisting of two matrices containing the calls and the distance from expectation (i.e., confidence).
}
\description{
Converts allele balance data produced by \code{freq_peak()} to a copy number by assinging the allele balance data (frequencies) to its closest expected ratio.
}
\details{
Converts allele balance data produced by \code{freq_peak()} to copy number.
See the examples section for a graphical representation of the expectations and the bins around them.
Once a copy number has called a distance from expectation (dfe) is calculated as a form of confidence.
The bins around different copy numbers are of different width, so the dfe is scaled by its respective bin width.
This results in a dfe that is 0 when it is exactly at our expectation (high confidence) and at 1 when it is half way between two expectations (low confidence).
}
\examples{
# Thresholds.
plot(c(0.0, 1), c(0,1), type = "n", xaxt = "n", xlab = "Expectation", ylab = "Allele balance")
myCalls <-  c(1/5, 1/4, 1/3, 1/2, 2/3, 3/4, 4/5)
axis(side = 1, at = myCalls, labels = c('1/5', '1/4', '1/3','1/2', '2/3', '3/4', '4/5'), las=2)
abline(v=myCalls)
abline(v=c(7/40, 9/40, 7/24, 5/12), lty=3, col ="#B22222")
abline(v=c(7/12, 17/24, 31/40, 33/40), lty=3, col ="#B22222")
text(x=7/40, y=0.1, labels = "7/40", srt = 90)
text(x=9/40, y=0.1, labels = "9/40", srt = 90)
text(x=7/24, y=0.1, labels = "7/24", srt = 90)
text(x=5/12, y=0.1, labels = "5/12", srt = 90)
text(x=7/12, y=0.1, labels = "7/12", srt = 90)
text(x=17/24, y=0.1, labels = "17/24", srt = 90)
text(x=31/40, y=0.1, labels = "31/40", srt = 90)
text(x=33/40, y=0.1, labels = "33/40", srt = 90)

# Prepare data and visualize
data(vcfR_example)
gt <- extract.gt(vcf)
# Censor non-heterozygous positions.
hets <- is_het(gt)
is.na(vcf@gt[,-1][!hets]) <- TRUE
# Extract allele depths.
ad <- extract.gt(vcf, element = "AD")
ad1 <- masplit(ad, record = 1)
ad2 <- masplit(ad, record = 2)
freq1 <- ad1/(ad1+ad2)
freq2 <- ad2/(ad1+ad2)
myPeaks1 <- freq_peak(freq1, getPOS(vcf))
# Censor windows with fewer than 20 heterozygous positions
is.na(myPeaks1$peaks[myPeaks1$counts < 20]) <- TRUE
# Convert peaks to ploidy call
peak_to_ploid(myPeaks1)


}
\seealso{
\code{freq_peak}, \code{freq_peak_plot}
}
