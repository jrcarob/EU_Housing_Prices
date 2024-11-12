# (c) Eurostat House Pricing data
# Data: https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Housing_price_statistics_-_house_price_index
# R Code: José Caro
# https://github.com/jrcarob

# Load required libraries
library(tidyverse)
library(scales)
library(ggtext)

# Create the data frame as xlsx file is not clean
housing_data <- data.frame(
  year = rep(2015:2023, 28),
  country = rep(c("EU27", "BE", "BG", "CZ", "DK", "DE", "EE", "IE", "ES", "FR", "HR", "IT", "CY", "LV",
                  "LT",	"LU",	"HU", "MT",	"NL",	"AT",	"PL",	"PT",	"RO",	"SI",	"SK",	"FI",	"SE", "NO"), each = 9),
  index = c(
    # EU27
    100.00, 104.32, 109.31, 114.82, 120.40, 127.13, 137.83, 148.54, 148.07,
    # BE
    100.00, 102.33, 105.95, 109.15, 113.23, 118.09, 125.96, 132.93, 136.05,
    # BG
    100.00, 107.02, 116.30, 123.96, 131.42, 137.41, 149.33, 169.92, 186.67,
    # CZ
    100.00, 107.20, 119.70, 130.00, 141.90, 153.90, 184.20, 215.30, 211.70,
    # DK
    100.00, 104.58, 109.77, 114.70, 117.22, 122.31, 136.57, 143.15, 137.10,
    # DE
    100.10, 107.50, 114.10, 121.70, 128.70, 138.70, 154.80, 162.60, 148.80,
    # EE
    100.00, 104.75, 110.51, 117.07, 125.27, 132.79, 152.78, 186.76, 197.72,
    # IE
    100.00, 107.46, 119.14, 131.33, 134.41, 134.82, 145.98, 163.96, 168.99,
    # ES
    100.00, 104.62, 111.10, 118.58, 124.71, 127.50, 132.19, 141.98, 147.69,
    # FR
    100.00, 101.04, 104.24, 107.29, 110.86, 116.62, 123.98, 131.82, 131.26,
    # HR
    100.00, 100.89, 104.75, 111.14, 121.10, 130.38, 139.91, 160.69, 179.88,
    # IT
    100.00, 100.30, 99.20, 98.60, 98.50, 100.40, 103.00, 106.90, 108.30,
    # CY
    100.00, 100.27, 102.52, 104.32, 108.20, 107.98, 104.33, 107.13, 110.27,
    # LV
    100.00, 108.49, 118.01, 129.30, 140.88, 145.77, 161.65, 184.01, 190.89,
    # LT
    100.00, 105.40, 114.80, 123.18, 131.61, 141.18, 163.84, 195.05, 214.20,
    # LU
    100.00, 106.01, 111.96, 119.86, 131.99, 151.12, 172.15, 188.60, 171.48,
    # HU
    100.00, 113.38, 127.24, 145.50, 170.17, 178.58, 208.04, 254.52, 272.54,
    #MT
    100.00, 105.45, 111.03, 117.45, 124.65, 128.86, 135.44, 144.45, 153.42,
    #NL
    100.00, 105.29, 113.81, 124.40, 133.38, 144.07, 164.94, 186.84, 183.26,
    #AT
    100.00, 106.71, 112.14, 118.83, 125.97, 135.52, 151.02, 168.49, 163.68,
    #PL	
    100.00, 101.86, 105.78, 112.74, 122.52, 135.36, 147.77, 165.21, 179.78,
    #PT	
    100.00, 107.12, 117.02, 129.03, 141.88, 154.33, 168.84, 190.17, 205.76,
    #RO	
    100.00, 105.95, 112.36, 118.62, 122.69, 128.44, 134.09, 143.70, 148.43,
    #SI
    100.00, 103.25, 111.79, 121.55, 129.69, 135.66, 151.32, 173.65, 186.22,
    #SK	
    100.00, 106.67, 112.91, 121.32, 132.40, 145.02, 154.27, 175.41, 175.08,
    #FI	
    100.00, 101.29, 102.39, 103.34, 103.77, 105.60, 110.45, 111.75, 105.41,
    #SE 
    100.00, 108.24, 115.43, 114.35, 117.19, 122.11, 134.46, 139.25, 131.93,
    #NO
    100.00, 107.88, 113.75, 115.53, 120.18, 126.11, 137.66, 145.71, 147.63
  )
)

# Calculate percentage changes for labels
changes <- housing_data %>%
  group_by(country) %>%
  summarize(
    change = round((last(index) - first(index)), 1),
    label = sprintf("+%.1f%%", change)
  )

# Create the visualization
ggplot(housing_data, aes(x = year, y = index, group = country)) +
  # Add light blue background
  geom_rect(
    aes(xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf),
    fill = "NA", #F5F9FF"
    #inherit.aes = FALSE
    subset(housing_data, country %in% "EU27"), colour = "red"
  ) +
  # Add area fill under the line
  geom_ribbon(
    aes(ymin = 0, ymax = index),
    fill = "#0000F7", #E6EEF7
    alpha = 0.1
  ) +
  # Add the line
  geom_line(color = "#004494", linewidth = 1) +
  # Add end points
  geom_point(
    data = housing_data %>% filter(year == 2023),
    color = "#004494",
    size = 3,
    shape = 21,
    fill = "white",
    stroke = 1.5
  ) +
  # Add percentage change labels
  geom_label(
    data = changes,
    aes(x = 2023, y = 50, label = label),
    fill = "#004494",
    color = "white",
    label.size = 0,
    hjust = 1,
    vjust = 0.5,
    size = 3
  ) +
  # Add red dotted line at 200
  geom_hline(
    yintercept = 200,
    color = "#CC0000",
    linetype = "dotted",
    linewidth = 0.5
  ) +
  facet_wrap(~country, scales = "free", ncol = 6) + 
  scale_y_continuous(
    limits = c(0, 275),
    breaks = seq(0, 200, 50),
    minor_breaks = NULL
  ) +
  scale_x_continuous(
    limits = c(2015, 2023),
    #breaks = seq(2015, 2023, by = 1)
    breaks = c(2015, 2023)#,
    #labels = c("2015", "2023")
  ) +
  labs(
    title = "The rise of housing prices across the EU",
    subtitle = "2015-2023",
    caption = "Author: José Caro (12th, nov'2024) - @caroisallin\n Source: Eurostat House Price Index.\n Code: https://github.com/jrcarob/EU_Housing_Prices",
    x = NULL,
    y = NULL
  ) +
  theme(plot.caption.position = "plot",
        plot.caption = element_text(hjust = 0)) +
  theme_minimal() +
  theme(
    plot.title = element_text(
      family = "Roboto Condensed",
      size = 30,
      face = "bold",
      hjust = 0.5,
      margin = margin(b = 10)
    ),
    plot.subtitle = element_text(
      family = "Roboto Condensed",
      size = 20,
      hjust = 0.5,
      margin = margin(b = 20)
    ),
    strip.text = element_text(size = 10, face = "bold"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    axis.text = element_text(size = 8),
    panel.spacing = unit(1.5, "lines"),
    plot.margin = margin(t = 20, r = 20, b = 20, l = 20)
  )
