require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
car <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="select * from CARS where CO2_G_MI_ is not null"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_in2422', PASS='orcl_in2422', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', verbose = TRUE))))

ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title="PLOT 1") +
  labs(x="RATED HORSEPOWER", y="CO2 G MI", color="VEHICLE TYPE") +
  layer(data=car , 
        mapping=aes(x=as.numeric(RATED_HORSEPOWER), y=as.numeric(CO2_G_MI_), color = as.character(VEHICLE_TYPE)), 
        stat="identity",
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.0, height=0)
  ) 