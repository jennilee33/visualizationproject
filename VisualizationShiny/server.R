#ui.r code

library(devtools) #calls devtools package
library(shiny) #calls shiny package
library(ggplot2) #calls ggplot package
library(googleVis) #calls googleVis package
library(shinydashboard) #calls shinydashboard package
library(DT)

# delete later VisualizationShiny <- read.csv(file = "./data/data.csv")
shinyServer(function(input, output, session){
  
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
  
  # myOptions <- reactive({
  #   list(
  #     page=ifelse(input$pageable==TRUE,'enable','disable'),
  #     #change variables to what makes sense for us
  #     pageSize=input$pagesize,  #change variables to what makes sense for us
  #     width = 800
  #     )
  # })
  # 
  # output$customer1 <- renderGvis({
  #   gvisTable(customer.insights,
  #             options=myOptions()
  # #             )
  #   
  # })  
  # 
  output$customermap <-renderGvis({
    gvisGeoChart(customer.map, locationvar="Country", colorvar = "TotalCustomers",
                 options=list(
                   title = "Number of Customers in Each Country",
                   colorAxis = "{colors: ['lightblue','blue','darkblue','darkgrey','black']}",
                   width = 1200,
                   height = 600
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
  
  # output$productplotxx <-renderGvis({
  #   gvisColumnChart(product.map,
  #                options=list(
  #                  title = "Total Products Sold in Each Country",
  #                  width=800,
  #                  height=250
  #                ))
  #   
  # })
  # # output$productplotxx2 <-renderGvis({
  #   gvisColumnChart(product.map%>%
  #                     filter(., Country != "United Kingdom"),
  #                   options=list(
  #                     title = "Total Products Sold in Countries Outside the UK",
  #                     width=800,
  #                     height=250
  #                   ))
  #   
  # })
  
  
  #test for new reactive plot
  
  observe({
    updateCheckboxGroupInput(
      session, 'checkGroup', choices = product.map$Country,
      selected = if (input$bar) 
        product.map$Country
    )
  })
  
  output$productplotchecks <- renderPlot(
    product.map %>%
      filter(Country %in% input$checkGroup) %>%
      ggplot(aes(x = Country, y = totquant)) +
      geom_col(fill = "light blue") +
      ggtitle("Total Products Sold by Country") +
      theme(
        axis.text.x = element_text(
              size=8, 
              angle=45),
        axis.text.y = element_text(
              face="bold",
              size=8)
      )+
      labs(
        x = "Country",
        y= "Total Products Sold"
        
      )
    
  )
  # output$productplotchecks <- renderPlot({
  #   
  #   input$checkGroup
  #   
  # })
  
  # output$productplotnew <- renderPlot({
  #   
  #   product.map %>%
  #     filter(continent %in% input$ContinentSelect)
  #   x = Country,
  #   y = totquant,
  #   type = bar,
  #   layout(title = "Total Products Sold by Country",
  #          xaxis = list(title = "Total Products"),
  #          yaxis = list(title = "Country"))
  #   
  #   
  # })
  #end test new reactive plot
  
  output$table <- DT::renderDataTable({
    datatable(VisualizationShiny, 
              rownames=FALSE)
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