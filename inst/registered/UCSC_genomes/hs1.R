GENOME <- "hs1"
ORGANISM <- "Homo sapiens"
ASSEMBLED_MOLECULES <- paste0("chr", c(1:22, "X", "Y", "M"))
CIRC_SEQS <- "chrM"

library(GenomeInfoDb)

.order_seqlevels <- function(seqlevels)
{
    oo <- match(ASSEMBLED_MOLECULES, seqlevels)
    stopifnot(!anyNA(oo))
    oo
}

FETCH_ORDERED_CHROM_SIZES <-
    function(goldenPath.url=getOption("UCSC.goldenPath.url"))
{
    filename <- paste0(GENOME, ".chrom.sizes.txt")
    url <- paste(goldenPath.url, GENOME, "bigZips", filename, sep="/")
    col2class <- c(chrom="character", size="integer")
    chrom_sizes <- GenomeInfoDb:::fetch_table_from_url(url,
                                              colnames=names(col2class),
                                              col2class=col2class)
    oo <- .order_seqlevels(chrom_sizes[ , "chrom"])
    S4Vectors:::extract_data_frame_rows(chrom_sizes, oo)
}

NCBI_LINKER <- list(
    assembly_accession="GCA_009914755.4",
    special_mappings=c(chrM="MT")
)

