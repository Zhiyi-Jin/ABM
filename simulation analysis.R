library(ggplot2)

getwd()
setwd()

####
#(1)the effect of social influence on the rate of purchase 
dt <- read.csv("experiment-table.csv",
               skip = 6, stringsAsFactors = FALSE)

colnames(dt) <- c("run", "marketing.effort", "social.influence.coef", "network.type", "product.quality", 
                  "social.influence", "greener%", "number.people", "step", "last.tick")
str(dt)

# overall effect
ggplot(dt, aes(x = social.influence, y = last.tick)) +
  geom_boxplot() + 
  labs(title = "Fig.1 Time to 100% purchase", 
        x = "Social influence",
        y = "Ticks") +
  theme_bw()
quartz.save("1.png")

# based on different network types
dt1 <- dt[dt$social.influence == "true" & dt$marketing.effort == 0.4 & dt$social.influence.coef == 0.5, ]
ggplot(dt1, aes(x = network.type, y = last.tick)) +
  geom_boxplot() + 
  theme_bw() + 
  labs(title = "Fig.2 Time to 100% purchase", 
       x = "Types of network", 
       y = "Ticks", 
       subtitle = "(Social influence T, Marketing effort 0.4, Coefficient of social influence 0.5)")
quartz.save("2.png")

####
# (2) the effect of marketing effort
dt2 <- dt[dt$social.influence.coef == 0.5,]
ggplot(dt2, aes(x = marketing.effort, y = last.tick, color = social.influence)) +
  geom_line() + 
  labs(title  = "Fig.3 Time to 100% purchase", 
       subtitle = "(Coefficient of social influence 0.5)",
       x = "Level of marketing effort",
       y = "Ticks",
       color = "Social Influence") +
  theme_bw()
quartz.save("3.png")

####
# (3) the effect of coefficient of social influence
dt3 <- dt[dt$social.influence == "true" & dt$marketing.effort == 0.4,]
ggplot(dt3, aes(x = as.factor(social.influence.coef), y = last.tick)) +
  geom_boxplot() + 
  labs(title = "Fig.4 Time to 100% purchase", 
       x = "Coefficient of Social influence",
       y = "Ticks",
       subtitle = "(Marketing effort 0.4, Social influence T)") +
  theme_bw()
quartz.save("4.png")

dt4 <- dt[dt$social.influence == "true",]
ggplot(dt4, aes(x = as.factor(social.influence.coef), y = last.tick, color = as.factor(marketing.effort))) +
  geom_boxplot() + 
  labs(title = "Fig.5 Time to 100% purchase", 
       x = "Coefficient of Social influence",
       y = "Ticks",
       subtitle = "(Social influence T)",
       color = "Marketing effort") +
  theme_bw() 
quartz.save("5.png")

