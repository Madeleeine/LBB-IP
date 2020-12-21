server <- function(input,output){
  output$plot_p1 <- renderPlotly({
    p1 <-full_data_cleaned%>% 
      filter(LOCATION==input$input_1) %>% 
      filter(SUBJECT==input$input_2) %>% 
      ggplot(aes(x=TIME,y=Value))+geom_line()+theme_minimal()
    ggplotly(p1)
  })
  output$plot_p2 <- renderPlotly({
    p2 <-full_data_meat_cleaned %>% 
      filter(LOCATION==input$input_3) %>% 
      filter(SUBJECT==input$input_4) %>% 
      ggplot(aes(x=TIME,y=Value))+geom_line()+theme_minimal()
    ggplotly(p2)})
  output$plot_p3 <- renderPlotly({
    p3<-iso_yes_full %>%  
      filter(TIME==input$input_5) %>% 
      filter(SUBJECT==input$input_6)%>% 
      top_n(10,Value) %>% 
      arrange(desc(Value)) %>% 
      ggplot(aes(x=Value,y=reorder(LOCATION,Value),fill=LOCATION))+geom_col(show.legend = FALSE)+theme_classic()+
      labs(x="Thousand Tonnes",y="Country")
    ggplotly(p3)})
  output$plot_p4 <- renderPlotly({
    p4<-iso_yes_meat_full%>%  
      filter(TIME==input$input_8) %>% 
      filter(SUBJECT==input$input_7)%>% 
      top_n(10,Value) %>% 
      arrange(desc(Value)) %>% 
      ggplot(aes(x=Value,y=reorder(LOCATION,Value),fill=LOCATION))+geom_col(show.legend = FALSE)+theme_classic()+
      labs(x="Thousand Tonnes",y="Country")
    ggplotly(p4)})
  output$plot_p5<-renderLeaflet({
    df %>% 
      filter(SUBJECT==input$input_9)%>%
      filter(TIME==input$input_14) %>% 
      leaflet() %>% 
      addTiles() %>% 
      addMarkers() %>% 
      addCircleMarkers(radius=5,color=~pal_crop(Value),label=~paste0(LOCATION,"\n",":",Value,"\n","Thousand Tonnes")) %>% 
      addLegend(title="Crop Produced",pal=pal_crop,values=c(min(iso_yes_full$Value):max(iso_yes_full$Value)),position="bottomright")
  })
  output$plot_p6<-renderLeaflet({
    df_1 %>% 
      filter(SUBJECT==input$input_10) %>% 
      filter(TIME==input$input_11) %>% 
      leaflet()%>% 
      addTiles()%>% 
      addMarkers() %>% 
      addCircleMarkers(radius=5,color=~pal_meat(Value),label=~paste0(LOCATION,"\n",":",Value,"\n","Thousand Tonnes")) %>% 
      addLegend(title="Meat Consumed",pal=pal_meat,values=c(min(iso_yes_meat_full$Value):max(iso_yes_meat_full$Value)),position="bottomright")
  })
  output$plot_p7<-renderPlotly({p7<-iso_yes_full %>%  
    filter(TIME==input$input_12) %>% 
    ggplot(aes(x=SUBJECT,y=Value,fill=SUBJECT))+
    geom_boxplot(outlier.shape = NA)+theme_minimal()+labs(x="Crop",y="Thousand Tonnes")+
    theme(legend.position = "none")+scale_fill_brewer(palette="Set2")
  ggplotly(p7)
  
  })
  
  output$plot_p8<-renderPlotly({p8<-iso_yes_meat_full %>% 
    filter(TIME==input$input_13) %>% 
    ggplot(aes(x=SUBJECT,y=Value,fill=SUBJECT))+
    geom_boxplot(outlier.shape = NA)+theme_minimal()+labs(x="Crop",y="Thousand Tonnes")+
    theme(legend.position = "none")+scale_fill_brewer(palette="Set2")
  ggplotly(p8)
  
  
  })
  output$plot_p9<-renderPlotly({
    x_axis <- input$input_15
    y_axis <- input$input_16
    p9<-ggplot(agriculture_wide,aes(x=get(x_axis),y=get(y_axis)))+labs(x=(input$input_15),y=(input$input_16))+geom_point()
    ggplotly(p9)
  })
  output$plot_p10<-renderPlotly({
    p10<-agriculture %>%
    filter(LOCATION==input$input_17) %>% 
    ggplot(aes(x=TIME,y=Value))+geom_line(aes(col=SUBJECT))+theme_minimal()
    ggplotly(p10)
  })
}
