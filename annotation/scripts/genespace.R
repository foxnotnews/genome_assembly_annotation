library(ggplot2)
library(GENESPACE)

gpar <- init_genespace(wd = "result/genespace", path2mcscanx = "MCScanX")

out <- run_genespace(gsParam = gpar, overwrite = T)