% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runspatialdecon.R
\name{runspatialdecon,NanoStringGeoMxSet-method}
\alias{runspatialdecon,NanoStringGeoMxSet-method}
\title{Run spatialdecon on a NanostringGeomxSet object}
\usage{
\S4method{runspatialdecon}{NanoStringGeoMxSet}(
  object,
  X = NULL,
  norm_elt = NULL,
  raw_elt = NULL,
  wts = NULL,
  resid_thresh = 3,
  lower_thresh = 0.5,
  align_genes = TRUE,
  is_pure_tumor = NULL,
  n_tumor_clusters = 10,
  cell_counts = NULL,
  cellmerges = NULL,
  maxit = 1000
)
}
\arguments{
\item{object}{A NanostringGeomxSet object.}

\item{X}{Cell profile matrix. If NULL, the safeTME matrix is used.}

\item{norm_elt}{normalized data element in assayData}

\item{raw_elt}{raw data element in assayData}

\item{wts}{Optional, a matrix of weights.}

\item{resid_thresh}{A scalar, sets a threshold on how extreme individual data
points' values
can be (in log2 units) before getting flagged as outliers and set to NA.}

\item{lower_thresh}{A scalar. Before log2-scale residuals are calculated,
both observed and fitted
values get thresholded up to this value. Prevents log2-scale residuals from
becoming extreme in
points near zero.}

\item{align_genes}{Logical. If TRUE, then Y, X, bg, and wts are row-aligned
by shared genes.}

\item{is_pure_tumor}{A logical vector denoting whether each AOI consists of
pure tumor. If specified,
then the algorithm will derive a tumor expression profile and merge it with
the immune profiles matrix.}

\item{n_tumor_clusters}{Number of tumor-specific columns to merge into the
cell profile matrix.
 Has an impact only when is_pure_tumor argument is used to indicate pure
  tumor AOIs.
 Takes this many clusters from the pure-tumor AOI data and gets the average
 expression profile in each cluster.  Default 10.}

\item{cell_counts}{Number of cells estimated to be within each sample. If
provided alongside norm_factors,
 then the algorithm will additionally output cell abundance esimtates on the
 scale of cell counts.}

\item{cellmerges}{A list object holding the mapping from beta's cell names to
combined cell names. If left
NULL, then defaults to a mapping of granular immune cell definitions to
 broader categories.}

\item{maxit}{Maximum number of iterations. Default 1000.}
}
\value{
if not given cellmerges and cell_counts, a valid GeoMx S4 object
including the following items
 \itemize{
   \item In pData
   \itemize{
      \item beta: matrix of cell abundance estimates, cells in rows and
               observations in columns
      \item p: matrix of p-values for H0: beta == 0
      \item t: matrix of t-statistics for H0: beta == 0
      \item se: matrix of standard errors of beta values
      \item prop_of_all: rescaling of beta to sum to 1 in each observation
      \item prop_of_nontumor: rescaling of beta to sum to 1 in each observation,
                           excluding tumor abundance estimates
      \item sigmas: covariance matrices of each observation's beta estimates
     }
   \item In assayData
   \itemize{
      \item yhat: a matrix of fitted values
      \item resids: a matrix of residuals from the model fit.
                 (log2(pmax(y, lower_thresh)) - log2(pmax(xb, lower_thresh))).
   }
   \item In experimentData
   \itemize{
      \item SpatialDeconMatrix: the cell profile matrix used in the decon fit.
   }
}


if given cellmerges, the valid GeoMx S4 object will additionally include
the following items
 \itemize{
   \item In pData
   \itemize{
      \item beta.granular: cell abundances prior to combining closely-related
                        cell types
      \item sigma.granular: sigmas prior to combining closely-related cell types
   }
}

if given cell_counts, the valid GeoMx S4 object will additionally include
 the following items
 \itemize{
 \item In pData
   \itemize{
      \item cell.counts: beta rescaled to estimate cell numbers, based on
                      prop_of_all and nuclei count
   }
}

if given both cellmerges and cell_counts, the valid GeoMx S4 object will
 additionally include the following items
 \itemize{
 \item In pData
   \itemize{
      \item cell.counts.granular: cell.counts prior to combining closely-related
                               cell types
   }
}
}
\description{
A wrapper for applying spatialdecon to a NanostringGeomxSet object.
}
\examples{

library(GeomxTools)
datadir <- system.file("extdata", "DSP_NGS_Example_Data", package = "GeomxTools")
demoData <- readRDS(file.path(datadir, "/demoData.rds"))

demoData <- shiftCountsOne(demoData)
target_demoData <- aggregateCounts(demoData)

target_demoData <- normalize(target_demoData, "quant")

demoData <- runspatialdecon(object = target_demoData, 
                            norm_elt = "exprs_norm",
                            raw_elt = "exprs")

}
