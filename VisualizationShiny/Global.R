#global.r code

library(data.table)
library(dplyr)
library(datasets)
VisualizationShiny <- fread(file = "./data/data.csv") #reads UK retailer data

#determines summary of customer spend OVERALL not per invoice
customer.spend = 
  VisualizationShiny %>%
    mutate(., spend = Quantity*UnitPrice) %>%
    filter(., InvoiceNo > 0) %>% #removes any AP
    group_by(., CustomerID) %>%
    summarise(., custspend=sum(spend)) %>%
    filter(., custspend > 0)
#head(customer.spend)

#determines count of invoices purchased per customer
customer.invoices = 
  VisualizationShiny %>%
  group_by(., CustomerID) %>%
  summarise(., invoices = n()) #sums all products for each customer
#summary(customer.invoices)

#determines products purchased per customer
customer.products = 
  VisualizationShiny %>%
    group_by(., CustomerID) %>%
    summarise(., totcustprod = sum(Quantity)) #sums all products for each customer
#summary(customer.products)

#determines product revenue for each unique product
product.revenue = 
  VisualizationShiny %>%
  mutate(., spend = Quantity*UnitPrice) %>%
  filter(., InvoiceNo > 0) %>% #removes any AP
  group_by(., StockCode) %>%
  summarise(., prodspend=sum(spend)) %>%
  filter(., prodspend > 0)
#head(product.revenue)

#for interactive table on customer page
customer.insights = 
    VisualizationShiny %>%
  mutate(., TotalSpend = Quantity*UnitPrice) %>%
  group_by(., CustomerID, Country) %>%
  summarise(., Invoices = n())
#head(customer.insights)

#productplot - counts number of products sold on each day
productplot1=
  VisualizationShiny %>%
  mutate(., month = substring(InvoiceDate,1,2)) %>% #takes month from Date
  transmute(., #InvoiceNo = InvoiceNo, 
          #  InvoiceDate = InvoiceDate, 
            Quantity = Quantity,  #do not count here
            Country = Country, 
          month = month)
#  group_by(., Country)%>%
 # summarise(., productsum=sum(Quantity))
#head(productplot1)
#class(productplot1$month)
#class(productplot1$Quantity)
#class(productplot1$Country)

#determines country backup plot
customer.map = 
  VisualizationShiny %>%
  group_by(., Country,CustomerID) %>%
  summarise(., totcust = length(CustomerID)) #sums all products for each customer
#summary(customer.products)
head(customer.map)

#determines country backup plot
product.map = 
  VisualizationShiny %>%
  group_by(., Country) %>%
  summarise(., totquant = sum(Quantity)) #sums all products for each customer
#summary(customer.products)
