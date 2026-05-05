# Figure 7A: In vivo cecal Salmonella load
# Nature Communications format: 90 mm width, 300 DPI

library(ggplot2)

# Simulated data (replace with actual animal trial data)
in_vivo_data <- tibble::tibble(
  Day = rep(c(0, 3, 7, 14, 21), 4),
  Log10_CFU_g = c(
    6.5, 6.4, 6.3, 6.2, 6.1,  # Control
    6.5, 6.0, 5.2, 4.5, 4.3,  # Synergy
    6.5, 6.3, 5.8, 5.5, 5.2,  # Phage mono
    6.5, 6.4, 6.3, 6.2, 6.1   # Probiotic mono
  ),
  Treatment = factor(rep(c("Control", "Synergy", "Phage mono", "Probiotic mono"), each = 5),
                levels = c("Control", "Synergy", "Phage mono", "Probiotic mono"))
)

p7A <- ggplot(in_vivo_data, aes(x = Day, y = Log10_CFU_g, color = Treatment, group = Treatment)) +
  geom_point(size = 3, stroke = 1.5) +
  geom_line(size = 1) +
  scale_color_manual(values = c("#000000", "#E69F00", "#56B4E9", "#999999")) +
  labs(
    x = "Day",
    y = expression(paste("Cecal ", italic("Salmonella"), " load (log"[10], " CFU/g)")),
    title = NULL
  ) +
  theme_classic(base_size = 10) +  # Removed base_family for compatibility
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = c(0.3, 0.8),
    legend.background = element_rect(fill = "white", color = "black"),
    legend.key = element_blank(),
    legend.title = element_blank(),
    axis.text = element_text(size = 9, color = "black"),
    axis.title = element_text(size = 10, color = "black")
  )

ggsave(
  filename = "figure7A_in_vivo.tiff",
  plot = p7A,
  path = "~/github/rujinlong/pr0117-PhageProbioticSynergy/analyses/figures",
  dpi = 300,
  width = 90,
  height = 70,
  units = "mm",
  compression = "lzw"
)

print(p7A)
