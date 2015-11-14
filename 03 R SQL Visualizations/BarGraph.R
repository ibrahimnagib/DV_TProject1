require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
car <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="select * from CARS"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_in2422', PASS='orcl_in2422', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON' ), verbose = TRUE))); 


# df <- car %>% group_by(VEHICLE_MANUFACTURER_NAME) %>% summarize(sum(RATED_HORSEPOWER)) 
# df1 <- df %>% ungroup %>% group_by(CLARITY) %>% summarize(WINDOW_AVG_PRICE=mean(AVG_PRICE))
# df <- inner_join(df, df1, by="CLARITY")
#View(df)

ggplot() +
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title="Horsepower by Manufactuer") +
  labs(x="Vehicle Manufacturer Name", y="Rated Horsepower") +
  theme(axis.text.x = element_text(angle=90,hjust=1)) +
#  geom_text(data=car, label=(RATED_HORSEPOWER), angle=90) + # Still can't get the labels right
  layer(data=car , 
    mapping=aes(x=as.character(VEHICLE_MANUFACTURER_NAME), y=as.numeric(RATED_HORSEPOWER)), # Find out how to aggregate the horsepower by manufacturer name into averages
    stat="identity", 
    stat_params=list(), 
    geom="bar",
    geom_params=list(colour="blue")
  ) +
#   layer (data=car,
#     mapping=aes(x=VEHICLE_MANUFACTURER_NAME, y=RATED_HORSEPOWER, label=RATED_HORSEPOWER),
#     stat="identity",
#     stat_params=list(colour="black"),
#     geom="text",
#     geom_params=list(angle=90),
#   )+
  layer(data=df, 
        mapping=aes(yintercept = 32808, label="Average"), 
        geom="hline",
        geom_params=list(colour="red")
  ) 
  

