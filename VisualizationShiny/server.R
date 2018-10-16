#ui.r code

library(devtools) #calls devtools package
library(shiny) #calls shiny package
library(ggplot2) #calls ggplot package
library(googleVis) #calls googleVis package
library(shinydashboard) #calls shinydashboard package
library(DT)

# delete later VisualizationShiny <- read.csv(file = "./data/data.csv")
shinyServer(function(input, output){
  
#  datasetInput <- reactive({
#    switch(input$VisualizationShiny,
#           "InvoiceNumber" = InvoiceNo,
#           "StockCode" = StockCode,
#           "Description" = Description,
#           "Quantity" = Quantity,
#           "InvoiceDate" = InvoiceDate,
#           "UnitPrice" = UnitPrice,
#           "CustomerID" = CustomerID,
#           "Country" = Country
           
#           )
#  })
  # show map using googleVis
  # output$customer <- renderGvis({
  #   gvisGeoChart(VisualizationShiny, "CustomerID", input$selected,
  #                options=list(region="US", displayMode="regions",
  #                             resolution="provinces",
  #                             width="auto", height="auto"))
  #   
  # })
  
  myOptions <- reactive({
    list(
      page=ifelse(input$pageable==TRUE,'enable','disable'),
      #change variables to what makes sense for us
      pageSize=input$pagesize,  #change variables to what makes sense for us
      width = 300
      )
  })
  
  output$customer1 <- renderGvis({
    gvisTable(customer.insights,
              options=myOptions()
              )
    
  })  
  
  output$customermap <-renderGvis({
    gvisGeoChart(customer.map, locationvar="Country", hovervar="totcust",
                 options=list(
                   title = "Number of Customers in Each Country",
                   width = 300
                 ))
    
  })
    
  #end customer info box
#     gvisTable(VisualizationShiny, 
#                           formats=list(CustomerID="" #try customer id in quotes if doesnt work
# # ),
#                           options=list(page='enable'))
    # using width="auto" and height="auto" to
    # automatically adjust the map size
  
 # productdata <- reactive({
#   productplot1 %>%
#      filter(., Country == "input$country")

#productplot1 %>%
#  filter(., Country == "input$country")
  
  output$productplotxx <-renderGvis({
    gvisColumnChart(product.map,
                 options=list(
                   title = "Total Products Sold in Each Country",
                   width=800,
                   height=300
                 ))
    
  })
#used for reactive filter
  # productplot2 <- reactive({
  #   productplot1 %>%
  #     filter(., Country == "input$country") #command tbd
  # })
  # # 
  #    output$productPlot <- renderGvis({
  #     # gvisBarChart(data = productplot2(),
  #      #             x = productplot2()[,month()],
  #      #             y = productplot2()[,Quantity()]
  #     gvisMotionChart(data.frame(productplot2()),
  #                     idvar=data.frame(productplot2()$Quantity),
  #                     timevar=data.frame(productplot2()$month))
  # # output$productPlot <- renderPlot(
  #   productplot2()%>%
  #     ggplot(aes(x=month,y=Quantity)) +
  #       geom_point()
  #   
  })
      # ggplot(productplot2[,productplot2$month()[1]],productplot2[,productplot2$month()[2]],type="b")
      # })
      # 
    
  #  renderGvis({
  #  gvisBarChart(data.frame(productplot2()),
 #                "month",
  #               "Quantity"

  
  # show histogram using googleVis


#xvar = "month",
#yvar = "Quantity"
  
#function(input, output) {
#  output$count <- renderPlot(
#    VisualizationShiny # %>%
#      filter(origin == input$origin & dest == input$dest) %>%
#      group_by(carrier) %>%
#      count() %>%
#      ggplot(aes(x = carrier, y = n)) +
#      geom_col(fill = "lightblue") +
#      ggtitle("Number of flights")
#  )
#}