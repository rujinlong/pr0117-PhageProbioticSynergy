# Figure 3A: In vitro time-kill kinetics
# Nature Communications format: 90 mm width, 300 DPI, Arial/Helvetica font

library(ggplot2)
library(readr)

# Simulated data (replace with actual experimental data)
time_kill_data <- tibble::tibble(
  Time_h = rep(c(0, 2, 4, 8, 12, 24), 3),
  Log10_CFU_mL = c(
    6.0, 5.8, 5.5, 4.2, 3.0, 2.8,  # Synergy
    6.0, 5.9, 5.7, 4.8, 4.2, 3.2,  # Phage mono
    6.0, 6.0, 5.9, 5.8, 5.8, 5.6   # Probiotic mono
  ),
  Treatment = factor(rep(c("Synergy", "Phage mono", "Probiotic mono"), each = 6),
                levels = c("Synergy", "Phage mono", "Probiotic mono"))
)

# Create the plot
p3A <- ggplot(time_kill_data, aes(x = Time_h, y = Log10_CFU_mL, color = Treatment, shape = Treatment)) +
  geom_point(size = 3, stroke = 1.5) +
  geom_line(size = 1) +
  scale_color_manual(values = c("#E69F00", "#56B4E9", "#999999")) +
  scale_shape_manual(values = c(16, 17, 15)) +
  labs(
    x = "Time (hours)",
    y = expression(paste("Pathogen load (log"[10], " CFU/mL)")),
    title = NULL
  ) +
  theme_classic(base_size = 10) +  # Removed base_family for compatibility
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = c(0.7, 0.8),
    legend.background = element_rect(fill = "white", color = "black"),
    legend.key = element_blank(),
    legend.title = element_blank(),
    axis.text = element_text(size = 9, color = "black"),
    axis.title = element_text(size = 10, color = "black")
  )

# Save as TIFF (Nature Communications requirement: 300 DPI)
ggsave(
  filename = "figure3A_time_kill.tiff",
  plot = p3A,
  path = "~/github/rujinlong/pr0117-PhageProbioticSynergy/analyses/figures",
  dpi = 300,
  width = 90,  # 90 mm for single column
  height = 70, # Adjust as needed
  units = "mm",
  compression = "lzw"
)

print(p3A)
