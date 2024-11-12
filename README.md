# EU_Housing_Prices
R code to reproduce the EU chart on "The Rise of Housing Prices Across the EU"

I was able to replicate, in R, the chart on house prices evolution in the EU seen in the [European Parliament site](https://www.europarl.europa.eu/topics/en/article/20241014STO24542/rising-housing-costs-in-the-eu-the-facts-infographics) with data from [Eurostat](https://ec.europa.eu/eurostat/databrowser/view/prc_hpi_a/default/table?lang=en)

![plot](https://github.com/user-attachments/assets/8e81202e-c039-4e9b-8222-aedaf9eb903b)

Code is fully usable and would be great to fine-tune it by including or modifying the following elements to make it more appealing:
1) Place the country initials below rather than above (I tried with `strip.position = "bottom"` but it didn't) that will reduce the size of the chart as countries like Hungary has a very high index and that's is the plot limit while the others show a blank gap between their names and the plot.
2) Add the flags to each country (apparently, the R package `ggflags` does it but needs to link code countries with ISO specs, I think, which was it a mess).
3) Rather that enlarging the EU27 average, which I suspect it has been done at inphographic level with any other software I boxed the EU27 average in a red box, that was the best way I figured out.
4) As the last year is 2023, the final circle is partially omitted, I do not know whether is a matter of x-axis specs or plot limits but it would be great to show the full circle.
5) Adding the x-axis tick marks was impossible

Please, feel free to use the code and play around with it to overcome these issues. You can open an issue and share your comments. Any help is welcome!!
