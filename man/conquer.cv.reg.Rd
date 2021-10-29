% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/smqr.R
\name{conquer.cv.reg}
\alias{conquer.cv.reg}
\title{Cross-Validated Penalized Convolution Smoothed Quantile Regression}
\usage{
conquer.cv.reg(
  X,
  Y,
  lambdaSeq = NULL,
  tau = 0.5,
  kernel = c("Gaussian", "logistic", "uniform", "parabolic", "triangular"),
  h = 0,
  penalty = c("lasso", "scad", "mcp"),
  kfolds = 5,
  numLambda = 50,
  para = NULL,
  epsilon = 0.001,
  iteMax = 500,
  phi0 = 0.01,
  gamma = 1.2,
  iteTight = 3
)
}
\arguments{
\item{X}{A \eqn{n} by \eqn{p} design matrix. Each row is a vector of observation with \eqn{p} covariates.}

\item{Y}{An \eqn{n}-dimensional response vector.}

\item{lambdaSeq}{(\strong{optional}) A sequence of candidate regularization parameters. If unspecified, the sequence will be generated by a simulated pivotal quantity approach proposed by Belloni and Chernozhukov (2011).}

\item{tau}{(\strong{optional}) Quantile level (between 0 and 1). Default is 0.5.}

\item{kernel}{(\strong{optional}) A character string specifying the choice of kernel function. Default is "Gaussian". Choices are "Gaussian", "logistic", "uniform", "parabolic" and "triangular".}

\item{h}{(\strong{optional}) The bandwidth parameter for kernel smoothing. Default is \eqn{max{0.5 * (log(p) / n)^(1/4), 0.05}}.}

\item{penalty}{(\strong{optional}) A character string specifying the penalty. Default is "lasso". Choices are "lasso", "scad" or "mcp".}

\item{kfolds}{(\strong{optional}) Number of folds for cross-validation. Default is 5.}

\item{numLambda}{(\strong{optional}) Number of \eqn{lambda} values for cross-validation if \code{lambdaSeq} is unspeficied. Default is 50.}

\item{para}{(\strong{optional}) A constant parameter for "scad" and "mcp". Do not need to specify if the penalty is lasso. The default values are 3.7 for "scad" and 3 for "mcp".}

\item{epsilon}{(\strong{optional}) A tolerance level for the stopping rule. The iteration will stop when the maximum magnitude of the change of coefficient updates is less than \code{epsilon}. Default is 0.001.}

\item{iteMax}{(\strong{optional}) Maximum number of iterations. Default is 500.}

\item{phi0}{(\strong{optional}) The initial quadratic coefficient parameter in the local adaptive majorize-minimize algorithm. Default is 0.01.}

\item{gamma}{(\strong{optional}) The adaptive search parameter (greater than 1) in the local adaptive majorize-minimize algorithm. Default is 1.2.}

\item{iteTight}{(\strong{optional}) Maximum number of tightening iterations in the iteratively reweighted l_1-penalized algorithm. Do not need to specify if the penalty is lasso. Default is 3.}
}
\value{
An object containing the following items will be returned:
\describe{
\item{\code{coeff}}{A \eqn{(p + 1)} vector of estimated coefficients, including the intercept.}
\item{\code{lambda}}{Regularization parameter selected by cross-validation.}
\item{\code{bandwidth}}{Bandwidth value.}
\item{\code{tau}}{Quantile level.}
\item{\code{kernel}}{Kernel function.}
\item{\code{penalty}}{Penalty type.}
\item{\code{n}}{Sample size.}
\item{\code{p}}{Number of covariates.}
}
}
\description{
Fit sparse quantile regression models via regularized conquer methods with "lasso", "scad" and "mcp" penalties. The regularization parameter \eqn{\lambda} is selected by cross-validation.
}
\examples{
n = 100; p = 100; s = 3
beta = c(rep(1.5, s), rep(0, p - s))
X = matrix(rnorm(n * p), n, p)
Y = X \%*\% beta + rt(n, 2)

## Cross-validated regularized conquer with lasso penalty at tau = 0.8
fit.lasso = conquer.cv.reg(X, Y, tau = 0.8, kernel = "Gaussian", penalty = "lasso")
beta.lasso = fit.lasso$coeff

#' ## Cross-validated regularized conquer with scad penalty at tau = 0.8
fit.scad = conquer.cv.reg(X, Y,tau = 0.8, kernel = "Gaussian", penalty = "scad")
beta.scad = fit.scad$coeff
}
\references{
Belloni, A. and Chernozhukov, V. (2011). l_1 penalized quantile regression in high-dimensional sparse models. Ann. Statist. 39 82-130.

Fan, J., Liu, H., Sun, Q. and Zhang, T. (2018). I-LAMM for sparse learning: Simultaneous control of algorithmic complexity and statistical error. Ann. Statist. 46 814-841.

Koenker, R. and Bassett, G. (1978). Regression quantiles. Econometrica 46 33-50.

Tan, K. M., Wang, L. and Zhou, W.-X. (2021). High-dimensional quantile regression: convolution smoothing and concave regularization. J. Roy. Statist. Soc. Ser. B, to appear.
}
\seealso{
See \code{\link{conquer.reg}} for regularized quantile regression with a prescribed \eqn{lambda}.
}
\author{
Xuming He <xmhe@umich.edu>, Xiaoou Pan <xip024@ucsd.edu>, Kean Ming Tan <keanming@umich.edu>, and Wen-Xin Zhou <wez243@ucsd.edu>
}