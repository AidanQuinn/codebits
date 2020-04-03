# Load libraries
library(scholar)
library(ggplot2)


# Get citation history
cit <- get_citation_history('HRot1M8AAAAJ')

# Get h-index
prof <- get_profile('HRot1M8AAAAJ')

# Make annotation:
annotation <- sprintf(
  "Total Citations: %s \n h-Index: %s \n i10-Index: %s \n%s",
  prof$total_cites,
  prof$h_index,
  prof$i10_index,
  format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z")
  )

# Save path
file_name <- "/Users/Aidan/Dropbox/Public/web/scholar_citations_HRot1M8AAAAJ&hl.png"

# Generate colors vector
cols <- c(rep("gray45", nrow(cit)-1), "gray75")

# Draw plot
png(file_name, width = 1000, height = 500, res = 150)
ggplot(cit, aes(x = year, y = cites)) +
  geom_bar(stat='identity', fill = cols, color = cols) +
  stat_smooth(
    data = cit[-nrow(cit),], # remove current year
    se = F, 
    fullrange=TRUE, # projection for current year
    method = "lm",  # linear model
    formula = y ~ poly(x, 2), # use x^2 for linear modeling
    linetype = 3, color = "midnightblue"
  ) +
  theme_light() + 
  theme(
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank()) +
  scale_y_continuous(limits = c(0, NA), expand = c(0, T)) +
  xlab('') +
  ylab('Number of Citations') +
  annotate(
    'text', label = annotation, 
    x=-Inf, y=Inf, vjust=1.1, hjust=-0.05, size=3, color='darkgrey')
dev.off()
