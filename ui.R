ui<-dashboardPage(
  dashboardHeader(title="Agriculture Produce Dashboard",dropdownMenu(
    type = "messages",
    messageItem(from = "Madeleine",
      message = "Check out the Data Source!",
      href = "https://data.oecd.org/"
                )
  )
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text="Crop Produce",tabName="crop",icon=icon("leaf")),
      menuItem(text="Meat Produce",tabName="meat",icon=icon("bacon")),
      menuItem(text="General Overview",tabName="general",icon=icon("globe"))
               )
                  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "crop",
              fluidPage(fluidRow(tabsetPanel(
                          tabPanel("Crop Production",column(width = 3,title="Select Variables",status="info",
                             selectInput(inputId = "input_1",label="Select Region/Country",
                                         choices=distinct_loc,selected="Australia"),
                             selectInput(inputId = "input_2",label="Crop",
                                         choices = distinct_sub,selected="MAIZE")),
                                        column(width = 9,box(width=12,title = "Crop Production (Thousand Tonnes)",status="primary",solidHeader = T,
                                             plotlyOutput("plot_p1")))),
                          tabPanel("Top 10 Crop Producer",column(width=3,title="Select Year",status="info",
                              selectInput(inputId = "input_5",label="Select Year",choices=1990:2019,selected="2010"),
                              selectInput(inputId = "input_6",label="Select Crop",choices=distinct_sub,selected = "MAIZE")),
                         
                                          column(width=9,box(width = 12,title="Top 10 Crop Producer",status="primary",solidHeader=T,
                                           plotlyOutput("plot_p3")))
                                         ),
                          tabPanel("Overall Distibution",column(width=3,title="Select Year",status="info",
                                                                selectInput(inputId ="input_12",label="Select Year",choices=distinct_year,selected=2010)),
                                   column(width=9,(box(width=12,title = "Overall Distribution",status="primary",solidHeader = T,
                                                       plotlyOutput("plot_p7")))))))),
                        fluidRow(
                          column(width=2),
                          column(width = 8,
                                 tags$h3("Crop Production Distribution Map")),
                          column(width=2)),        
                       fluidRow(column(width=3,title="Map Settings",selectInput(inputId = "input_9",label="Select Crop",choices=distinct_sub,selected="MAIZE"),
                                                                 selectInput(inputId = "input_14",label="Select Year", choices=distinct_year,selected=2010)),
                         column(width=9,title="map",leafletOutput("plot_p5")))),
      tabItem(tabName="meat",
              fluidPage(fluidRow(tabsetPanel(
                                tabPanel("Meat Consumption",column(width=3,    
                                              selectInput(inputId = "input_3",label="Select Region/Country",
                                                          choices=distinct_loc_meat,selected="Australia"),
                                              selectInput(inputId = "input_4",label="Meat",
                                                          choices = distinct_loc_sub,selected="PIG")),
                                              column(width=9,box(width=12,
                                                     title = "Meat Consumption (Thousand Tonnes)",status="primary",solidHeader = T,
                                                     plotlyOutput("plot_p2")))),
                                tabPanel("Top 10 Meat Consumption by Year and Meat Type",column(width=3,title="Select Meat",status="info",
                                                     selectInput(inputId ="input_8",label="Select Year",
                                                                 choices=distinct_year,selected=2010),
                                                     selectInput(inputId = "input_7",label="Select Meat",
                                                                 choices=distinct_loc_sub,selected="BEEF")),
                                                  column(width=9,(box(width=12,title = "Top 10 Meat Consumption by Year",status="primary",solidHeader = T,
                                                         plotlyOutput("plot_p4"))))),
                                tabPanel("Overall Distibution",column(width=3,title="Select Meat",status="info",
                                selectInput(inputId ="input_13",label="Select Year",choices=distinct_year,selected=2010)),
                                column(width=9,(box(width=12,title = "Overall Distribution",status="primary",solidHeader = T,
                                                    plotlyOutput("plot_p8"
                                                                 )))))),
                        fluidRow(
                              column(width=2),
                              column(width = 8,
                              tags$h3("Meat Consumption Distribution Map")),
                              column(width=2)),
                       fluidRow(column(width=3,title="Map Settings",selectInput(inputId = "input_10",label="Select Meat",
                                                                         choices=distinct_loc_sub,selected="BEEF"),
                                                                    selectInput(inputId = "input_11",label="Select Year",
                                                                        choices=distinct_year,selected=2010)),
                                column(width=9,title="map",leafletOutput("plot_p6")))))),
             
      
      tabItem(tabName="general",
        fluidPage(
        fluidRow(column(width=3,title="Select Variables to Compare",selectInput(inputId = "input_15",label="Select Variable",choices=distinct_all),
                        selectInput(inputId = "input_16",label="Select Variable",choices=distinct_all)),
                 column(width=9,(box(width=12,title="Variable Correlation Analyzer",status="primary",solidHeader = T,plotlyOutput("plot_p9"))))),
        fluidRow(column(width=3,title="Select Variables to Compare",selectInput(inputId = "input_17",label="Select Region",choices=distinct_all_location)),
                 column(width=9,(box(width=12,title="Produce Based on Region",status="primary",solidHeader = T,plotlyOutput("plot_p10"))))),
        
      )
              )))) 

  

