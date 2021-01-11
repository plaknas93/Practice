
#CENTRAL LIMIT THEOREM IN ACTION

data=read.csv(file='D:/RWorks/Practice/central_limit_test_file.csv')
head(data)

data$score

library(ggplot2)
ggplot(data,aes(x=score))+geom_histogram(fill='cornflower blue',col='red')+theme_bw()+xlab('Scores')+ylab('Frequency')+ggtitle('Class Score Distribution')+geom_vline(xintercept = mean(data$Score_1), color = "red", linetype = "longdash")

p_mean=mean(data$score)
p_mean
p_std=sd(data$score)
p_std
s=0
m=0
sam_var=0
for(i in 1:1000)
{
  ss=sample(data$score,30)
  sam_var[i]=sd(ss)
  s[i]=list(ss)
}

s
s[1]
sam1= as.numeric(unlist(s[1]))
sam1
mean(sam1)

names(s)=1:1000
s1500=data.frame(s)
s1500
head(s1500)
write.csv(s50,file='central_limit_thm.csv')

samdist=colMeans(s1500)


samdist 
plot(samdist)

hist(samdist)
hist(sam_var)
library(ggplot2)
x=1:10000
d=data.frame(x,samdist)

ggplot(data = d,aes(x=samdist))+geom_histogram()
ggplot(data = d,aes(x=samdist))+geom_freqpoly()


mean(samdist)
p_mean
sd(samdist)
p_std
p_std/(30^(0.5))

p_std
n=1:1000
sem=p_std/(n^0.5)
data=data.frame(n,sem)
data
ggplot(data=data,aes(x=n,y=sem))+geom_line()+ggtitle("Standard Error with n")+xlab("n") 
#scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

