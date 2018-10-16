#ui.r code

library(devtools) #calls devtools package
library(shiny) #calls shiny package
library(ggplot2) #calls ggplot package
library(googleVis) #calls googleVis package
library(shinydashboard) #calls shinydashboard package
library(DT)
#uses data from https://www.kaggle.com/carrie1/ecommerce-data/version/1
#remember to set working directory to project file to test
# delete laterVisualizationShiny <- read.csv(file = "./data/data.csv") #reads UK customer data file
# Customer and Product Dashboard for a UK Retailer

shinyUI(

dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(
    sidebarUserPanel("Customer and Product Dashboard" #***make an enter to show whole line
                     ), 
    sidebarMenu(
      menuItem("Customer", tabName = "customer", icon = icon("fal fa-users")), 
      menuItem("Product", tabName = "product", icon = icon("fas fa-map"))) 
  ),
    dashboardBody(
      tabItems(
      #start of customer tab
      tabItem(
        tabName = "customer",
        
        #within customer tab start of icons
        
        # infoBoxes with fill=FALSE
        fluidRow(
          # A static infoBox
          infoBox("Total Customers", 
                  length(unique(VisualizationShiny$CustomerID)), 
                  icon = icon("fas fa-list-ol")), #need to add  icon
          infoBox("Average Customer Spend", #need to add icon
                  round(mean(customer.spend$custspend),digits=0), 
                  icon = icon("far fa-credit-card")),
          infoBox("Average Number of Invoices per Customer", #need to add icon
                  round(mean(customer.invoices$invoices),digits=0), 
                  icon = icon("fas fa-list-alt"))
        ),
        #within customer tab end of icons
        

      #               ),
      headerPanel("Customer Trends"),
      
      mainPanel(
        
          
          checkboxInput(
          inputId = "pageable", 
          label = "Pageable"),
        
          conditionalPanel("input.pageable==true",
              numericInput(inputId = "pagesize",
              label = "Customers per Page",10)
          )    
          ,
      
          fluidRow(
            box(htmlOutput("customer1")
                )
            ,
            box(htmlOutput("customermap")
                )
          )
          
          
          )
      
      
      

      
      ),
      #end of customer tab
      
      #start of product tab
      tabItem(
        tabName = "product",
        fluidRow(
          # A static infoBox
          infoBox("Total Products", 
                  length(unique(VisualizationShiny$StockCode)), 
                  icon = icon("fas fa-expand")), 
          infoBox("Average Product Revenue", 
                  round(mean(product.revenue$prodspend),digits=0), 
                  icon = icon("fas fa-signal")),
          infoBox("Average Number of Products Purchased per Customer", #not unique products, can be repeats #need to add icon
                  round(mean(customer.products$totcustprod),digits=0), 
                  icon = icon("fas fa-object-ungroup"))
          
        ),
        headerPanel("Product Trends"),
        
        #start product test plot
        
        #fluid page for dynamically adapting to screens of different resolutions.
       # sidebarPanel(
       #   selectizeInput("country",
       #               label = "Country",
       #               choices = unique(productplot1$Country))
       #   ),
         
      mainPanel(
        fluidRow(
          # box(htmlOutput("productPlot")),
          box(
            htmlOutput("productplotxx"),
            width=800,height=400)
        
        )
      )   
    )
  )
)
)
)

#fluidRow(
#  box(htmlOutput("customer1"),
#      width = 2000
#      plotOutput(outputId = "productPlot")))
#head(VisualizationShiny)
#fluidPage(
#  titlePanel("Customer Data"),
#  sidebarLayout(
#    sidebarPanel(
#      selectizeInput(inputId = "origin",
#                     label = "Departure airport",
#                     choices = unique(flights$origin)),
#      selectizeInput(inputId = "dest",
#                     label = "Arrival airport",
#                     choices = unique(flights$dest))
#    ),
#    mainPanel(plotOutput("count"))
#  )
#)