% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runmergeTumorIntoXGeo.R
\name{runMergeTumorIntoX,NanoStringGeoMxSet-method}
\alias{runMergeTumorIntoX,NanoStringGeoMxSet-method}
\title{Run mergeTumorIntoX on a NanostringGeomxSet object}
\usage{
\S4method{runMergeTumorIntoX}{NanoStringGeoMxSet}(object, X, K = 10, pure_tumor_ids = NULL, norm_elt = NULL)
}
\arguments{
\item{object}{A NanostringGeomxSet object.}

\item{X}{The training matrix}

\item{K}{the number of clusters to fit}

\item{pure_tumor_ids}{Vector identifying columns of norm that are pure tumor.
Can be indices, logicals or column names.}

\item{norm_elt}{norm data element in assayData}
}
\value{
an updated X matrix with new columns, "tumor.1", "tumor.2", ...
}
\description{
A wrapper for applying mergeTumorIntoX to a NanostringGeomxSet object.
}
\examples{
library(GeomxTools)
datadir <- system.file("extdata", "DSP_NGS_Example_Data", package = "GeomxTools")
demoData <- readRDS(file.path(datadir, "/demoData.rds"))

demoData <- shiftCountsOne(demoData)
target_demoData <- aggregateCounts(demoData)

target_demoData <- normalize(target_demoData, "quant")

data(safeTME)
tumor.ids <- as.logical(sample(x = c("TRUE","FALSE"), size = 88, replace = TRUE))
safeTME.with.tumor <- runMergeTumorIntoX(object = target_demoData,
                                         X = safeTME,
                                         K = 3,
                                         pure_tumor_ids = tumor.ids,
                                         norm_elt = "exprs_norm")

}
