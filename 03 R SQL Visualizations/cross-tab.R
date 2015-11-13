require("jsonlite") 
require("RCurl")
require(ggplot2)
require(dplyr)
car <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="Select VEHICLE_MANUFACTURER_NAME,VEHICLE_TYPE, round(sum(ENGINE_EFFICIENCY)) as SUM_ENGINE_EFFICIENCY, CASE 
When ENGINE_EFFICIENCY <= 90 THEN \\\'LOW\\\'
                                                 ELSE \\\'HIGH\\\'
                                                 END
                                                 CALCULATED_EFFICIENCY
                                                 FROM(select VEHICLE_MANUFACTURER_NAME,VEHICLE_TYPE, sum(RATED_HORSEPOWER)/sum(TEST_VEH_DISPLACEMENT_L_) as ENGINE_EFFICIENCY
                                                 from CARS 
                                                 where CO2_G_MI_ is not null 
                                                 GROUP BY VEHICLE_MANUFACTURER_NAME,VEHICLE_TYPE)
                                                 GROUP BY VEHICLE_MANUFACTURER_NAME,VEHICLE_TYPE,ENGINE_EFFICIENCY
                                                 Order by VEHICLE_MANUFACTURER_NAME ;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_in2422', PASS='orcl_in2422', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=90), verbose = TRUE))); 
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Crosstab of Data') +
  labs(x=paste("VEHICLE_TYPE"), y=paste("VEHICLE_MANUFACTURER_NAME")) +
  layer(data=car, 
        mapping=aes(x=VEHICLE_TYPE, y=VEHICLE_MANUFACTURER_NAME, label=SUM_ENGINE_EFFICIENCY), 
        stat="identity", 
        stat_params=list(), 
        geom="text", 
        position=position_identity()
  ) +
  layer(data=car, 
        mapping=aes(x=VEHICLE_TYPE, y=VEHICLE_MANUFACTURER_NAME, fill=CALCULATED_EFFICIENCY), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  )