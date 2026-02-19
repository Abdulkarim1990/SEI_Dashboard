
# Verify
library(crosstalk)





if (file.exists("renv/activate.R")) source("renv/activate.R")

suppressPackageStartupMessages({
  library(shiny)
  library(shinydashboard)
  library(shinyWidgets)
  library(shinyjs)
  library(rhandsontable)
  library(DT)
  library(plotly)
  library(tidyverse)    # ggplot2, dplyr, tidyr, stringr, readr, purrr, forcats
  library(lubridate)
  library(scales)
  library(RColorBrewer)
  library(jsonlite)
  library(httr)         
  library(janitor)
  library(openxlsx)
  library(kableExtra)
  library(markdown)
  library(here)
  library(rio)
  library(pivottabler)
  library(gt)
  
  library(epicontacts)  
  library(htmlwidgets)  
  library(shinyauthr)
  library(sodium)
  library(shinymanager)
  library(webshot)
})




####################################################################reading the c data
credentials <- data.frame(
  user = c("user1", "user2"),
  password = c("password1", "password2"), 
  stringsAsFactors = FALSE
)

plc_data_new <- read.csv("plc_data_new.csv")
plc_data_hbk2 <- read.csv("plc_data_hbk2.csv")
access_data <- read.csv("access_data.csv")

plc_data_hbk3 <- read.csv("plc_data_hbk3.csv")

plc_data_hbk4 <- read.csv("plc_data_hbk4.csv")


vlc_data <- read.csv("vlc_data.csv")


priority_data <- read.csv("priority_data.csv")


plc_monitoring_data <- read.csv("plc_monitoring_data.csv")



tablet_survey <- read.csv("tablet_survey.csv")
head(tablet_survey)








priority_objectives <- read.csv("priority_objectives.csv")







lesson_data <- read.csv("lesson_data.csv")


plc_data_hbk2 <- read.csv("plc_data_hbk2.csv")
#head(plc_data_hbk2)

plc_trial_school <- read.csv("plc_trial_school.csv")




lesson_data_new <- read.csv("lesson_data_new.csv")



inter_data <- read.csv("inter_data.csv")

inter_data$region_inter <- as.factor(inter_data$region_inter)
inter_data$district_inter <- as.factor(inter_data$district_inter)
inter_data$school_inter <- as.factor(inter_data$school_inter)
inter_data$JHS_type <- as.factor(inter_data$JHS_type)
inter_data$learning_area <- as.factor(inter_data$learning_area)
inter_data$sex_inter <- as.factor(inter_data$sex_inter)
inter_data$need_inter <- as.factor(inter_data$need_inter)
inter_data$inter_level <- as.factor(inter_data$inter_level)

addResourcePath("images", "www")





# Verify the conversion



gcc_objectives <- read.csv("gcc_objectives.csv")


gcc_data <- read.csv("gcc_data.csv")

sip_data <- read.csv("sip_data.csv")





sip_objectives <- read.csv("sip_objectives.csv")




plc_data_hbk5 <- read.csv("plc_data_hbk5.csv")

#section 2



###########Building the User Interface (UI)

########## The main menu for the UI are declared here. 
library(shiny)
library(shinydashboard)

ui <- dashboardPage(skin = "yellow",
                    
                    dashboardHeader(title = "SEI Dashboard", titleWidth = 300
                    ),
                    dashboardSidebar(width = 200,
                                     useShinyjs(),  
                                     sidebarMenu(id = "sidebarMenu", 
                                                 menuItem("Home", tabName = "home", icon = icon("home")),
                                                 menuItem("PLC Attendance", icon = icon("chalkboard-teacher"),
                                                          menuSubItem("National Summary", tabName = "plc_attendance"),
                                                          menuSubItem("Regional Summary", tabName = "overall_summary"),
                                                          menuSubItem("School-Level Summary", tabName = "school_level")
                                                          #    menuSubItem("PLC in Trial Schools", tabName = "trial_school_plc")
                                                 ),
                                                 menuItem("Access & Quality", icon = icon("book-reader"),
                                                          menuSubItem("Access", tabName = "access"),
                                                          menuSubItem("Lesson Observation", tabName = "lesson_observation")
                                                 ),
                                                 # menuItem("SIP Implementation", tabName = "sip_imp", icon = icon("chart-line")),
                                                 menuItem("SIP Implementation",  href = "https://t-tel.shinyapps.io/sei_reform_monitoring/", icon = icon("chart-line")),
                                                 menuItem("Monitoring Reports", href = "https://t-tel.shinyapps.io/sei_reform_monitoring/", icon = icon("heartbeat")),
                                                 #menuItem("G&C School Based Reports", tabName = "guidance_counselling", icon = icon("user-graduate")),
                                                 #menuItem("Raw Data Download", href = "https://t-tel.shinyapps.io/sei_reform_monitoring/", icon = icon("download")),
                                                 # menuItem("Sexual Harassment Training", tabName = "SH_T", icon = icon("user-graduate")),
                                                 # menuItem("Priority Schools Report", tabName = "PSR", icon = icon("user-graduate")),
                                                 #menuItem("Leadership Training", tabName = "lead", icon = icon("user-tie")),
                                                 # menuItem("Intervention Results", tabName = "inter", icon = icon("chart-bar")),
                                                 menuItem("VLC Attendance", tabName = "VLC", icon = icon("chart-bar")),
                                               
                                                         
                                                          menuItem("Tablet Distribution", tabName = "tablet", icon = icon("tablet")),
                                                         
                                              
                                                 
                                                 
                                                 menuItem("STP Completion Rate",  href = "https://t-tel.shinyapps.io/waec_stp/", icon = icon("check-circle")),
                                                 menuItem(
                                                   "Teacher Helpline & Analytics",
                                                   href = "https://ges-teacher-helpline-599e37efb14d.herokuapp.com/",
                                                   icon = icon("user-graduate")
                                                   
                                                 )
                                                 
                                                 
                                     )
                                     
                                     
                                     
                    ),
                    dashboardBody(
                      useShinyjs(),
                      
                      tags$head(
                        tags$script(src = "https://www.googletagmanager.com/gtag/js?id=G-CF61F8D2MB"),
                        tags$script(HTML("
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'G-CF61F8D2MB');
    "))
                      ),
                      
                      tags$head(
                        tags$style(HTML("
                .custom-box {
                    border: 1px solid #ddd;
                    box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.2);
                    border-radius: 5px;
                    padding: 10px;
                    background-color: #f9f9f9;
                }
                .custom-heading {
                    text-align: center;
                    color: #555;
                    margin-bottom: 15px;
                }
            "))),
                      
                      tags$style(HTML("
    /* Custom CSS for the tabPanel */
    .tabset-panel .nav-tabs > li.active > a {
      background-color: blue; /* Change to your desired background color */
      color: white;           /* Change to your desired text color */
    }
  "))    
                      ,
                      
                      tags$head(
                        tags$style(HTML("
      .dropup .dropdown-menu {
        top: auto;
        bottom: 100%;
      }
    "))
                      ),
                      
                      
                      
                      defaultTab = "home",
                      tabItems(
                        tabItem(tabName = "home",
                                tags$head(
                                  tags$style(HTML("
            html, body {
              width: 100%;
              padding: 0;
              margin: 0;
            }

            .container-fluid, .navbar {
              width: 100%;
              padding: 0 !important;
              margin: 0 !important;
            }

            h2 {
              text-align: center;
              background-color: #336699;
              color: white;
              padding: 15px;
              border-radius: 5px;
            }

            /* Hero section */
            .hero-section {
              width: 100%;
              min-height: calc(100vh - 50px);
              background-image:
                linear-gradient(rgba(0, 30, 60, 0.65), rgba(0, 30, 60, 0.65)),
                url('../images/students4.png');
              background-size: cover;
              background-position: center;
              background-repeat: no-repeat;
              background-color: #1a3a5c;
              display: flex;
              flex-direction: column;
              justify-content: center;
              align-items: center;
              padding: 50px 20px 40px;
              gap: 28px;
            }

            /* Hero card */
            .hero-card {
              background: rgba(255, 255, 255, 0.97);
              border-radius: 12px;
              box-shadow: 0 8px 32px rgba(0, 0, 0, 0.35);
              padding: 40px 50px;
              max-width: 680px;
              width: 90%;
              text-align: center;
            }

            .hero-badge {
              font-size: 0.78rem;
              text-transform: uppercase;
              letter-spacing: 1.2px;
              color: #336699;
              font-weight: 700;
              margin-bottom: 14px;
            }

            .hero-divider {
              width: 55px;
              height: 3px;
              background: #336699;
              margin: 14px auto;
              border-radius: 2px;
            }

            .hero-title {
              font-size: 2.1rem;
              font-weight: 700;
              color: #1a2e4a;
              margin: 0 0 4px;
              letter-spacing: -0.3px;
            }

            .hero-subtitle {
              font-size: 1rem;
              color: #555;
              margin: 0 0 16px;
              line-height: 1.5;
            }

            .hero-description {
              font-size: 0.93rem;
              color: #666;
              line-height: 1.75;
              margin-bottom: 22px;
            }

            .hero-nav-buttons {
              display: flex;
              flex-wrap: wrap;
              gap: 10px;
              justify-content: center;
              margin-top: 8px;
            }

            .hero-nav-btn {
              background-color: #336699 !important;
              color: white !important;
              border: none !important;
              border-radius: 6px !important;
              padding: 8px 18px !important;
              font-size: 0.88rem !important;
              font-weight: 500 !important;
              cursor: pointer;
              transition: background-color 0.2s ease;
            }

            .hero-nav-btn:hover,
            .hero-nav-btn:focus {
              background-color: #264d73 !important;
              color: white !important;
            }

            /* Stat cards */
            .stat-cards-row {
              display: flex;
              flex-wrap: wrap;
              gap: 16px;
              justify-content: center;
              max-width: 860px;
              width: 90%;
            }

            .stat-card {
              background: rgba(255, 255, 255, 0.14);
              border: 1px solid rgba(255, 255, 255, 0.3);
              border-radius: 10px;
              padding: 20px 30px;
              text-align: center;
              min-width: 155px;
            }

            .stat-number {
              font-size: 1.9rem;
              font-weight: 700;
              color: white;
              display: block;
            }

            .stat-label {
              font-size: 0.75rem;
              color: rgba(255, 255, 255, 0.82);
              text-transform: uppercase;
              letter-spacing: 0.6px;
              margin-top: 5px;
              display: block;
            }
                                  "))
                                ),
                                div(class = "hero-section",
                                    div(class = "hero-card",
                                        div(class = "hero-badge",
                                            "Ghana Education Service | T-TEL"
                                        ),
                                        div(class = "hero-divider"),
                                        h1(class = "hero-title", "SEI Dashboard"),
                                        p(class = "hero-subtitle",
                                          "Secondary Education Improvement Programme — Data Monitoring & Analytics"),
                                        p(class = "hero-description",
                                          "This dashboard visualises data from Ghana's secondary schools, covering Professional Learning Community (PLC) attendance, school access and lesson observation quality, virtual learning, and tablet distribution across all regions."),
                                        div(class = "hero-divider"),
                                        p(style = "font-size:0.85rem; color:#888; margin-bottom:14px;",
                                          "Select a section below or use the sidebar to navigate."),
                                        div(class = "hero-nav-buttons",
                                            actionButton("home_goto_plc", "PLC Attendance",
                                                         class = "hero-nav-btn"),
                                            actionButton("home_goto_access", "Access & Quality",
                                                         class = "hero-nav-btn"),
                                            actionButton("home_goto_vlc", "VLC Attendance",
                                                         class = "hero-nav-btn"),
                                            actionButton("home_goto_tablet", "Tablet Distribution",
                                                         class = "hero-nav-btn")
                                        )
                                    ),
                                    div(class = "stat-cards-row",
                                        div(class = "stat-card",
                                            uiOutput("home_stat_regions"),
                                            tags$span(class = "stat-label", "Regions")
                                        ),
                                        div(class = "stat-card",
                                            uiOutput("home_stat_schools"),
                                            tags$span(class = "stat-label", "Schools")
                                        ),
                                        div(class = "stat-card",
                                            tags$span(class = "stat-number", "5"),
                                            tags$span(class = "stat-label", "PLC Handbooks")
                                        ),
                                        div(class = "stat-card",
                                            uiOutput("home_stat_years"),
                                            tags$span(class = "stat-label", "Academic Years")
                                        )
                                    )
                                )
                        ),
                        
                        
                        
                        
                        tabItem(tabName = "plc_attendance",
                                fluidRow(
                                  box(title = "Select PLC Handbook to View National Attendance Summary", width = 12,
                                      selectInput("dataset_choice", "Please select a handbook:", 
                                                  choices = c("PLC Handbook 1 - NTS" = "plc_data_new", 
                                                              "PLC Handbook 2 - Introduction of SHS/SHTS/STEM Curriculum" = "plc_data_hbk2",
                                                              "PLC Handbook 3 - Departmental Professional Learning Community Session" = "plc_data_hbk3",
                                                              "Year 1 - Subject Specific PLC Handbook Survey" = "plc_data_hbk4",
                                                              "Year 2 - Subject Specific PLC Handbook Survey" = "plc_data_hbk5"
                                                  ),
                                                  selected = "plc_data_hbk5"
                                      )
                                  ),
                                  # Content for plc_data_new
                                  conditionalPanel(
                                    condition = "input.dataset_choice == 'plc_data_new'",
                                    box(title = "Professional Learning Community Handbook 1, Working to the National Teachers’ Standards", width = 12,
                                        p("Ghana Education Service has collaborated with the National Teaching Council, tutors of Colleges of Education, the University for Development Studies, Accra and Takoradi Technical Universities, and teachers from selected Senior High Schools, Senior High Technical Schools, and Technical Institutes to develop this maiden Professional Learning Community (PLC) Handbook. The Professional Learning Community (PLC) Handbook is intended to assist Heads of Secondary Schools and teachers to run weekly PLC sessions in schools. These PLC sessions are dedicated periods in the school’s weekly schedule where all teachers come together and work collaboratively to improve teaching and learning. PLC sessions will help teachers to build a collective understanding of how to improve outcomes for all learners in their schools through a series of practical activities such as lesson study, team teaching, and action research.")
                                    ),
                                    box(title = "National PLC Session Attendance Rate", width = 12,
                                        plotlyOutput("attendance_rate_chart")
                                    )
                                  ),
                                  # Content for plc_data_hbk2
                                  conditionalPanel(
                                    condition = "input.dataset_choice == 'plc_data_hbk2'",
                                    box(
                                      title = "Introduction to the Senior High School (SHS), Senior High Technical School (SHTS) and Science, Technology, Engineering and Mathematics (STEM) Curriculum",
                                      width = 12,
                                      p("The aim of teacher professional development activities is to ensure that teachers at all levels of education can improve their work through learning while teaching their classes. The National Council for Curriculum and Assessment (NaCCA) has, in collaboration with teachers from Senior High Schools, Senior High Technical Schools and Science Technical Engineering and Mathematics Schools, Colleges of Education and Universities developed this Professional Learning Community (PLC) Handbook. The Handbook is intended to assist heads and teachers of Secondary Schools to run weekly PLC sessions in schools. These PLC sessions are dedicated periods in the school’s weekly schedule where all teachers come together and work collaboratively to improve teaching and learning. The sessions are designed to support professionalising teaching by providing opportunities for teachers to develop communities of practice where they interact to share ideas with the view to improving their teaching and enhancing learning outcomes in their schools. The sessions provide examples that promote teachers’ understanding of gender equality and social inclusion and social emotional learning responsiveness and how this understanding can support learning. They also integrate differentiation and 21st century skills in lesson planning and delivery.")
                                    ),
                                    box(
                                      title = "National PLC Session Attendance Rate",
                                      width = 12,
                                      plotlyOutput("attendance_rate_chart_hbk2")
                                    )
                                  ),
                                  # Content for plc_data_hbk3
                                  conditionalPanel(
                                    condition = "input.dataset_choice == 'plc_data_hbk3'",
                                    box(
                                      title = "Departmental Professional Learning Community Handbook",
                                      width = 12,
                                      p("This Departmental Professional Learning Community Handbook will help teachers to familiarise themselves with the details of the new Senior High School (SHS), Senior High Technical (SHTS) and Science, Technology, Engineering and Mathematics (STEM) curriculum ahead of national roll-out in 2024/25. Professional Learning Community (PLC) sessions were introduced across all SHS and SHTS in Ghana in June 2023 and the first two PLC Handbooks were designed to be used by teachers in mixed departmental groups. This Departmental Professional Learning Community Handbook signals a shift in approach as we focus on providing more detailed information and guidance to teachers ahead of the roll-out of the new SHS, SHTS and STEM curriculum. This Handbook is therefore intended to be used by teachers working in departmental groupings and should be used in conjunction with subject-specific Year One Teacher Manuals. The Handbook will guide teachers and help to familiarise them with the Weekly Learning Planner and Teacher Manuals as they develop their own Learning Plans for each subject.  The Handbook contains a total of 13 Sessions covering all 24 weeks in Year One of the new SHS, SHTS and STEM curriculum.")
                                      
                                    ),
                                    
                                    box(
                                      title = "National PLC Session Attendance Rate",
                                      width = 12,
                                      plotlyOutput("attendance_rate_chart_hbk3")
                                    )
                                  ),
                                  conditionalPanel(
                                    condition = "input.dataset_choice == 'plc_data_hbk4'",
                                    box(
                                      title = "Year 1 - Subject Specific PLC Handbook Survey",
                                      width = 12,
                                      div(style = "max-height: 200px; overflow-y: auto;",
                                          HTML("
                  <p>This Professional Learning Community (PLC) Handbook is designed to enable teachers to
deliver effective lessons for Year One of the new Economics Curriculum. </p>

                  <p>‘Effective’ is
defined as meaning that each lesson:</p>
                  <ul>
                    <li>Has a weekly learning plan which is aligned with the content and pedagogy set out
in the relevant Teacher Manual;</li>
                    <li>Incorporates the relevant Learner Materials which are available on the curriculum
microsite;</li>
                    <li>Contains assessment strategies which are aligned with the Teacher Manual,
Learner Materials and Transcript Assessment Guidance;</li>
                    <li>Is delivered by the teacher in close adherence (Fidelity of Implementation) with i.)
to iii.) above.</li>
                    
                  </ul>

                  <p>The PLC Handbook has a strong focus on assessment, outlining structured approaches to
assessment derived from the Teacher Assessment Manual and Toolkit (TAMT), emphasising
the attainment of learning outcomes, timely feedback to learners and recording learning
outcomes accurately.</p>

                  <p>Additionally, this Handbook prescribes nine (9) main assessment events which teachers
should score and record to constitute each learner’s academic transcript for the academic
year as follows: Two (2) Class exercises or Homework, one (1) Individual Portfolio, one (1)
Group Project, two (2) Mid-semester examinations (in first and second semesters), two
(2) End of Semester examinations (in first and second semester) and one (1) Individual
project. It also promotes continuous weekly assessment for learning across all DoK levels,
supporting teachers to deliver an all-inclusive education by inculcating 21st
century skills, ICT, national values and support to special needs learners. <p>
                  ")
                                      )      
                                    ),
                                    
                                    box(
                                      title = "National PLC Session Attendance Rate",
                                      width = 12,
                                      plotlyOutput("attendance_rate_chart_hbk4")
                                    )
                                    
                                  ),
                                  
                                  ###################################handbook 5
                                  conditionalPanel(
                                    condition = "input.dataset_choice == 'plc_data_hbk5'",
                                    box(
                                      title = "Year 2 - Subject Specific PLC Handbook Survey",
                                      width = 12,
                                      div(style = "max-height: 200px; overflow-y: auto;",
                                          HTML("
                  <p>The purpose of the Year Two Professional Learning Community
(PLC) Handbook is to support teachers to effectively deliver the
new Senior High School (SHS) curriculum. This Handbook is
accompanied by a Subject Specific App tailored to SHS curriculum.
The App is designed to assist teachers with lesson planning,
delivery and assessment. The Subject Specific App uses
information directly from the following materials:</p>
                  <ol>
                    <li>Curriculum</li>
                    <li>Teacher Manual</li>
                    <li>Learner Materials</li>
                    <li>Vision and Philosophy of the SHS curriculum</li>
                    <li>21st century skills and competencies</li>
                    <li>National Teachers' Standards</li>
                    <li>West African Examinations Council (WAEC) Scheme of
Assessment and Detailed Syllabus</li>
                    <li>Learning Planning Template</li>
                    <li>Teacher Assessment Manual and Toolkit</li>
                    <li>Socio Emotional Learning</li>
                    <li>National Values</li>
                    <li>Gender Equality and Social Inclusion (GESI), etc.</li>
                  </ol>
                  <p><strong>Learning Outcome (LO):</strong> To explore how the Subject Specific App
can assist teachers with lesson planning, delivery and assessment
(NTS 2b, 2c, 2e, 2f, 3a, 3d, 3e, 3g-3k and 3o).</p>
                  
                  <p><strong>Learning Indicator (LI) 1:</strong> Use the Subject Specific App to explore
the Year Two Curriculum Materials (Teacher Manual and Learner
Materials)</p>
                  <p><strong>Learning Indicator (LI) 2:</strong> Discuss the advantages and disadvantages
of using the Subject Specific App to design lessons and assessment
strategies.</p>
                  ")
                                      )      
                                    ),
                                    
                                    box(
                                      title = "National PLC Session Attendance Rate",
                                      width = 12,
                                      plotlyOutput("attendance_rate_chart_hbk5")
                                    )
                                    
                                  )
                                  
                                  
                                  
                                )
                        )
                        ,
                        
                        
                        
                        
                        tabItem(tabName = "overall_summary",
                                tags$style(HTML("
            .footnote {
                font-size: 0.8em;
                color: #333;
                margin-top: 10px;
            }
        ")),
                                fluidRow(
                                  box(title = "Select PLC Handbook to View Regional PLC Attendance Summary", width = 12,
                                      selectInput("dataset_choice_regional", "Please select a handbook:", 
                                                  choices = c("PLC Handbook 1 - NTS" = "plc_data_new", 
                                                              "PLC Handbook 2 - Introduction to SHS/SHTS/STEM Curriculum" = "plc_data_hbk2",
                                                              "PLC Handbook 3 - Departmental Professional Learning Community Session" = "plc_data_hbk3",
                                                              "Year 1 - Subject Specific PLC Handbook Survey" = "plc_data_hbk4",
                                                              "Year 2 - Subject Specific PLC Handbook Survey" = "plc_data_hbk5"
                                                  ),
                                                  selected = "plc_data_hbk5")
                                  )
                                ),
                                # Content for plc_data_new
                                conditionalPanel(
                                  condition = "input.dataset_choice_regional == 'plc_data_new'",
                                  fluidRow(
                                    column(width = 12, align = "center", h4("Regional Level PLC Attendance Rate for Handbook 1 - NTS"))
                                  ),
                                  fluidRow(
                                    box( title = "Regional summary of PLC attendance rate - handbook 1 (NTS)", width = 12,
                                         DTOutput("overall_summary")
                                    )
                                  )
                                ),
                                
                                # Content for plc_data_hbk2
                                conditionalPanel(
                                  condition = "input.dataset_choice_regional == 'plc_data_hbk2'",
                                  fluidRow(
                                    column(width = 12, align = "center", h4("Regional Level PLC Attendance Rate for Handbook 2 - Introduction of SHS/SHTS/STEM Curriculum"))
                                  ),
                                  fluidRow(box(title = "Regional summary of PLC attendance rate - handbook 2 (Introduction to SHS/SHTS/STEM Curriculum)", width = 12,
                                               DTOutput("overall_summary_hbk2") 
                                  )
                                  )
                                ),
                                
                                fluidRow(
                                  column(width = 12, align = "center",
                                         downloadButton("download_data", "Click to Download Raw Data")
                                  )
                                ),
                                
                                conditionalPanel(
                                  condition = "input.dataset_choice_regional == 'plc_data_hbk3'",
                                  fluidRow(
                                    column(width = 12, align = "center", h4("Regional Level PLC Attendance Rate for Handbook  - Departmental Professional Learning Community Session"))
                                  ),
                                  fluidRow(box(title = "Regional summary of PLC attendance rate - handbook 3 (Departmental Professional Learning Community)", width = 12,
                                               DTOutput("overall_summary_hbk3") 
                                  )
                                  )
                                ),
                                
                                
                                
                                conditionalPanel(
                                  condition = "input.dataset_choice_regional == 'plc_data_hbk4'",
                                  fluidRow(
                                    column(width = 12, align = "center", h4("Regional Level PLC Attendance Rate for Handbook  - Year 1 - Subject Specific PLC Handbook Survey"))
                                  ),
                                  fluidRow(box(title = "Regional summary of PLC attendance rate - Year 1 - Subject Specific PLC Handbook Survey", width = 12,
                                               DTOutput("overall_summary_hbk4") 
                                  )
                                  )
                                ),
                                ###########year 2
                                conditionalPanel(
                                  condition = "input.dataset_choice_regional == 'plc_data_hbk5'",
                                  fluidRow(
                                    column(width = 12, align = "center", h4("Regional Level PLC Attendance Rate for Handbook  - Year 2 - Subject Specific PLC Handbook Survey"))
                                  ),
                                  fluidRow(box(title = "Regional summary of PLC attendance rate - Year 2 - Subject Specific PLC Handbook Survey", width = 12,
                                               DTOutput("overall_summary_hbk5") 
                                  )
                                  )
                                ),
                                
                                
                                
                        )
                        ,
                        tabItem(tabName = "school_level",
                                fluidRow(
                                  # Dropdown menu to select the PLC Handbook
                                  box(title = "Select PLC Handbook to View School-Level PLC Attendance Summary", width = 12,
                                      selectInput("dataset_choice_school", "Please select a handbook:", 
                                                  choices = c("PLC Handbook 1 - NTS" = "plc_data_new", 
                                                              "PLC Handbook 2 - Introduction to SHS/SHTS/STEM Curriculum" = "plc_data_hbk2",
                                                              "PLC Handbook 3 - Departmental Professional Learning Community Session" = "plc_data_hbk3",
                                                              "Year 1 - Subject Specific PLC Handbook Survey" = "plc_data_hbk4",
                                                              "Year 2 - Subject Specific PLC Handbook Survey" = "plc_data_hbk5"
                                                              
                                                              
                                                  ),
                                                  selected = "plc_data_hbk5")
                                  )
                                ),
                                # Content for plc_data_new
                                conditionalPanel(
                                  condition = "input.dataset_choice_school == 'plc_data_new'",
                                  fluidRow(box(width = 12,
                                               column(width = 12, uiOutput("region_ui")),
                                               column(width = 3, uiOutput("year_ui")),
                                               column(width = 3, uiOutput("handbook_ui"))
                                  )
                                  ),
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School-level summary of PLC attendance for Handbook 1 - NTS"))
                                  ),
                                  fluidRow(width = 12,
                                           downloadButton("export_button", "Export Table Handbook 1"),
                                           fluidRow(
                                             fluidRow(
                                               box(width = 12,
                                                   column(width = 12,
                                                          rHandsontableOutput("table_plot", height = 400)
                                                   )
                                               )
                                             )
                                           )
                                  ),
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School Leadership Attendance to PLC Sessions for Handbook 1 - NTS"))
                                  ),
                                  
                                  
                                  fluidRow(
                                    
                                    rHandsontableOutput("table_plot1", height = 500)
                                  ),
                                  
                                  
                                ),
                                # Content for plc_data_hbk2
                                conditionalPanel(
                                  condition = "input.dataset_choice_school == 'plc_data_hbk2'",
                                  
                                  fluidRow(box( width = 12,
                                                column(width = 12, uiOutput("region_ui_hbk2")),
                                                
                                  )
                                  ),
                                  
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School-level summary of PLC attendance for Handbook 2 - Introduction of SHS/SHTS/STEM Curriculum"))
                                  ),
                                  fluidRow(
                                    downloadButton("export_button_hbk2", "Export Table Handbook 2"),
                                    fluidRow(
                                      fluidRow(
                                        box(width = 12,
                                            column(width = 12,
                                                   # Placeholder for the table output for plc_data_hbk2
                                                   rHandsontableOutput("table_plot_hbk2", height = 400)
                                            )
                                        )
                                      )
                                    )
                                  ),
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School Leadership Attendance to PLC Sessions for Handbook 2 - Introduction of SHS/SHTS/STEM Curriculum"))
                                  ),
                                  fluidRow(
                                    # Placeholder for the dataTable output for plc_data_hbk2
                                    column(width = 12, rHandsontableOutput("table_plot1_hbk2", height = "500px"))
                                    
                                  )
                                ),
                                
                                # Content for plc_data_hbk3
                                conditionalPanel(
                                  condition = "input.dataset_choice_school == 'plc_data_hbk3'",
                                  
                                  fluidRow(box( width = 12,
                                                column(width = 6,
                                                       uiOutput("region_ui_hbk3")),
                                                # column(width = 6, sliderInput("session_slider_hbk3", 
                                                # "Select Session", 
                                                # min = 1, 
                                                #max = 14, 
                                                #value = 1, 
                                                #step = 1,
                                                #ticks = TRUE,
                                                #animate = TRUE))
                                                
                                  )
                                  ),
                                  
                                  
                                  
                                  
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School-level summary of PLC attendance for Handbook 3 - Departmental Professional Learning Community"))
                                  ),
                                  fluidRow(
                                    downloadButton("export_button_hbk3", "Export Table Handbook 3"),
                                    fluidRow(
                                      fluidRow(
                                        box(width = 12,
                                            column(width = 12,
                                                   # Placeholder for the table output for plc_data_hbk3
                                                   rHandsontableOutput("table_plot_hbk3", height = 400)
                                            )
                                        )
                                      )
                                    )
                                  ),
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School Leadership Attendance to PLC Sessions for Handbook 3 - Departmental Professional Learning Community"))
                                  ),
                                  fluidRow(
                                    downloadButton("export_button_hbk3_led", "Export Leadership Attendance Table Handbook 3"),
                                    fluidRow(
                                      box(width = 12,
                                          # Placeholder for the dataTable output for plc_data_hbk3
                                          column(width = 12,
                                                 
                                                 rHandsontableOutput("table_plot1_hbk3", height = "500px")
                                          )
                                      ) #
                                    )
                                  )
                                ),
                                
                                conditionalPanel(
                                  condition = "input.dataset_choice_school == 'plc_data_hbk4'",
                                  
                                  fluidRow(box( width = 12,
                                                column(width = 6,
                                                       uiOutput("region_ui_hbk4")),
                                                # column(width = 6, sliderInput("session_slider_hbk3", 
                                                # "Select Session", 
                                                # min = 1, 
                                                #max = 14, 
                                                #value = 1, 
                                                #step = 1,
                                                #ticks = TRUE,
                                                #animate = TRUE))
                                                
                                  )
                                  ),
                                  
                                  
                                  
                                  
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School-level summary of PLC attendance: Year 1 - Subject Specific PLC Handbook Survey"))
                                  ),
                                  fluidRow(
                                    downloadButton("export_button_hbk4", "Export Table Handbook 4"),
                                    fluidRow(
                                      fluidRow(
                                        box(width = 12,
                                            column(width = 12,
                                                   # Placeholder for the table output for plc_data_hbk3
                                                   rHandsontableOutput("table_plot_hbk4", height = 400)
                                            )
                                        )
                                      )
                                    )
                                  ),
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School Leadership Attendance to PLC Sessions: Year 1 - Subject Specific PLC Handbook Survey"))
                                  ),
                                  fluidRow(
                                    downloadButton("export_button_hbk4_led", "Export Leadership Attendance Table Handbook 4"),
                                    fluidRow(
                                      box(width = 12,
                                          # Placeholder for the dataTable output for plc_data_hbk4
                                          column(width = 12,
                                                 
                                                 rHandsontableOutput("table_plot1_hbk4", height = "500px")
                                          )
                                      ) #
                                    )
                                  )
                                  
                                ),  
                                
                                ############handbook 5
                                
                                conditionalPanel(
                                  condition = "input.dataset_choice_school == 'plc_data_hbk5'",
                                  
                                  fluidRow(box( width = 12,
                                                column(width = 6,
                                                       uiOutput("region_ui_hbk5")),
                                                # column(width = 6, sliderInput("session_slider_hbk3", 
                                                # "Select Session", 
                                                # min = 1, 
                                                #max = 14, 
                                                #value = 1, 
                                                #step = 1,
                                                #ticks = TRUE,
                                                #animate = TRUE))
                                                
                                  )
                                  ),
                                  
                                  
                                  
                                  
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School-level summary of PLC attendance: Year 2 - Subject Specific PLC Handbook Survey"))
                                  ),
                                  fluidRow(
                                    downloadButton("export_button_hbk5", "Export of SSPLC Year 2 School Data"),
                                    fluidRow(
                                      fluidRow(
                                        box(width = 12,
                                            column(width = 12,
                                                   # Placeholder for the table output for plc_data_hbk3
                                                   rHandsontableOutput("table_plot_hbk5", height = 400)
                                            )
                                        )
                                      )
                                    )
                                  ),
                                  fluidRow(
                                    column(width = 12, align = "center", h4("School Leadership Attendance to PLC Sessions: Year 2 - Subject Specific PLC Handbook Survey"))
                                  ),
                                  fluidRow(
                                    downloadButton("export_button_hbk5_led", "Export Leadership Attendance Table - SSPLC Year 2"),
                                    fluidRow(
                                      box(width = 12,
                                          # Placeholder for the dataTable output for plc_data_hbk5
                                          column(width = 12,
                                                 
                                                 rHandsontableOutput("table_plot1_hbk5", height = "500px")
                                          )
                                      ) #
                                    )
                                  )
                                  
                                ),
                                
                        ),
                        
                        
                        
                        
                        
                        
                        tabItem(tabName = "trial_school_plc",
                                tabsetPanel(
                                  id = "plc_panel",
                                  tabPanel("Overall Summary",
                                           div(style = "margin-bottom: 20px;", # Adding margin at the bottom
                                               box(
                                                 title = "Professional Learning Community Session in Curriculum Trial Schools", 
                                                 width = 12,
                                                 
                                                 p("Ghana Education Service and National Council for Curriculum and Assessment are trialing the new secondary school curriculum in 32 schools. These schools are supposed to attend PLC sessions and then practice what they learn in the classroom ...")
                                               )
                                           ),
                                           div(style = "margin-bottom: 20px;", # Adding margin at the bottom
                                               box(
                                                 
                                                 width = 12,
                                                 class = "custom-box",
                                                 # Create a proper layout structure with fluidRow
                                                 fluidRow(
                                                   # First row for the filter
                                                   column(12, 
                                                          div(style = "margin-bottom: 15px;",
                                                              column(4, 
                                                                     selectInput(
                                                                       "academic_year_filter",
                                                                       "Select Academic Year:",
                                                                       choices = c("All", "2023/2024 Academic Year", "2024/2025 Academic Year"),
                                                                       selected = "All"
                                                                     )
                                                              ),
                                                              column(8, "")  # Empty column for spacing
                                                          )
                                                   )
                                                 ),
                                                 # Second row for the plot with full width
                                                 fluidRow(
                                                   column(12, 
                                                          div(style = "height: 400px;",  # Fixed height for the plot
                                                              plotlyOutput("attendance_rate_chart_trial", height = "100%")
                                                          )
                                                   )
                                                 )
                                               )
                                           )    # Additional components can be added here if needed
                                  ),
                                  tabPanel("School-Level Analysis",
                                           # Dynamic UI for region and academic year selection
                                           fluidRow(
                                             box(width = 12,
                                                 class = "custom-box",  
                                                 column(width = 6, 
                                                        selectInput(
                                                          "academic_year_filter_school",
                                                          "Select Academic Year:",
                                                          choices = c("All", "2023/2024 Academic Year", "2024/2025 Academic Year"),
                                                          selected = "All"
                                                        )
                                                 )
                                                 
                                             )
                                           ),
                                           
                                           # Heading for school-level summary
                                           fluidRow(
                                             column(width = 12, align = "center", 
                                                    h4("School-level Summary of PLC Attendance in Curriculum Trial Schools"))
                                           ),
                                           
                                           # Export button and table display
                                           fluidRow(
                                             column(width = 6, downloadButton("export_button_school_level", "Export Table")),
                                             column(width = 6, align = "right", actionButton("refresh_button_school_level", "Refresh Data"))
                                           ),
                                           fluidRow(
                                             box(width = 12,
                                                 column(width = 12,
                                                        class = "custom-box",  
                                                        rHandsontableOutput("table_plot_school_level", height = 400)
                                                 )
                                             )
                                           ),
                                           
                                           # Heading for another section (e.g., Leadership Attendance)
                                           fluidRow(
                                             column(width = 12, align = "center", 
                                                    h4("School Leadership Attendance to PLC Sessions in Curriculum Trial Schools"))
                                           ),
                                           
                                           # Table display for the second section
                                           fluidRow(
                                             box(width = 12,
                                                 column(width = 12,
                                                        rHandsontableOutput("table_plot_school_level_2", height = 500)
                                                 )
                                             )
                                           )
                                  )#
                                )
                        ),
                        
                        
                        
                        tabItem(tabName = "access",
                                tabsetPanel(
                                  tabPanel("National Summary",
                                           fluidRow(
                                             column(4, uiOutput("year_ui_national")),
                                             column(4, 
                                                    box(
                                                      title = "Data Submission",
                                                      status = "primary",
                                                      width = 12,
                                                      solidHeader = TRUE,
                                                      collapsible = FALSE,
                                                      icon("university", lib = "font-awesome"),
                                                      textOutput("distinct_schools_output", inline = TRUE)
                                                      
                                                    )
                                             )
                                           )
                                           
                                           
                                           ,
                                           fluidRow(
                                             column(6, 
                                                    box(
                                                      title = "Overall Teaching Staff Population",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 450,
                                                      plotOutput("plot_teachers_national", height = "350px", width = "100%")
                                                      
                                                    )
                                             ),
                                             column(6, 
                                                    box(
                                                      title = "Overall Non-teaching Staff Population",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 450,
                                                      plotOutput("plot_nonteaching_national", height = "350px", width = "100%")
                                                      
                                                    )
                                             )
                                             
                                           ),
                                           fluidRow(
                                             column(6, 
                                                    box(
                                                      title = "Overall Student Population",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 500,
                                                      selectInput("year_select_students_national", "Select Year:", 
                                                                  choices = c("Year 1", "Year 2", "Year 3", "All Students")),
                                                      plotOutput("plot_students_national", height = "350px", width = "100%")
                                                      
                                                    )
                                             ),
                                             column(6, 
                                                    box(
                                                      title = "Overall Students with Special Needs",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 500,
                                                      # Dropdown for selecting the year
                                                      selectInput("year_select_national_sen", 
                                                                  "Select Year for SEN Students:",
                                                                  choices = c("Year 1", "Year 2", "Year 3", "All Students")),
                                                      
                                                      # Output: Bar plot for students with special needs at the national level
                                                      plotOutput("plot_sen_students_national")
                                                    )
                                                    
                                             )
                                           )
                                  ),
                                  
                                  tabPanel("Regional Summary",
                                           fluidRow(
                                             # Column for Academic Year selection
                                             column(4, 
                                                    selectInput("year_access_regional_analysis", 
                                                                "Select Academic Year", 
                                                                choices = unique(access_data$year_access), 
                                                                selected = unique(access_data$year_access)[2])
                                             ),
                                             
                                             # Column for Region selection
                                             column(4, 
                                                    selectInput("Region_access_regional_analysis", 
                                                                "Select Region", 
                                                                choices = NULL)
                                             ), 
                                             
                                             # Column for the Data Submission box
                                             column(4, 
                                                    box(
                                                      title = "Data Submission",
                                                      status = "primary",
                                                      width = 12,
                                                      solidHeader = TRUE,
                                                      collapsible = FALSE,
                                                      icon("university", lib = "font-awesome"),
                                                      textOutput("distinct_school_text" , inline = TRUE)
                                                    )
                                             )
                                           )
                                           
                                           ,
                                           fluidRow(
                                             column(6, 
                                                    box(
                                                      title = "Regional Teaching Staff Population",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 450,
                                                      plotOutput("plot_teachers_region", height = "400px", width = "100%")
                                                      
                                                    )
                                             ),
                                             column(6, 
                                                    box(
                                                      title = "Regional Non-teaching Staff Population",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 450,
                                                      plotOutput("plot_nonteaching_staff_region", height = "400px", width = "100%")
                                                      
                                                      
                                                    )
                                             )
                                             
                                           ),
                                           fluidRow(
                                             column(6, 
                                                    box(
                                                      title = "Regional Student Population",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 500,
                                                      selectInput("year_select_students", "Select Year:", 
                                                                  c("Year 1", "Year 2", "Year 3", "All Students")),
                                                      plotOutput("plot_students_region", height = "350px", width = "100%")
                                                      
                                                      
                                                    )
                                             ),
                                             column(6, 
                                                    box(
                                                      title = "Regional Students with Special Needs",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 500,
                                                      selectInput("year_select_sen_students", "Select Year:", 
                                                                  c("Year 1", "Year 2", "Year 3", "All Students")),
                                                      plotOutput("plot_sen_students_region", height = "350px", width = "100%")
                                                      
                                                    )
                                                    
                                             )
                                           )
                                  ),
                                  
                                  tabPanel("School-level summary",
                                           
                                           fluidRow(
                                             column(4, selectInput("year_access", "Select Academic Year", choices = unique(access_data$year_access), selected = unique(access_data$year_access)[2])),
                                             column(4, selectInput("Region_access", "Select Region", choices = NULL)),
                                             column(4, selectInput("Name_school_access", "Select School", choices = NULL))
                                           )
                                           ,
                                           fluidRow(
                                             column(6, 
                                                    box(
                                                      title = "Teaching Staff Population",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 450,
                                                      plotOutput("plot_teachers", height = "400px", width = "100%")
                                                    )
                                             ),
                                             column(6, 
                                                    box(
                                                      title = "Non-teaching Staff Population",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 450,
                                                      plotOutput("plot_non_teaching_staff", height = "400px", width = "100%")
                                                    )
                                             )
                                           ),
                                           fluidRow(
                                             column(6, 
                                                    box(
                                                      title = "Student Population",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 500,
                                                      selectInput("year_select", "Select Year:", c("Year 1", "Year 2", "Year 3", "All Students")),
                                                      plotOutput("plot_students", height = "350px", width = "100%")
                                                    )
                                             ),
                                             column(6, 
                                                    box(
                                                      title = "Students with Special Needs",
                                                      status = "primary",
                                                      solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      width = 12,
                                                      height = 450,
                                                      selectInput("year_select_sen", "Select Year:", c("Year 1", "Year 2", "Year 3", "All Students")),
                                                      plotOutput("plot_students_sen", height = "320px", width = "100%")
                                                    )
                                                    
                                             )
                                           )
                                  )
                                  ,          
                                  
                                  
                                  tags$style(HTML("
    .nav.nav-tabs {
      background-color: #2C3E50; 
    }
    .nav.nav-tabs > li > a {
      color: #ECF0F1;
    }
    .nav.nav-tabs > li.active > a {
      color: #F39C12;
      background-color: #ECF0F1;
    }
  ")),
                                )
                        )
                        ,
                        tabItem(tabName = "lesson_observation",
                                
                                fluidRow(
                                  column(width = 12, 
                                         fluidRow(
                                           column(width = 12, 
                                                  h4("School-Level Lesson Observation Results", style =  "color: white;"), # Change the color as needed
                                                  selectInput("academic_year",
                                                              label = NULL,
                                                              choices = c("Lesson Observation Results" = "lesson_data_new"),
                                                              selected = "lesson_data_new")
                                                  
                                           )   
                                         )
                                  ),
                                  
                                  
                                  tabsetPanel(
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    tabPanel("National Result",
                                             tags$br(),  # Add line breaks for spacing
                                             tags$br(),
                                             
                                             
                                             
                                             # Conditional Panel for the 2023/2024 academic year
                                             conditionalPanel(
                                               condition = "input.academic_year == 'lesson_data_new'",
                                               fluidRow(
                                                 
                                                 tags$br(),  # Add line breaks for spacing
                                                 tags$br(),
                                                 tags$br(),  # Additional line break for spacing
                                                 
                                                 box(
                                                   width = 12,
                                                   fluidRow(
                                                     column(4, 
                                                            selectInput("year_select_nat_new", "Select an Academic Year", 
                                                                        choices = unique(lesson_data_new$year_lesson), 
                                                                        selected = unique(lesson_data_new$year_lesson)[4])),
                                                     
                                                     column(4, 
                                                            selectInput("year_lesson_delivery_nat", "Select the Year", 
                                                                        choices = c("Overall", na.omit(unique(lesson_data_new$begin_group_RRNG5Kxfl_aa7_class))), 
                                                                        selected = "Overall"))
                                                   )
                                                 )
                                                 ,
                                                 
                                                 tags$br(),  # Additional spacing after select inputs
                                                 tags$br(),
                                                 
                                                 
                                                 # Box for the Summary of Lesson Observation Competencies
                                                 box(width = 12,
                                                     tags$h3("Summary of Lesson Observation Results"),
                                                     
                                                     # Add tabsetPanel for Summary vs Detailed view
                                                     tabsetPanel(
                                                       id = "results_tabs",
                                                       
                                                       # Tab 1: Summary View (current table)
                                                       tabPanel("Summary View", 
                                                                value = "summary",
                                                                tags$br(),
                                                                DTOutput("summaryTableNational_new")
                                                       ),
                                                       
                                                       # Tab 2: Detailed Breakdown
                                                       tabPanel("Detailed Breakdown", 
                                                                value = "detailed",
                                                                tags$br(),
                                                                DTOutput("detailedTableNational_new")
                                                       )
                                                     )
                                                 ),
                                                 tags$br(),  # Add line breaks for spacing
                                                 tags$br(),
                                                 
                                                 # Columns for Key strengths and Areas that need improvement
                                                 box(width = 12,
                                                     tags$h3("Thematic Analysis of the Strengths and Areas of Improvements - Lesson Delivery in the Secondary Schools"),
                                                     column(width = 6,
                                                            box(title = "Key strengths of teachers in the school",
                                                                status = "primary",
                                                                solidHeader = TRUE,
                                                                collapsible = TRUE,
                                                                width = 12,
                                                                height = "auto",
                                                                htmlOutput("strengthsOutput_new") 
                                                            )
                                                     ),
                                                     column(width = 6,
                                                            box(title = "Areas that need improvement",
                                                                status = "primary",
                                                                solidHeader = TRUE,
                                                                collapsible = TRUE,
                                                                width = 12,
                                                                height = "auto",
                                                                htmlOutput("areasForDevOutput_new")   # Uncomment and use if needed
                                                            )
                                                     )
                                                 )
                                                 
                                               )
                                               
                                               
                                             ),
                                             
                                             
                                             
                                    ),
                                    
                                    
                                    tabPanel("Regional Result",
                                             tags$br(),  # Add line breaks for spacing
                                             tags$br(),
                                             
                                             conditionalPanel(
                                               condition = "input.academic_year == 'lesson_data_new'",
                                               
                                               fluidRow(
                                                 column(4, 
                                                        selectInput("year_select_reg_new", "Select an Academic Year", 
                                                                    choices = unique(lesson_data_new$year_lesson), 
                                                                    selected = unique(lesson_data_new$year_lesson)[4])),
                                                 
                                                 column(4, 
                                                        selectInput("region_select_reg_new", "Select a Region", 
                                                                    choices = unique(lesson_data_new$Region_lesson), 
                                                                    selected = unique(lesson_data_new$Region_lesson)[4])),
                                                 
                                                 column(4, 
                                                        selectInput("year_lesson_delivery_reg", "Select the Year", 
                                                                    choices = c("Overall", na.omit(unique(lesson_data_new$begin_group_RRNG5Kxfl_aa7_class))), 
                                                                    selected = "Overall"))
                                               ), 
                                               
                                               tags$br(), tags$br(), tags$br(),
                                               
                                               box(width = 12,
                                                   tags$h3("Summary of Lesson Observation Results - Regional Analysis"),
                                                   
                                                   # Add tabsetPanel for Summary vs Detailed view
                                                   tabsetPanel(
                                                     id = "regional_results_tabs",
                                                     
                                                     # Tab 1: Summary View
                                                     tabPanel("Summary View", 
                                                              value = "regional_summary",
                                                              tags$br(),
                                                              tags$p("Note: This table provides the overall regional summary result for each lesson observation competency."),
                                                              DTOutput("summaryTableRegional_new")
                                                     ),
                                                     
                                                     # Tab 2: Detailed Breakdown
                                                     tabPanel("Detailed Breakdown", 
                                                              value = "regional_detailed",
                                                              tags$br(),
                                                              tags$p("Note: This table shows detailed breakdown of individual variables for the selected region."),
                                                              DTOutput("detailedTableRegional_new")
                                                     )
                                                   )
                                               ),
                                               
                                               tags$br(), tags$br(),
                                               
                                               box(width = 12,
                                                   tags$h3("Thematic Analysis of the Strengths and Areas of Improvements - Lesson Delivery in the Secondary Schools"),
                                                   column(width = 6,
                                                          box(title = "Key strengths of teachers in the school",
                                                              status = "primary",
                                                              solidHeader = TRUE,
                                                              collapsible = TRUE,
                                                              width = 12,
                                                              height = "auto",
                                                              htmlOutput("strengthsOutput_new_region")
                                                          )
                                                   ),
                                                   column(width = 6,
                                                          box(title = "Areas that need improvement",
                                                              status = "primary",
                                                              solidHeader = TRUE,
                                                              collapsible = TRUE,
                                                              width = 12,
                                                              height = "auto",
                                                              htmlOutput("areasForDevOutput_new_region") # uncomment when ready
                                                          )
                                                   )
                                               )
                                               
                                             ) # <-- conditionalPanel correctly closed here!
                                             
                                             
                                             
                                             
                                    ),
                                    
                                    tabPanel("School Result",
                                             conditionalPanel(
                                               condition = "input.academic_year == 'lesson_data'",
                                               
                                               fluidRow(
                                                 column(width = 3, uiOutput("region_ui_lesson")),
                                                 column(width = 3, uiOutput("term_ui")),
                                                 column(width = 3, uiOutput("school_ui")),
                                                 fluidRow(
                                                   tags$head(
                                                     tags$style(HTML("
.box .box-header .box-title {
    display: block;
    text-align: center;
    width: 100%;
}
"))
                                                   ),
                                                   box(
                                                     title = "Summary insight on lesson observation",
                                                     width = 12,  # Ensure the box is the full width of its container
                                                     div(style = "padding: 10px; overflow-wrap: break-word;",  # Add padding and ensure text wraps
                                                         textOutput("summary_text")
                                                     ),
                                                     style = "overflow-y: auto; height: 50px;"  # Set a max height and make content scrollable if it overflows
                                                   )
                                                 ),
                                                 box(
                                                   title = "Table of Lesson Observation Competencies",
                                                   status = "primary",
                                                   solidHeader = TRUE,
                                                   collapsible = TRUE,
                                                   width = 12,
                                                   height = 500,
                                                   DT::dataTableOutput("summaryTable")
                                                 ),
                                                 box(
                                                   title = "Key strengths of teachers in the school",
                                                   status = "primary",
                                                   solidHeader = TRUE,
                                                   collapsible = TRUE,
                                                   width = 6,
                                                   height = "auto",
                                                   htmlOutput("strengthsOutput_schl_new")
                                                 ),
                                                 box(
                                                   title = "Areas that need improvement",
                                                   status = "primary",
                                                   solidHeader = TRUE,
                                                   collapsible = TRUE,
                                                   width = 6,
                                                   height = "auto",
                                                   htmlOutput("areasForDevOutput_schl_new")
                                                 )
                                               )
                                             ),
                                             
                                             # UI conditional statement for 2023/2024 academic year lesson observation
                                             conditionalPanel(
                                               condition = "input.academic_year == 'lesson_data_new'",
                                               
                                               fluidRow(
                                                 column(4, 
                                                        selectInput("year_select_schl_new", "Select an Academic Year", 
                                                                    choices = unique(lesson_data_new$year_lesson), 
                                                                    selected = unique(lesson_data_new$year_lesson)[4])),
                                                 
                                                 column(4, 
                                                        selectInput("region_select_schl_new", "Select a Region", 
                                                                    choices = unique(lesson_data_new$Region_lesson), 
                                                                    selected = unique(lesson_data_new$Region_lesson)[4])),
                                                 
                                                 column(4, 
                                                        selectInput("school_select_schl_new", "Select a School", 
                                                                    choices = NULL)), # We'll update this dynamically
                                                 
                                                 column(4, 
                                                        selectInput("year_lesson_delivery_schl", "Select the Year", 
                                                                    choices = c("Overall", na.omit(unique(lesson_data_new$begin_group_RRNG5Kxfl_aa7_class))), 
                                                                    selected = "Overall"))
                                                 ,
                                                 fluidRow(
                                                   tags$head(
                                                     tags$style(HTML("
.box .box-header .box-title {
    display: block;
    text-align: center;
    width: 100%;
}
"))
                                                   ),
                                                   box(
                                                     title = "Summary insight on lesson observation",
                                                     width = 12,  # Ensure the box is the full width of its container
                                                     div(style = "padding: 10px; overflow-wrap: break-word;",  # Add padding and ensure text wraps
                                                         htmlOutput("summary_text_new")
                                                     ),
                                                     style = "overflow-y: auto; height: 50px;"  # Set a max height and make content scrollable if it overflows
                                                   )
                                                 ),
                                                 box(
                                                   title = "Table of Lesson Observation Competencies",
                                                   status = "primary",
                                                   solidHeader = TRUE,
                                                   collapsible = TRUE,
                                                   width = 12,
                                                   height = 500,
                                                   div(style = "overflow-x: auto;", DTOutput("summaryTableSchool_new"))
                                                 ),
                                                 box(
                                                   title = "Key strengths of teachers in the school",
                                                   status = "primary",
                                                   solidHeader = TRUE,
                                                   collapsible = TRUE,
                                                   width = 6,
                                                   height = "auto",
                                                   DTOutput("strengthTextDisplay_new")
                                                 ),
                                                 box(
                                                   title = "Areas that need improvement",
                                                   status = "primary",
                                                   solidHeader = TRUE,
                                                   collapsible = TRUE,
                                                   width = 6,
                                                   height = "auto",
                                                   DTOutput("areasForDevDisplay_new")
                                                 )
                                               )
                                             ),
                                             
                                             
                                             
                                    )
                                    ,
                                    
                                  )
                                )
                        ),
                        
                        
                        
                        
                        
                        
                        tabItem(tabName = "SH_T",
                                h2("Sexual Harassment Training"),
                                tabsetPanel(
                                  tabPanel("National Summary",
                                           br(), 
                                           
                                           
                                           box(
                                             width = 12,
                                             br(), 
                                             br(), 
                                             
                                             fluidRow(
                                               box(
                                                 title = "About Sexual Harassment Training in the Schools",
                                                 width = 12,
                                                 div(style = "max-height: 200px; overflow-y: auto;",
                                                     HTML("<p>The sexual harassment training aims to educate teachers about recognizing and preventing sexual harassment. It includes various modules that cover legal aspects, ethical considerations, and practical strategies for creating a safe educational environment.</p>")
                                                 )
                                               )
                                             )
                                           ),
                                           fluidRow(
                                             
                                             box(  title = "National Summary Table",
                                                   status = "primary",
                                                   solidHeader = TRUE,
                                                   collapsible = TRUE,
                                                   width = 12,
                                                   
                                                   DTOutput("nationalSummaryTable")
                                             )
                                             
                                           )
                                           
                                           
                                  )
                                  
                                )
                        ), 
                        
                        
                        
                        tabItem(
                          tabName = "lead",
                          h2("Summary of Leadership Training in SHS, SHTS, STEM"),
                          
                          box(
                            width = 12,
                            br(), 
                            br(), 
                            
                            fluidRow(
                              box(
                                title = "About Leadership Training in SHS, SHTS, STEM",
                                width = 12,
                                div(style = "max-height: 200px; overflow-y: auto;",
                                    HTML("<p>The Ghana Education Service in collaboration with the National Teaching Council with support from  Transforming Teaching, Education & Learning (T-TEL) through its Leaders in Teaching (LiT) programme funded by the Mastercard Foundation, is ensuring that the capacity of secondary school leaders is enhanced. In this way, such school leaders can create a positive environment in their institutions for learning because schools are effectively led, and teaching is inclusive and effective. Through this support, six practical school leadership capacity development handbooks would be developed considering six modules and eight quality indicators identified from a deep dive exercise undertaken by the Ghana Education Service in December 2020. Gender equity approaches and social inclusion practices have been integrated into the modules to ensure an all-inclusive programme delivery in schools considering the diverse needs of teachers, non-teachers, and students. Opportunities are provided for school leadership teams to work with their stakeholders to regularly undertake selfevaluation of their practices against the eight quality indicators and use the outcome for school improvement planning.</p>")
                                )
                              )
                            )
                          ),
                          
                          # Region Select Input
                          fluidRow(
                            box(
                              selectInput("region", "Select Region:", choices = unique(plc_monitoring_data$Region_moni)),
                              width = 12
                            )
                          ),
                          # Region Select Input
                          
                          
                          # Value Boxes for Summary Metrics
                          fluidRow(
                            valueBoxOutput("total_trainings", width = 4),
                            valueBoxOutput("total_leaders_trained", width = 4),
                            valueBoxOutput("session_coverage", width = 4)
                          ),
                          
                          # Data Table for School-Level Summary
                          fluidRow(
                            
                            
                            box( downloadButton("download_table", "Download Table"),
                                 title = "School-Level Summary",
                                 status = "primary",
                                 solidHeader = TRUE,
                                 width = 12,
                                 rHandsontableOutput("school_summary_table")
                            ),
                            
                          ),
                          
                          # Key Activities Table
                          fluidRow(
                            box(
                              title = "Key Activities",
                              status = "info",
                              solidHeader = TRUE,
                              width = 12,
                              DTOutput("activities_table")
                            )
                          )
                        )
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        #sip_imp
                        
                        
                        
                        ,#
                        
                        
                        
                        
                        tabItem(tabName = "PSR",
                                tabsetPanel(
                                  tabPanel("Priority Schools Report",
                                           fluidRow(
                                             
                                             box(title = "About Result Based Grant to 94 Priority Schools", 
                                                 width = 12, 
                                                 div(style = "max-height: 200px; overflow-y: auto;",
                                                     HTML("
                  <p>The Ghana Education Service (GES) has facilitated the development of School Improvement Plans (SIPs) for all Senior High (SHS), Senior High Technical (SHTS), and Science, Technology, Engineering, and Mathematics (STEM) schools. In collaboration with the Mastercard Foundation through T-TEL, GES is now disbursing funds to support the following 94 prioritized schools in meeting their SIP objectives and enhancing teaching and learning.</p>

                  <p>The Results-Based Grant Support aims to advance leadership, management, and educational outcomes in these 94 prioritized schools by:</p>
                  <ul>
                    <li>Encouraging and incentivizing schools to achieve their School Improvement Plan objectives.</li>
                    <li>Providing resources directly aimed at improving teaching and learning</li>
                    
                  </ul>

                  <p>Each of the 94 schools will have access to a results-based grant of up to $5,000 for the 2023/24 academic year, contingent on the achievement of their SIP objectives. For each SIP objective evidenced as 'achieved' based on the relevant indicators, the school will receive $1,000, converted to Ghana Cedis at the prevailing exchange rate, through the GES. </p>

                  <p> The schools are required to demonstrate how these funds have been utilized to enhance teaching and learning, in accordance with the attached verification process. <p>
                  ")
                                                 )
                                                 
                                                 
                                                 ,
                                                 
                                             ),
                                             
                                             box(width = 12,
                                                 column(3, uiOutput("selectRegion")),
                                                 column(3, uiOutput("selectSchool"))
                                             ),
                                             box(title = "Submission Time", status = "warning", solidHeader = TRUE, width = 12,
                                                 textOutput("latestDateBox"),
                                                 dateRangeInput("dateRange", "Select Date Range:",
                                                                start = Sys.Date() - 365,  # Example: 1 year ago
                                                                end = Sys.Date(),
                                                                min = "2023-01-01",  # Earliest data date
                                                                max = Sys.Date()     # Current date
                                                 )
                                             ),
                                             box(title = "Latest Report on SIP Implementation by Priority Schools", width = 12,
                                                 DTOutput("objectivesTable")
                                             )
                                           )
                                  ),
                                  tabPanel("Regional Summary",
                                           fluidRow(
                                             tags$head(
                                               tags$style(HTML("
.box .box-header .box-title {
    display: block;
    text-align: center;
    width: 100%;
}
"))
                                             ),
                                             fluidRow(
                                               box(title = "Introduction",
                                                   width = 12,
                                                   status = "info",
                                                   solidHeader = TRUE,
                                                   collapsible = TRUE,
                                                   p("This section provides a regional summary of the implementation of SIP by the 94 priority schools. The table below will continue to provide the latest summary. The summary as seen below is the latest based on submissions made on", Sys.Date()),
                                                   p(""),
                                                   p("Use the table below to view detailed metrics for each region.Use the data range to view previous submissions and progress.")
                                               )
                                             )
                                             
                                             ,
                                             box(width = 12,
                                                 dateRangeInput("dateRange_reg", "Select Date Range:",
                                                                start = min(priority_data$endtime),  # Default start date 30 days ago
                                                                end = Sys.Date(),         # Default end date today
                                                                min = priority_data$endtime,  # Set minimum date based on your data
                                                                max = Sys.Date()           # Set maximum date to today
                                                 )
                                             )
                                             
                                             
                                             ,
                                             
                                             box(title = "Summary of Regional SIP Reports", width = 12,
                                                 dataTableOutput("regionTable")
                                             )
                                           )
                                  )
                                  
                                )
                        ),
                        
                        
                        
                        tabItem(tabName = "guidance_counselling",
                                tabsetPanel(
                                  tabPanel("School Level Guidance and Counselling Report",
                                           fluidRow(
                                             
                                             box(title = "About Guidance and Counselling Implementation in the schools", 
                                                 width = 12, 
                                                 div(style = "max-height: 200px; overflow-y: auto;",
                                                     HTML("
                  <p>The Ministry of Education in collaboration with agencies – Ghana Education Service and Ghana TVET Service are leading a restructuring of guidance and counselling (G&C) services in secondary education institutions in Ghana. Towards this end, a framework was deveopled in June 2023. This framework recognises the vital role G&C plays in secondary education by providing learners with the necessary support, resources and direction to navigate the challenges they face and make informed decisions about their academic, personal and emotional well-being. It demonstrates a strong emphasis on the need to adequately prepare the learner for further studies, career development, and the world of work. Ultimately, the restructuring seeks to enhance the effectiveness of student support services by aligning support to the evolving needs of the 21st-century learner. It is upon this framework that 49 phase one SEIs (32 SHS, SHTS and STEM schools under GES and 17 Technical Institutes under GTVET have developed and are implementing action plans over an academic year. SEIs will implement various activities across the four themes of the framework – academics, career and tertiary, psychosocial support, and guidance services as proof-of-concept, to be followed consequently, by a national scale-up.
 </p>

                  
                  ")
                                                 )
                                                 
                                                 
                                                 ,
                                                 
                                             ),
                                             
                                             box(width = 12,
                                                 column(3, uiOutput("selectRegion_gcc")),
                                                 column(3, uiOutput("selectSchool_gcc")),
                                                 column(6, uiOutput("selectArea_gcc"))
                                             ),
                                             box(title = "Submission Time", status = "warning", solidHeader = TRUE, width = 12,
                                                 textOutput("latestDateBox_gcc"),
                                                 dateRangeInput("dateRange_gcc", "Select Date Range:", 
                                                                start = min(gcc_data$endtime), end = Sys.Date())
                                             ),
                                             box(title = "Latest Guidance and Counselling Implementation Reports by Schools", width = 12,
                                                 DTOutput("data_table")
                                             )
                                           )
                                           
                                  )
                                )
                        ),
                        
                        tabItem(tabName = "inter",
                                tabsetPanel(
                                  # School Level Result Tab
                                  tabPanel(
                                    "School Level Result", 
                                    fluidRow(
                                      column(width = 6, selectInput("region_select", "Select Region:", choices = NULL, selected = NULL)),
                                      column(width = 6, selectInput("school_select", "Select School:", choices = NULL, selected = NULL))
                                    ),
                                    fluidRow(
                                      valueBoxOutput("total_students", width = 3),
                                      valueBoxOutput("avg_english_score", width = 3),
                                      valueBoxOutput("avg_maths_score", width = 3),
                                      valueBoxOutput("percentage_intervention", width = 3)
                                    ),
                                    fluidRow(
                                      box(
                                        title = "Filter by Gender", status = "primary", solidHeader = TRUE, width = 12,
                                        radioButtons(
                                          inputId = "sex_filter",
                                          label = "Select Gender:",
                                          choices = list("Overall" = "overall", "Male" = "Male", "Female" = "Female"),
                                          selected = "overall",
                                          inline = TRUE
                                        )
                                      )
                                    ),
                                    fluidRow(
                                      box(title = "Proficiency Levels in English", status = "success", solidHeader = TRUE, width = 6, plotOutput("english_proficiency_plot")),
                                      box(title = "Proficiency Levels in Mathematics", status = "success", solidHeader = TRUE, width = 6, plotOutput("math_proficiency_plot"))
                                    ),
                                    fluidRow(
                                      tabBox(
                                        title = "Score Histograms", width = 6,
                                        tabPanel("English Scores", box(title = "Histogram of English Scores", status = "info", solidHeader = TRUE, width = 12, plotOutput("english_scores_histogram"))),
                                        tabPanel("Mathematics Scores", box(title = "Histogram of Mathematics Scores", status = "info", solidHeader = TRUE, width = 12, plotOutput("math_scores_histogram")))
                                      ),
                                      tabBox(
                                        title = "Remedial Analysis", width = 6,
                                        tabPanel("Remedial English", box(title = "Students Needing Remedial Support - English", status = "info", solidHeader = TRUE, width = 12, plotOutput("students_needing_remedial_pie", height = "400px"))),
                                        tabPanel("Remedial Mathematics", box(title = "Students Needing Remedial Support - Maths", status = "info", solidHeader = TRUE, width = 12, plotOutput("remedial_level_distribution", height = "400px")))
                                      )
                                    ),
                                    fluidRow(
                                      box(title = "Insights", status = "warning", solidHeader = TRUE, width = 12, verbatimTextOutput("insights_text"))
                                    )
                                  ),
                                  
                                  # Regional Result Tab
                                  tabPanel(
                                    "Regional Result", 
                                    fluidRow(
                                      column(width = 6, selectInput("region_select_reg", "Select Region:", choices = NULL, selected = NULL))
                                    ),
                                    fluidRow(
                                      valueBoxOutput("total_students_reg", width = 3),
                                      valueBoxOutput("avg_english_score_reg", width = 3),
                                      valueBoxOutput("avg_maths_score_reg", width = 3),
                                      valueBoxOutput("percentage_intervention_reg", width = 3)
                                    ),
                                    fluidRow(
                                      box(
                                        title = "Filter by Gender", status = "primary", solidHeader = TRUE, width = 12,
                                        radioButtons(
                                          inputId = "sex_filter_reg",
                                          label = "Select Gender:",
                                          choices = list("Overall" = "overall", "Male" = "Male", "Female" = "Female"),
                                          selected = "overall",
                                          inline = TRUE
                                        )
                                      )
                                    ),
                                    fluidRow(
                                      box(title = "Proficiency Levels in English", status = "success", solidHeader = TRUE, width = 6, plotOutput("english_proficiency_plot_reg")),
                                      box(title = "Proficiency Levels in Mathematics", status = "success", solidHeader = TRUE, width = 6, plotOutput("math_proficiency_plot_reg"))
                                    ),
                                    fluidRow(
                                      tabBox(
                                        title = "Score Histograms", width = 6,
                                        tabPanel("English Scores", box(title = "Histogram of English Scores", status = "info", solidHeader = TRUE, width = 12, plotOutput("english_scores_histogram_reg"))),
                                        tabPanel("Mathematics Scores", box(title = "Histogram of Mathematics Scores", status = "info", solidHeader = TRUE, width = 12, plotOutput("math_scores_histogram_reg")))
                                      ),
                                      tabBox(
                                        title = "Remedial Analysis", width = 6,
                                        tabPanel("Remedial English", box(title = "Students Needing Remedial Support - English", status = "info", solidHeader = TRUE, width = 12, plotOutput("students_needing_remedial_pie_reg", height = "400px"))),
                                        tabPanel("Remedial Maths", box(title = "Students Needing Remedial Support - Maths", status = "info", solidHeader = TRUE, width = 12, plotOutput("remedial_level_distribution_reg", height = "400px")))
                                      )
                                    ),
                                    fluidRow(
                                      box(title = "Insights", status = "warning", solidHeader = TRUE, width = 12, verbatimTextOutput("insights_text_reg"))
                                    )
                                  ),
                                  
                                  # National Result Tab
                                  tabPanel(
                                    "National Result", 
                                    fluidRow(
                                      valueBoxOutput("total_students_nat", width = 3),
                                      valueBoxOutput("avg_english_score_nat", width = 3),
                                      valueBoxOutput("avg_maths_score_nat", width = 3),
                                      valueBoxOutput("percentage_intervention_nat", width = 3)
                                    ),
                                    fluidRow(
                                      box(
                                        title = "Filter by Gender", status = "primary", solidHeader = TRUE, width = 12,
                                        radioButtons(
                                          inputId = "sex_filter_nat",
                                          label = "Select Gender:",
                                          choices = list("Overall" = "overall", "Male" = "Male", "Female" = "Female"),
                                          selected = "overall",
                                          inline = TRUE
                                        )
                                      )
                                    ),
                                    fluidRow(
                                      box(title = "Proficiency Levels in English", status = "success", solidHeader = TRUE, width = 6, plotOutput("english_proficiency_plot_nat")),
                                      box(title = "Proficiency Levels in Mathematics", status = "success", solidHeader = TRUE, width = 6, plotOutput("math_proficiency_plot_nat"))
                                    ),
                                    fluidRow(
                                      tabBox(
                                        title = "Score Histograms", width = 6,
                                        tabPanel("English Scores", box(title = "Histogram of English Scores", status = "info", solidHeader = TRUE, width = 12, plotOutput("english_scores_histogram_nat"))),
                                        tabPanel("Mathematics Scores", box(title = "Histogram of Mathematics Scores", status = "info", solidHeader = TRUE, width = 12, plotOutput("math_scores_histogram_nat")))
                                      ),
                                      tabBox(
                                        title = "Remedial Analysis", width = 6,
                                        tabPanel("Remedial English", box(title = "Students Needing Remedial Support - English", status = "info", solidHeader = TRUE, width = 12, plotOutput("students_needing_remedial_pie_nat", height = "400px"))),
                                        tabPanel("Remedial Maths", box(title = "Students Needing Remedial Support - Maths", status = "info", solidHeader = TRUE, width = 12, plotOutput("students_needing_remedial_pie_nat_maths", height = "400px")))
                                      )
                                    ),
                                    fluidRow(
                                      box(title = "Insights", status = "warning", solidHeader = TRUE, width = 12, verbatimTextOutput("insights_text_nat"))
                                    )
                                  )
                                )
                        ),
                        
                        # UI for VLS Attendance tab with Overall summary and School Level table
                        tabItem(tabName = "VLC",
                                tabBox(
                                  id = "vls_main_tabs",
                                  width = 12,
                                  
                                  tabPanel("About VLC",
                                           fluidRow(
                                             box(
                                               title = "About Value Learning Community (VLC) Session",
                                               status = "warning",
                                               solidHeader = TRUE,
                                               width = 12,
                                               div(style = "height: 300px; overflow-y: auto;",
                                                   HTML("
          <p>The National Council for Curriculum and Assessment (NaCCA) has developed a new Senior High School (SHS) Curriculum. It aims to ensure that all learners achieve their potential by equipping them with 21st century skills, competencies, character qualities and shared Ghanaian values. Ultimately, the curriculum will prepare learners to live a responsible adult life, further their education, enter the world of work, and promote the awareness and application of shared national values.</p>
          <p>This is the first time that Ghana has developed a secondary curriculum which focuses on national values, attempting to educate a generation of Ghanaian youth who are proud of our country and can contribute effectively to its development. Shared Ghanaian values have been integrated into the curriculum to ensure that all secondary students understand what it means to be a responsible Ghanaian citizen. These values, all of which are identified and described in a <em>National Values Handbook</em> include honesty, integrity, diversity, equity, self-directed learning, confidence, self-discipline, adaptability, resourcefulness, leadership, and responsible citizenship.</p>
          <p>Young people created the handbook for young people. The Ghana Education Service and the National Union of Ghana Students, through the Youth Advisory Board, successfully facilitated the selection of writers for the handbook, engaging students from various SHSs with their chaperones and students from tertiary institutions nationwide. The handbook aims to:</p>
          <ol>
            <li>Highlight core values essential for the development and practice of young people.</li>
            <li>Create a structured guide that assists young people in understanding and implementing these values in their lives.</li>
            <li>Promote a culture of values-driven decision-making and behaviour among young people.</li>
            <li>Help young people understand and appreciate the relation between shared national values and national development.</li>
          </ol>
          <p>The handbook features weekly activities and adopts a student-as-expert approach in which students lead interactive sessions with their peers. The sessions span the academic year, including all of both semesters. There are 22 sessions covering up to 11 core values that will be studied for up to 16 weeks per semester.</p>
          <p>The weekly values handbook sessions will be held concurrently with teachers' Professional Learning Community (PLC) sessions to ensure that students are engaged while their teachers are attending PLC sessions.</p>
        ")
                                               )
                                             )
                                           )
                                  ),
                                  
                                  
                                  #########
                                  
                                  tabPanel("Overall Summary",
                                           fluidRow(
                                             column(3,
                                                    box(
                                                      title = "Filters", status = "warning", solidHeader = TRUE, collapsible = TRUE, width = 12,
                                                      dateRangeInput("vls_overall_date_range", "Date Range:",
                                                                     start = Sys.Date() - 30, end = Sys.Date()),
                                                      actionButton("vls_overall_update", "Update", icon = icon("sync"), 
                                                                   style = "color: #fff; background-color: #f39c12;")
                                                    )
                                             ),
                                             column(9,
                                                    fluidRow(
                                                      valueBoxOutput("vls_total_sessions", width = 6),
                                                      #  valueBoxOutput("vls_total_participants", width = 4),  # Updated to reflect learners
                                                      valueBoxOutput("vls_avg_attendance_rate", width = 6)
                                                    ),
                                                    #box(
                                                    # title = "Learner Participation Trends", status = "warning", solidHeader = TRUE, width = 12,  # Updated title
                                                    #plotlyOutput("vls_overall_trend_chart", height = "250px") 
                                                    #),
                                                    # box(
                                                    #  title = "Regional Comparison", status = "warning", solidHeader = TRUE, width = 12,
                                                    # plotOutput("vls_regional_comparison", height = "250px")
                                                    #)
                                             )
                                           ),
                                           fluidRow(
                                             column(12,
                                                    box(
                                                      title = "Summary by Region", status = "warning", solidHeader = TRUE, width = 12,
                                                      DT::dataTableOutput("vls_overall_summary_table")
                                                    )
                                             )
                                           )
                                  ),
                                  
                                  tabPanel("School Level Summary",
                                           fluidRow(
                                             column(12,
                                                    box(
                                                      title = "Filters", status = "warning", solidHeader = TRUE, collapsible = TRUE, width = 12,
                                                      fluidRow(
                                                        column(3, selectInput("vls_school_region", "Region:", 
                                                                              choices = c("All Regions", 
                                                                                          "Ahafo", "Ashanti", "Bono", "Bono East", "Central", 
                                                                                          "Eastern", "Greater Accra", "North East", "Northern", 
                                                                                          "Oti", "Savannah", "Upper East", "Upper West", 
                                                                                          "Volta", "Western", "Western North"), 
                                                                              selected = "All Regions")),
                                                        column(3, dateRangeInput("vls_school_date_range", "Date Range:",
                                                                                 start = Sys.Date() - 90, end = Sys.Date())),
                                                        column(3, textInput("vls_school_search", "Search School:", "")),
                                                        column(3, br(), actionButton("vls_school_update", "Update", icon = icon("sync"), 
                                                                                     style = "color: #fff; background-color: #f39c12;"))
                                                      )
                                                    )
                                             )
                                           ),
                                           fluidRow(
                                             column(12,
                                                    box(
                                                      title = "School Level VLC Attendance", status = "warning", solidHeader = TRUE, width = 12,
                                                      DT::dataTableOutput("vls_school_table", height = "500px")
                                                    )
                                             )
                                           )
                                  )
                                ),
                                
                                fluidRow(
                                  box(
                                    title = "Download Reports", status = "warning", solidHeader = TRUE, collapsible = TRUE, width = 12,
                                    fluidRow(
                                      column(4,
                                             selectInput("vls_report_type", "Report Type:", 
                                                         choices = c("Overall Summary", "School Level Data"))
                                      ),
                                      column(4,
                                             downloadButton("vls_download_excel", "Download Excel", 
                                                            style = "color: #fff; background-color: #f39c12;")
                                      ),
                                      column(4,
                                             downloadButton("vls_download_pdf", "Download PDF", 
                                                            style = "color: #fff; background-color: #f39c12;")
                                      )
                                    )
                                  )
                                )
                        ),#
                        
                        
                        ########################
                        tabItem(tabName = "tablet",
                                tags$style(HTML("
    .main-tabbox .nav-tabs > li > a {
      background-color: #3c8dbc !important;
      color: white !important;
      border: 1px solid #3c8dbc !important;
    }
    .main-tabbox .nav-tabs > li.active > a,
    .main-tabbox .nav-tabs > li.active > a:focus,
    .main-tabbox .nav-tabs > li.active > a:hover {
      background-color: #2e6da4 !important;
      color: white !important;
      border: 1px solid #2e6da4 !important;
    }
    .main-tabbox .nav-tabs > li > a:hover {
      background-color: #5a9bd4 !important;
      color: white !important;
    }
  ")),
                                
                                fluidRow(
                                  # Title and Overview
                                  column(12,
                                         h2("Tablet Monitoring Dashboard", class = "text-center"),
                                         br()
                                  )
                                ),
                                
                                # Filter Panel
                                fluidRow(
                                  box(
                                    title = "Filters", status = "primary", solidHeader = TRUE, width = 12,
                                    collapsible = TRUE,
                                    fluidRow(
                                      column(6,
                                             selectInput("region_filter", 
                                                         "Select Region:",
                                                         choices = c("All" = "all"),
                                                         selected = "all")
                                      ),
                                      column(6,
                                             actionButton("reset_filters", "Reset Filters", 
                                                          class = "btn btn-warning", 
                                                          style = "margin-top: 25px;")
                                      )
                                    )
                                  )
                                ),
                                
                                # Key Metrics Row
                                fluidRow(
                                  valueBoxOutput("total_schools", width = 3),
                                  valueBoxOutput("tablets_received", width = 3),
                                  valueBoxOutput("tablets_total", width = 3),
                                  valueBoxOutput("students_using", width = 3)
                                ),
                                
                                # Main TabPanel Structure
                                fluidRow(
                                  column(12,
                                         
                                         tabBox(
                                           width = NULL,
                                           title = "Tablet Monitoring Analysis",
                                           
                                           # Tab 1: Overall Summary
                                           tabPanel("Overall Summary",
                                                    br(),
                                                    
                                                    # Charts Row
                                                    #  fluidRow(
                                                    # Tablet Receipt Status
                                                    #column(6,
                                                    #    box(
                                                    #       title = "Tablet Receipt Status", status = "info", solidHeader = TRUE,
                                                    #        width = NULL, height = "400px",
                                                    # plotOutput("receipt_status_plot", height = "300px")
                                                    #       )
                                                    # ),
                                                    
                                                    # Tablet Setup Status
                                                    #  column(6,
                                                    #     box(
                                                    #        title = "Tablet Setup Status", status = "info", solidHeader = TRUE,
                                                    #         width = NULL, height = "400px",
                                                    #          # plotOutput("setup_status_plot", height = "300px")
                                                    #         )
                                                    #   )
                                                    #  ),
                                                    
                                                    # Distribution vs Usage Tables
                                                    fluidRow(
                                                      tabBox(
                                                        width = 12,
                                                        title = "Regional Summary Tables",
                                                        
                                                        # tabPanel("Tablet Distribution",
                                                        #        fluidRow(
                                                        #         column(12,
                                                        #               h4("Tablet Distribution Summary by Region"),
                                                        #              br(),
                                                        #             DT::dataTableOutput("tablet_distribution_table")
                                                        #     )
                                                        #)
                                                        #  ),
                                                        
                                                        tabPanel("Tablet Usage",
                                                                 fluidRow(
                                                                   column(12,
                                                                          h4("Tablet Usage Summary by Region"),
                                                                          br(),
                                                                          DT::dataTableOutput("tablet_usage_table")
                                                                   )
                                                                 )
                                                        ),
                                                        
                                                        tabPanel("Usage Barriers Summary",
                                                                 fluidRow(
                                                                   column(12,
                                                                          h4("Barriers to using the tablets"),
                                                                          br(),
                                                                          
                                                                          DT::dataTableOutput("non_usage_reasons_table")
                                                                          
                                                                   )
                                                                   
                                                                 )
                                                                 
                                                        )
                                                      )
                                                    )
                                           ),
                                           
                                           # Tab 2: School Level Data
                                           tabPanel("School Level Data",
                                                    br(),
                                                    
                                                    # Detailed Data Table
                                                    fluidRow(
                                                      column(12,
                                                             box(
                                                               title = "Detailed School Data", status = "primary", solidHeader = TRUE,
                                                               width = NULL,
                                                               div(style = "overflow-x: auto;",
                                                                   DT::dataTableOutput("detailed_table")
                                                               )
                                                             )
                                                      )
                                                    )
                                                    # Quick Statistics
                                                    
                                           )
                                         )
                                  )
                                )
                        ),
                        
                        
                        tabItem(tabName = "tvet_tablet",
                                tags$style(HTML("
    .tvet-tabbox .nav-tabs > li > a {
      background-color: #9b59b6 !important;
      color: white !important;
      border: 1px solid #9b59b6 !important;
    }
    .tvet-tabbox .nav-tabs > li.active > a,
    .tvet-tabbox .nav-tabs > li.active > a:focus,
    .tvet-tabbox .nav-tabs > li.active > a:hover {
      background-color: #8e44ad !important;
      color: white !important;
      border: 1px solid #8e44ad !important;
    }
    .tvet-tabbox .nav-tabs > li > a:hover {
      background-color: #a569bd !important;
      color: white !important;
    }
  ")),
                                
                                fluidRow(
                                  # Title and Overview
                                  column(12,
                                         h2("TVET Tablet Monitoring Dashboard", class = "text-center"),
                                         h4("Dashboard is Currently Under Development!!!", class = "text-center text-muted"),
                                         br()
                                  )
                                ),
                                
                                # Filter Panel
                                fluidRow(
                                  box(
                                    title = "Filters", status = "primary", solidHeader = TRUE, width = 12,
                                    collapsible = TRUE,
                                    fluidRow(
                                      column(4,
                                             selectInput("tvet_region_filter", 
                                                         "Select Region:",
                                                         choices = c("All" = "all"),
                                                         selected = "all")
                                      ),
                                      column(4,
                                             selectInput("tvet_institution_type", 
                                                         "Institution Type:",
                                                         choices = c("All Types" = "all", 
                                                                     "Technical Institutes" = "technical",
                                                                     "Vocational Schools" = "vocational"
                                                                    ),
                                                         selected = "all")
                                      ),
                                      column(4,
                                             actionButton("tvet_reset_filters", "Reset Filters", 
                                                          class = "btn btn-warning", 
                                                          style = "margin-top: 25px;")
                                      )
                                    )
                                  )
                                )
                        ),
                        
                        
                        
                        
                        ############################
                        
                        
                        tabItem(tabName = "sip_imp",
                                tabsetPanel(
                                  tabPanel("School Level SIP Report",
                                           fluidRow(
                                             
                                             box(title = "About SIP Implementation in the schools", 
                                                 width = 12, 
                                                 div(style = "max-height: 200px; overflow-y: auto;",
                                                     HTML("
                  <p>SIPs for Senior High Schools and Senior High Technical Schools were self-led and developed through a collaborative process. SIPs as the name implies are documented process for addressing gaps in the schools’ practices. They are aimed at improving and enhancing existing practices in the schools. The development of a SIP starts with a whole school self-evaluation; during which the school leadership work collaboratively with the school community including chiefs and queens and school board members to evaluate the activities of the school against eight quality indicators.</p>

                  <p>The eight quality indicators against which the school evaluate themselves are:</p>
                  <ul>
                    <li>Leadership and management</li>
                    <li>Teaching and learning</li>
                    <li>Assessment</li>
                    <li>Monitoring and evaluation</li>
                    <li>Student support services</li>
                    <li>Gender equality and social inclusion</li>
                    <li>Stakeholders’ engagement, and</li>
                    <li>School infrastructure and environment</li>
                  </ul>

                  <p>During this first year of secondary education reforms programme implementation, each school limited their self-evaluation to leadership and management, and teaching and learning practices. Data generated from the self-evaluation are analysed by the school through a collaborative process and a self-evaluation report is prepared to show the outcome of the analysis. The report generally captures good practices identified by the school and practices that needs improving under the two quality indicators. The areas that need improving are further analysed and put in order of priority out of which two or three of the priorities are selected for action.</p>

                  <p>The SIPs on this portal are therefore the outcome of each school’s self-evaluation and their intention to improve specific areas of their school. For school year 2023 and 2024, all senior high and senior high technical schools have identified five key areas for improvement including development of a learning focused vision, mission and value statements for their schools, and institutionalisation of professional learning communities through a weekly professional learning session. The areas of improvement were then translated into strategic objectives with each objective being assigned three achievement indicators or targets and each target having set of actions to be taken to achieve the strategic objectives.</p>
                  <p> Please scroll down, use the drop downs below to access the SIPs of various schools and view progress with regards to implementation!!! <p>
                  ")
                                                 )
                                                 
                                                 
                                                 ,
                                                 
                                             ),
                                             
                                             box(width = 12,
                                                 column(3, uiOutput("selectAcademicYear")),
                                                 
                                                 
                                             )
                                             
                                             
                                             
                                             
                                             
                                             
                                             
                                             
                                             
                                           )
                                           
                                  )
                                )##
                                
                        )##
                        #
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                      )
                      
                      
                    )
)































#section 3

####### This section contains the codes for analysing the data that are then displayed at the UI
server <- function(input, output, session) {
  
  # ---- Home page: stat summary outputs ----
  output$home_stat_regions <- renderUI({
    n <- tryCatch(dplyr::n_distinct(plc_data_new$Region), error = function(e) "—")
    tags$span(class = "stat-number", as.character(n))
  })

  output$home_stat_schools <- renderUI({
    n <- tryCatch(dplyr::n_distinct(plc_data_new$Name_school), error = function(e) "—")
    tags$span(class = "stat-number", as.character(n))
  })

  output$home_stat_years <- renderUI({
    n <- tryCatch(dplyr::n_distinct(access_data$year_access), error = function(e) "—")
    tags$span(class = "stat-number", as.character(n))
  })

  # ---- Home page: navigation button observers ----
  observeEvent(input$home_goto_plc, {
    updateTabItems(session, "sidebarMenu", "plc_attendance")
  })
  observeEvent(input$home_goto_access, {
    updateTabItems(session, "sidebarMenu", "access")
  })
  observeEvent(input$home_goto_vlc, {
    updateTabItems(session, "sidebarMenu", "VLC")
  })
  observeEvent(input$home_goto_tablet, {
    updateTabItems(session, "sidebarMenu", "tablet")
  })

  
  ##################################notification code
  
  
  
  ###############################################
  
  
  
  
  ###########server code for plc_data_new
  
  summary_data <- NULL
  
  # Compute the summary data only once
  if (is.null(summary_data)) {
    filtered_plc_data <- plc_data_new %>%
      filter(plc_take_place == 1) %>%
      mutate(across(c(nts.male_attendance, nts.no_male_teachers, 
                      nts.female_attendance, nts.no_female_teachers), 
                    ~ifelse(. == 0, NA, .)))
    
    summary_data <- filtered_plc_data %>%
      summarise(
        male_attendance = mean(nts.male_attendance / nts.no_male_teachers, na.rm = TRUE),
        female_attendance = mean(nts.female_attendance / nts.no_female_teachers, na.rm = TRUE),
        overall_attendance = mean(nts.total_attendance / nts.total_teachers_schoo, na.rm = TRUE)
      )
  }
  
  
  
  # Render plot
  output$attendance_rate_chart <- renderPlotly({
    req(summary_data)  # Ensure summary data is available
    
    attendance_data <- data.frame(
      category = c("Male", "Female", "Overall"),
      rate = c(summary_data$male_attendance, summary_data$female_attendance, summary_data$overall_attendance),
      colors = RColorBrewer::brewer.pal(3, "Set2")
    )
    
    plot_ly(attendance_data, 
            x = ~category, 
            y = ~rate * 100, 
            type = 'bar', 
            text = ~sprintf("%.2f%%", rate * 100), 
            textposition = 'outside',
            marker = list(color = ~colors)
    ) %>%
      layout(
        title = "Attendance Rate for PLC Handbook 1 - NTS",
        xaxis = list(title = "Category"),
        yaxis = list(title = "Attendance Rate (%)", range = c(25, 100)),
        barmode = 'group'
      )
  })
  
  ############################server code for plc_data_hbk2  
  
  summary_data_hbk2 <- NULL
  
  # Compute the summary data only once
  if (is.null(summary_data_hbk2)) {
    summary_data_hbk2 <- plc_data_hbk2 %>%
      filter(plc_take_place_hbk2 == 1) %>%
      mutate(across(c(nts_hbk2.male_attendance_hbk2, nts_hbk2.no_male_teachers_hbk2, 
                      nts_hbk2.female_attendance_hbk2, nts_hbk2.no_female_teachers_hbk2), 
                    ~ifelse(. == 0, NA, .))) %>%
      summarise(
        male_attendance_hbk2 = mean(nts_hbk2.male_attendance_hbk2 / nts_hbk2.no_male_teachers_hbk2, na.rm = TRUE),
        female_attendance_hbk2 = mean(nts_hbk2.female_attendance_hbk2 / nts_hbk2.no_female_teachers_hbk2, na.rm = TRUE),
        overall_attendance_hbk2 = mean(nts_hbk2.total_attendance_hbk2 / nts_hbk2.total_teachers_schoo_hbk2, na.rm = TRUE)
      )
  }
  
  
  # Render plot
  output$attendance_rate_chart_hbk2 <- renderPlotly({
    req(summary_data_hbk2)  # Ensure summary data is available
    
    attendance_data_hbk2 <- data.frame(
      category = c("Male", "Female", "Overall"),
      rate = c(summary_data_hbk2$male_attendance_hbk2, summary_data_hbk2$female_attendance_hbk2, summary_data_hbk2$overall_attendance_hbk2),
      colors = RColorBrewer::brewer.pal(3, "Set2")
    )
    
    plot_ly(attendance_data_hbk2, 
            x = ~category, 
            y = ~rate * 100, 
            type = 'bar', 
            text = ~sprintf("%.2f%%", rate * 100), 
            textposition = 'outside',
            marker = list(color = ~colors)
    ) %>%
      layout(
        title = "Attendance Rate for PLC Handbook 2",
        xaxis = list(title = "Category"),
        yaxis = list(title = "Attendance Rate (%)", range = c(25, 100)),
        barmode = 'group'
      )
  })
  ################################################################################end of national summary of for handbook 2#############3333
  
  
  ############################server code for plc_data_hbk3  
  
  summary_data_hbk3 <- NULL
  
  # Compute the summary data only once
  if (is.null(summary_data_hbk3)) {
    summary_data_hbk3 <- plc_data_hbk3 %>%
      filter(plc_take_place_hbk3 == 1) %>%
      mutate(across(c(nts_hbk3.male_attendance_hbk3, nts_hbk3.no_male_teachers_hbk3, 
                      nts_hbk3.female_attendance_hbk3, nts_hbk3.no_female_teachers_hbk3), 
                    ~ifelse(. == 0, NA, .))) %>%
      summarise(
        male_attendance_hbk3 = mean(nts_hbk3.male_attendance_hbk3 / nts_hbk3.no_male_teachers_hbk3, na.rm = TRUE),
        female_attendance_hbk3 = mean(nts_hbk3.female_attendance_hbk3 / nts_hbk3.no_female_teachers_hbk3, na.rm = TRUE),
        overall_attendance_hbk3 = mean(nts_hbk3.total_attendance_hbk3 / nts_hbk3.total_teachers_schoo_hbk3, na.rm = TRUE)
      )
  }
  
  
  
  
  # Render plot
  output$attendance_rate_chart_hbk3 <- renderPlotly({
    req(summary_data_hbk3)  # Ensure summary data is available
    
    attendance_data_hbk3 <- data.frame(
      category = c("Male", "Female", "Overall"),
      rate = c(summary_data_hbk3$male_attendance_hbk3, summary_data_hbk3$female_attendance_hbk3, summary_data_hbk3$overall_attendance_hbk3),
      colors = RColorBrewer::brewer.pal(3, "Set2")
    )
    
    plot_ly(attendance_data_hbk3, 
            x = ~category, 
            y = ~rate * 100, 
            type = 'bar', 
            text = ~sprintf("%.2f%%", rate * 100), 
            textposition = 'outside',
            marker = list(color = ~colors)
    ) %>%
      layout(
        title = "Attendance Rate for PLC Handbook 3",
        xaxis = list(title = "Category"),
        yaxis = list(title = "Attendance Rate (%)", range = c(25, 100)),
        barmode = 'group'
      )
  })
  
  #########################################END OF HANDBOOK 3
  
  ##################################################################Handbook 4
  
  summary_data_hbk4 <- NULL
  
  # Compute the summary data only once
  if (is.null(summary_data_hbk4)) {
    summary_data_hbk4 <- plc_data_hbk4 %>%
      filter(plc_take_place_hbk4 == 1) %>%
      mutate(across(c(nts_hbk4_male_attendance_hbk4, nts_hbk4_no_male_teachers_hbk4, 
                      nts_hbk4_female_attendance_hbk4, nts_hbk4_no_female_teachers_hbk4), 
                    ~ifelse(. == 0, NA, .))) %>%
      summarise(
        male_attendance_hbk4 = mean(nts_hbk4_male_attendance_hbk4 / nts_hbk4_no_male_teachers_hbk4, na.rm = TRUE),
        female_attendance_hbk4 = mean(nts_hbk4_female_attendance_hbk4 / nts_hbk4_no_female_teachers_hbk4, na.rm = TRUE),
        overall_attendance_hbk4 = mean(nts_hbk4_total_attendance_hbk4 / nts_hbk4_total_teachers_schoo_hbk4, na.rm = TRUE)
      )
  }
  
  
  
  
  # Render plot
  output$attendance_rate_chart_hbk4 <- renderPlotly({
    req(summary_data_hbk4)  # Ensure summary data is available
    
    attendance_data_hbk4 <- data.frame(
      category = c("Male", "Female", "Overall"),
      rate = c(summary_data_hbk4$male_attendance_hbk4, summary_data_hbk4$female_attendance_hbk4, summary_data_hbk4$overall_attendance_hbk4),
      colors = RColorBrewer::brewer.pal(3, "Set2")
    )
    
    plot_ly(attendance_data_hbk4, 
            x = ~category, 
            y = ~rate * 100, 
            type = 'bar', 
            text = ~sprintf("%.2f%%", rate * 100), 
            textposition = 'outside',
            marker = list(color = ~colors)
    ) %>%
      layout(
        title = "Attendance Rate: Year 1 - Subject Specific PLC Handbook Survey ",
        xaxis = list(title = "Category"),
        yaxis = list(title = "Attendance Rate (%)", range = c(25, 100)),
        barmode = 'group'
      )
  })
  
  
  
  #################################################################End of handbook 4
  
  ##################################################################Handbook 5
  
  summary_data_hbk5 <- NULL
  
  # Compute the summary data only once
  if (is.null(summary_data_hbk5)) {
    summary_data_hbk5 <- plc_data_hbk5 %>%
      filter(plc_take_place_hbk5 == 1) %>%
      mutate(across(c(nts_hbk5_male_attendance_hbk5, nts_hbk5_no_male_teachers_hbk5, 
                      nts_hbk5_female_attendance_hbk5, nts_hbk5_no_female_teachers_hbk5), 
                    ~ifelse(. == 0, NA, .))) %>%
      summarise(
        male_attendance_hbk5 = mean(nts_hbk5_male_attendance_hbk5 / nts_hbk5_no_male_teachers_hbk5, na.rm = TRUE),
        female_attendance_hbk5 = mean(nts_hbk5_female_attendance_hbk5 / nts_hbk5_no_female_teachers_hbk5, na.rm = TRUE),
        overall_attendance_hbk5 = mean(nts_hbk5_total_attendance_hbk5 / nts_hbk5_total_teachers_schoo_hbk5, na.rm = TRUE)
      )
  }
  
  # Render plot
  output$attendance_rate_chart_hbk5 <- renderPlotly({
    req(summary_data_hbk5)  # Ensure summary data is available
    
    attendance_data_hbk5 <- data.frame(
      category = c("Male", "Female", "Overall"),
      rate = c(summary_data_hbk5$male_attendance_hbk5, summary_data_hbk5$female_attendance_hbk5, summary_data_hbk5$overall_attendance_hbk5),
      colors = RColorBrewer::brewer.pal(3, "Set2")
    )
    
    plot_ly(attendance_data_hbk5, 
            x = ~category, 
            y = ~rate * 100, 
            type = 'bar', 
            text = ~sprintf("%.0f%%", rate * 100), 
            textposition = 'outside',
            marker = list(color = ~colors)
    ) %>%
      layout(
        title = "Attendance Rate: Year 2 - Subject Specific PLC Sessions in Schools ",
        xaxis = list(title = "Category"),
        yaxis = list(title = "Attendance Rate (%)", range = c(25, 100)),
        barmode = 'group'
      )
  })
  
  
  #################################################################End of handbook 5
  
  
  
  
  
  
  
  
  #####################################################################################overall summary analysis for curriculum trial schools#############
  
  # Reactive expression for attendance summary
  attendance_summary_trial <- reactive({
    # Start with the base data
    filtered_plc_trial_data <- plc_trial_school %>%
      filter(plc_take_place_curri_trial == 1)
    
    # Apply academic year filter if not "All"
    if (input$academic_year_filter != "All") {
      filtered_plc_trial_data <- filtered_plc_trial_data %>%
        filter(Academic_Year_Trial == input$academic_year_filter)
    }
    
    # Continue with your existing data processing
    filtered_plc_trial_data <- filtered_plc_trial_data %>%
      mutate(across(c(nts_curri_trial.male_attendance_curri_trial, nts_curri_trial.no_male_teachers_curri_trial,
                      nts_curri_trial.female_attendance_curri_trial, nts_curri_trial.no_female_teachers_curri_trial), 
                    ~ifelse(. == 0, NA, .)))
    
    filtered_plc_trial_data %>%
      summarise(
        male_attendance = mean(nts_curri_trial.male_attendance_curri_trial / nts_curri_trial.no_male_teachers_curri_trial, na.rm = TRUE),
        female_attendance = mean(nts_curri_trial.female_attendance_curri_trial / nts_curri_trial.no_female_teachers_curri_trial, na.rm = TRUE),
        overall_attendance = mean(nts_curri_trial.total_attendance_curri_trial / nts_curri_trial.total_teachers_schoo_curri_trial, na.rm = TRUE)
      )
  })
  
  # Your existing renderPlotly code remains the same
  output$attendance_rate_chart_trial <- renderPlotly({
    attendance_data_trial <- data.frame(
      category = c("Male", "Female", "Overall"),
      rate = c(attendance_summary_trial()$male_attendance, 
               attendance_summary_trial()$female_attendance, 
               attendance_summary_trial()$overall_attendance),
      colors = RColorBrewer::brewer.pal(3, "Set2")
    )
    
    plot_ly(attendance_data_trial, 
            x = ~category, 
            y = ~rate * 100, 
            type = 'bar', 
            text = ~sprintf("%.2f%%", rate * 100), 
            textposition = 'outside',
            marker = list(color = ~colors)
    ) %>%
      layout(
        xaxis = list(title = "Category"),
        yaxis = list(title = "Attendance Rate (%)", range = c(25, 100)),
        barmode = 'group'
      )
  })
  
  
  
  
  
  
  #####################################################################################end of overall summary analysis for curriculum trial schools
  
  #####################################################################################
  
  ###########################################handbook 1 regional analysis
  
  # Pre-calculate region_schools data frame outside reactive context
  region_schools <- data.frame(
    Region = c("Ahafo", "Ashanti", "Bono", "Bono East", "Central", "Eastern", "Greater Accra", "North East", "Northern", "Oti", "Savannah", "Upper East", "Upper West", "Volta", "Western", "Western North"),
    no_schools_region = c(16, 139, 35, 29, 75, 92, 46, 13, 27, 22, 12, 32, 29, 69, 35, 18)
  )
  
  # Global variable to store the precomputed summary data
  overall_summary_data <- NULL
  
  # Compute the summary data only once
  if (is.null(overall_summary_data)) {
    overall_summary_data <- plc_data_new %>%
      filter(plc_take_place == 1) %>%
      group_by(Region) %>%
      left_join(region_schools, by = "Region") %>%
      summarise(
        no_schools_region = first(no_schools_region),
        n_schools = n_distinct(Name_school),
        count = sum(plc_take_place == 1),
        male_mean = round(sum(nts.male_attendance, na.rm = TRUE), 0),
        female_mean = round(sum(nts.female_attendance, na.rm = TRUE), 0),
        overall_mean = round(sum(nts.total_attendance, na.rm = TRUE), 0),
        male_pop_mean = round(sum(nts.no_male_teachers, na.rm = TRUE), 0),
        female_pop_mean = round(sum(nts.no_female_teachers, na.rm = TRUE), 0),
        overall_pop_mean = round(sum(nts.total_teachers_schoo, na.rm = TRUE), 0),
        percent_male_attend = scales::percent(male_mean / male_pop_mean),
        percent_female_attend = scales::percent(female_mean / female_pop_mean),
        percent_total_attend = scales::percent(overall_mean / overall_pop_mean),
        percent_plc_schools = scales::percent(n_schools / no_schools_region),
        avg_sessions_school = round(count / n_schools, 0)
      )
  }
  
  
  
  # Visualising using DT table
  output$overall_summary <- renderDT({
    overall_summary_data %>%
      select(Region, no_schools_region, n_schools, count, avg_sessions_school, percent_male_attend, percent_female_attend, percent_total_attend, percent_plc_schools) %>%
      datatable(
        colnames = c(
          "Region", "Total number of schools in the region***", "Number of schools organizing PLC meetings", 
          "Number of meetings organized","Average sessions by school", "% of male teachers attending PLC meetings",
          "% of female teachers attending PLC meetings", "Overall % of teachers attending PLC meetings",
          "% of schools organizing PLC meetings in each region"
        ),
        extensions = 'Buttons',
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          pageLength = 20,
          lengthMenu = c(5, 10, 15, 20, 25, 30),
          autoWidth = TRUE,
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#336699', 'color': '#ffffff'});",
            "}"
          ),
          title = "Regional Level PLC Attendance Rate",
          drawCallback = JS("function(settings) {",
                            "var api = this.api();",
                            "var nrows = api.page.info().recordsDisplay;",
                            "var ncols = api.columns().nodes().length;",
                            "$('#' + settings.sTableId + '_wrapper').append('<div class=\"footnote\">*** Footnote: The total number of schools does not include the 12 Secondary Education Transformation Programme (SETP) schools who have completed the PLC session on NTS and are currently on their third PLC session handbook.</div>');",
                            "}")
        )
      ) %>%
      formatStyle(
        columns = 1:8,
        backgroundColor = "white",
        color = "black",
        border = "1px solid #336699",
        fontSize = "14px"
      ) %>%
      formatStyle(
        columns = 0,
        fontWeight = "bold"
      )
  })
  ###################################################################################################
  
  ###############################################handbook 2 regional analysis
  
  
  # Pre-calculate region_schools data frame outside reactive context
  region_schools_hbk2 <- data.frame(
    Region_hbk2 = c("Ahafo", "Ashanti", "Bono", "Bono East", "Central", "Eastern", "Greater Accra", "North East", "Northern", "Oti", "Savannah", "Upper East", "Upper West", "Volta", "Western", "Western North"),
    no_schools_region_hbk2 = c(17, 140, 35, 29, 75, 93, 46, 14, 29, 25, 12, 35, 31, 67, 36, 18)
  )
  
  overall_summary_data_hbk2 <- NULL
  
  # Compute the summary data only once
  if (is.null(overall_summary_data_hbk2)) {
    overall_summary_data_hbk2 <- plc_data_hbk2 %>%
      group_by(Region_hbk2) %>%
      left_join(region_schools_hbk2, by = "Region_hbk2") %>%
      summarise(
        no_schools_region_hbk2 = first(no_schools_region_hbk2),
        n_schools_hbk2 = n_distinct(Name_school_hbk2),
        count_hbk2 = sum(plc_take_place_hbk2 == 1),
        male_mean_hbk2 = round(sum(nts_hbk2.male_attendance_hbk2, na.rm = TRUE), 0),
        female_mean_hbk2 = round(sum(nts_hbk2.female_attendance_hbk2, na.rm = TRUE), 0),
        overall_mean_hbk2 = round(sum(nts_hbk2.total_attendance_hbk2, na.rm = TRUE), 0),
        male_pop_mean_hbk2 = round(sum(nts_hbk2.no_male_teachers_hbk2, na.rm = TRUE), 0),
        female_pop_mean_hbk2 = round(sum(nts_hbk2.no_female_teachers_hbk2, na.rm = TRUE), 0),
        overall_pop_mean_hbk2 = round(sum(nts_hbk2.total_teachers_schoo_hbk2, na.rm = TRUE), 0),
        percent_male_attend_hbk2 = scales::percent(male_mean_hbk2 / male_pop_mean_hbk2),
        percent_female_attend_hbk2 = scales::percent(female_mean_hbk2 / female_pop_mean_hbk2),
        percent_total_attend_hbk2 = scales::percent(overall_mean_hbk2 / overall_pop_mean_hbk2),
        percent_plc_schools_hbk2 = paste0(format(round(n_schools_hbk2 / no_schools_region_hbk2 * 100, 1), nsmall = 1), "%"),
        avg_sessions_school_hbk2 = round(count_hbk2 / n_schools_hbk2, 0)
      )
  }
  
  
  
  # Visualising using DT table
  output$overall_summary_hbk2 <- renderDT({
    overall_summary_data_hbk2 %>%
      select(Region_hbk2, no_schools_region_hbk2, n_schools_hbk2, count_hbk2, avg_sessions_school_hbk2, percent_male_attend_hbk2, percent_female_attend_hbk2, percent_total_attend_hbk2, percent_plc_schools_hbk2) %>%
      datatable(
        colnames = c(
          "Region", "Total number of schools in the region***", "Number of schools organizing PLC meetings", 
          "Number of meetings organized","Average sessions by school", "% of male teachers attending PLC meetings",
          "% of female teachers attending PLC meetings", "Overall % of teachers attending PLC meetings",
          "% of schools organizing PLC meetings in each region"
        ),
        extensions = 'Buttons',
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          pageLength = 20,
          lengthMenu = c(5, 10, 15, 20, 25, 30),
          autoWidth = TRUE,
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#336699', 'color': '#ffffff'});",
            "}"
          ),
          title = "Regional Level PLC Attendance Rate",
          drawCallback = JS("function(settings) {",
                            "var api = this.api();",
                            "var nrows = api.page.info().recordsDisplay;",
                            "var ncols = api.columns().nodes().length;",
                            "$('#' + settings.sTableId + '_wrapper').append('<div class=\"footnote\">*** Footnote: This includes all the SHS/SHTS that are currently implementing the reform.</div>');",
                            "}")
        )
      ) %>%
      formatStyle(
        columns = 1:8,
        backgroundColor = "white",
        color = "black",
        border = "1px solid #336699",
        fontSize = "14px"
      ) %>%
      formatStyle(
        columns = 0,
        fontWeight = "bold"
      )
  })
  #########################################################################################PLC HANDBOOK 3 REGIONAL SUMMARY
  ###############################################handbook 3 regional analysis
  
  
  # Pre-calculate region_schools data frame outside reactive context
  region_schools_hbk3 <- data.frame(
    Region_hbk3 = c("Ahafo", "Ashanti", "Bono", "Bono East", "Central", "Eastern", "Greater Accra", "North East", "Northern", "Oti", "Savannah", "Upper East", "Upper West", "Volta", "Western", "Western North"),
    no_schools_region_hbk3 = c(17, 141, 36, 29, 75, 93, 46, 14, 29, 25, 12, 35, 31, 68, 36, 18)
  )
  
  overall_summary_data_hbk3 <- NULL
  
  # Compute the summary data only once
  if (is.null(overall_summary_data_hbk3)) {
    overall_summary_data_hbk3 <- plc_data_hbk3 %>%
      group_by(Region_hbk3) %>%
      left_join(region_schools_hbk3, by = "Region_hbk3") %>%
      summarise(
        no_schools_region_hbk3 = first(no_schools_region_hbk3),
        n_schools_hbk3 = n_distinct(Name_school_hbk3),
        count_hbk3 = sum(plc_take_place_hbk3 == 1),
        male_mean_hbk3 = round(sum(nts_hbk3.male_attendance_hbk3, na.rm = TRUE), 0),
        female_mean_hbk3 = round(sum(nts_hbk3.female_attendance_hbk3, na.rm = TRUE), 0),
        overall_mean_hbk3 = round(sum(nts_hbk3.total_attendance_hbk3, na.rm = TRUE), 0),
        male_pop_mean_hbk3 = round(sum(nts_hbk3.no_male_teachers_hbk3, na.rm = TRUE), 0),
        female_pop_mean_hbk3 = round(sum(nts_hbk3.no_female_teachers_hbk3, na.rm = TRUE), 0),
        overall_pop_mean_hbk3 = round(sum(nts_hbk3.total_teachers_schoo_hbk3, na.rm = TRUE), 0),
        percent_male_attend_hbk3 = scales::percent(male_mean_hbk3 / male_pop_mean_hbk3),
        percent_female_attend_hbk3 = scales::percent(female_mean_hbk3 / female_pop_mean_hbk3),
        percent_total_attend_hbk3 = scales::percent(overall_mean_hbk3 / overall_pop_mean_hbk3),
        percent_plc_schools_hbk3 = paste0(format(round(n_schools_hbk3 / no_schools_region_hbk3 * 100, 1), nsmall = 1), "%"),
        avg_sessions_school_hbk3 = round(count_hbk3 / n_schools_hbk3, 0)
      )
  }
  
  
  
  # Visualising using DT table
  output$overall_summary_hbk3 <- renderDT({
    overall_summary_data_hbk3 %>%
      select(Region_hbk3, no_schools_region_hbk3, n_schools_hbk3, count_hbk3, avg_sessions_school_hbk3, percent_male_attend_hbk3, percent_female_attend_hbk3, percent_total_attend_hbk3, percent_plc_schools_hbk3) %>%
      datatable(
        colnames = c(
          "Region", "Total number of schools in the region***", "Number of schools organizing PLC meetings", 
          "Number of meetings organized","Average sessions by school", "% of male teachers attending PLC meetings",
          "% of female teachers attending PLC meetings", "Overall % of teachers attending PLC meetings",
          "% of schools organizing PLC meetings in each region"
        ),
        extensions = 'Buttons',
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          pageLength = 20,
          lengthMenu = c(5, 10, 15, 20, 25, 30),
          autoWidth = TRUE,
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#336699', 'color': '#ffffff'});",
            "}"
          ),
          title = "Regional Level PLC Attendance Rate",
          drawCallback = JS("function(settings) {",
                            "var api = this.api();",
                            "var nrows = api.page.info().recordsDisplay;",
                            "var ncols = api.columns().nodes().length;",
                            "$('#' + settings.sTableId + '_wrapper').append('<div class=\"footnote\">*** Footnote: This includes all the SHS/SHTS that are currently implementing the reform.</div>');",
                            "}")
        )
      ) %>%
      formatStyle(
        columns = 1:8,
        backgroundColor = "white",
        color = "black",
        border = "1px solid #336699",
        fontSize = "14px"
      ) %>%
      formatStyle(
        columns = 0,
        fontWeight = "bold"
      )
  })
  
  
  ########################################################################################END OF PLC HANDBOOK 3 REGIONAL SUMMARY
  ###########################################################################################################
  
  
  
  
  #
  
  ###############################################handbook 4 regional analysis
  
  # Pre-calculate region_schools data frame outside reactive context
  region_schools_hbk4 <- data.frame(
    Region_hbk4 = c("Ahafo", "Ashanti", "Bono", "Bono East", "Central", "Eastern", "Greater Accra", "North East", "Northern", "Oti", "Savannah", "Upper East", "Upper West", "Volta", "Western", "Western North"),
    no_schools_region_hbk4 = c(17, 142, 36, 29, 75, 94, 46, 14, 29, 25, 12, 35, 31, 68, 36, 18)
  )
  
  overall_summary_data_hbk4 <- NULL
  
  # Compute the summary data only once
  if (is.null(overall_summary_data_hbk4)) {
    overall_summary_data_hbk4 <- plc_data_hbk4 %>%
      group_by(Region_hbk4) %>%
      left_join(region_schools_hbk4, by = "Region_hbk4") %>%
      summarise(
        no_schools_region_hbk4 = first(no_schools_region_hbk4),
        n_schools_hbk4 = n_distinct(Name_school_hbk4),
        count_hbk4 = sum(plc_take_place_hbk4 == 1),
        male_mean_hbk4 = round(sum(nts_hbk4_male_attendance_hbk4, na.rm = TRUE), 0),
        female_mean_hbk4 = round(sum(nts_hbk4_female_attendance_hbk4, na.rm = TRUE), 0),
        overall_mean_hbk4 = round(sum(nts_hbk4_total_attendance_hbk4, na.rm = TRUE), 0),
        male_pop_mean_hbk4 = round(sum(nts_hbk4_no_male_teachers_hbk4, na.rm = TRUE), 0),
        female_pop_mean_hbk4 = round(sum(nts_hbk4_no_female_teachers_hbk4, na.rm = TRUE), 0),
        overall_pop_mean_hbk4 = round(sum(nts_hbk4_total_teachers_schoo_hbk4, na.rm = TRUE), 0),
        percent_male_attend_hbk4 = scales::percent(male_mean_hbk4 / male_pop_mean_hbk4),
        percent_female_attend_hbk4 = scales::percent(female_mean_hbk4 / female_pop_mean_hbk4),
        percent_total_attend_hbk4 = scales::percent(overall_mean_hbk4 / overall_pop_mean_hbk4),
        percent_plc_schools_hbk4 = paste0(format(round(n_schools_hbk4 / no_schools_region_hbk4 * 100, 1), nsmall = 1), "%"),
        avg_sessions_school_hbk4 = round(count_hbk4 / n_schools_hbk4, 0)
      )
  }
  
  
  
  # Visualising using DT table
  output$overall_summary_hbk4 <- renderDT({
    overall_summary_data_hbk4 %>%
      select(Region_hbk4, no_schools_region_hbk4, n_schools_hbk4, count_hbk4, avg_sessions_school_hbk4, percent_male_attend_hbk4, percent_female_attend_hbk4, percent_total_attend_hbk4, percent_plc_schools_hbk4) %>%
      datatable(
        colnames = c(
          "Region", "Total number of schools in the region***", "Number of schools organizing PLC meetings", 
          "Number of meetings organized","Average sessions by school", "% of male teachers attending PLC meetings",
          "% of female teachers attending PLC meetings", "Overall % of teachers attending PLC meetings",
          "% of schools organizing PLC meetings in each region"
        ),
        extensions = 'Buttons',
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          pageLength = 20,
          lengthMenu = c(5, 10, 15, 20, 25, 30),
          autoWidth = TRUE,
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#336699', 'color': '#ffffff'});",
            "}"
          ),
          title = "Regional Level PLC Attendance Rate",
          drawCallback = JS("function(settings) {",
                            "var api = this.api();",
                            "var nrows = api.page.info().recordsDisplay;",
                            "var ncols = api.columns().nodes().length;",
                            "$('#' + settings.sTableId + '_wrapper').append('<div class=\"footnote\">*** Footnote: This includes all the SHS/SHTS that are currently implementing the reform.</div>');",
                            "}")
        )
      ) %>%
      formatStyle(
        columns = 1:8,
        backgroundColor = "white",
        color = "black",
        border = "1px solid #336699",
        fontSize = "14px"
      ) %>%
      formatStyle(
        columns = 0,
        fontWeight = "bold"
      )
  })
  
  
  
  
  ########################################################################################END OF PLC HANDBOOK 4 REGIONAL SUMMARY
  ####
  
  
  #############################################Handbook 5 year 2 SSPLC
  ###############################################handbook 5 regional analysis
  
  
  # Pre-calculate region_schools data frame outside reactive context
  region_schools_hbk5 <- data.frame(
    Region_hbk5 = c("Ahafo", "Ashanti", "Bono", "Bono East", "Central", "Eastern", "Greater Accra", "North East", "Northern", "Oti", "Savannah", "Upper East", "Upper West", "Volta", "Western", "Western North"),
    no_schools_region_hbk5 = c(18, 144, 37, 29, 75, 94, 47, 18, 31, 25, 13, 35, 31, 68, 38, 18)
  )
  
  overall_summary_data_hbk5 <- NULL
  
  # Compute the summary data only once
  if (is.null(overall_summary_data_hbk5)) {
    overall_summary_data_hbk5 <- plc_data_hbk5 %>%
      group_by(Region_hbk5) %>%
      left_join(region_schools_hbk5, by = "Region_hbk5") %>%
      summarise(
        no_schools_region_hbk5 = first(no_schools_region_hbk5),
        n_schools_hbk5 = n_distinct(Name_school_hbk5),
        count_hbk5 = sum(plc_take_place_hbk5 == 1),
        male_mean_hbk5 = round(sum(nts_hbk5_male_attendance_hbk5, na.rm = TRUE), 0),
        female_mean_hbk5 = round(sum(nts_hbk5_female_attendance_hbk5, na.rm = TRUE), 0),
        overall_mean_hbk5 = round(sum(nts_hbk5_total_attendance_hbk5, na.rm = TRUE), 0),
        male_pop_mean_hbk5 = round(sum(nts_hbk5_no_male_teachers_hbk5, na.rm = TRUE), 0),
        female_pop_mean_hbk5 = round(sum(nts_hbk5_no_female_teachers_hbk5, na.rm = TRUE), 0),
        overall_pop_mean_hbk5 = round(sum(nts_hbk5_total_teachers_schoo_hbk5, na.rm = TRUE), 0),
        percent_male_attend_hbk5 = scales::percent(male_mean_hbk5 / male_pop_mean_hbk5),
        percent_female_attend_hbk5 = scales::percent(female_mean_hbk5 / female_pop_mean_hbk5),
        percent_total_attend_hbk5 = scales::percent(overall_mean_hbk5 / overall_pop_mean_hbk5),
        percent_plc_schools_hbk5 = paste0(format(round(n_schools_hbk5 / no_schools_region_hbk5 * 100, 1), nsmall = 1), "%"),
        avg_sessions_school_hbk5 = round(count_hbk5 / n_schools_hbk5, 0)
      )
  }
  
  
  
  # Visualising using DT table
  output$overall_summary_hbk5 <- renderDT({
    overall_summary_data_hbk5 %>%
      select(Region_hbk5, no_schools_region_hbk5, n_schools_hbk5, count_hbk5, avg_sessions_school_hbk5, percent_male_attend_hbk5, percent_female_attend_hbk5, percent_total_attend_hbk5, percent_plc_schools_hbk5) %>%
      datatable(
        colnames = c(
          "Region", "Total number of schools in the region***", "Number of schools organizing PLC meetings", 
          "Number of meetings organized","Average sessions by school", "% of male teachers attending PLC meetings",
          "% of female teachers attending PLC meetings", "Overall % of teachers attending PLC meetings",
          "% of schools organizing PLC meetings in each region"
        ),
        extensions = 'Buttons',
        options = list(
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
          pageLength = 20,
          lengthMenu = c(5, 10, 15, 20, 25, 30),
          autoWidth = TRUE,
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'background-color': '#336699', 'color': '#ffffff'});",
            "}"
          ),
          title = "Regional Level PLC Attendance Rate",
          drawCallback = JS("function(settings) {",
                            "var api = this.api();",
                            "var nrows = api.page.info().recordsDisplay;",
                            "var ncols = api.columns().nodes().length;",
                            "$('#' + settings.sTableId + '_wrapper').append('<div class=\"footnote\">*** Footnote: This includes all the SHS/SHTS that are currently implementing the reform.</div>');",
                            "}")
        )
      ) %>%
      formatStyle(
        columns = 1:8,
        backgroundColor = "white",
        color = "black",
        border = "1px solid #336699",
        fontSize = "14px"
      ) %>%
      formatStyle(
        columns = 0,
        fontWeight = "bold"
      )
  })
  
  
  
  ########################################################################################END OF PLC HANDBOOK 5 REGIONAL SUMMARY
  ####
  
  
  
  
  
  ##############END HANDBOOK 5 YEAR 2 SSPLC
  
  
  
  
  ######################################school level for hbk 1 and 2.
  
  
  
  
  output$region_ui <- renderUI({
    selectInput("region_select", 
                label = h4("Select a region to view the PLC attendance summary of schools in the selected region"), 
                choices = unique(plc_data_new$Region), 
                selected = unique(plc_data_new$Region)[1])
  })
  
  
  
  
  table_trial <- reactive({
    data <- plc_data_new %>% 
      filter(plc_take_place == 1, Region == input$region_select) %>%
      mutate(Name_school = factor(Name_school, levels = c ("Bechem Presby Senior High",	"Derma Comm. Day School",	"Samuel Otu Presby Senior High.",	"Boakye Tromo Senior High/Tech",	"Bomaa Comm. Senior High",	"Serwaa Kesse Girls Senior High",	"Terchire Senior High",	"Yamfo Anglican Senior High School",	"Acherensua Senior High",	"Hwidiem Senior High",	"Gyamfi Kumanini Senior High/Tech",	"OLA Girls Senior High, Kenyasi ",	"Kukuom Agric Senior High",	"Sankore Senior High",	"Ahafoman Senior High/Tech",	"Mim Senior High",	"Adu Gyamfi Senior High",	"Agona Senior High/Tech",	"Boanim Senior High/ Tech Sch",	"Konadu Yiadom Catholic Senior High",	"Okomfo Anokye Senior High",	"S.D.A. Senior High, Agona",	"Bankoman Senior High",	"Bodomase Senior High/Tech",	"Dadease Agric Senior High",	"Tweneboa Kodua Senior High",	"Effiduase Senior High/Com",	"Effiduase Senior High/Tech",	"T. I. Ahmadiyya Girl's Senior High, Asokore",	"Tijjaniya Senior High",	"Ghana Muslim Mission Senior High",	"Nsutaman Cath. Senior High",	"Presby Senior High/Tech, Kwamang",	"Akumadan Senior High",	"Asuoso Comm. Senior High",	"Nkenkansu Community Senior High",	"Wiafe Akenten Presby Senior High",	"Dwamena Akenten Senior High",	"Namong Senior High/Tech",	"St. Jerome Senior High, Abofour",	"Christ the King Cath., Obuasi",	"Obuasi Senior High/Tech",	"Spiritan Senior High",	"Amaniampong Senior High",	"Kofiase Adventist Senior High/Tech.",	"Opoku Agyeman Senior High/Tech",	"St. Joseph Sem/Senior High, Mampong",	"St. Monica's Senior High, Mampong",	"Adanwomase Senior High",	"Adventist Girls Senior High, Ntonso",	"Antoa Senior High",	"Gyaama Pensan Senior High/Tech",	"Kofi Adjei Senior High/Tech",	"Simms Senior High/Com.",	"Islamic Senior High,Kumasi",	"Adventist Senior High, Kumasi",	"Agric Nzema Senior High, Kumasi",	"Al-Azariya Islamic Snr. High, Kumasi",	"Anglican Senior High, Kumasi",	"Armed Forces Senior High/Tech, Kumasi",	"Asanteman Senior High",	"J. A. Kufuor Senior High",	"KNUST Senior High",	"Kumasi Girls Senior High,",	"Kumasi High School",	"Kumasi Senior High/Tech",	"Kumasi Wesley Girls High Sch",	"Mancell Senior High",	"Nuru-Ameen Islamic Senior High, Asewase",	"Opoku Ware School",	"Osei Kyeretwie Senior High",	"Pentecost Senior High, Kumasi",	"Prempeh College",	"Prince Of Peace Girls",	"Serwaah Nyarko Girls' Snr. High",	"St. Hubert Sem/Senior High, Kumasi",	"St. Louis Senior High, Kumasi",	"T. I. Ahmadiyya Senior High , Kumasi",	"Uthmaniya Senior High, Tafo",	"Yaa Asantewaa Girls Senior High .",	"Juaben Senior High",	"Akwesi Awobaa Senior High",	"Ejuraman Anglican Senior High",	"Sekyedumase Senior High/Tech",	"Onwe senior High Senior",	"Ejisu Senior High/Tech",	"Achinakrom Senior High",	"Bonwire Senior High/Tech",	"Ejisuman Senior High",	"Church Of Christ Senior High",	"St. Sebastian Cath. Senior High",	"Ghana STEM Academy, Deduako",	"Ghana STEM Academy, Jachie",	"Beposo Senior High",	"Bosomtwe Oyoko Comm. Senior High",	"Jachie Pramso Senior High",	"Osei Adutwum Senior High",	"St. George's Senior High Tech.",	"Bosomtwe Senior High/Tech",	"Bosome Senior High/Tech.",	"Denyaseman Cath.Senior High",	"Ofoase Kokoben Senior High",	"Oppong Mem. Senior High",	"S.D.A. Senior High, Bekwai",	"St. Joseph Senior High/Tech, Ahwiren",	"Wesley High School, Bekwai",	"Barekese Senior High",	"Nkawie Senior High/Tech",	"Osei Tutu Senior High, Akropong",	"Toase Senior High",	"Adobewora Comm. Senior High",	"Mpasatia Senior High/Tech",	"Nyinahin Cath. Senior High",	"Afua Kobi Ampem Girls' Senior High",	"Anum Asamoah Senior High/Tech",	"Atwima Kwanwoma Snr High/Tech",	"Presbyterian Girls Senior High",	"Ibadur Rahman Academy",	"Kumasi Academy",	"Parkoso Comm. Senior High",	"Sakafia Islamic Senior High",	"Tawheed Senior High.",	"Banka Comm. Senior High",	"Bompata Presby Senior High",	"Juaso Senior High/Tech",	"Jubilee Senior High",	"Kurofa Methodist Senior High Tech",	"Morso Senior High/Tech",	"Ofoase Senior High/Tech",	"Agogo State College",	"Collins Senior High/Commercial, Agogo",	"Owerriman Senior High Tech",	"Konongo Odumase Senior High .",	"St. Mary's Girl's Senior High, Konongo",	"Wesley Senior High, Konongo .",	"Esaase Bontefufuo Snr. High/Tech.",	"Manso-Adubia Senior High",	"Mansoman Senior High",	"Jacobu Senior High/Tech.",	"Tweapease Senior High School",	"Adugyama Comm. Senior High",	"Mankranso Senior High",	"Sabronum Methodist Senior High/Tech",	"Maabang Senior High/Tech",	"Tepa Senior High",	"Afigya Senior High/Tech",	"Afigyaman Senior High School",	"St. Michael's Senior High, Ahenkro",	"Aduman Senior High",	"Otumfuo Osei Tutu II College",	"Akrofuom Senior High/Tech",	"New Edubiase Senior High",	"Asare Bediako Senior High .",	"Bodwesango Senior High",	"Dompoase Senior High",	"Fomena T.I. Ahmad Senior High",	"Ghana STEM Academy, Koase",	"Istiquaama Snr. High",	"Koase Senior High/Tech",	"Nkyeraa Senior High Sch.",	"Wenchi Meth. Senior High",	"Badu Senior High/Tech.",	"Menji Senior High",	"Nkoranman Senior High",	"Nsawkaw State Senior High",	"Chiraa Senior High",	"Notre Dame Girls Senior High, Sunyani",	"Odomaseman Senior High",	"Sacred Heart Senior High, Nsoatre",	"S.D.A Senior High, Sunyani",	"St. James Sem & Senior High, Abesim",	"Sunyani Senior High",	"Twene Amanfo Senior High/Tech.",	"Drobo Senior High",	"Our Lady of Providence Senior High",	"Diamono Senior High Sch.",	"Duadaso No. 1 Senior High/Tech.",	"Goka Senior High/Tech.",	"Nafana Senior High",	"St. Ann's Girls Senior High, Sampa",	"Sumaman Senior High",	"Nkrankwanta Comm Senior High",	"Mansen Senior High",	"Wamanafo Senior High/Tech",	"Dormaa Senior High",	"Salvation Army Senior High, Aboabo Dormaa",	"Berekum Presby Senior High",	"Berekum Senior High",	"Jinijini Senior High",	"Methodist Senior High/Tech.,Biadan",	"St. Augustine Senior High, Nsapor-Berekum",	"Bandaman Senior High",	"Ameyaw Akumfi Senior High/Tech.",	"Guakro Effah Senior High",	"Krobo Comm.Senior High",	"St. Francis Seminary/Senior High, Buoyem",	"Tuobodom Senior High/Tech",	"Gyarko Comm. Day Senior High",	"Kesse Basahyia Senior High",	"Kwarteng Ankomah Senior High",	"Our Lady of Mount Carmel Girls Senior High, Techiman",	"Techiman Senior High",	"Yeboah Asuamah Senior High",	"Abrafi Senior High",	"Kwame Danso Senior High/Tech",	"Bassa Community Senior High",	"Kajaji Senior High",	"Abeaseman Comm. Day Senior High",	"Prang Senior High",	"Yeji Senior High/Tech",	"Donkro- Nkwanta Senior High",	"Kwabre Senior High",	"Nkoranza Senior High/Tech",	"Busunya Senior High",	"Osei Bonsu Senior High",	"Jema Senior High",	"Kintampo Senior High",	"New Longoro Comm.School (Dega)",	"Amanten Senior High",	"Atebubu Senior High",	"New Krokompe Comm. Senior High",	"Ayanfuri Senior High",	"Diaso Senior High",	"Boa-Amponsem Senior High",	"Dunkwa Senior High/Tech",	"Kyekyewere Comm. Senior High School",	"Mokwaa Senior High Sch",	"Jukwa Senior High",	"Twifo Hemang Senior High/Tech",	"Twifo Praso Senior High",	"Abeadze State College",	"Kwegyir Aggrey Senior High",	"Mankessim Senior High/Tech",	"Methodist High School,Saltpond",	"Mfantsiman Girls Senior High",	"Kobina Ansah SHS",	"Edinaman Senior High",	"Eguafo-Abrem Senior High",	"Komenda Senior High/Tech.",	"Apam Senior High",	"College of Music Senior, Mozano",	"Gomoa Senior High/Tech",	"Mozano Senior High",	"Fettehman Senior High",	"Gomoa Gyaman Senior High",	"Potsin T.I. Ahm. Senior High",	"S.D.A SHS, Jukwa",	"St. Gregory Catholic Senior High School",	"Ogyeedom Comm.Snr High/Tech",	"Akyin Senior High School",	"Ekumfi T. I. Ahmadiiyya Snr. High",	"J.E.A. Mills Senior High",	"Winneba Senior High",	"Academy of Christ the King, Cape Coast",	"Adisadel College",	"Effutu Senior High/Tech",	"Ghana National College",	"Holy Child School, Cape Coast",	"Mfantsipim School",	"Oguaa Senior High/Tech",	"St. Augustine's College, Cape Coast",	"University Practice Senior High",	"Wesley Girls Senior High, Cape Coast",	"Awutu Bawjiase Comm. Senior High",	"Awutu Winton Senior High",	"Obrachire Senior High/Tech",	"Odupong Comm. Day School",	"Senya Senior High",	"Bontrase Senior High Tech. Sch",	"Adankwaman Senior High",	"Assin Manso Senior High",	"Assin Nsuta Agric. Senior High",	"Nyankumase Ahenkro Snr. High",	"Assin North Senior High/Tech",	"Assin State College",	"Gyaase Community Senior High",	"Obiri Yeboah Senior High/Technical",	"Brakwa Senior High/Tech",	"Breman Asikuma Senior High",	"Odoben Senior High",	"Bisease Senior High/Com",	"Enyan Denkyira Senior High",	"Enyan Maim Comm. Day School",	"Mando Senior High/Tech.",	"Agona Fankobaa Senior High",	"Nyakrom Senior High Tech",	"Siddiq Senior High Sch.",	"Swedru Sch. Of Business",	"Agona Namonwora Comm.Senior High",	"Ampim Darko Senior High School",	"Kwanyako Senior High ",	"Nsaba Presby Senior High",	"Swedru Senior High",	"Abakrampa Senior High/Tech",	"Aburaman Senior High",	"Aggrey Mem. A.M.E.Zion Snr. High",	"Moree Comm. Senior High",	"Apesua Comm. Senior High",	"Klo-Agogo Senior High",	"Yilo Krobo Senior High/Com",	"Asamankese Senior High",	"St. Thomas Senior High/Tech",	"Adeiso Presby Senior High",	"Kwaobaah Nyanoa Comm. Senior High",	"Asesewa Senior High School",	"Islamic Girls Senior High,Suhum",	"Presby Senior High, Suhum",	"Suhum Senior High/Tech",	"Nsawam Senior High",	"St. Martin's Senior High, Nsawam",	"Ghana Senior High, Koforidua ",	"Koforidua Senior High/Tech",	"New Juaben Senior High/Com",	"Oti Boateng Senior High",	"Oyoko Methodist Senior High",	"Pope John Snr. High & Min. Sem., Koforidua",	"S.D.A Senior High, Koforidua",	"Pentecost Senior High,Koforidua",	"Akro Senior High/Tech",	"Akuse Methodist Senior High/Tech",	"Krobo Girls Senior High",	"Manya Krobo Senior High",	"Fodoa Comm. Senior High",	"Nkawkaw Senior High",	"Bepong Senior High School",	"Kwahu Ridge Senior High",	"Mpraeso Senior High",	"St. Paul's Senior High, Asakraka Kwahu",	"St. Peter's Senior High, Nkwatia",	"Abetifi Presby Senior High",	"Kwahu Tafo Senior High",	"Nkwatia Presby Senior High/Com",	"St. Dominic's Senior High/Tech, Pepease",	"Asuom Senior High",	"Kade Senior High/Tech.",	"New Nsutam Senior High/Tech",	"Osino Presby Senior High/Tech.",	"Presby Senior High, Begoro",	"Abuakwa State College",	"Akim Asafo Senior High",	"Apedwa Presby Senior High",	"Kibi Senior High/Tech",	"Ofori Panin Senior High",	"Saviour Senior High, Osiem",	"St. Stephen's Presby Snr. High/Tech, Asiakwa",	"W.B.M. Zion Senior High, Old Tafo",	"St. Rose's Senior High, Akwatia",	"Salvation Army Senior High, Akim Wenchi",	"Tarkrowase Comm. Senior High",	"Achiase Senior High",	"Akim Swedru Senior High",	"Aperade Senior High/Tech.",	"Amuana Praso Senior High",	"New Abirem/Afosu Senior High",	"St. Michael's Senior High, Akoase (Nkawkaw)",	"Akroso Senior High/Tech",	"Attafuah Senior High/Tech",	"Atweaman Senior High",	"Oda Senior High",	"St. Francis Senior High/Tech, Akim Oda",	"Anum Apapam Comm. Day",	"Kraboa-Coaltar Presby Snr. High/Tech.",	"STEM Academy, Abomosu",	"S.D.A. Senior High. Akim Sekyere",	"Kwabeng Anglican Senior High/Tech",	"Adjena Senior High/Tech.",	"Akwamuman Senior High",	"Anum Presby Senior High",	"Apeguso Senior High",	"Boso Senior High Technical",	"Akokoaso Senior High/Tech",	"Ayirebi Senior High",	"Aburi Girls Senior High",	"Adonten Senior High",	"Diaspora Girls' Senior High",	"Presby Senior High/Tech, Aburi",	"Benkum Senior High",	"H'Mount Sinai Senior High",	"Mampong/Akw Snr. High/Tech for the Deaf",	"Mangoase Senior High",	"Methodist Girls Senior High, Mamfe",	"Nifa Senior High",	"Okuapeman Senior High",	"Presby Senior High, Mampong Akwapim",	"Presby Senior High/Tech, Adukrom",	"Presby Senior High/Tech, Larteh",	"Maame Krobo Comm. Senior High",	"St. Fidelis Senior High/Tech",	"Donkorkrom Agric Senior High",	"Mem-Chemfre Comm. Senior High",	"Lashibi Comm. Day",	"Chemu Senior High/Tech",	"Our Lady of Mercy Senior High",	"Presby Senior High, Tema",	"Tema Manhean Senior High/Tech",	"Tema Meth. Day Senior High",	"Tema Senior High ",	"Ghanata Senior High",	"Osudoku Senior High/Tech.",	"Ningo Senior High",	"Prampram Senior High",	"O'Reilly Senior High",	"Presby Senior High, Teshie",	"West Africa Senior High",	"Presby Boys Senior High, Legon",	"Forces Senior High/Tech, Burma Camp",	"La Presby Senior High",	"Labone Senior High",	"St. Thomas Aquinas Senior High, Cantoments",	"Nungua Senior High",	"Kpone Comm. Senior High",	"Adjen Kotoku Senior High",	"Akramaman Senior High",	"Amasaman Senior High/Tech",	"St. John's Grammar Senior High",	"Christian Methodist Senior High",	"Ngleshie Amanfro Senior High",	"Kwabenya Comm. Senior High",	"Odorgonno Senior High",	"Ashiaman Senior High",	"Frafraha Comm. Senior High",	"Ada Senior High/Tech.",	"Ada Senior High",	"Accra Academy",	"Accra Girls Senior High .",	"Accra Senior High",	"Accra Wesley Girls High",	"Achimota Senior High",	"Ebenezer Senior High",	"Holy Trinity Senior High",	"Kaneshie Senior High/Tech.",	"Kinbu Senior High/Tech",	"Presby Senior High, Osu",	"St. Margaret Mary Snr.High/Tech",	"St. Mary's Senior High, Korle Gonno ",	"Wesley Grammar Senior High",	"Yunyoo-Nasuan Comm. SHS",	"Ghana STEM Academy, Kpasenpke",	"Janga Senior High/Tech",	"Walewale Senior High",	"Wulugu Senior High",	"Yagaba Senior High School",	"Gambaga Girls Senior High",	"Langbinsi Senior High/Tech",	"Nalerigu Senior High",	"Sakogu Senior High/Tech",	"Chereponi Senior High/Tech.",	"Bunkpurugu Senior High/Tech",	"Nakpanduri Senior High",	"Presby SHTS, Nankpanduri",	"Zabzugu Senior High",	"Dagbon State Senior High/Tech",	"Yendi Senior High",	"Kasuliyili Senior High",	"Tolon Senior High",	"E. P. Agric Senior High/Tech.",	"Anbariya Senior High Sch.",	"Business Senior High, Tamale",	"Ghana Senior High, Tamale",	"Presby Senior High, Tamale",	"St. Charles Senior High, Tamale",	"Tamale Girls Senior High",	"Vitting Senior High/Tech.",	"Pong-Tamale Senior High",	"Savelugu Senior High",	"Islamic Science Senior High, Tamale",	"Kalpohin Senior High",	"Northern School of Business",	"Tamale Senior High .",	"Saboba E.P. Senior High",	"Wapuli Comm. Senior High",	"Wulensi Senior High",	"Bimbilla Senior High",	"Sang Comm. Day School",	"Kumbungu Senior High",	"Kpandai Senior High",	"Karaga Senior High",	"Gushegu Senior High",	"Kyabobo Girls' School",	"Nkwanta Comm.Senior High",	"Nkwanta Senior High",	"Ntruboman Senior High",	"Kpassa Senior High/Tech",	"Kete Krachi Senior High/Tech.",	"Krachi Senior High",	"Nchumuruman Comm. Day Senior High",	"Asukawkaw Senior High",	"Oti Senior High/Tech Sch",	"Yabram Comm. Day School",	"Ahamansu Islamic Senior High School",	"Dodi-Papase Senior High/Tech",	"Kadjebi-Asato Senior High",	"Baglo Ridge Senior High/Tech.",	"Bueman Senior High .",	"Okadjakrom Senior High/Tech.",	"Biakoye Comm. School",	"Bowiri Comm. Day School",	"Nkonya Senior High",	"Tapaman Senior High/Tech",	"Worawora Senior High",	"Damongo Senior High",	"Ndewura Jakpa Senior High/Tech.",	"Sawla Senior High Sch.",	"Tuna Senior High/Tech.",	"Daboya Comm. Day School",	"Salaga Senior High",	"Salaga T.I. Ahmad Senior High",	"Buipe Senior High",	"Mpaha Comm. Senior High",	"Bamboi Comm. Senior High",	"Bole Senior High",	"St. Anthony of Padua Senior High/Tech",	"Bolgatanga Senior High ",	"Tongo Senior High/Tech",	"Pusiga Comm. Day Senior High Sch.",	"Kongo Senior High",	"Chiana Senior High",	"Mirigu Community Day Senior High",	"Nabango Senior High Tech",	"Paga Senior High",	"Sirigu Senior High",	"Awe Senior High/Tech.",	"Navrongo Senior High ",	"Notre Dame Sem/ Senior High, Navrongo",	"St. John's Integrated Snr. High/Tech",	"O.L.L. Girls Senior High",	"Tempane Senior High",	"Garu Comm. Day Senior High",	"Fumbisi Senior High",	"Kanjaga Comm. Senior High",	"Naab Azantilow Senior High/Tech.",	"Sandema Senior High",	"Wiaga Comm. Senior High",	"Azeem-Namoa Senior High/Tech",	"Bongo Senior High",	"Gowrie Senior High/Tech.",	"Zorkor Senior High",	"Bolga Girls Senior High ",	"Bolga Sherigu Comm. Senior High",	"Zamse Senior High/Tech",	"Zuarungu Senior High",	"Gambigo Comm. Day Senior High",	"Binduri Comm. Senior High",	"Kusanaba Senior High",	"Zebilla Senior High/Tech",	"Bawku Senior High",	"Bawku Senior High/Tech.",	"Lassie-Tuolu Senior High",	"Islamic Senior High, Wa",	"Jamiat Al-Hidaya Islamic Girls",	"Northern Star Senior High",	"T. I. Ahmadiyya Senior High, Wa",	"Wa Senior High .",	"Wa Senior High/Tech.",	"Funsi Senior High School",	"Loggu Comm. Day School",	"Dr. Hila Liman Senior High School",	"Kanton Senior High",	"Tumu Senior High/Tech.",	"Ko Senior High",	"Nandom Senior High",	"Sombo Senior High",	"Kaleo Senior High/Tech",	"Queen of Peace Senior High, Nadowli",	"St. Augustine Senior High/Tech, Saan Charikpong",	"Takpo Senior High Sch.",	"Birifoh Senior High Sch.",	"Eremon Senior High/Tech.",	"Lawra Senior High ",	"Lambussie Comm. Senior High",	"Piina Senior High",	"Holy Family Senior High",	"Han Senior High",	"Jirapa Senior High",	"St. Francis Girls Senior High, Jirapa ",	"Ullo Senior High",	"Daffiamah Senior High",	"Dabala Senior High/Tech.",	"Sogakope Senior High",	"St. Catherine Girls Senior High",	"Kpeve Senior High Tech",	"Peki Senior High",	"Peki Senior High/Technical",	"Tongor Senior High Tech.",	"Aveyime Battor Senior High/Tech.",	"Battor Senior High",	"Dofor Senior High",	"Mepe St. Kizito Senior High/Tech.",	"Volo Comm. Senior High",	"Anfoega Senior High",	"Vakpo Senior High",	"Vakpo Senior High/Tech",	"Bishop Herman College",	"Kpando Senior High .",	"Aflao Community SHS",	"Klikor Senior High/Tech.",	"Some Senior High",	"St. Paul's Senior High, Denu",	"Three Town Senior High",	"Afife Senior High Tech.",	"Dzodze Penyi Senior High",	"Weta Senior High/Tech.",	"Wovenu Senior High Technical",	"Keta Senior High/Tech .",	"Afadjato Senior High/Tech.",	"Akpafu Senior High/Tech.",	"Alavanyo Senior High/Tech.",	"E. P. Senior High",	"Likpe Senior High",	"St. Mary's Sem.& Senior High, Lolobi",	"Abutia Senior High/Tchnical",	"Akome Senior High/Tech.",	"Avatime Senior High",	"Dzolo Senior High",	"Kpedze Senior High",	"Tsito Senior High/Tech",	"Awudome Senior High .",	"E.P.C. Mawuko Girls Senior High",	"Mawuli School, Ho",	"OLA Girls Senior High, Ho",	"Shia Senior HighTechnical",	"Sokode Senior High/Tech",	"Tanyigbe Senior High",	"Taviefe Senior High",	"Ziavi Senior High/Tech",	"Adidome Senior High",	"Mafi-Kumasi Senior High/Tech",	"Abor Senior High",	"Anlo Afiadenyigba Senior High",	"Anlo Awomefia Senior High",	"Anlo Senior High",	"Atiavi Senior High/Tech",	"Keta Business Senior High",	"Tsiame Senior High",	"Volta Senior High School",	"Zion Senior High",	"Avenor Senior High",	"Ave Senior High",	"Akatsi Senior High/Tech",	"Agotime Senior High",	"Ziope Senior High Sch.",	"Agate Comm. Senior High",	"Jim Bourton Mem Agric. Senior High",	"Leklebi Senior High",	"Ve Comm. Senior High",	"Adaklu Senior High",	"Gbekor Senior High",	"Asankrangwa Senior High",	"Asankrangwa Senior High/Tech",	"Amenfiman Senior High",	"Benso Senior High/Tech",	"Fiaseman Senior High",	"Tarkwa Senior High",	"Ahantaman Girls' Senior High",	"Shama Senior High",	"Adiembra Senior High",	"Archbishop Porter Girls Snr.High .",	"Bompeh Senior High./Tech",	"Diabene Senior High/Tech",	"Fijai Senior High",	"Ghana Senior High/Tech",	"Methodist Senior High, Sekondi",	"Sekondi College ",	"St. John's Senior High, Sekondi",	"Huni Valley Senior High",	"Prestea Senior High/Tech",	"St. Augustine's Senior High, Bogoso",	"Axim Girls Senior High",	"Gwiraman Comm.Senior High",	"Nsein Senior High",	"Daboase Senior High/Tech",	"Mpohor Senior High",	"Annor Adjaye Senior High",	"Half Assini Senior High",	"Bonzo-Kaku Senior High",	"Esiama Senior High/Tech",	"Nkroful Agric. Senior High",	"Uthman Bin Afam SHS",	"Takoradi Senior High",	"Baidoo Bonso Senior High/Tech",	"Sankor Senior High School",	"St. Mary's Boys' Senior High, Apowa",	"Manso-Amenfi Comm. Day School",	"Dadieso Senior High",	"Asawinso Senior High",	"Sefwi-Wiawso Senior High",	"Sefwi-Wiawso Senior High/Tech",	"St. Joseph Senior High, Sefwi Wiawso",	"Akontombra Senior High",	"Nsawora Edumafa Comm. Senior High School",	"Juaboso Senior High",	"Bodi Senior High",	"Bibiani Senior High/Tech.",	"Chirano Comm. Day School",	"Ghana STEM Academy, Awaso",	"Queens Girls' Senior High, Sefwi Awhiaso",	"Sefwi Bekwai Senior High",	"Adjoafua Comm. Senior High",	"Bia Senior High/Tech",	"Adabokrom Comm. SHS",	"Nana Brentu Senior High/Tech", "Nuriya Islamic SHS", "Presbyterian Boys Model SHS", "Wioso SHS", "Holy Child SHS", "Twereku Ampem SHS", "Kyem Amponsah SHS", "Gomoa Jukwa SDA SHS"))) %>%
                                                           group_by(Name_school) %>%
                                                             summarise(
                                                               count = sum(plc_take_place == 1),
                                                               sessions_hbk1 = list(nts.Session),
                                                               male_mean = round(mean(nts.male_attendance, na.rm = TRUE),0),
                                                               female_mean = round(mean(nts.female_attendance, na.rm = TRUE),0),
                                                               overall_mean = round(mean(nts.total_attendance, na.rm = TRUE),0),
                                                               male_pop_mean = round(mean(nts.no_male_teachers, na.rm = TRUE),0),
                                                               female_pop_mean = round(mean(nts.no_female_teachers, na.rm = TRUE),0),
                                                               overall_pop_mean = round(mean(nts.total_teachers_schoo, na.rm = TRUE),0),
                                                               percent_male_attend = scales::percent(male_mean/male_pop_mean),
                                                               percent_female_attend = scales::percent(female_mean/female_pop_mean),
                                                               percent_total_attend = scales::percent(overall_mean/overall_pop_mean)
                                                             )%>%
                                                             rowwise() %>%
                                                             mutate(
                                                               units_completed_hbk1 = {
                                                                 session_nums_1 <- unlist(str_extract_all(unlist(sessions_hbk1), "\\d+"))
                                                                 session_nums_1 <- unique(as.numeric(session_nums_1))
                                                                 session_nums_1 <- sort(session_nums_1)
                                                                 if (length(session_nums_1) > 0) {
                                                                   paste("PLC Session(s):", paste(session_nums_1, collapse = ", "))
                                                                 } else {
                                                                   "PLC Session(s): None"
                                                                 }
                                                               }
                                                             ) %>%
                                                             ungroup()
                                                           
                                                           # Debug: Print the first few rows to the console to check
                                                           print(head(data))
                                                           return(data)
  })
  
  
  
  
  #Initially I used plot_ly table. However, the regional teams keep requesting for a way to download the school tables. Plot_ly does not have
  #that function so I switched to Rhandsontable. 
  output$table_plot <- renderRHandsontable({
    table_data <- table_trial()
    
    if (is.null(table_data)) {
      return(NULL) # Return NULL if table_data is NULL (i.e., an error occurred)
    }
    
    table_data$Name_school <- as.character(table_data$Name_school) # Convert factor to character
    
    table_data_subset <- table_data[, c("Name_school", "count", "units_completed_hbk1", "percent_male_attend", "percent_female_attend", "percent_total_attend")]
    
    rhandsontable(table_data_subset,
                  colHeaders = c("School name", "Number of meetings Held","Details of Sessions Completed and Submitted", "Male teacher attendance (percent)", "Female teacher attendance (percent)", "Overall attendance (percent)"),
                  rowHeaders = NULL,
                  search = TRUE,
                  readOnly = TRUE) %>%
      hot_context_menu(
        customOpts = list(
          csv = list(
            name = "Download to CSV",
            callback = JS(
              "function (key, options) {
             var csv = csvString(this, sep = ',', dec = '.');

             var link = document.createElement('a');
             link.setAttribute('href', 'data:text/plain;charset=utf-8,' +
               encodeURIComponent(csv));
             link.setAttribute('download', 'table_data.csv');

             document.body.appendChild(link);
             link.click();
             document.body.removeChild(link);
           }")
          )
        )
      ) %>%
      hot_cols(
        colWidths = c(280, rep(180, 5))  # Adjust column widths as needed
      ) %>%
      onRender(
        JS(
          "function(el, x) {
           var hot = this.hot;  // Reference to the Handsontable instance
           hot.addHook('beforeChange', function(changes, source) {
             if (source === 'alter' && (changes[0][0] === 'insert_row' || changes[0][0] === 'remove_row')) {
               return false;  // Prevent row insertion and deletion
             }
           });
         }"
        )
      )
  })
  
  output$export_button <- downloadHandler(
    filename = function() {
      paste("table_export", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      table_data <- table_trial()  # Make sure this is getting the correct data
      # Check if column names match
      table_data_subset <- table_data[, c("Name_school", "count", "units_completed_hbk1", "percent_male_attend", "percent_female_attend", "percent_total_attend")]
      # Debug: Uncomment below line to check data in the R console
      # print(head(table_data_subset))
      write.csv(table_data_subset, file, row.names = FALSE)
    }
  )
  
  
  ##########################################################################code for handbook 2 plc attendance
  
  
  
  
  
  output$region_ui_hbk2 <- renderUI({
    selectInput("region_select_hbk2", 
                label = h4("Select a region to view the PLC attendance summary of schools in the selected region for Handbook 2"), 
                choices = unique(plc_data_hbk2$Region_hbk2), 
                selected = unique(plc_data_hbk2$Region_hbk2)[1])
  })
  
  table_trial_hbk2 <- reactive({
    data_hbk2 <- plc_data_hbk2 %>% 
      filter(plc_take_place_hbk2 == 1, Region_hbk2 == input$region_select_hbk2) %>%
      mutate(Name_school_hbk2 = factor(Name_school_hbk2, levels = c ("Bechem Presby Senior High",	"Derma Comm. Day School",	"Samuel Otu Presby Senior High.",	"Boakye Tromo Senior High/Tech",	"Bomaa Comm. Senior High",	"Serwaa Kesse Girls Senior High",	"Terchire Senior High",	"Yamfo Anglican Senior High School",	"Acherensua Senior High",	"Hwidiem Senior High",	"Gyamfi Kumanini Senior High/Tech",	"OLA Girls Senior High, Kenyasi ",	"Kukuom Agric Senior High",	"Sankore Senior High",	"Ahafoman Senior High/Tech",	"Mim Senior High",	"Adu Gyamfi Senior High",	"Agona Senior High/Tech",	"Boanim Senior High/ Tech Sch",	"Konadu Yiadom Catholic Senior High",	"Okomfo Anokye Senior High",	"S.D.A. Senior High, Agona",	"Bankoman Senior High",	"Bodomase Senior High/Tech",	"Dadease Agric Senior High",	"Tweneboa Kodua Senior High",	"Effiduase Senior High/Com",	"Effiduase Senior High/Tech",	"T. I. Ahmadiyya Girl's Senior High, Asokore",	"Tijjaniya Senior High",	"Ghana Muslim Mission Senior High",	"Nsutaman Cath. Senior High",	"Presby Senior High/Tech, Kwamang",	"Akumadan Senior High",	"Asuoso Comm. Senior High",	"Nkenkansu Community Senior High",	"Wiafe Akenten Presby Senior High",	"Dwamena Akenten Senior High",	"Namong Senior High/Tech",	"St. Jerome Senior High, Abofour",	"Christ the King Cath., Obuasi",	"Obuasi Senior High/Tech",	"Spiritan Senior High",	"Amaniampong Senior High",	"Kofiase Adventist Senior High/Tech.",	"Opoku Agyeman Senior High/Tech",	"St. Joseph Sem/Senior High, Mampong",	"St. Monica's Senior High, Mampong",	"Adanwomase Senior High",	"Adventist Girls Senior High, Ntonso",	"Antoa Senior High",	"Gyaama Pensan Senior High/Tech",	"Kofi Adjei Senior High/Tech",	"Simms Senior High/Com.",	"Islamic Senior High,Kumasi",	"Adventist Senior High, Kumasi",	"Agric Nzema Senior High, Kumasi",	"Al-Azariya Islamic Snr. High, Kumasi",	"Anglican Senior High, Kumasi",	"Armed Forces Senior High/Tech, Kumasi",	"Asanteman Senior High",	"J. A. Kufuor Senior High",	"KNUST Senior High",	"Kumasi Girls Senior High,",	"Kumasi High School",	"Kumasi Senior High/Tech",	"Kumasi Wesley Girls High Sch",	"Mancell Senior High",	"Nuru-Ameen Islamic Senior High, Asewase",	"Opoku Ware School",	"Osei Kyeretwie Senior High",	"Pentecost Senior High, Kumasi",	"Prempeh College",	"Prince Of Peace Girls",	"Serwaah Nyarko Girls' Snr. High",	"St. Hubert Sem/Senior High, Kumasi",	"St. Louis Senior High, Kumasi",	"T. I. Ahmadiyya Senior High , Kumasi",	"Uthmaniya Senior High, Tafo",	"Yaa Asantewaa Girls Senior High .",	"Juaben Senior High",	"Akwesi Awobaa Senior High",	"Ejuraman Anglican Senior High",	"Sekyedumase Senior High/Tech",	"Onwe senior High Senior",	"Ejisu Senior High/Tech",	"Achinakrom Senior High",	"Bonwire Senior High/Tech",	"Ejisuman Senior High",	"Church Of Christ Senior High",	"St. Sebastian Cath. Senior High",	"Ghana STEM Academy, Deduako",	"Ghana STEM Academy, Jachie",	"Beposo Senior High",	"Bosomtwe Oyoko Comm. Senior High",	"Jachie Pramso Senior High",	"Osei Adutwum Senior High",	"St. George's Senior High Tech.",	"Bosomtwe Senior High/Tech",	"Bosome Senior High/Tech.",	"Denyaseman Cath.Senior High",	"Ofoase Kokoben Senior High",	"Oppong Mem. Senior High",	"S.D.A. Senior High, Bekwai",	"St. Joseph Senior High/Tech, Ahwiren",	"Wesley High School, Bekwai",	"Barekese Senior High",	"Nkawie Senior High/Tech",	"Osei Tutu Senior High, Akropong",	"Toase Senior High",	"Adobewora Comm. Senior High",	"Mpasatia Senior High/Tech",	"Nyinahin Cath. Senior High",	"Afua Kobi Ampem Girls' Senior High",	"Anum Asamoah Senior High/Tech",	"Atwima Kwanwoma Snr High/Tech",	"Presbyterian Girls Senior High",	"Ibadur Rahman Academy",	"Kumasi Academy",	"Parkoso Comm. Senior High",	"Sakafia Islamic Senior High",	"Tawheed Senior High.",	"Banka Comm. Senior High",	"Bompata Presby Senior High",	"Juaso Senior High/Tech",	"Jubilee Senior High",	"Kurofa Methodist Senior High Tech",	"Morso Senior High/Tech",	"Ofoase Senior High/Tech",	"Agogo State College",	"Collins Senior High/Commercial, Agogo",	"Owerriman Senior High Tech",	"Konongo Odumase Senior High .",	"St. Mary's Girl's Senior High, Konongo",	"Wesley Senior High, Konongo .",	"Esaase Bontefufuo Snr. High/Tech.",	"Manso-Adubia Senior High",	"Mansoman Senior High",	"Jacobu Senior High/Tech.",	"Tweapease Senior High School",	"Adugyama Comm. Senior High",	"Mankranso Senior High",	"Sabronum Methodist Senior High/Tech",	"Maabang Senior High/Tech",	"Tepa Senior High",	"Afigya Senior High/Tech",	"Afigyaman Senior High School",	"St. Michael's Senior High, Ahenkro",	"Aduman Senior High",	"Otumfuo Osei Tutu II College",	"Akrofuom Senior High/Tech",	"New Edubiase Senior High",	"Asare Bediako Senior High .",	"Bodwesango Senior High",	"Dompoase Senior High",	"Fomena T.I. Ahmad Senior High",	"Ghana STEM Academy, Koase",	"Istiquaama Snr. High",	"Koase Senior High/Tech",	"Nkyeraa Senior High Sch.",	"Wenchi Meth. Senior High",	"Badu Senior High/Tech.",	"Menji Senior High",	"Nkoranman Senior High",	"Nsawkaw State Senior High",	"Chiraa Senior High",	"Notre Dame Girls Senior High, Sunyani",	"Odomaseman Senior High",	"Sacred Heart Senior High, Nsoatre",	"S.D.A Senior High, Sunyani",	"St. James Sem & Senior High, Abesim",	"Sunyani Senior High",	"Twene Amanfo Senior High/Tech.",	"Drobo Senior High",	"Our Lady of Providence Senior High",	"Diamono Senior High Sch.",	"Duadaso No. 1 Senior High/Tech.",	"Goka Senior High/Tech.",	"Nafana Senior High",	"St. Ann's Girls Senior High, Sampa",	"Sumaman Senior High",	"Nkrankwanta Comm Senior High",	"Mansen Senior High",	"Wamanafo Senior High/Tech",	"Dormaa Senior High",	"Salvation Army Senior High, Aboabo Dormaa",	"Berekum Presby Senior High",	"Berekum Senior High",	"Jinijini Senior High",	"Methodist Senior High/Tech.,Biadan",	"St. Augustine Senior High, Nsapor-Berekum",	"Bandaman Senior High",	"Ameyaw Akumfi Senior High/Tech.",	"Guakro Effah Senior High",	"Krobo Comm.Senior High",	"St. Francis Seminary/Senior High, Buoyem",	"Tuobodom Senior High/Tech",	"Gyarko Comm. Day Senior High",	"Kesse Basahyia Senior High",	"Kwarteng Ankomah Senior High",	"Our Lady of Mount Carmel Girls Senior High, Techiman",	"Techiman Senior High",	"Yeboah Asuamah Senior High",	"Abrafi Senior High",	"Kwame Danso Senior High/Tech",	"Bassa Community Senior High",	"Kajaji Senior High",	"Abeaseman Comm. Day Senior High",	"Prang Senior High",	"Yeji Senior High/Tech",	"Donkro- Nkwanta Senior High",	"Kwabre Senior High",	"Nkoranza Senior High/Tech",	"Busunya Senior High",	"Osei Bonsu Senior High",	"Jema Senior High",	"Kintampo Senior High",	"New Longoro Comm.School (Dega)",	"Amanten Senior High",	"Atebubu Senior High",	"New Krokompe Comm. Senior High",	"Ayanfuri Senior High",	"Diaso Senior High",	"Boa-Amponsem Senior High",	"Dunkwa Senior High/Tech",	"Kyekyewere Comm. Senior High School",	"Mokwaa Senior High Sch",	"Jukwa Senior High",	"Twifo Hemang Senior High/Tech",	"Twifo Praso Senior High",	"Abeadze State College",	"Kwegyir Aggrey Senior High",	"Mankessim Senior High/Tech",	"Methodist High School,Saltpond",	"Mfantsiman Girls Senior High",	"Kobina Ansah SHS",	"Edinaman Senior High",	"Eguafo-Abrem Senior High",	"Komenda Senior High/Tech.",	"Apam Senior High",	"College of Music Senior, Mozano",	"Gomoa Senior High/Tech",	"Mozano Senior High",	"Fettehman Senior High",	"Gomoa Gyaman Senior High",	"Potsin T.I. Ahm. Senior High",	"S.D.A SHS, Jukwa",	"St. Gregory Catholic Senior High School",	"Ogyeedom Comm.Snr High/Tech",	"Akyin Senior High School",	"Ekumfi T. I. Ahmadiiyya Snr. High",	"J.E.A. Mills Senior High",	"Winneba Senior High",	"Academy of Christ the King, Cape Coast",	"Adisadel College",	"Effutu Senior High/Tech",	"Ghana National College",	"Holy Child School, Cape Coast",	"Mfantsipim School",	"Oguaa Senior High/Tech",	"St. Augustine's College, Cape Coast",	"University Practice Senior High",	"Wesley Girls Senior High, Cape Coast",	"Awutu Bawjiase Comm. Senior High",	"Awutu Winton Senior High",	"Obrachire Senior High/Tech",	"Odupong Comm. Day School",	"Senya Senior High",	"Bontrase Senior High Tech. Sch",	"Adankwaman Senior High",	"Assin Manso Senior High",	"Assin Nsuta Agric. Senior High",	"Nyankumase Ahenkro Snr. High",	"Assin North Senior High/Tech",	"Assin State College",	"Gyaase Community Senior High",	"Obiri Yeboah Senior High/Technical",	"Brakwa Senior High/Tech",	"Breman Asikuma Senior High",	"Odoben Senior High",	"Bisease Senior High/Com",	"Enyan Denkyira Senior High",	"Enyan Maim Comm. Day School",	"Mando Senior High/Tech.",	"Agona Fankobaa Senior High",	"Nyakrom Senior High Tech",	"Siddiq Senior High Sch.",	"Swedru Sch. Of Business",	"Agona Namonwora Comm.Senior High",	"Ampim Darko Senior High School",	"Kwanyako Senior High ",	"Nsaba Presby Senior High",	"Swedru Senior High",	"Abakrampa Senior High/Tech",	"Aburaman Senior High",	"Aggrey Mem. A.M.E.Zion Snr. High",	"Moree Comm. Senior High",	"Apesua Comm. Senior High",	"Klo-Agogo Senior High",	"Yilo Krobo Senior High/Com",	"Asamankese Senior High",	"St. Thomas Senior High/Tech",	"Adeiso Presby Senior High",	"Kwaobaah Nyanoa Comm. Senior High",	"Asesewa Senior High School",	"Islamic Girls Senior High,Suhum",	"Presby Senior High, Suhum",	"Suhum Senior High/Tech",	"Nsawam Senior High",	"St. Martin's Senior High, Nsawam",	"Ghana Senior High, Koforidua ",	"Koforidua Senior High/Tech",	"New Juaben Senior High/Com",	"Oti Boateng Senior High",	"Oyoko Methodist Senior High",	"Pope John Snr. High & Min. Sem., Koforidua",	"S.D.A Senior High, Koforidua",	"Pentecost Senior High,Koforidua",	"Akro Senior High/Tech",	"Akuse Methodist Senior High/Tech",	"Krobo Girls Senior High",	"Manya Krobo Senior High",	"Fodoa Comm. Senior High",	"Nkawkaw Senior High",	"Bepong Senior High School",	"Kwahu Ridge Senior High",	"Mpraeso Senior High",	"St. Paul's Senior High, Asakraka Kwahu",	"St. Peter's Senior High, Nkwatia",	"Abetifi Presby Senior High",	"Kwahu Tafo Senior High",	"Nkwatia Presby Senior High/Com",	"St. Dominic's Senior High/Tech, Pepease",	"Asuom Senior High",	"Kade Senior High/Tech.",	"New Nsutam Senior High/Tech",	"Osino Presby Senior High/Tech.",	"Presby Senior High, Begoro",	"Abuakwa State College",	"Akim Asafo Senior High",	"Apedwa Presby Senior High",	"Kibi Senior High/Tech",	"Ofori Panin Senior High",	"Saviour Senior High, Osiem",	"St. Stephen's Presby Snr. High/Tech, Asiakwa",	"W.B.M. Zion Senior High, Old Tafo",	"St. Rose's Senior High, Akwatia",	"Salvation Army Senior High, Akim Wenchi",	"Tarkrowase Comm. Senior High",	"Achiase Senior High",	"Akim Swedru Senior High",	"Aperade Senior High/Tech.",	"Amuana Praso Senior High",	"New Abirem/Afosu Senior High",	"St. Michael's Senior High, Akoase (Nkawkaw)",	"Akroso Senior High/Tech",	"Attafuah Senior High/Tech",	"Atweaman Senior High",	"Oda Senior High",	"St. Francis Senior High/Tech, Akim Oda",	"Anum Apapam Comm. Day",	"Kraboa-Coaltar Presby Snr. High/Tech.",	"STEM Academy, Abomosu",	"S.D.A. Senior High. Akim Sekyere",	"Kwabeng Anglican Senior High/Tech",	"Adjena Senior High/Tech.",	"Akwamuman Senior High",	"Anum Presby Senior High",	"Apeguso Senior High",	"Boso Senior High Technical",	"Akokoaso Senior High/Tech",	"Ayirebi Senior High",	"Aburi Girls Senior High",	"Adonten Senior High",	"Diaspora Girls' Senior High",	"Presby Senior High/Tech, Aburi",	"Benkum Senior High",	"H'Mount Sinai Senior High",	"Mampong/Akw Snr. High/Tech for the Deaf",	"Mangoase Senior High",	"Methodist Girls Senior High, Mamfe",	"Nifa Senior High",	"Okuapeman Senior High",	"Presby Senior High, Mampong Akwapim",	"Presby Senior High/Tech, Adukrom",	"Presby Senior High/Tech, Larteh",	"Maame Krobo Comm. Senior High",	"St. Fidelis Senior High/Tech",	"Donkorkrom Agric Senior High",	"Mem-Chemfre Comm. Senior High",	"Lashibi Comm. Day",	"Chemu Senior High/Tech",	"Our Lady of Mercy Senior High",	"Presby Senior High, Tema",	"Tema Manhean Senior High/Tech",	"Tema Meth. Day Senior High",	"Tema Senior High ",	"Ghanata Senior High",	"Osudoku Senior High/Tech.",	"Ningo Senior High",	"Prampram Senior High",	"O'Reilly Senior High",	"Presby Senior High, Teshie",	"West Africa Senior High",	"Presby Boys Senior High, Legon",	"Forces Senior High/Tech, Burma Camp",	"La Presby Senior High",	"Labone Senior High",	"St. Thomas Aquinas Senior High, Cantoments",	"Nungua Senior High",	"Kpone Comm. Senior High",	"Adjen Kotoku Senior High",	"Akramaman Senior High",	"Amasaman Senior High/Tech",	"St. John's Grammar Senior High",	"Christian Methodist Senior High",	"Ngleshie Amanfro Senior High",	"Kwabenya Comm. Senior High",	"Odorgonno Senior High",	"Ashiaman Senior High",	"Frafraha Comm. Senior High",	"Ada Senior High/Tech.",	"Ada Senior High",	"Accra Academy",	"Accra Girls Senior High .",	"Accra Senior High",	"Accra Wesley Girls High",	"Achimota Senior High",	"Ebenezer Senior High",	"Holy Trinity Senior High",	"Kaneshie Senior High/Tech.",	"Kinbu Senior High/Tech",	"Presby Senior High, Osu",	"St. Margaret Mary Snr.High/Tech",	"St. Mary's Senior High, Korle Gonno ",	"Wesley Grammar Senior High",	"Yunyoo-Nasuan Comm. SHS",	"Ghana STEM Academy, Kpasenpke",	"Janga Senior High/Tech",	"Walewale Senior High",	"Wulugu Senior High",	"Yagaba Senior High School",	"Gambaga Girls Senior High",	"Langbinsi Senior High/Tech",	"Nalerigu Senior High",	"Sakogu Senior High/Tech",	"Chereponi Senior High/Tech.",	"Bunkpurugu Senior High/Tech",	"Nakpanduri Senior High",	"Presby SHTS, Nankpanduri",	"Zabzugu Senior High",	"Dagbon State Senior High/Tech",	"Yendi Senior High",	"Kasuliyili Senior High",	"Tolon Senior High",	"E. P. Agric Senior High/Tech.",	"Anbariya Senior High Sch.",	"Business Senior High, Tamale",	"Ghana Senior High, Tamale",	"Presby Senior High, Tamale",	"St. Charles Senior High, Tamale",	"Tamale Girls Senior High",	"Vitting Senior High/Tech.",	"Pong-Tamale Senior High",	"Savelugu Senior High",	"Islamic Science Senior High, Tamale",	"Kalpohin Senior High",	"Northern School of Business",	"Tamale Senior High .",	"Saboba E.P. Senior High",	"Wapuli Comm. Senior High",	"Wulensi Senior High",	"Bimbilla Senior High",	"Sang Comm. Day School",	"Kumbungu Senior High",	"Kpandai Senior High",	"Karaga Senior High",	"Gushegu Senior High",	"Kyabobo Girls' School",	"Nkwanta Comm.Senior High",	"Nkwanta Senior High",	"Ntruboman Senior High",	"Kpassa Senior High/Tech",	"Kete Krachi Senior High/Tech.",	"Krachi Senior High",	"Nchumuruman Comm. Day Senior High",	"Asukawkaw Senior High",	"Oti Senior High/Tech Sch",	"Yabram Comm. Day School",	"Ahamansu Islamic Senior High School",	"Dodi-Papase Senior High/Tech",	"Kadjebi-Asato Senior High",	"Baglo Ridge Senior High/Tech.",	"Bueman Senior High .",	"Okadjakrom Senior High/Tech.",	"Biakoye Comm. School",	"Bowiri Comm. Day School",	"Nkonya Senior High",	"Tapaman Senior High/Tech",	"Worawora Senior High",	"Damongo Senior High",	"Ndewura Jakpa Senior High/Tech.",	"Sawla Senior High Sch.",	"Tuna Senior High/Tech.",	"Daboya Comm. Day School",	"Salaga Senior High",	"Salaga T.I. Ahmad Senior High",	"Buipe Senior High",	"Mpaha Comm. Senior High",	"Bamboi Comm. Senior High",	"Bole Senior High",	"St. Anthony of Padua Senior High/Tech",	"Bolgatanga Senior High ",	"Tongo Senior High/Tech",	"Pusiga Comm. Day Senior High Sch.",	"Kongo Senior High",	"Chiana Senior High",	"Mirigu Community Day Senior High",	"Nabango Senior High Tech",	"Paga Senior High",	"Sirigu Senior High",	"Awe Senior High/Tech.",	"Navrongo Senior High ",	"Notre Dame Sem/ Senior High, Navrongo",	"St. John's Integrated Snr. High/Tech",	"O.L.L. Girls Senior High",	"Tempane Senior High",	"Garu Comm. Day Senior High",	"Fumbisi Senior High",	"Kanjaga Comm. Senior High",	"Naab Azantilow Senior High/Tech.",	"Sandema Senior High",	"Wiaga Comm. Senior High",	"Azeem-Namoa Senior High/Tech",	"Bongo Senior High",	"Gowrie Senior High/Tech.",	"Zorkor Senior High",	"Bolga Girls Senior High ",	"Bolga Sherigu Comm. Senior High",	"Zamse Senior High/Tech",	"Zuarungu Senior High",	"Gambigo Comm. Day Senior High",	"Binduri Comm. Senior High",	"Kusanaba Senior High",	"Zebilla Senior High/Tech",	"Bawku Senior High",	"Bawku Senior High/Tech.",	"Lassie-Tuolu Senior High",	"Islamic Senior High, Wa",	"Jamiat Al-Hidaya Islamic Girls",	"Northern Star Senior High",	"T. I. Ahmadiyya Senior High, Wa",	"Wa Senior High .",	"Wa Senior High/Tech.",	"Funsi Senior High School",	"Loggu Comm. Day School",	"Dr. Hila Liman Senior High School",	"Kanton Senior High",	"Tumu Senior High/Tech.",	"Ko Senior High",	"Nandom Senior High",	"Sombo Senior High",	"Kaleo Senior High/Tech",	"Queen of Peace Senior High, Nadowli",	"St. Augustine Senior High/Tech, Saan Charikpong",	"Takpo Senior High Sch.",	"Birifoh Senior High Sch.",	"Eremon Senior High/Tech.",	"Lawra Senior High ",	"Lambussie Comm. Senior High",	"Piina Senior High",	"Holy Family Senior High",	"Han Senior High",	"Jirapa Senior High",	"St. Francis Girls Senior High, Jirapa ",	"Ullo Senior High",	"Daffiamah Senior High",	"Dabala Senior High/Tech.",	"Sogakope Senior High",	"St. Catherine Girls Senior High",	"Kpeve Senior High Tech",	"Peki Senior High",	"Peki Senior High/Technical",	"Tongor Senior High Tech.",	"Aveyime Battor Senior High/Tech.",	"Battor Senior High",	"Dofor Senior High",	"Mepe St. Kizito Senior High/Tech.",	"Volo Comm. Senior High",	"Anfoega Senior High",	"Vakpo Senior High",	"Vakpo Senior High/Tech",	"Bishop Herman College",	"Kpando Senior High .",	"Aflao Community SHS",	"Klikor Senior High/Tech.",	"Some Senior High",	"St. Paul's Senior High, Denu",	"Three Town Senior High",	"Afife Senior High Tech.",	"Dzodze Penyi Senior High",	"Weta Senior High/Tech.",	"Wovenu Senior High Technical",	"Keta Senior High/Tech .",	"Afadjato Senior High/Tech.",	"Akpafu Senior High/Tech.",	"Alavanyo Senior High/Tech.",	"E. P. Senior High",	"Likpe Senior High",	"St. Mary's Sem.& Senior High, Lolobi",	"Abutia Senior High/Tchnical",	"Akome Senior High/Tech.",	"Avatime Senior High",	"Dzolo Senior High",	"Kpedze Senior High",	"Tsito Senior High/Tech",	"Awudome Senior High .",	"E.P.C. Mawuko Girls Senior High",	"Mawuli School, Ho",	"OLA Girls Senior High, Ho",	"Shia Senior HighTechnical",	"Sokode Senior High/Tech",	"Tanyigbe Senior High",	"Taviefe Senior High",	"Ziavi Senior High/Tech",	"Adidome Senior High",	"Mafi-Kumasi Senior High/Tech",	"Abor Senior High",	"Anlo Afiadenyigba Senior High",	"Anlo Awomefia Senior High",	"Anlo Senior High",	"Atiavi Senior High/Tech",	"Keta Business Senior High",	"Tsiame Senior High",	"Volta Senior High School",	"Zion Senior High",	"Avenor Senior High",	"Ave Senior High",	"Akatsi Senior High/Tech",	"Agotime Senior High",	"Ziope Senior High Sch.",	"Agate Comm. Senior High",	"Jim Bourton Mem Agric. Senior High",	"Leklebi Senior High",	"Ve Comm. Senior High",	"Adaklu Senior High",	"Gbekor Senior High",	"Asankrangwa Senior High",	"Asankrangwa Senior High/Tech",	"Amenfiman Senior High",	"Benso Senior High/Tech",	"Fiaseman Senior High",	"Tarkwa Senior High",	"Ahantaman Girls' Senior High",	"Shama Senior High",	"Adiembra Senior High",	"Archbishop Porter Girls Snr.High .",	"Bompeh Senior High./Tech",	"Diabene Senior High/Tech",	"Fijai Senior High",	"Ghana Senior High/Tech",	"Methodist Senior High, Sekondi",	"Sekondi College ",	"St. John's Senior High, Sekondi",	"Huni Valley Senior High",	"Prestea Senior High/Tech",	"St. Augustine's Senior High, Bogoso",	"Axim Girls Senior High",	"Gwiraman Comm.Senior High",	"Nsein Senior High",	"Daboase Senior High/Tech",	"Mpohor Senior High",	"Annor Adjaye Senior High",	"Half Assini Senior High",	"Bonzo-Kaku Senior High",	"Esiama Senior High/Tech",	"Nkroful Agric. Senior High",	"Uthman Bin Afam SHS",	"Takoradi Senior High",	"Baidoo Bonso Senior High/Tech",	"Sankor Senior High School",	"St. Mary's Boys' Senior High, Apowa",	"Manso-Amenfi Comm. Day School",	"Dadieso Senior High",	"Asawinso Senior High",	"Sefwi-Wiawso Senior High",	"Sefwi-Wiawso Senior High/Tech",	"St. Joseph Senior High, Sefwi Wiawso",	"Akontombra Senior High",	"Nsawora Edumafa Comm. Senior High School",	"Juaboso Senior High",	"Bodi Senior High",	"Bibiani Senior High/Tech.",	"Chirano Comm. Day School",	"Ghana STEM Academy, Awaso",	"Queens Girls' Senior High, Sefwi Awhiaso",	"Sefwi Bekwai Senior High",	"Adjoafua Comm. Senior High",	"Bia Senior High/Tech",	"Adabokrom Comm. SHS",	"Nana Brentu Senior High/Tech", "Nuriya Islamic SHS", "Presbyterian Boys Model SHS", "Wioso SHS", "Holy Child SHS", "Twereku Ampem SHS", "Kyem Amponsah SHS", "Gomoa Jukwa SDA SHS"))) %>%
                                                                     
                                                                     
                                                                     
                                                                     group_by(Name_school_hbk2) %>%
                                                                       summarise(
                                                                         count_hbk2 = sum(plc_take_place_hbk2 == 1),
                                                                         sessions = list(nts_hbk2.Session_hbk2),
                                                                         
                                                                         male_mean_hbk2 = round(mean(nts_hbk2.male_attendance_hbk2, na.rm = TRUE),0),
                                                                         female_mean_hbk2 = round(mean(nts_hbk2.female_attendance_hbk2, na.rm = TRUE),0),
                                                                         overall_mean_hbk2 = round(mean(nts_hbk2.total_attendance_hbk2, na.rm = TRUE),0),
                                                                         male_pop_mean_hbk2 = round(mean(nts_hbk2.no_male_teachers_hbk2, na.rm = TRUE),0),
                                                                         female_pop_mean_hbk2 = round(mean(nts_hbk2.no_female_teachers_hbk2, na.rm = TRUE),0),
                                                                         overall_pop_mean_hbk2 = round(mean(nts_hbk2.total_teachers_schoo_hbk2, na.rm = TRUE),0),
                                                                         percent_male_attend_hbk2 = scales::percent(male_mean_hbk2/male_pop_mean_hbk2),
                                                                         percent_female_attend_hbk2 = scales::percent(female_mean_hbk2/female_pop_mean_hbk2),
                                                                         percent_total_attend_hbk2 = scales::percent(overall_mean_hbk2/overall_pop_mean_hbk2)
                                                                       )%>%
                                                                       rowwise() %>%
                                                                       mutate(
                                                                         units_completed_hbk2 = {
                                                                           # Extract all numeric values from the session descriptions
                                                                           session_nums <- unlist(str_extract_all(unlist(sessions), "\\d+"))
                                                                           # Remove duplicate session numbers, convert to numeric, and sort
                                                                           session_nums <- unique(as.numeric(session_nums))
                                                                           session_nums <- sort(session_nums)
                                                                           # Create the string with PLC Session prefix
                                                                           session_str <- if (length(session_nums) > 0) {
                                                                             paste("PLC Session(s):", paste(session_nums, collapse = ", "))
                                                                           } else {
                                                                             "PLC Session(s): None"
                                                                           }
                                                                           session_str
                                                                         }
                                                                       )
                                                                     
                                                                     
                                                                     return(data_hbk2)
  })
  
  output$table_plot_hbk2 <- renderRHandsontable({
    table_data_hbk2 <- table_trial_hbk2()
    
    if (is.null(table_data_hbk2)) {
      return(NULL) # Return NULL if table_data is NULL (i.e., an error occurred)
    }
    
    table_data_hbk2$Name_school_hbk2 <- as.character(table_data_hbk2$Name_school_hbk2) # Convert factor to character
    
    table_data_subset_hbk2 <- table_data_hbk2[, c("Name_school_hbk2", "count_hbk2", "units_completed_hbk2", "percent_male_attend_hbk2", "percent_female_attend_hbk2", "percent_total_attend_hbk2")]
    
    rhandsontable(table_data_subset_hbk2,
                  colHeaders = c("School name", "Number of meetings Held","Details of Sessions Completed and Submitted", "Male teacher attendance (percent)", "Female teacher attendance (percent)", "Overall attendance (percent)"),
                  rowHeaders = NULL,
                  search = TRUE,
                  readOnly = TRUE) %>%
      hot_context_menu(
        customOpts = list(
          csv = list(
            name = "Download to CSV",
            callback = JS(
              "function (key, options) {
             var csv = csvString(this, sep = ',', dec = '.');

             var link = document.createElement('a');
             link.setAttribute('href', 'data:text/plain;charset=utf-8,' +
               encodeURIComponent(csv));
             link.setAttribute('download', 'table_data.csv');

             document.body.appendChild(link);
             link.click();
             document.body.removeChild(link);
           }")
          )
        )
      ) %>%
      hot_cols(
        colWidths = c(280, rep(180, 5))  # Adjust column widths as needed
      ) %>%
      onRender(
        JS(
          "function(el, x) {
           var hot = this.hot;  // Reference to the Handsontable instance
           hot.addHook('beforeChange', function(changes, source) {
             if (source === 'alter' && (changes[0][0] === 'insert_row' || changes[0][0] === 'remove_row')) {
               return false;  // Prevent row insertion and deletion
             }
           });
         }"
        )
      )
  })
  
  
  
  output$export_button_hbk2 <- downloadHandler(
    filename = function() {
      paste("data_hbk2", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      table_data_hbk2 <- table_trial_hbk2()  # Get the reactive data
      table_data_subset_hbk2 <- table_data_hbk2[, c("Name_school_hbk2", "count_hbk2", "units_completed_hbk2", "percent_male_attend_hbk2", "percent_female_attend_hbk2", "percent_total_attend_hbk2")]
      write.csv(table_data_subset_hbk2, file, row.names = FALSE)
    }
  )
  
  
  
  ##################################################################################################Handbook 3 school level code
  ##########################################################################code for handbook 3 plc attendance
  
  # mutate(Name_school_hbk3 = factor(Name_school_hbk3, levels = c ("Bechem Presby Senior High",	"Derma Comm. Day School",	"Samuel Otu Presby Senior High.",	"Boakye Tromo Senior High/Tech",	"Bomaa Comm. Senior High",	"Serwaa Kesse Girls Senior High",	"Terchire Senior High",	"Yamfo Anglican Senior High School",	"Acherensua Senior High",	"Hwidiem Senior High",	"Gyamfi Kumanini Senior High/Tech",	"OLA Girls Senior High, Kenyasi ",	"Kukuom Agric Senior High",	"Sankore Senior High",	"Ahafoman Senior High/Tech",	"Mim Senior High",	"Adu Gyamfi Senior High",	"Agona Senior High/Tech",	"Boanim Senior High/ Tech Sch",	"Konadu Yiadom Catholic Senior High",	"Okomfo Anokye Senior High",	"S.D.A. Senior High, Agona",	"Bankoman Senior High",	"Bodomase Senior High/Tech",	"Dadease Agric Senior High",	"Tweneboa Kodua Senior High",	"Effiduase Senior High/Com",	"Effiduase Senior High/Tech",	"T. I. Ahmadiyya Girl's Senior High, Asokore",	"Tijjaniya Senior High",	"Ghana Muslim Mission Senior High",	"Nsutaman Cath. Senior High",	"Presby Senior High/Tech, Kwamang",	"Akumadan Senior High",	"Asuoso Comm. Senior High",	"Nkenkansu Community Senior High",	"Wiafe Akenten Presby Senior High",	"Dwamena Akenten Senior High",	"Namong Senior High/Tech",	"St. Jerome Senior High, Abofour",	"Christ the King Cath., Obuasi",	"Obuasi Senior High/Tech",	"Spiritan Senior High",	"Amaniampong Senior High",	"Kofiase Adventist Senior High/Tech.",	"Opoku Agyeman Senior High/Tech",	"St. Joseph Sem/Senior High, Mampong",	"St. Monica's Senior High, Mampong",	"Adanwomase Senior High",	"Adventist Girls Senior High, Ntonso",	"Antoa Senior High",	"Gyaama Pensan Senior High/Tech",	"Kofi Adjei Senior High/Tech",	"Simms Senior High/Com.",	"Islamic Senior High,Kumasi",	"Adventist Senior High, Kumasi",	"Agric Nzema Senior High, Kumasi",	"Al-Azariya Islamic Snr. High, Kumasi",	"Anglican Senior High, Kumasi",	"Armed Forces Senior High/Tech, Kumasi",	"Asanteman Senior High",	"J. A. Kufuor Senior High",	"KNUST Senior High",	"Kumasi Girls Senior High,",	"Kumasi High School",	"Kumasi Senior High/Tech",	"Kumasi Wesley Girls High Sch",	"Mancell Senior High",	"Nuru-Ameen Islamic Senior High, Asewase",	"Opoku Ware School",	"Osei Kyeretwie Senior High",	"Pentecost Senior High, Kumasi",	"Prempeh College",	"Prince Of Peace Girls",	"Serwaah Nyarko Girls' Snr. High",	"St. Hubert Sem/Senior High, Kumasi",	"St. Louis Senior High, Kumasi",	"T. I. Ahmadiyya Senior High , Kumasi",	"Uthmaniya Senior High, Tafo",	"Yaa Asantewaa Girls Senior High .",	"Juaben Senior High",	"Akwesi Awobaa Senior High",	"Ejuraman Anglican Senior High",	"Sekyedumase Senior High/Tech",	"Onwe senior High Senior",	"Ejisu Senior High/Tech",	"Achinakrom Senior High",	"Bonwire Senior High/Tech",	"Ejisuman Senior High",	"Church Of Christ Senior High",	"St. Sebastian Cath. Senior High",	"Ghana STEM Academy, Deduako",	"Ghana STEM Academy, Jachie",	"Beposo Senior High",	"Bosomtwe Oyoko Comm. Senior High",	"Jachie Pramso Senior High",	"Osei Adutwum Senior High",	"St. George's Senior High Tech.",	"Bosomtwe Senior High/Tech",	"Bosome Senior High/Tech.",	"Denyaseman Cath.Senior High",	"Ofoase Kokoben Senior High",	"Oppong Mem. Senior High",	"S.D.A. Senior High, Bekwai",	"St. Joseph Senior High/Tech, Ahwiren",	"Wesley High School, Bekwai",	"Barekese Senior High",	"Nkawie Senior High/Tech",	"Osei Tutu Senior High, Akropong",	"Toase Senior High",	"Adobewora Comm. Senior High",	"Mpasatia Senior High/Tech",	"Nyinahin Cath. Senior High",	"Afua Kobi Ampem Girls' Senior High",	"Anum Asamoah Senior High/Tech",	"Atwima Kwanwoma Snr High/Tech",	"Presbyterian Girls Senior High",	"Ibadur Rahman Academy",	"Kumasi Academy",	"Parkoso Comm. Senior High",	"Sakafia Islamic Senior High",	"Tawheed Senior High.",	"Banka Comm. Senior High",	"Bompata Presby Senior High",	"Juaso Senior High/Tech",	"Jubilee Senior High",	"Kurofa Methodist Senior High Tech",	"Morso Senior High/Tech",	"Ofoase Senior High/Tech",	"Agogo State College",	"Collins Senior High/Commercial, Agogo",	"Owerriman Senior High Tech",	"Konongo Odumase Senior High .",	"St. Mary's Girl's Senior High, Konongo",	"Wesley Senior High, Konongo .",	"Esaase Bontefufuo Snr. High/Tech.",	"Manso-Adubia Senior High",	"Mansoman Senior High",	"Jacobu Senior High/Tech.",	"Tweapease Senior High School",	"Adugyama Comm. Senior High",	"Mankranso Senior High",	"Sabronum Methodist Senior High/Tech",	"Maabang Senior High/Tech",	"Tepa Senior High",	"Afigya Senior High/Tech",	"Afigyaman Senior High School",	"St. Michael's Senior High, Ahenkro",	"Aduman Senior High",	"Otumfuo Osei Tutu II College",	"Akrofuom Senior High/Tech",	"New Edubiase Senior High",	"Asare Bediako Senior High .",	"Bodwesango Senior High",	"Dompoase Senior High",	"Fomena T.I. Ahmad Senior High",	"Ghana STEM Academy, Koase",	"Istiquaama Snr. High",	"Koase Senior High/Tech",	"Nkyeraa Senior High Sch.",	"Wenchi Meth. Senior High",	"Badu Senior High/Tech.",	"Menji Senior High",	"Nkoranman Senior High",	"Nsawkaw State Senior High",	"Chiraa Senior High",	"Notre Dame Girls Senior High, Sunyani",	"Odomaseman Senior High",	"Sacred Heart Senior High, Nsoatre",	"S.D.A Senior High, Sunyani",	"St. James Sem & Senior High, Abesim",	"Sunyani Senior High",	"Twene Amanfo Senior High/Tech.",	"Drobo Senior High",	"Our Lady of Providence Senior High",	"Diamono Senior High Sch.",	"Duadaso No. 1 Senior High/Tech.",	"Goka Senior High/Tech.",	"Nafana Senior High",	"St. Ann's Girls Senior High, Sampa",	"Sumaman Senior High",	"Nkrankwanta Comm Senior High",	"Mansen Senior High",	"Wamanafo Senior High/Tech",	"Dormaa Senior High",	"Salvation Army Senior High, Aboabo Dormaa",	"Berekum Presby Senior High",	"Berekum Senior High",	"Jinijini Senior High",	"Methodist Senior High/Tech.,Biadan",	"St. Augustine Senior High, Nsapor-Berekum",	"Bandaman Senior High",	"Ameyaw Akumfi Senior High/Tech.",	"Guakro Effah Senior High",	"Krobo Comm.Senior High",	"St. Francis Seminary/Senior High, Buoyem",	"Tuobodom Senior High/Tech",	"Gyarko Comm. Day Senior High",	"Kesse Basahyia Senior High",	"Kwarteng Ankomah Senior High",	"Our Lady of Mount Carmel Girls Senior High, Techiman",	"Techiman Senior High",	"Yeboah Asuamah Senior High",	"Abrafi Senior High",	"Kwame Danso Senior High/Tech",	"Bassa Community Senior High",	"Kajaji Senior High",	"Abeaseman Comm. Day Senior High",	"Prang Senior High",	"Yeji Senior High/Tech",	"Donkro- Nkwanta Senior High",	"Kwabre Senior High",	"Nkoranza Senior High/Tech",	"Busunya Senior High",	"Osei Bonsu Senior High",	"Jema Senior High",	"Kintampo Senior High",	"New Longoro Comm.School (Dega)",	"Amanten Senior High",	"Atebubu Senior High",	"New Krokompe Comm. Senior High",	"Ayanfuri Senior High",	"Diaso Senior High",	"Boa-Amponsem Senior High",	"Dunkwa Senior High/Tech",	"Kyekyewere Comm. Senior High School",	"Mokwaa Senior High Sch",	"Jukwa Senior High",	"Twifo Hemang Senior High/Tech",	"Twifo Praso Senior High",	"Abeadze State College",	"Kwegyir Aggrey Senior High",	"Mankessim Senior High/Tech",	"Methodist High School,Saltpond",	"Mfantsiman Girls Senior High",	"Kobina Ansah SHS",	"Edinaman Senior High",	"Eguafo-Abrem Senior High",	"Komenda Senior High/Tech.",	"Apam Senior High",	"College of Music Senior, Mozano",	"Gomoa Senior High/Tech",	"Mozano Senior High",	"Fettehman Senior High",	"Gomoa Gyaman Senior High",	"Potsin T.I. Ahm. Senior High",	"S.D.A SHS, Jukwa",	"St. Gregory Catholic Senior High School",	"Ogyeedom Comm.Snr High/Tech",	"Akyin Senior High School",	"Ekumfi T. I. Ahmadiiyya Snr. High",	"J.E.A. Mills Senior High",	"Winneba Senior High",	"Academy of Christ the King, Cape Coast",	"Adisadel College",	"Effutu Senior High/Tech",	"Ghana National College",	"Holy Child School, Cape Coast",	"Mfantsipim School",	"Oguaa Senior High/Tech",	"St. Augustine's College, Cape Coast",	"University Practice Senior High",	"Wesley Girls Senior High, Cape Coast",	"Awutu Bawjiase Comm. Senior High",	"Awutu Winton Senior High",	"Obrachire Senior High/Tech",	"Odupong Comm. Day School",	"Senya Senior High",	"Bontrase Senior High Tech. Sch",	"Adankwaman Senior High",	"Assin Manso Senior High",	"Assin Nsuta Agric. Senior High",	"Nyankumase Ahenkro Snr. High",	"Assin North Senior High/Tech",	"Assin State College",	"Gyaase Community Senior High",	"Obiri Yeboah Senior High/Technical",	"Brakwa Senior High/Tech",	"Breman Asikuma Senior High",	"Odoben Senior High",	"Bisease Senior High/Com",	"Enyan Denkyira Senior High",	"Enyan Maim Comm. Day School",	"Mando Senior High/Tech.",	"Agona Fankobaa Senior High",	"Nyakrom Senior High Tech",	"Siddiq Senior High Sch.",	"Swedru Sch. Of Business",	"Agona Namonwora Comm.Senior High",	"Ampim Darko Senior High School",	"Kwanyako Senior High ",	"Nsaba Presby Senior High",	"Swedru Senior High",	"Abakrampa Senior High/Tech",	"Aburaman Senior High",	"Aggrey Mem. A.M.E.Zion Snr. High",	"Moree Comm. Senior High",	"Apesua Comm. Senior High",	"Klo-Agogo Senior High",	"Yilo Krobo Senior High/Com",	"Asamankese Senior High",	"St. Thomas Senior High/Tech",	"Adeiso Presby Senior High",	"Kwaobaah Nyanoa Comm. Senior High",	"Asesewa Senior High School",	"Islamic Girls Senior High,Suhum",	"Presby Senior High, Suhum",	"Suhum Senior High/Tech",	"Nsawam Senior High",	"St. Martin's Senior High, Nsawam",	"Ghana Senior High, Koforidua ",	"Koforidua Senior High/Tech",	"New Juaben Senior High/Com",	"Oti Boateng Senior High",	"Oyoko Methodist Senior High",	"Pope John Snr. High & Min. Sem., Koforidua",	"S.D.A Senior High, Koforidua",	"Pentecost Senior High,Koforidua",	"Akro Senior High/Tech",	"Akuse Methodist Senior High/Tech",	"Krobo Girls Senior High",	"Manya Krobo Senior High",	"Fodoa Comm. Senior High",	"Nkawkaw Senior High",	"Bepong Senior High School",	"Kwahu Ridge Senior High",	"Mpraeso Senior High",	"St. Paul's Senior High, Asakraka Kwahu",	"St. Peter's Senior High, Nkwatia",	"Abetifi Presby Senior High",	"Kwahu Tafo Senior High",	"Nkwatia Presby Senior High/Com",	"St. Dominic's Senior High/Tech, Pepease",	"Asuom Senior High",	"Kade Senior High/Tech.",	"New Nsutam Senior High/Tech",	"Osino Presby Senior High/Tech.",	"Presby Senior High, Begoro",	"Abuakwa State College",	"Akim Asafo Senior High",	"Apedwa Presby Senior High",	"Kibi Senior High/Tech",	"Ofori Panin Senior High",	"Saviour Senior High, Osiem",	"St. Stephen's Presby Snr. High/Tech, Asiakwa",	"W.B.M. Zion Senior High, Old Tafo",	"St. Rose's Senior High, Akwatia",	"Salvation Army Senior High, Akim Wenchi",	"Tarkrowase Comm. Senior High",	"Achiase Senior High",	"Akim Swedru Senior High",	"Aperade Senior High/Tech.",	"Amuana Praso Senior High",	"New Abirem/Afosu Senior High",	"St. Michael's Senior High, Akoase (Nkawkaw)",	"Akroso Senior High/Tech",	"Attafuah Senior High/Tech",	"Atweaman Senior High",	"Oda Senior High",	"St. Francis Senior High/Tech, Akim Oda",	"Anum Apapam Comm. Day",	"Kraboa-Coaltar Presby Snr. High/Tech.",	"STEM Academy, Abomosu",	"S.D.A. Senior High. Akim Sekyere",	"Kwabeng Anglican Senior High/Tech",	"Adjena Senior High/Tech.",	"Akwamuman Senior High",	"Anum Presby Senior High",	"Apeguso Senior High",	"Boso Senior High Technical",	"Akokoaso Senior High/Tech",	"Ayirebi Senior High",	"Aburi Girls Senior High",	"Adonten Senior High",	"Diaspora Girls' Senior High",	"Presby Senior High/Tech, Aburi",	"Benkum Senior High",	"H'Mount Sinai Senior High",	"Mampong/Akw Snr. High/Tech for the Deaf",	"Mangoase Senior High",	"Methodist Girls Senior High, Mamfe",	"Nifa Senior High",	"Okuapeman Senior High",	"Presby Senior High, Mampong Akwapim",	"Presby Senior High/Tech, Adukrom",	"Presby Senior High/Tech, Larteh",	"Maame Krobo Comm. Senior High",	"St. Fidelis Senior High/Tech",	"Donkorkrom Agric Senior High",	"Mem-Chemfre Comm. Senior High",	"Lashibi Comm. Day",	"Chemu Senior High/Tech",	"Our Lady of Mercy Senior High",	"Presby Senior High, Tema",	"Tema Manhean Senior High/Tech",	"Tema Meth. Day Senior High",	"Tema Senior High ",	"Ghanata Senior High",	"Osudoku Senior High/Tech.",	"Ningo Senior High",	"Prampram Senior High",	"O'Reilly Senior High",	"Presby Senior High, Teshie",	"West Africa Senior High",	"Presby Boys Senior High, Legon",	"Forces Senior High/Tech, Burma Camp",	"La Presby Senior High",	"Labone Senior High",	"St. Thomas Aquinas Senior High, Cantoments",	"Nungua Senior High",	"Kpone Comm. Senior High",	"Adjen Kotoku Senior High",	"Akramaman Senior High",	"Amasaman Senior High/Tech",	"St. John's Grammar Senior High",	"Christian Methodist Senior High",	"Ngleshie Amanfro Senior High",	"Kwabenya Comm. Senior High",	"Odorgonno Senior High",	"Ashiaman Senior High",	"Frafraha Comm. Senior High",	"Ada Senior High/Tech.",	"Ada Senior High",	"Accra Academy",	"Accra Girls Senior High .",	"Accra Senior High",	"Accra Wesley Girls High",	"Achimota Senior High",	"Ebenezer Senior High",	"Holy Trinity Senior High",	"Kaneshie Senior High/Tech.",	"Kinbu Senior High/Tech",	"Presby Senior High, Osu",	"St. Margaret Mary Snr.High/Tech",	"St. Mary's Senior High, Korle Gonno ",	"Wesley Grammar Senior High",	"Yunyoo-Nasuan Comm. SHS",	"Ghana STEM Academy, Kpasenpke",	"Janga Senior High/Tech",	"Walewale Senior High",	"Wulugu Senior High",	"Yagaba Senior High School",	"Gambaga Girls Senior High",	"Langbinsi Senior High/Tech",	"Nalerigu Senior High",	"Sakogu Senior High/Tech",	"Chereponi Senior High/Tech.",	"Bunkpurugu Senior High/Tech",	"Nakpanduri Senior High",	"Presby SHTS, Nankpanduri",	"Zabzugu Senior High",	"Dagbon State Senior High/Tech",	"Yendi Senior High",	"Kasuliyili Senior High",	"Tolon Senior High",	"E. P. Agric Senior High/Tech.",	"Anbariya Senior High Sch.",	"Business Senior High, Tamale",	"Ghana Senior High, Tamale",	"Presby Senior High, Tamale",	"St. Charles Senior High, Tamale",	"Tamale Girls Senior High",	"Vitting Senior High/Tech.",	"Pong-Tamale Senior High",	"Savelugu Senior High",	"Islamic Science Senior High, Tamale",	"Kalpohin Senior High",	"Northern School of Business",	"Tamale Senior High .",	"Saboba E.P. Senior High",	"Wapuli Comm. Senior High",	"Wulensi Senior High",	"Bimbilla Senior High",	"Sang Comm. Day School",	"Kumbungu Senior High",	"Kpandai Senior High",	"Karaga Senior High",	"Gushegu Senior High",	"Kyabobo Girls' School",	"Nkwanta Comm.Senior High",	"Nkwanta Senior High",	"Ntruboman Senior High",	"Kpassa Senior High/Tech",	"Kete Krachi Senior High/Tech.",	"Krachi Senior High",	"Nchumuruman Comm. Day Senior High",	"Asukawkaw Senior High",	"Oti Senior High/Tech Sch",	"Yabram Comm. Day School",	"Ahamansu Islamic Senior High School",	"Dodi-Papase Senior High/Tech",	"Kadjebi-Asato Senior High",	"Baglo Ridge Senior High/Tech.",	"Bueman Senior High .",	"Okadjakrom Senior High/Tech.",	"Biakoye Comm. School",	"Bowiri Comm. Day School",	"Nkonya Senior High",	"Tapaman Senior High/Tech",	"Worawora Senior High",	"Damongo Senior High",	"Ndewura Jakpa Senior High/Tech.",	"Sawla Senior High Sch.",	"Tuna Senior High/Tech.",	"Daboya Comm. Day School",	"Salaga Senior High",	"Salaga T.I. Ahmad Senior High",	"Buipe Senior High",	"Mpaha Comm. Senior High",	"Bamboi Comm. Senior High",	"Bole Senior High",	"St. Anthony of Padua Senior High/Tech",	"Bolgatanga Senior High ",	"Tongo Senior High/Tech",	"Pusiga Comm. Day Senior High Sch.",	"Kongo Senior High",	"Chiana Senior High",	"Mirigu Community Day Senior High",	"Nabango Senior High Tech",	"Paga Senior High",	"Sirigu Senior High",	"Awe Senior High/Tech.",	"Navrongo Senior High ",	"Notre Dame Sem/ Senior High, Navrongo",	"St. John's Integrated Snr. High/Tech",	"O.L.L. Girls Senior High",	"Tempane Senior High",	"Garu Comm. Day Senior High",	"Fumbisi Senior High",	"Kanjaga Comm. Senior High",	"Naab Azantilow Senior High/Tech.",	"Sandema Senior High",	"Wiaga Comm. Senior High",	"Azeem-Namoa Senior High/Tech",	"Bongo Senior High",	"Gowrie Senior High/Tech.",	"Zorkor Senior High",	"Bolga Girls Senior High ",	"Bolga Sherigu Comm. Senior High",	"Zamse Senior High/Tech",	"Zuarungu Senior High",	"Gambigo Comm. Day Senior High",	"Binduri Comm. Senior High",	"Kusanaba Senior High",	"Zebilla Senior High/Tech",	"Bawku Senior High",	"Bawku Senior High/Tech.",	"Lassie-Tuolu Senior High",	"Islamic Senior High, Wa",	"Jamiat Al-Hidaya Islamic Girls",	"Northern Star Senior High",	"T. I. Ahmadiyya Senior High, Wa",	"Wa Senior High .",	"Wa Senior High/Tech.",	"Funsi Senior High School",	"Loggu Comm. Day School",	"Dr. Hila Liman Senior High School",	"Kanton Senior High",	"Tumu Senior High/Tech.",	"Ko Senior High",	"Nandom Senior High",	"Sombo Senior High",	"Kaleo Senior High/Tech",	"Queen of Peace Senior High, Nadowli",	"St. Augustine Senior High/Tech, Saan Charikpong",	"Takpo Senior High Sch.",	"Birifoh Senior High Sch.",	"Eremon Senior High/Tech.",	"Lawra Senior High ",	"Lambussie Comm. Senior High",	"Piina Senior High",	"Holy Family Senior High",	"Han Senior High",	"Jirapa Senior High",	"St. Francis Girls Senior High, Jirapa ",	"Ullo Senior High",	"Daffiamah Senior High",	"Dabala Senior High/Tech.",	"Sogakope Senior High",	"St. Catherine Girls Senior High",	"Kpeve Senior High Tech",	"Peki Senior High",	"Peki Senior High/Technical",	"Tongor Senior High Tech.",	"Aveyime Battor Senior High/Tech.",	"Battor Senior High",	"Dofor Senior High",	"Mepe St. Kizito Senior High/Tech.",	"Volo Comm. Senior High",	"Anfoega Senior High",	"Vakpo Senior High",	"Vakpo Senior High/Tech",	"Bishop Herman College",	"Kpando Senior High .",	"Aflao Community SHS",	"Klikor Senior High/Tech.",	"Some Senior High",	"St. Paul's Senior High, Denu",	"Three Town Senior High",	"Afife Senior High Tech.",	"Dzodze Penyi Senior High",	"Weta Senior High/Tech.",	"Wovenu Senior High Technical",	"Keta Senior High/Tech .",	"Afadjato Senior High/Tech.",	"Akpafu Senior High/Tech.",	"Alavanyo Senior High/Tech.",	"E. P. Senior High",	"Likpe Senior High",	"St. Mary's Sem.& Senior High, Lolobi",	"Abutia Senior High/Tchnical",	"Akome Senior High/Tech.",	"Avatime Senior High",	"Dzolo Senior High",	"Kpedze Senior High",	"Tsito Senior High/Tech",	"Awudome Senior High .",	"E.P.C. Mawuko Girls Senior High",	"Mawuli School, Ho",	"OLA Girls Senior High, Ho",	"Shia Senior HighTechnical",	"Sokode Senior High/Tech",	"Tanyigbe Senior High",	"Taviefe Senior High",	"Ziavi Senior High/Tech",	"Adidome Senior High",	"Mafi-Kumasi Senior High/Tech",	"Abor Senior High",	"Anlo Afiadenyigba Senior High",	"Anlo Awomefia Senior High",	"Anlo Senior High",	"Atiavi Senior High/Tech",	"Keta Business Senior High",	"Tsiame Senior High",	"Volta Senior High School",	"Zion Senior High",	"Avenor Senior High",	"Ave Senior High",	"Akatsi Senior High/Tech",	"Agotime Senior High",	"Ziope Senior High Sch.",	"Agate Comm. Senior High",	"Jim Bourton Mem Agric. Senior High",	"Leklebi Senior High",	"Ve Comm. Senior High",	"Adaklu Senior High",	"Gbekor Senior High",	"Asankrangwa Senior High",	"Asankrangwa Senior High/Tech",	"Amenfiman Senior High",	"Benso Senior High/Tech",	"Fiaseman Senior High",	"Tarkwa Senior High",	"Ahantaman Girls' Senior High",	"Shama Senior High",	"Adiembra Senior High",	"Archbishop Porter Girls Snr.High .",	"Bompeh Senior High./Tech",	"Diabene Senior High/Tech",	"Fijai Senior High",	"Ghana Senior High/Tech",	"Methodist Senior High, Sekondi",	"Sekondi College ",	"St. John's Senior High, Sekondi",	"Huni Valley Senior High",	"Prestea Senior High/Tech",	"St. Augustine's Senior High, Bogoso",	"Axim Girls Senior High",	"Gwiraman Comm.Senior High",	"Nsein Senior High",	"Daboase Senior High/Tech",	"Mpohor Senior High",	"Annor Adjaye Senior High",	"Half Assini Senior High",	"Bonzo-Kaku Senior High",	"Esiama Senior High/Tech",	"Nkroful Agric. Senior High",	"Uthman Bin Afam SHS",	"Takoradi Senior High",	"Baidoo Bonso Senior High/Tech",	"Sankor Senior High School",	"St. Mary's Boys' Senior High, Apowa",	"Manso-Amenfi Comm. Day School",	"Dadieso Senior High",	"Asawinso Senior High",	"Sefwi-Wiawso Senior High",	"Sefwi-Wiawso Senior High/Tech",	"St. Joseph Senior High, Sefwi Wiawso",	"Akontombra Senior High",	"Nsawora Edumafa Comm. Senior High School",	"Juaboso Senior High",	"Bodi Senior High",	"Bibiani Senior High/Tech.",	"Chirano Comm. Day School",	"Ghana STEM Academy, Awaso",	"Queens Girls' Senior High, Sefwi Awhiaso",	"Sefwi Bekwai Senior High",	"Adjoafua Comm. Senior High",	"Bia Senior High/Tech",	"Adabokrom Comm. SHS",	"Nana Brentu Senior High/Tech", "Nuriya Islamic SHS", "Presbyterian Boys Model SHS", "Wioso SHS", "Holy Child SHS", "Twereku Ampem SHS", "Kyem Amponsah SHS", "Gomoa Jukwa SDA SHS"))) %>%
  
  
  
  
  output$region_ui_hbk3 <- renderUI({
    selectInput("region_select_hbk3", 
                label = h4("Select a region to view the PLC attendance summary of schools in the selected region for Handbook 3"), 
                choices = unique(plc_data_hbk3$Region_hbk3), 
                selected = unique(plc_data_hbk3$Region_hbk3)[1])
  })
  
  table_trial_hbk3 <- reactive({
    data_hbk3 <- plc_data_hbk3 %>% 
      filter(plc_take_place_hbk3 == 1, Region_hbk3 == input$region_select_hbk3) %>%
      mutate(Name_school_hbk3 = factor(Name_school_hbk3, levels = c ("Bechem Presby Senior High",	"Derma Comm. Day School",	"Samuel Otu Presby Senior High.",	"Boakye Tromo Senior High/Tech",	"Bomaa Comm. Senior High",	"Serwaa Kesse Girls Senior High",	"Terchire Senior High",	"Yamfo Anglican Senior High School",	"Acherensua Senior High",	"Hwidiem Senior High",	"Gyamfi Kumanini Senior High/Tech",	"OLA Girls Senior High, Kenyasi ",	"Kukuom Agric Senior High",	"Sankore Senior High",	"Ahafoman Senior High/Tech",	"Mim Senior High",	"Adu Gyamfi Senior High",	"Agona Senior High/Tech",	"Boanim Senior High/ Tech Sch",	"Konadu Yiadom Catholic Senior High",	"Okomfo Anokye Senior High",	"S.D.A. Senior High, Agona",	"Bankoman Senior High",	"Bodomase Senior High/Tech",	"Dadease Agric Senior High",	"Tweneboa Kodua Senior High",	"Effiduase Senior High/Com",	"Effiduase Senior High/Tech",	"T. I. Ahmadiyya Girl's Senior High, Asokore",	"Tijjaniya Senior High",	"Ghana Muslim Mission Senior High",	"Nsutaman Cath. Senior High",	"Presby Senior High/Tech, Kwamang",	"Akumadan Senior High",	"Asuoso Comm. Senior High",	"Nkenkansu Community Senior High",	"Wiafe Akenten Presby Senior High",	"Dwamena Akenten Senior High",	"Namong Senior High/Tech",	"St. Jerome Senior High, Abofour",	"Christ the King Cath., Obuasi",	"Obuasi Senior High/Tech",	"Spiritan Senior High",	"Amaniampong Senior High",	"Kofiase Adventist Senior High/Tech.",	"Opoku Agyeman Senior High/Tech",	"St. Joseph Sem/Senior High, Mampong",	"St. Monica's Senior High, Mampong",	"Adanwomase Senior High",	"Adventist Girls Senior High, Ntonso",	"Antoa Senior High",	"Gyaama Pensan Senior High/Tech",	"Kofi Adjei Senior High/Tech",	"Simms Senior High/Com.",	"Islamic Senior High,Kumasi",	"Adventist Senior High, Kumasi",	"Agric Nzema Senior High, Kumasi",	"Al-Azariya Islamic Snr. High, Kumasi",	"Anglican Senior High, Kumasi",	"Armed Forces Senior High/Tech, Kumasi",	"Asanteman Senior High",	"J. A. Kufuor Senior High",	"KNUST Senior High",	"Kumasi Girls Senior High,",	"Kumasi High School",	"Kumasi Senior High/Tech",	"Kumasi Wesley Girls High Sch",	"Mancell Senior High",	"Nuru-Ameen Islamic Senior High, Asewase",	"Opoku Ware School",	"Osei Kyeretwie Senior High",	"Pentecost Senior High, Kumasi",	"Prempeh College",	"Prince Of Peace Girls",	"Serwaah Nyarko Girls' Snr. High",	"St. Hubert Sem/Senior High, Kumasi",	"St. Louis Senior High, Kumasi",	"T. I. Ahmadiyya Senior High , Kumasi",	"Uthmaniya Senior High, Tafo",	"Yaa Asantewaa Girls Senior High .",	"Juaben Senior High",	"Akwesi Awobaa Senior High",	"Ejuraman Anglican Senior High",	"Sekyedumase Senior High/Tech",	"Onwe senior High Senior",	"Ejisu Senior High/Tech",	"Achinakrom Senior High",	"Bonwire Senior High/Tech",	"Ejisuman Senior High",	"Church Of Christ Senior High",	"St. Sebastian Cath. Senior High",	"Ghana STEM Academy, Deduako",	"Ghana STEM Academy, Jachie",	"Beposo Senior High",	"Bosomtwe Oyoko Comm. Senior High",	"Jachie Pramso Senior High",	"Osei Adutwum Senior High",	"St. George's Senior High Tech.",	"Bosomtwe Senior High/Tech",	"Bosome Senior High/Tech.",	"Denyaseman Cath.Senior High",	"Ofoase Kokoben Senior High",	"Oppong Mem. Senior High",	"S.D.A. Senior High, Bekwai",	"St. Joseph Senior High/Tech, Ahwiren",	"Wesley High School, Bekwai",	"Barekese Senior High",	"Nkawie Senior High/Tech",	"Osei Tutu Senior High, Akropong",	"Toase Senior High",	"Adobewora Comm. Senior High",	"Mpasatia Senior High/Tech",	"Nyinahin Cath. Senior High",	"Afua Kobi Ampem Girls' Senior High",	"Anum Asamoah Senior High/Tech",	"Atwima Kwanwoma Snr High/Tech",	"Presbyterian Girls Senior High",	"Ibadur Rahman Academy",	"Kumasi Academy",	"Parkoso Comm. Senior High",	"Sakafia Islamic Senior High",	"Tawheed Senior High.",	"Banka Comm. Senior High",	"Bompata Presby Senior High",	"Juaso Senior High/Tech",	"Jubilee Senior High",	"Kurofa Methodist Senior High Tech",	"Morso Senior High/Tech",	"Ofoase Senior High/Tech",	"Agogo State College",	"Collins Senior High/Commercial, Agogo",	"Owerriman Senior High Tech",	"Konongo Odumase Senior High .",	"St. Mary's Girl's Senior High, Konongo",	"Wesley Senior High, Konongo .",	"Esaase Bontefufuo Snr. High/Tech.",	"Manso-Adubia Senior High",	"Mansoman Senior High",	"Jacobu Senior High/Tech.",	"Tweapease Senior High School",	"Adugyama Comm. Senior High",	"Mankranso Senior High",	"Sabronum Methodist Senior High/Tech",	"Maabang Senior High/Tech",	"Tepa Senior High",	"Afigya Senior High/Tech",	"Afigyaman Senior High School",	"St. Michael's Senior High, Ahenkro",	"Aduman Senior High",	"Otumfuo Osei Tutu II College",	"Akrofuom Senior High/Tech",	"New Edubiase Senior High",	"Asare Bediako Senior High .",	"Bodwesango Senior High",	"Dompoase Senior High",	"Fomena T.I. Ahmad Senior High",	"Ghana STEM Academy, Koase",	"Istiquaama Snr. High",	"Koase Senior High/Tech",	"Nkyeraa Senior High Sch.",	"Wenchi Meth. Senior High",	"Badu Senior High/Tech.",	"Menji Senior High",	"Nkoranman Senior High",	"Nsawkaw State Senior High",	"Chiraa Senior High",	"Notre Dame Girls Senior High, Sunyani",	"Odomaseman Senior High",	"Sacred Heart Senior High, Nsoatre",	"S.D.A Senior High, Sunyani",	"St. James Sem & Senior High, Abesim",	"Sunyani Senior High",	"Twene Amanfo Senior High/Tech.",	"Drobo Senior High",	"Our Lady of Providence Senior High",	"Diamono Senior High Sch.",	"Duadaso No. 1 Senior High/Tech.",	"Goka Senior High/Tech.",	"Nafana Senior High",	"St. Ann's Girls Senior High, Sampa",	"Sumaman Senior High",	"Nkrankwanta Comm Senior High",	"Mansen Senior High",	"Wamanafo Senior High/Tech",	"Dormaa Senior High",	"Salvation Army Senior High, Aboabo Dormaa",	"Berekum Presby Senior High",	"Berekum Senior High",	"Jinijini Senior High",	"Methodist Senior High/Tech.,Biadan",	"St. Augustine Senior High, Nsapor-Berekum",	"Bandaman Senior High",	"Ameyaw Akumfi Senior High/Tech.",	"Guakro Effah Senior High",	"Krobo Comm.Senior High",	"St. Francis Seminary/Senior High, Buoyem",	"Tuobodom Senior High/Tech",	"Gyarko Comm. Day Senior High",	"Kesse Basahyia Senior High",	"Kwarteng Ankomah Senior High",	"Our Lady of Mount Carmel Girls Senior High, Techiman",	"Techiman Senior High",	"Yeboah Asuamah Senior High",	"Abrafi Senior High",	"Kwame Danso Senior High/Tech",	"Bassa Community Senior High",	"Kajaji Senior High",	"Abeaseman Comm. Day Senior High",	"Prang Senior High",	"Yeji Senior High/Tech",	"Donkro- Nkwanta Senior High",	"Kwabre Senior High",	"Nkoranza Senior High/Tech",	"Busunya Senior High",	"Osei Bonsu Senior High",	"Jema Senior High",	"Kintampo Senior High",	"New Longoro Comm.School (Dega)",	"Amanten Senior High",	"Atebubu Senior High",	"New Krokompe Comm. Senior High",	"Ayanfuri Senior High",	"Diaso Senior High",	"Boa-Amponsem Senior High",	"Dunkwa Senior High/Tech",	"Kyekyewere Comm. Senior High School",	"Mokwaa Senior High Sch",	"Jukwa Senior High",	"Twifo Hemang Senior High/Tech",	"Twifo Praso Senior High",	"Abeadze State College",	"Kwegyir Aggrey Senior High",	"Mankessim Senior High/Tech",	"Methodist High School,Saltpond",	"Mfantsiman Girls Senior High",	"Kobina Ansah SHS",	"Edinaman Senior High",	"Eguafo-Abrem Senior High",	"Komenda Senior High/Tech.",	"Apam Senior High",	"College of Music Senior, Mozano",	"Gomoa Senior High/Tech",	"Mozano Senior High",	"Fettehman Senior High",	"Gomoa Gyaman Senior High",	"Potsin T.I. Ahm. Senior High",	"S.D.A SHS, Jukwa",	"St. Gregory Catholic Senior High School",	"Ogyeedom Comm.Snr High/Tech",	"Akyin Senior High School",	"Ekumfi T. I. Ahmadiiyya Snr. High",	"J.E.A. Mills Senior High",	"Winneba Senior High",	"Academy of Christ the King, Cape Coast",	"Adisadel College",	"Effutu Senior High/Tech",	"Ghana National College",	"Holy Child School, Cape Coast",	"Mfantsipim School",	"Oguaa Senior High/Tech",	"St. Augustine's College, Cape Coast",	"University Practice Senior High",	"Wesley Girls Senior High, Cape Coast",	"Awutu Bawjiase Comm. Senior High",	"Awutu Winton Senior High",	"Obrachire Senior High/Tech",	"Odupong Comm. Day School",	"Senya Senior High",	"Bontrase Senior High Tech. Sch",	"Adankwaman Senior High",	"Assin Manso Senior High",	"Assin Nsuta Agric. Senior High",	"Nyankumase Ahenkro Snr. High",	"Assin North Senior High/Tech",	"Assin State College",	"Gyaase Community Senior High",	"Obiri Yeboah Senior High/Technical",	"Brakwa Senior High/Tech",	"Breman Asikuma Senior High",	"Odoben Senior High",	"Bisease Senior High/Com",	"Enyan Denkyira Senior High",	"Enyan Maim Comm. Day School",	"Mando Senior High/Tech.",	"Agona Fankobaa Senior High",	"Nyakrom Senior High Tech",	"Siddiq Senior High Sch.",	"Swedru Sch. Of Business",	"Agona Namonwora Comm.Senior High",	"Ampim Darko Senior High School",	"Kwanyako Senior High ",	"Nsaba Presby Senior High",	"Swedru Senior High",	"Abakrampa Senior High/Tech",	"Aburaman Senior High",	"Aggrey Mem. A.M.E.Zion Snr. High",	"Moree Comm. Senior High",	"Apesua Comm. Senior High",	"Klo-Agogo Senior High",	"Yilo Krobo Senior High/Com",	"Asamankese Senior High",	"St. Thomas Senior High/Tech",	"Adeiso Presby Senior High",	"Kwaobaah Nyanoa Comm. Senior High",	"Asesewa Senior High School",	"Islamic Girls Senior High,Suhum",	"Presby Senior High, Suhum",	"Suhum Senior High/Tech",	"Nsawam Senior High",	"St. Martin's Senior High, Nsawam",	"Ghana Senior High, Koforidua ",	"Koforidua Senior High/Tech",	"New Juaben Senior High/Com",	"Oti Boateng Senior High",	"Oyoko Methodist Senior High",	"Pope John Snr. High & Min. Sem., Koforidua",	"S.D.A Senior High, Koforidua",	"Pentecost Senior High,Koforidua",	"Akro Senior High/Tech",	"Akuse Methodist Senior High/Tech",	"Krobo Girls Senior High",	"Manya Krobo Senior High",	"Fodoa Comm. Senior High",	"Nkawkaw Senior High",	"Bepong Senior High School",	"Kwahu Ridge Senior High",	"Mpraeso Senior High",	"St. Paul's Senior High, Asakraka Kwahu",	"St. Peter's Senior High, Nkwatia",	"Abetifi Presby Senior High",	"Kwahu Tafo Senior High",	"Nkwatia Presby Senior High/Com",	"St. Dominic's Senior High/Tech, Pepease",	"Asuom Senior High",	"Kade Senior High/Tech.",	"New Nsutam Senior High/Tech",	"Osino Presby Senior High/Tech.",	"Presby Senior High, Begoro",	"Abuakwa State College",	"Akim Asafo Senior High",	"Apedwa Presby Senior High",	"Kibi Senior High/Tech",	"Ofori Panin Senior High",	"Saviour Senior High, Osiem",	"St. Stephen's Presby Snr. High/Tech, Asiakwa",	"W.B.M. Zion Senior High, Old Tafo",	"St. Rose's Senior High, Akwatia",	"Salvation Army Senior High, Akim Wenchi",	"Tarkrowase Comm. Senior High",	"Achiase Senior High",	"Akim Swedru Senior High",	"Aperade Senior High/Tech.",	"Amuana Praso Senior High",	"New Abirem/Afosu Senior High",	"St. Michael's Senior High, Akoase (Nkawkaw)",	"Akroso Senior High/Tech",	"Attafuah Senior High/Tech",	"Atweaman Senior High",	"Oda Senior High",	"St. Francis Senior High/Tech, Akim Oda",	"Anum Apapam Comm. Day",	"Kraboa-Coaltar Presby Snr. High/Tech.",	"STEM Academy, Abomosu",	"S.D.A. Senior High. Akim Sekyere",	"Kwabeng Anglican Senior High/Tech",	"Adjena Senior High/Tech.",	"Akwamuman Senior High",	"Anum Presby Senior High",	"Apeguso Senior High",	"Boso Senior High Technical",	"Akokoaso Senior High/Tech",	"Ayirebi Senior High",	"Aburi Girls Senior High",	"Adonten Senior High",	"Diaspora Girls' Senior High",	"Presby Senior High/Tech, Aburi",	"Benkum Senior High",	"H'Mount Sinai Senior High",	"Mampong/Akw Snr. High/Tech for the Deaf",	"Mangoase Senior High",	"Methodist Girls Senior High, Mamfe",	"Nifa Senior High",	"Okuapeman Senior High",	"Presby Senior High, Mampong Akwapim",	"Presby Senior High/Tech, Adukrom",	"Presby Senior High/Tech, Larteh",	"Maame Krobo Comm. Senior High",	"St. Fidelis Senior High/Tech",	"Donkorkrom Agric Senior High",	"Mem-Chemfre Comm. Senior High",	"Lashibi Comm. Day",	"Chemu Senior High/Tech",	"Our Lady of Mercy Senior High",	"Presby Senior High, Tema",	"Tema Manhean Senior High/Tech",	"Tema Meth. Day Senior High",	"Tema Senior High ",	"Ghanata Senior High",	"Osudoku Senior High/Tech.",	"Ningo Senior High",	"Prampram Senior High",	"O'Reilly Senior High",	"Presby Senior High, Teshie",	"West Africa Senior High",	"Presby Boys Senior High, Legon",	"Forces Senior High/Tech, Burma Camp",	"La Presby Senior High",	"Labone Senior High",	"St. Thomas Aquinas Senior High, Cantoments",	"Nungua Senior High",	"Kpone Comm. Senior High",	"Adjen Kotoku Senior High",	"Akramaman Senior High",	"Amasaman Senior High/Tech",	"St. John's Grammar Senior High",	"Christian Methodist Senior High",	"Ngleshie Amanfro Senior High",	"Kwabenya Comm. Senior High",	"Odorgonno Senior High",	"Ashiaman Senior High",	"Frafraha Comm. Senior High",	"Ada Senior High/Tech.",	"Ada Senior High",	"Accra Academy",	"Accra Girls Senior High .",	"Accra Senior High",	"Accra Wesley Girls High",	"Achimota Senior High",	"Ebenezer Senior High",	"Holy Trinity Senior High",	"Kaneshie Senior High/Tech.",	"Kinbu Senior High/Tech",	"Presby Senior High, Osu",	"St. Margaret Mary Snr.High/Tech",	"St. Mary's Senior High, Korle Gonno ",	"Wesley Grammar Senior High",	"Yunyoo-Nasuan Comm. SHS",	"Ghana STEM Academy, Kpasenpke",	"Janga Senior High/Tech",	"Walewale Senior High",	"Wulugu Senior High",	"Yagaba Senior High School",	"Gambaga Girls Senior High",	"Langbinsi Senior High/Tech",	"Nalerigu Senior High",	"Sakogu Senior High/Tech",	"Chereponi Senior High/Tech.",	"Bunkpurugu Senior High/Tech",	"Nakpanduri Senior High",	"Presby SHTS, Nankpanduri",	"Zabzugu Senior High",	"Dagbon State Senior High/Tech",	"Yendi Senior High",	"Kasuliyili Senior High",	"Tolon Senior High",	"E. P. Agric Senior High/Tech.",	"Anbariya Senior High Sch.",	"Business Senior High, Tamale",	"Ghana Senior High, Tamale",	"Presby Senior High, Tamale",	"St. Charles Senior High, Tamale",	"Tamale Girls Senior High",	"Vitting Senior High/Tech.",	"Pong-Tamale Senior High",	"Savelugu Senior High",	"Islamic Science Senior High, Tamale",	"Kalpohin Senior High",	"Northern School of Business",	"Tamale Senior High .",	"Saboba E.P. Senior High",	"Wapuli Comm. Senior High",	"Wulensi Senior High",	"Bimbilla Senior High",	"Sang Comm. Day School",	"Kumbungu Senior High",	"Kpandai Senior High",	"Karaga Senior High",	"Gushegu Senior High",	"Kyabobo Girls' School",	"Nkwanta Comm.Senior High",	"Nkwanta Senior High",	"Ntruboman Senior High",	"Kpassa Senior High/Tech",	"Kete Krachi Senior High/Tech.",	"Krachi Senior High",	"Nchumuruman Comm. Day Senior High",	"Asukawkaw Senior High",	"Oti Senior High/Tech Sch",	"Yabram Comm. Day School",	"Ahamansu Islamic Senior High School",	"Dodi-Papase Senior High/Tech",	"Kadjebi-Asato Senior High",	"Baglo Ridge Senior High/Tech.",	"Bueman Senior High .",	"Okadjakrom Senior High/Tech.",	"Biakoye Comm. School",	"Bowiri Comm. Day School",	"Nkonya Senior High",	"Tapaman Senior High/Tech",	"Worawora Senior High",	"Damongo Senior High",	"Ndewura Jakpa Senior High/Tech.",	"Sawla Senior High Sch.",	"Tuna Senior High/Tech.",	"Daboya Comm. Day School",	"Salaga Senior High",	"Salaga T.I. Ahmad Senior High",	"Buipe Senior High",	"Mpaha Comm. Senior High",	"Bamboi Comm. Senior High",	"Bole Senior High",	"St. Anthony of Padua Senior High/Tech",	"Bolgatanga Senior High ",	"Tongo Senior High/Tech",	"Pusiga Comm. Day Senior High Sch.",	"Kongo Senior High",	"Chiana Senior High",	"Mirigu Community Day Senior High",	"Nabango Senior High Tech",	"Paga Senior High",	"Sirigu Senior High",	"Awe Senior High/Tech.",	"Navrongo Senior High ",	"Notre Dame Sem/ Senior High, Navrongo",	"St. John's Integrated Snr. High/Tech",	"O.L.L. Girls Senior High",	"Tempane Senior High",	"Garu Comm. Day Senior High",	"Fumbisi Senior High",	"Kanjaga Comm. Senior High",	"Naab Azantilow Senior High/Tech.",	"Sandema Senior High",	"Wiaga Comm. Senior High",	"Azeem-Namoa Senior High/Tech",	"Bongo Senior High",	"Gowrie Senior High/Tech.",	"Zorkor Senior High",	"Bolga Girls Senior High ",	"Bolga Sherigu Comm. Senior High",	"Zamse Senior High/Tech",	"Zuarungu Senior High",	"Gambigo Comm. Day Senior High",	"Binduri Comm. Senior High",	"Kusanaba Senior High",	"Zebilla Senior High/Tech",	"Bawku Senior High",	"Bawku Senior High/Tech.",	"Lassie-Tuolu Senior High",	"Islamic Senior High, Wa",	"Jamiat Al-Hidaya Islamic Girls",	"Northern Star Senior High",	"T. I. Ahmadiyya Senior High, Wa",	"Wa Senior High .",	"Wa Senior High/Tech.",	"Funsi Senior High School",	"Loggu Comm. Day School",	"Dr. Hila Liman Senior High School",	"Kanton Senior High",	"Tumu Senior High/Tech.",	"Ko Senior High",	"Nandom Senior High",	"Sombo Senior High",	"Kaleo Senior High/Tech",	"Queen of Peace Senior High, Nadowli",	"St. Augustine Senior High/Tech, Saan Charikpong",	"Takpo Senior High Sch.",	"Birifoh Senior High Sch.",	"Eremon Senior High/Tech.",	"Lawra Senior High ",	"Lambussie Comm. Senior High",	"Piina Senior High",	"Holy Family Senior High",	"Han Senior High",	"Jirapa Senior High",	"St. Francis Girls Senior High, Jirapa ",	"Ullo Senior High",	"Daffiamah Senior High",	"Dabala Senior High/Tech.",	"Sogakope Senior High",	"St. Catherine Girls Senior High",	"Kpeve Senior High Tech",	"Peki Senior High",	"Peki Senior High/Technical",	"Tongor Senior High Tech.",	"Aveyime Battor Senior High/Tech.",	"Battor Senior High",	"Dofor Senior High",	"Mepe St. Kizito Senior High/Tech.",	"Volo Comm. Senior High",	"Anfoega Senior High",	"Vakpo Senior High",	"Vakpo Senior High/Tech",	"Bishop Herman College",	"Kpando Senior High .",	"Aflao Community SHS",	"Klikor Senior High/Tech.",	"Some Senior High",	"St. Paul's Senior High, Denu",	"Three Town Senior High",	"Afife Senior High Tech.",	"Dzodze Penyi Senior High",	"Weta Senior High/Tech.",	"Wovenu Senior High Technical",	"Keta Senior High/Tech .",	"Afadjato Senior High/Tech.",	"Akpafu Senior High/Tech.",	"Alavanyo Senior High/Tech.",	"E. P. Senior High",	"Likpe Senior High",	"St. Mary's Sem.& Senior High, Lolobi",	"Abutia Senior High/Tchnical",	"Akome Senior High/Tech.",	"Avatime Senior High",	"Dzolo Senior High",	"Kpedze Senior High",	"Tsito Senior High/Tech",	"Awudome Senior High .",	"E.P.C. Mawuko Girls Senior High",	"Mawuli School, Ho",	"OLA Girls Senior High, Ho",	"Shia Senior HighTechnical",	"Sokode Senior High/Tech",	"Tanyigbe Senior High",	"Taviefe Senior High",	"Ziavi Senior High/Tech",	"Adidome Senior High",	"Mafi-Kumasi Senior High/Tech",	"Abor Senior High",	"Anlo Afiadenyigba Senior High",	"Anlo Awomefia Senior High",	"Anlo Senior High",	"Atiavi Senior High/Tech",	"Keta Business Senior High",	"Tsiame Senior High",	"Volta Senior High School",	"Zion Senior High",	"Avenor Senior High",	"Ave Senior High",	"Akatsi Senior High/Tech",	"Agotime Senior High",	"Ziope Senior High Sch.",	"Agate Comm. Senior High",	"Jim Bourton Mem Agric. Senior High",	"Leklebi Senior High",	"Ve Comm. Senior High",	"Adaklu Senior High",	"Gbekor Senior High",	"Asankrangwa Senior High",	"Asankrangwa Senior High/Tech",	"Amenfiman Senior High",	"Benso Senior High/Tech",	"Fiaseman Senior High",	"Tarkwa Senior High",	"Ahantaman Girls' Senior High",	"Shama Senior High",	"Adiembra Senior High",	"Archbishop Porter Girls Snr.High .",	"Bompeh Senior High./Tech",	"Diabene Senior High/Tech",	"Fijai Senior High",	"Ghana Senior High/Tech",	"Methodist Senior High, Sekondi",	"Sekondi College ",	"St. John's Senior High, Sekondi",	"Huni Valley Senior High",	"Prestea Senior High/Tech",	"St. Augustine's Senior High, Bogoso",	"Axim Girls Senior High",	"Gwiraman Comm.Senior High",	"Nsein Senior High",	"Daboase Senior High/Tech",	"Mpohor Senior High",	"Annor Adjaye Senior High",	"Half Assini Senior High",	"Bonzo-Kaku Senior High",	"Esiama Senior High/Tech",	"Nkroful Agric. Senior High",	"Uthman Bin Afam SHS",	"Takoradi Senior High",	"Baidoo Bonso Senior High/Tech",	"Sankor Senior High School",	"St. Mary's Boys' Senior High, Apowa",	"Manso-Amenfi Comm. Day School",	"Dadieso Senior High",	"Asawinso Senior High",	"Sefwi-Wiawso Senior High",	"Sefwi-Wiawso Senior High/Tech",	"St. Joseph Senior High, Sefwi Wiawso",	"Akontombra Senior High",	"Nsawora Edumafa Comm. Senior High School",	"Juaboso Senior High",	"Bodi Senior High",	"Bibiani Senior High/Tech.",	"Chirano Comm. Day School",	"Ghana STEM Academy, Awaso",	"Queens Girls' Senior High, Sefwi Awhiaso",	"Sefwi Bekwai Senior High",	"Adjoafua Comm. Senior High",	"Bia Senior High/Tech",	"Adabokrom Comm. SHS",	"Nana Brentu Senior High/Tech", "Nuriya Islamic SHS", "Presbyterian Boys Model SHS", "Wioso SHS", "Holy Child SHS", "Twereku Ampem SHS", "Kyem Amponsah SHS", "Gomoa Jukwa SDA SHS","Santa Esther Girls SHS" ))) %>%
                                                                     
                                                                     
                                                                     
                                                                     group_by(Name_school_hbk3) %>%
                                                                       summarise(
                                                                         count_hbk3 = sum(plc_take_place_hbk3 == 1),
                                                                         sessions_3 = list(nts_hbk3.Session_hbk3),
                                                                         
                                                                         male_mean_hbk3 = round(mean(nts_hbk3.male_attendance_hbk3, na.rm = TRUE),0),
                                                                         female_mean_hbk3 = round(mean(nts_hbk3.female_attendance_hbk3, na.rm = TRUE),0),
                                                                         overall_mean_hbk3 = round(mean(nts_hbk3.total_attendance_hbk3, na.rm = TRUE),0),
                                                                         male_pop_mean_hbk3 = round(mean(nts_hbk3.no_male_teachers_hbk3, na.rm = TRUE),0),
                                                                         female_pop_mean_hbk3 = round(mean(nts_hbk3.no_female_teachers_hbk3, na.rm = TRUE),0),
                                                                         overall_pop_mean_hbk3 = round(mean(nts_hbk3.total_teachers_schoo_hbk3, na.rm = TRUE),0),
                                                                         percent_male_attend_hbk3 = scales::percent(male_mean_hbk3/male_pop_mean_hbk3),
                                                                         percent_female_attend_hbk3 = scales::percent(female_mean_hbk3/female_pop_mean_hbk3),
                                                                         percent_total_attend_hbk3 = scales::percent(overall_mean_hbk3/overall_pop_mean_hbk3)
                                                                       )%>%
                                                                       rowwise() %>%
                                                                       mutate(
                                                                         
                                                                         
                                                                         
                                                                         
                                                                         
                                                                         ############
                                                                         units_completed_hbk3 = {
                                                                           # Extract all numeric values from the session descriptions
                                                                           session_nums_3 <- unlist(str_extract_all(unlist(sessions_3), "^Session \\d+(:.*)?"))
                                                                           
                                                                           # Remove "Session" and any text after the session number
                                                                           session_nums_3 <- as.numeric(gsub("Session |:.*", "", session_nums_3))
                                                                           # Remove duplicate session numbers, convert to numeric, and sort
                                                                           session_nums_3 <- unique(as.numeric(session_nums_3))
                                                                           session_nums_3 <- sort(session_nums_3)
                                                                           print(session_nums_3)
                                                                           
                                                                           valid_sessions <- unique(plc_data_hbk3$nts_hbk3.Session_hbk3)  # Ensure this column exists in nts_hbk3
                                                                           print(valid_sessions)  # Debugging: Print valid sessions
                                                                           print(session_nums_3)  # Debugging: Print session numbers before filtering
                                                                           session_nums <- session_nums_3[session_nums_3 %in% valid_sessions]  # Filter valid sessions
                                                                           print(session_nums_3) 
                                                                           # Create the string with PLC Session prefix
                                                                           session_str_3 <- if (length(session_nums_3) > 0) {
                                                                             paste("PLC Session(s):", paste(session_nums_3, collapse = ", "))
                                                                           } else {
                                                                             "PLC Session(s): None"
                                                                           }
                                                                           session_str_3
                                                                         }
                                                                       )
                                                                     return(data_hbk3)
                                                                     
                                                                     
                                                                     
  })
  
  
  output$table_plot_hbk3 <- renderRHandsontable({
    table_data_hbk3 <- table_trial_hbk3()
    
    if (is.null(table_data_hbk3)) {
      return(NULL) # Return NULL if table_data is NULL (i.e., an error occurred)
    }
    
    table_data_hbk3$Name_school_hbk3 <- as.character(table_data_hbk3$Name_school_hbk3) # Convert factor to character
    
    table_data_subset_hbk3 <- table_data_hbk3[, c("Name_school_hbk3", "count_hbk3", "units_completed_hbk3", "percent_male_attend_hbk3", "percent_female_attend_hbk3", "percent_total_attend_hbk3")]
    
    rhandsontable(table_data_subset_hbk3,
                  colHeaders = c("School name", "Number of meetings Held","Details of Sessions Completed and Submitted", "Male teacher attendance (percent)", "Female teacher attendance (percent)", "Overall attendance (percent)"),
                  rowHeaders = NULL,
                  search = TRUE,
                  readOnly = TRUE) %>%
      hot_context_menu(
        customOpts = list(
          csv = list(
            name = "Download to CSV",
            callback = JS(
              "function (key, options) {
             var csv = csvString(this, sep = ',', dec = '.');

             var link = document.createElement('a');
             link.setAttribute('href', 'data:text/plain;charset=utf-8,' +
               encodeURIComponent(csv));
             link.setAttribute('download', 'table_data.csv');

             document.body.appendChild(link);
             link.click();
             document.body.removeChild(link);
           }")
          )
        )
      ) %>%
      hot_cols(
        colWidths = c(280, rep(180, 5))  # Adjust column widths as needed
      ) %>%
      onRender(
        JS(
          "function(el, x) {
           var hot = this.hot;  // Reference to the Handsontable instance
           hot.addHook('beforeChange', function(changes, source) {
             if (source === 'alter' && (changes[0][0] === 'insert_row' || changes[0][0] === 'remove_row')) {
               return false;  // Prevent row insertion and deletion
             }
           });
         }"
        )
      )
  })
  
  
  
  output$export_button_hbk3 <- downloadHandler(
    filename = function() {
      paste("data_hbk3", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      table_data_hbk3 <- table_trial_hbk3()  # Get the reactive data
      table_data_subset_hbk3 <- table_data_hbk3[, c("Name_school_hbk3", "count_hbk3", "units_completed_hbk3", "percent_male_attend_hbk3", "percent_female_attend_hbk3", "percent_total_attend_hbk3")]
      write.csv(table_data_subset_hbk3, file, row.names = FALSE)
    }
  )
  
  
  
  
  ###############################################################################################END OF HANDBOOK 3 SCHOOL LEVEL CODE
  
  
  
  ##
  
  ##################################################################################################Handbook 4 school level code
  ##########################################################################code for handbook 4 plc attendance
  
  
  
  output$region_ui_hbk4 <- renderUI({
    selectInput("region_select_hbk4", 
                label = h4("Select a region to view the PLC attendance summary of schools in the selected region for Year 1 SSPLC"), 
                choices = unique(plc_data_hbk4$Region_hbk4), 
                selected = unique(plc_data_hbk4$Region_hbk4)[1])
  })
  
  
  table_trial_hbk4 <- reactive({
    data_hbk4 <- plc_data_hbk4 %>% 
      filter(plc_take_place_hbk4 == 1, Region_hbk4 == input$region_select_hbk4) %>%
      mutate(Name_school_hbk4 = factor(Name_school_hbk4, levels = c ("Bechem Presby Senior High",
                                                                     "Derma Comm. Day School",
                                                                     "Samuel Otu Presby Senior High.",
                                                                     "Boakye Tromo Senior High/Tech",
                                                                     "Bomaa Comm. Senior High",
                                                                     "Serwaa Kesse Girls Senior High",
                                                                     "Terchire Senior High",
                                                                     "Yamfo Anglican Senior High School",
                                                                     "Acherensua Senior High",
                                                                     "Hwidiem Senior High",
                                                                     "Gyamfi Kumanini Senior High/Tech",
                                                                     "OLA Girls Senior High, Kenyasi ",
                                                                     "Kukuom Agric Senior High",
                                                                     "Sankore Senior High",
                                                                     "Ahafoman Senior High/Tech",
                                                                     "Mim Senior High",
                                                                     "Adu Gyamfi Senior High",
                                                                     "Agona Senior High/Tech",
                                                                     "Boanim Senior High/ Tech Sch",
                                                                     "Konadu Yiadom Catholic Senior High",
                                                                     "Okomfo Anokye Senior High",
                                                                     "S.D.A. Senior High, Agona",
                                                                     "Bankoman Senior High",
                                                                     "Bodomase Senior High/Tech",
                                                                     "Dadease Agric Senior High",
                                                                     "Tweneboa Kodua Senior High",
                                                                     "Effiduase Senior High/Com",
                                                                     "Effiduase Senior High/Tech",
                                                                     "T. I. Ahmadiyya Girl's Senior High, Asokore",
                                                                     "Tijjaniya Senior High",
                                                                     "Ghana Muslim Mission Senior High",
                                                                     "Nsutaman Cath. Senior High",
                                                                     "Presby Senior High/Tech, Kwamang",
                                                                     "Akumadan Senior High",
                                                                     "Asuoso Comm. Senior High",
                                                                     "Nkenkansu Community Senior High",
                                                                     "Wiafe Akenten Presby Senior High",
                                                                     "Dwamena Akenten Senior High",
                                                                     "Namong Senior High/Tech",
                                                                     "St. Jerome Senior High, Abofour",
                                                                     "Christ the King Cath., Obuasi",
                                                                     "Obuasi Senior High/Tech",
                                                                     "Spiritan Senior High",
                                                                     "Amaniampong Senior High",
                                                                     "Kofiase Adventist Senior High/Tech.",
                                                                     "Opoku Agyeman Senior High/Tech",
                                                                     "St. Joseph Sem/Senior High, Mampong",
                                                                     "St. Monica's Senior High, Mampong",
                                                                     "Adanwomase Senior High",
                                                                     "Adventist Girls Senior High, Ntonso",
                                                                     "Antoa Senior High",
                                                                     "Gyaama Pensan Senior High/Tech",
                                                                     "Kofi Adjei Senior High/Tech",
                                                                     "Simms Senior High/Com.",
                                                                     "Islamic Senior High,Kumasi",
                                                                     "Adventist Senior High, Kumasi",
                                                                     "Agric Nzema Senior High, Kumasi",
                                                                     "Al-Azariya Islamic Snr. High, Kumasi",
                                                                     "Anglican Senior High, Kumasi",
                                                                     "Armed Forces Senior High/Tech, Kumasi",
                                                                     "Asanteman Senior High",
                                                                     "J. A. Kufuor Senior High",
                                                                     "KNUST Senior High",
                                                                     "Kumasi Girls Senior High,",
                                                                     "Kumasi High School",
                                                                     "Kumasi Senior High/Tech",
                                                                     "Kumasi Wesley Girls High Sch",
                                                                     "Mancell Senior High",
                                                                     "Nuru-Ameen Islamic Senior High, Asewase",
                                                                     "Opoku Ware School",
                                                                     "Osei Kyeretwie Senior High",
                                                                     "Pentecost Senior High, Kumasi",
                                                                     "Prempeh College",
                                                                     "Prince Of Peace Girls",
                                                                     "Serwaah Nyarko Girls' Snr. High",
                                                                     "St. Hubert Sem/Senior High, Kumasi",
                                                                     "St. Louis Senior High, Kumasi",
                                                                     "T. I. Ahmadiyya Senior High , Kumasi",
                                                                     "Uthmaniya Senior High, Tafo",
                                                                     "Yaa Asantewaa Girls Senior High .",
                                                                     "Juaben Senior High",
                                                                     "Akwesi Awobaa Senior High",
                                                                     "Ejuraman Anglican Senior High",
                                                                     "Sekyedumase Senior High/Tech",
                                                                     "Onwe senior High Senior",
                                                                     "Ejisu Senior High/Tech",
                                                                     "Achinakrom Senior High",
                                                                     "Bonwire Senior High/Tech",
                                                                     "Ejisuman Senior High",
                                                                     "Church Of Christ Senior High",
                                                                     "St. Sebastian Cath. Senior High",
                                                                     "Ghana STEM Academy, Deduako",
                                                                     "Ghana STEM Academy, Jachie",
                                                                     "Beposo Senior High",
                                                                     "Bosomtwe Oyoko Comm. Senior High",
                                                                     "Jachie Pramso Senior High",
                                                                     "Osei Adutwum Senior High",
                                                                     "St. George's Senior High Tech.",
                                                                     "Bosomtwe Senior High/Tech",
                                                                     "Bosome Senior High/Tech.",
                                                                     "Denyaseman Cath.Senior High",
                                                                     "Ofoase Kokoben Senior High",
                                                                     "Oppong Mem. Senior High",
                                                                     "S.D.A. Senior High, Bekwai",
                                                                     "St. Joseph Senior High/Tech, Ahwiren",
                                                                     "Wesley High School, Bekwai",
                                                                     "Barekese Senior High",
                                                                     "Nkawie Senior High/Tech",
                                                                     "Osei Tutu Senior High, Akropong",
                                                                     "Toase Senior High",
                                                                     "Adobewora Comm. Senior High",
                                                                     "Mpasatia Senior High/Tech",
                                                                     "Nyinahin Cath. Senior High",
                                                                     "Afua Kobi Ampem Girls' Senior High",
                                                                     "Anum Asamoah Senior High/Tech",
                                                                     "Atwima Kwanwoma Snr High/Tech",
                                                                     "Presbyterian Girls Senior High",
                                                                     "Ibadur Rahman Academy",
                                                                     "Kumasi Academy",
                                                                     "Parkoso Comm. Senior High",
                                                                     "Sakafia Islamic Senior High",
                                                                     "Tawheed Senior High.",
                                                                     "Banka Comm. Senior High",
                                                                     "Bompata Presby Senior High",
                                                                     "Juaso Senior High/Tech",
                                                                     "Jubilee Senior High",
                                                                     "Kurofa Methodist Senior High Tech",
                                                                     "Morso Senior High/Tech",
                                                                     "Ofoase Senior High/Tech",
                                                                     "Agogo State College",
                                                                     "Collins Senior High/Commercial, Agogo",
                                                                     "Owerriman Senior High Tech",
                                                                     "Konongo Odumase Senior High .",
                                                                     "St. Mary's Girl's Senior High, Konongo",
                                                                     "Wesley Senior High, Konongo .",
                                                                     "Esaase Bontefufuo Snr. High/Tech.",
                                                                     "Manso-Adubia Senior High",
                                                                     "Mansoman Senior High",
                                                                     "Jacobu Senior High/Tech.",
                                                                     "Tweapease Senior High School",
                                                                     "Adugyama Comm. Senior High",
                                                                     "Mankranso Senior High",
                                                                     "Sabronum Methodist Senior High/Tech",
                                                                     "Maabang Senior High/Tech",
                                                                     "Tepa Senior High",
                                                                     "Afigya Senior High/Tech",
                                                                     "Afigyaman Senior High School",
                                                                     "St. Michael's Senior High, Ahenkro",
                                                                     "Aduman Senior High",
                                                                     "Otumfuo Osei Tutu II College",
                                                                     "Akrofuom Senior High/Tech",
                                                                     "New Edubiase Senior High",
                                                                     "Asare Bediako Senior High .",
                                                                     "Bodwesango Senior High",
                                                                     "Dompoase Senior High",
                                                                     "Fomena T.I. Ahmad Senior High",
                                                                     "Ghana STEM Academy, Koase",
                                                                     "Istiquaama Snr. High",
                                                                     "Koase Senior High/Tech",
                                                                     "Nkyeraa Senior High Sch.",
                                                                     "Wenchi Meth. Senior High",
                                                                     "Badu Senior High/Tech.",
                                                                     "Menji Senior High",
                                                                     "Nkoranman Senior High",
                                                                     "Nsawkaw State Senior High",
                                                                     "Chiraa Senior High",
                                                                     "Notre Dame Girls Senior High, Sunyani",
                                                                     "Odomaseman Senior High",
                                                                     "Sacred Heart Senior High, Nsoatre",
                                                                     "S.D.A Senior High, Sunyani",
                                                                     "St. James Sem & Senior High, Abesim",
                                                                     "Sunyani Senior High",
                                                                     "Twene Amanfo Senior High/Tech.",
                                                                     "Drobo Senior High",
                                                                     "Our Lady of Providence Senior High",
                                                                     "Diamono Senior High Sch.",
                                                                     "Duadaso No. 1 Senior High/Tech.",
                                                                     "Goka Senior High/Tech.",
                                                                     "Nafana Senior High",
                                                                     "St. Ann's Girls Senior High, Sampa",
                                                                     "Sumaman Senior High",
                                                                     "Nkrankwanta Comm Senior High",
                                                                     "Mansen Senior High",
                                                                     "Wamanafo Senior High/Tech",
                                                                     "Dormaa Senior High",
                                                                     "Salvation Army Senior High, Aboabo Dormaa",
                                                                     "Berekum Presby Senior High",
                                                                     "Berekum Senior High",
                                                                     "Jinijini Senior High",
                                                                     "Methodist Senior High/Tech.,Biadan",
                                                                     "St. Augustine Senior High, Nsapor-Berekum",
                                                                     "Bandaman Senior High",
                                                                     "Ameyaw Akumfi Senior High/Tech.",
                                                                     "Guakro Effah Senior High",
                                                                     "Krobo Comm.Senior High",
                                                                     "St. Francis Seminary/Senior High, Buoyem",
                                                                     "Tuobodom Senior High/Tech",
                                                                     "Gyarko Comm. Day Senior High",
                                                                     "Kesse Basahyia Senior High",
                                                                     "Kwarteng Ankomah Senior High",
                                                                     "Our Lady of Mount Carmel Girls Senior High, Techiman",
                                                                     "Techiman Senior High",
                                                                     "Yeboah Asuamah Senior High",
                                                                     "Abrafi Senior High",
                                                                     "Kwame Danso Senior High/Tech",
                                                                     "Bassa Community Senior High",
                                                                     "Kajaji Senior High",
                                                                     "Abeaseman Comm. Day Senior High",
                                                                     "Prang Senior High",
                                                                     "Yeji Senior High/Tech",
                                                                     "Donkro- Nkwanta Senior High",
                                                                     "Kwabre Senior High",
                                                                     "Nkoranza Senior High/Tech",
                                                                     "Busunya Senior High",
                                                                     "Osei Bonsu Senior High",
                                                                     "Jema Senior High",
                                                                     "Kintampo Senior High",
                                                                     "New Longoro Comm.School (Dega)",
                                                                     "Amanten Senior High",
                                                                     "Atebubu Senior High",
                                                                     "New Krokompe Comm. Senior High",
                                                                     "Ayanfuri Senior High",
                                                                     "Diaso Senior High",
                                                                     "Boa-Amponsem Senior High",
                                                                     "Dunkwa Senior High/Tech",
                                                                     "Kyekyewere Comm. Senior High School",
                                                                     "Mokwaa Senior High Sch",
                                                                     "Jukwa Senior High",
                                                                     "Twifo Hemang Senior High/Tech",
                                                                     "Twifo Praso Senior High",
                                                                     "Abeadze State College",
                                                                     "Kwegyir Aggrey Senior High",
                                                                     "Mankessim Senior High/Tech",
                                                                     "Methodist High School,Saltpond",
                                                                     "Mfantsiman Girls Senior High",
                                                                     "Kobina Ansah SHS",
                                                                     "Edinaman Senior High",
                                                                     "Eguafo-Abrem Senior High",
                                                                     "Komenda Senior High/Tech.",
                                                                     "Apam Senior High",
                                                                     "College of Music Senior, Mozano",
                                                                     "Gomoa Senior High/Tech",
                                                                     "Mozano Senior High",
                                                                     "Fettehman Senior High",
                                                                     "Gomoa Gyaman Senior High",
                                                                     "Potsin T.I. Ahm. Senior High",
                                                                     "S.D.A SHS, Jukwa",
                                                                     "St. Gregory Catholic Senior High School",
                                                                     "Ogyeedom Comm.Snr High/Tech",
                                                                     "Akyin Senior High School",
                                                                     "Ekumfi T. I. Ahmadiiyya Snr. High",
                                                                     "J.E.A. Mills Senior High",
                                                                     "Winneba Senior High",
                                                                     "Academy of Christ the King, Cape Coast",
                                                                     "Adisadel College",
                                                                     "Effutu Senior High/Tech",
                                                                     "Ghana National College",
                                                                     "Holy Child School, Cape Coast",
                                                                     "Mfantsipim School",
                                                                     "Oguaa Senior High/Tech",
                                                                     "St. Augustine's College, Cape Coast",
                                                                     "University Practice Senior High",
                                                                     "Wesley Girls Senior High, Cape Coast",
                                                                     "Awutu Bawjiase Comm. Senior High",
                                                                     "Awutu Winton Senior High",
                                                                     "Obrachire Senior High/Tech",
                                                                     "Odupong Comm. Day School",
                                                                     "Senya Senior High",
                                                                     "Bontrase Senior High Tech. Sch",
                                                                     "Adankwaman Senior High",
                                                                     "Assin Manso Senior High",
                                                                     "Assin Nsuta Agric. Senior High",
                                                                     "Nyankumase Ahenkro Snr. High",
                                                                     "Assin North Senior High/Tech",
                                                                     "Assin State College",
                                                                     "Gyaase Community Senior High",
                                                                     "Obiri Yeboah Senior High/Technical",
                                                                     "Brakwa Senior High/Tech",
                                                                     "Breman Asikuma Senior High",
                                                                     "Odoben Senior High",
                                                                     "Bisease Senior High/Com",
                                                                     "Enyan Denkyira Senior High",
                                                                     "Enyan Maim Comm. Day School",
                                                                     "Mando Senior High/Tech.",
                                                                     "Agona Fankobaa Senior High",
                                                                     "Nyakrom Senior High Tech",
                                                                     "Siddiq Senior High Sch.",
                                                                     "Swedru Sch. Of Business",
                                                                     "Agona Namonwora Comm.Senior High",
                                                                     "Ampim Darko Senior High School",
                                                                     "Kwanyako Senior High ",
                                                                     "Nsaba Presby Senior High",
                                                                     "Swedru Senior High",
                                                                     "Abakrampa Senior High/Tech",
                                                                     "Aburaman Senior High",
                                                                     "Aggrey Mem. A.M.E.Zion Snr. High",
                                                                     "Moree Comm. Senior High",
                                                                     "Apesua Comm. Senior High",
                                                                     "Klo-Agogo Senior High",
                                                                     "Yilo Krobo Senior High/Com",
                                                                     "Asamankese Senior High",
                                                                     "St. Thomas Senior High/Tech",
                                                                     "Adeiso Presby Senior High",
                                                                     "Kwaobaah Nyanoa Comm. Senior High",
                                                                     "Asesewa Senior High School",
                                                                     "Islamic Girls Senior High,Suhum",
                                                                     "Presby Senior High, Suhum",
                                                                     "Suhum Senior High/Tech",
                                                                     "Nsawam Senior High",
                                                                     "St. Martin's Senior High, Nsawam",
                                                                     "Ghana Senior High, Koforidua ",
                                                                     "Koforidua Senior High/Tech",
                                                                     "New Juaben Senior High/Com",
                                                                     "Oti Boateng Senior High",
                                                                     "Oyoko Methodist Senior High",
                                                                     "Pope John Snr. High & Min. Sem., Koforidua",
                                                                     "S.D.A Senior High, Koforidua",
                                                                     "Pentecost Senior High,Koforidua",
                                                                     "Akro Senior High/Tech",
                                                                     "Akuse Methodist Senior High/Tech",
                                                                     "Krobo Girls Senior High",
                                                                     "Manya Krobo Senior High",
                                                                     "Fodoa Comm. Senior High",
                                                                     "Nkawkaw Senior High",
                                                                     "Bepong Senior High School",
                                                                     "Kwahu Ridge Senior High",
                                                                     "Mpraeso Senior High",
                                                                     "St. Paul's Senior High, Asakraka Kwahu",
                                                                     "St. Peter's Senior High, Nkwatia",
                                                                     "Abetifi Presby Senior High",
                                                                     "Kwahu Tafo Senior High",
                                                                     "Nkwatia Presby Senior High/Com",
                                                                     "St. Dominic's Senior High/Tech, Pepease",
                                                                     "Asuom Senior High",
                                                                     "Kade Senior High/Tech.",
                                                                     "New Nsutam Senior High/Tech",
                                                                     "Osino Presby Senior High/Tech.",
                                                                     "Presby Senior High, Begoro",
                                                                     "Abuakwa State College",
                                                                     "Akim Asafo Senior High",
                                                                     "Apedwa Presby Senior High",
                                                                     "Kibi Senior High/Tech",
                                                                     "Ofori Panin Senior High",
                                                                     "Saviour Senior High, Osiem",
                                                                     "St. Stephen's Presby Snr. High/Tech, Asiakwa",
                                                                     "W.B.M. Zion Senior High, Old Tafo",
                                                                     "St. Rose's Senior High, Akwatia",
                                                                     "Salvation Army Senior High, Akim Wenchi",
                                                                     "Tarkrowase Comm. Senior High",
                                                                     "Achiase Senior High",
                                                                     "Akim Swedru Senior High",
                                                                     "Aperade Senior High/Tech.",
                                                                     "Amuana Praso Senior High",
                                                                     "New Abirem/Afosu Senior High",
                                                                     "St. Michael's Senior High, Akoase (Nkawkaw)",
                                                                     "Akroso Senior High/Tech",
                                                                     "Attafuah Senior High/Tech",
                                                                     "Atweaman Senior High",
                                                                     "Oda Senior High",
                                                                     "St. Francis Senior High/Tech, Akim Oda",
                                                                     "Anum Apapam Comm. Day",
                                                                     "Kraboa-Coaltar Presby Snr. High/Tech.",
                                                                     "STEM Academy, Abomosu",
                                                                     "S.D.A. Senior High. Akim Sekyere",
                                                                     "Kwabeng Anglican Senior High/Tech",
                                                                     "Adjena Senior High/Tech.",
                                                                     "Akwamuman Senior High",
                                                                     "Anum Presby Senior High",
                                                                     "Apeguso Senior High",
                                                                     "Boso Senior High Technical",
                                                                     "Akokoaso Senior High/Tech",
                                                                     "Ayirebi Senior High",
                                                                     "Aburi Girls Senior High",
                                                                     "Adonten Senior High",
                                                                     "Diaspora Girls' Senior High",
                                                                     "Presby Senior High/Tech, Aburi",
                                                                     "Benkum Senior High",
                                                                     "H'Mount Sinai Senior High",
                                                                     "Mampong/Akw Snr. High/Tech for the Deaf",
                                                                     "Mangoase Senior High",
                                                                     "Methodist Girls Senior High, Mamfe",
                                                                     "Nifa Senior High",
                                                                     "Okuapeman Senior High",
                                                                     "Presby Senior High, Mampong Akwapim",
                                                                     "Presby Senior High/Tech, Adukrom",
                                                                     "Presby Senior High/Tech, Larteh",
                                                                     "Maame Krobo Comm. Senior High",
                                                                     "St. Fidelis Senior High/Tech",
                                                                     "Donkorkrom Agric Senior High",
                                                                     "Mem-Chemfre Comm. Senior High",
                                                                     "Lashibi Comm. Day",
                                                                     "Chemu Senior High/Tech",
                                                                     "Our Lady of Mercy Senior High",
                                                                     "Presby Senior High, Tema",
                                                                     "Tema Manhean Senior High/Tech",
                                                                     "Tema Meth. Day Senior High",
                                                                     "Tema Senior High ",
                                                                     "Ghanata Senior High",
                                                                     "Osudoku Senior High/Tech.",
                                                                     "Ningo Senior High",
                                                                     "Prampram Senior High",
                                                                     "O'Reilly Senior High",
                                                                     "Presby Senior High, Teshie",
                                                                     "West Africa Senior High",
                                                                     "Presby Boys Senior High, Legon",
                                                                     "Forces Senior High/Tech, Burma Camp",
                                                                     "La Presby Senior High",
                                                                     "Labone Senior High",
                                                                     "St. Thomas Aquinas Senior High, Cantoments",
                                                                     "Nungua Senior High",
                                                                     "Kpone Comm. Senior High",
                                                                     "Adjen Kotoku Senior High",
                                                                     "Akramaman Senior High",
                                                                     "Amasaman Senior High/Tech",
                                                                     "St. John's Grammar Senior High",
                                                                     "Christian Methodist Senior High",
                                                                     "Ngleshie Amanfro Senior High",
                                                                     "Kwabenya Comm. Senior High",
                                                                     "Odorgonno Senior High",
                                                                     "Ashiaman Senior High",
                                                                     "Frafraha Comm. Senior High",
                                                                     "Ada Senior High/Tech.",
                                                                     "Ada Senior High",
                                                                     "Accra Academy",
                                                                     "Accra Girls Senior High .",
                                                                     "Accra Senior High",
                                                                     "Accra Wesley Girls High",
                                                                     "Achimota Senior High",
                                                                     "Ebenezer Senior High",
                                                                     "Holy Trinity Senior High",
                                                                     "Kaneshie Senior High/Tech.",
                                                                     "Kinbu Senior High/Tech",
                                                                     "Presby Senior High, Osu",
                                                                     "St. Margaret Mary Snr.High/Tech",
                                                                     "St. Mary's Senior High, Korle Gonno ",
                                                                     "Wesley Grammar Senior High",
                                                                     "Yunyoo-Nasuan Comm. SHS",
                                                                     "Ghana STEM Academy, Kpasenpke",
                                                                     "Janga Senior High/Tech",
                                                                     "Walewale Senior High",
                                                                     "Wulugu Senior High",
                                                                     "Yagaba Senior High School",
                                                                     "Gambaga Girls Senior High",
                                                                     "Langbinsi Senior High/Tech",
                                                                     "Nalerigu Senior High",
                                                                     "Sakogu Senior High/Tech",
                                                                     "Chereponi Senior High/Tech.",
                                                                     "Bunkpurugu Senior High/Tech",
                                                                     "Nakpanduri Senior High",
                                                                     "Presby SHTS, Nankpanduri",
                                                                     "Zabzugu Senior High",
                                                                     "Dagbon State Senior High/Tech",
                                                                     "Yendi Senior High",
                                                                     "Kasuliyili Senior High",
                                                                     "Tolon Senior High",
                                                                     "E. P. Agric Senior High/Tech.",
                                                                     "Anbariya Senior High Sch.",
                                                                     "Business Senior High, Tamale",
                                                                     "Ghana Senior High, Tamale",
                                                                     "Presby Senior High, Tamale",
                                                                     "St. Charles Senior High, Tamale",
                                                                     "Tamale Girls Senior High",
                                                                     "Vitting Senior High/Tech.",
                                                                     "Pong-Tamale Senior High",
                                                                     "Savelugu Senior High",
                                                                     "Islamic Science Senior High, Tamale",
                                                                     "Kalpohin Senior High",
                                                                     "Northern School of Business",
                                                                     "Tamale Senior High .",
                                                                     "Saboba E.P. Senior High",
                                                                     "Wapuli Comm. Senior High",
                                                                     "Wulensi Senior High",
                                                                     "Bimbilla Senior High",
                                                                     "Sang Comm. Day School",
                                                                     "Kumbungu Senior High",
                                                                     "Kpandai Senior High",
                                                                     "Karaga Senior High",
                                                                     "Gushegu Senior High",
                                                                     "Kyabobo Girls' School",
                                                                     "Nkwanta Comm.Senior High",
                                                                     "Nkwanta Senior High",
                                                                     "Ntruboman Senior High",
                                                                     "Kpassa Senior High/Tech",
                                                                     "Kete Krachi Senior High/Tech.",
                                                                     "Krachi Senior High",
                                                                     "Nchumuruman Comm. Day Senior High",
                                                                     "Asukawkaw Senior High",
                                                                     "Oti Senior High/Tech Sch",
                                                                     "Yabram Comm. Day School",
                                                                     "Ahamansu Islamic Senior High School",
                                                                     "Dodi-Papase Senior High/Tech",
                                                                     "Kadjebi-Asato Senior High",
                                                                     "Baglo Ridge Senior High/Tech.",
                                                                     "Bueman Senior High .",
                                                                     "Okadjakrom Senior High/Tech.",
                                                                     "Biakoye Comm. School",
                                                                     "Bowiri Comm. Day School",
                                                                     "Nkonya Senior High",
                                                                     "Tapaman Senior High/Tech",
                                                                     "Worawora Senior High",
                                                                     "Damongo Senior High",
                                                                     "Ndewura Jakpa Senior High/Tech.",
                                                                     "Sawla Senior High Sch.",
                                                                     "Tuna Senior High/Tech.",
                                                                     "Daboya Comm. Day School",
                                                                     "Salaga Senior High",
                                                                     "Salaga T.I. Ahmad Senior High",
                                                                     "Buipe Senior High",
                                                                     "Mpaha Comm. Senior High",
                                                                     "Bamboi Comm. Senior High",
                                                                     "Bole Senior High",
                                                                     "St. Anthony of Padua Senior High/Tech",
                                                                     "Bolgatanga Senior High ",
                                                                     "Tongo Senior High/Tech",
                                                                     "Pusiga Comm. Day Senior High Sch.",
                                                                     "Kongo Senior High",
                                                                     "Chiana Senior High",
                                                                     "Mirigu Community Day Senior High",
                                                                     "Nabango Senior High Tech",
                                                                     "Paga Senior High",
                                                                     "Sirigu Senior High",
                                                                     "Awe Senior High/Tech.",
                                                                     "Navrongo Senior High ",
                                                                     "Notre Dame Sem/ Senior High, Navrongo",
                                                                     "St. John's Integrated Snr. High/Tech",
                                                                     "O.L.L. Girls Senior High",
                                                                     "Tempane Senior High",
                                                                     "Garu Comm. Day Senior High",
                                                                     "Fumbisi Senior High",
                                                                     "Kanjaga Comm. Senior High",
                                                                     "Naab Azantilow Senior High/Tech.",
                                                                     "Sandema Senior High",
                                                                     "Wiaga Comm. Senior High",
                                                                     "Azeem-Namoa Senior High/Tech",
                                                                     "Bongo Senior High",
                                                                     "Gowrie Senior High/Tech.",
                                                                     "Zorkor Senior High",
                                                                     "Bolga Girls Senior High ",
                                                                     "Bolga Sherigu Comm. Senior High",
                                                                     "Zamse Senior High/Tech",
                                                                     "Zuarungu Senior High",
                                                                     "Gambigo Comm. Day Senior High",
                                                                     "Binduri Comm. Senior High",
                                                                     "Kusanaba Senior High",
                                                                     "Zebilla Senior High/Tech",
                                                                     "Bawku Senior High",
                                                                     "Bawku Senior High/Tech.",
                                                                     "Lassie-Tuolu Senior High",
                                                                     "Islamic Senior High, Wa",
                                                                     "Jamiat Al-Hidaya Islamic Girls",
                                                                     "Northern Star Senior High",
                                                                     "T. I. Ahmadiyya Senior High, Wa",
                                                                     "Wa Senior High .",
                                                                     "Wa Senior High/Tech.",
                                                                     "Funsi Senior High School",
                                                                     "Loggu Comm. Day School",
                                                                     "Dr. Hila Liman Senior High School",
                                                                     "Kanton Senior High",
                                                                     "Tumu Senior High/Tech.",
                                                                     "Ko Senior High",
                                                                     "Nandom Senior High",
                                                                     "Sombo Senior High",
                                                                     "Kaleo Senior High/Tech",
                                                                     "Queen of Peace Senior High, Nadowli",
                                                                     "St. Augustine Senior High/Tech, Saan Charikpong",
                                                                     "Takpo Senior High Sch.",
                                                                     "Birifoh Senior High Sch.",
                                                                     "Eremon Senior High/Tech.",
                                                                     "Lawra Senior High ",
                                                                     "Lambussie Comm. Senior High",
                                                                     "Piina Senior High",
                                                                     "Holy Family Senior High",
                                                                     "Han Senior High",
                                                                     "Jirapa Senior High",
                                                                     "St. Francis Girls Senior High, Jirapa ",
                                                                     "Ullo Senior High",
                                                                     "Daffiamah Senior High",
                                                                     "Dabala Senior High/Tech.",
                                                                     "Sogakope Senior High",
                                                                     "St. Catherine Girls Senior High",
                                                                     "Kpeve Senior High Tech",
                                                                     "Peki Senior High",
                                                                     "Peki Senior High/Technical",
                                                                     "Tongor Senior High Tech.",
                                                                     "Aveyime Battor Senior High/Tech.",
                                                                     "Battor Senior High",
                                                                     "Dofor Senior High",
                                                                     "Mepe St. Kizito Senior High/Tech.",
                                                                     "Volo Comm. Senior High",
                                                                     "Anfoega Senior High",
                                                                     "Vakpo Senior High",
                                                                     "Vakpo Senior High/Tech",
                                                                     "Bishop Herman College",
                                                                     "Kpando Senior High .",
                                                                     "Aflao Community SHS",
                                                                     "Klikor Senior High/Tech.",
                                                                     "Some Senior High",
                                                                     "St. Paul's Senior High, Denu",
                                                                     "Three Town Senior High",
                                                                     "Afife Senior High Tech.",
                                                                     "Dzodze Penyi Senior High",
                                                                     "Weta Senior High/Tech.",
                                                                     "Wovenu Senior High Technical",
                                                                     "Keta Senior High/Tech .",
                                                                     "Afadjato Senior High/Tech.",
                                                                     "Akpafu Senior High/Tech.",
                                                                     "Alavanyo Senior High/Tech.",
                                                                     "E. P. Senior High",
                                                                     "Likpe Senior High",
                                                                     "St. Mary's Sem.& Senior High, Lolobi",
                                                                     "Abutia Senior High/Tchnical",
                                                                     "Akome Senior High/Tech.",
                                                                     "Avatime Senior High",
                                                                     "Dzolo Senior High",
                                                                     "Kpedze Senior High",
                                                                     "Tsito Senior High/Tech",
                                                                     "Awudome Senior High .",
                                                                     "E.P.C. Mawuko Girls Senior High",
                                                                     "Mawuli School, Ho",
                                                                     "OLA Girls Senior High, Ho",
                                                                     "Shia Senior HighTechnical",
                                                                     "Sokode Senior High/Tech",
                                                                     "Tanyigbe Senior High",
                                                                     "Taviefe Senior High",
                                                                     "Ziavi Senior High/Tech",
                                                                     "Adidome Senior High",
                                                                     "Mafi-Kumasi Senior High/Tech",
                                                                     "Abor Senior High",
                                                                     "Anlo Afiadenyigba Senior High",
                                                                     "Anlo Awomefia Senior High",
                                                                     "Anlo Senior High",
                                                                     "Atiavi Senior High/Tech",
                                                                     "Keta Business Senior High",
                                                                     "Tsiame Senior High",
                                                                     "Volta Senior High School",
                                                                     "Zion Senior High",
                                                                     "Avenor Senior High",
                                                                     "Ave Senior High",
                                                                     "Akatsi Senior High/Tech",
                                                                     "Agotime Senior High",
                                                                     "Ziope Senior High Sch.",
                                                                     "Agate Comm. Senior High",
                                                                     "Jim Bourton Mem Agric. Senior High",
                                                                     "Leklebi Senior High",
                                                                     "Ve Comm. Senior High",
                                                                     "Adaklu Senior High",
                                                                     "Gbekor Senior High",
                                                                     "Asankrangwa Senior High",
                                                                     "Asankrangwa Senior High/Tech",
                                                                     "Amenfiman Senior High",
                                                                     "Benso Senior High/Tech",
                                                                     "Fiaseman Senior High",
                                                                     "Tarkwa Senior High",
                                                                     "Ahantaman Girls' Senior High",
                                                                     "Shama Senior High",
                                                                     "Adiembra Senior High",
                                                                     "Archbishop Porter Girls Snr.High .",
                                                                     "Bompeh Senior High./Tech",
                                                                     "Diabene Senior High/Tech",
                                                                     "Fijai Senior High",
                                                                     "Ghana Senior High/Tech",
                                                                     "Methodist Senior High, Sekondi",
                                                                     "Sekondi College ",
                                                                     "St. John's Senior High, Sekondi",
                                                                     "Huni Valley Senior High",
                                                                     "Prestea Senior High/Tech",
                                                                     "St. Augustine's Senior High, Bogoso",
                                                                     "Axim Girls Senior High",
                                                                     "Gwiraman Comm.Senior High",
                                                                     "Kwame Nkrumah SHS",
                                                                     "Daboase Senior High/Tech",
                                                                     "Mpohor Senior High",
                                                                     "Annor Adjaye Senior High",
                                                                     "Half Assini Senior High",
                                                                     "Bonzo-Kaku Senior High",
                                                                     "Esiama Senior High/Tech",
                                                                     "Nkroful Agric. Senior High",
                                                                     "Uthman Bin Afam SHS",
                                                                     "Takoradi Senior High",
                                                                     "Baidoo Bonso Senior High/Tech",
                                                                     "Sankor Senior High School",
                                                                     "St. Mary's Boys' Senior High, Apowa",
                                                                     "Manso-Amenfi Comm. Day School",
                                                                     "Dadieso Senior High",
                                                                     "Asawinso Senior High",
                                                                     "Sefwi-Wiawso Senior High",
                                                                     "Sefwi-Wiawso Senior High/Tech",
                                                                     "St. Joseph Senior High, Sefwi Wiawso",
                                                                     "Akontombra Senior High",
                                                                     "Nsawora Edumafa Comm. Senior High School",
                                                                     "Juaboso Senior High",
                                                                     "Bodi Senior High",
                                                                     "Bibiani Senior High/Tech.",
                                                                     "Chirano Comm. Day School",
                                                                     "Ghana STEM Academy, Awaso",
                                                                     "Queens Girls' Senior High, Sefwi Awhiaso",
                                                                     "Sefwi Bekwai Senior High",
                                                                     "Adjoafua Comm. Senior High",
                                                                     "Bia Senior High/Tech",
                                                                     "Adabokrom Comm. SHS",
                                                                     "Nana Brentu Senior High/Tech",
                                                                     "Nuriya Islamic SHS",
                                                                     "Presbyterian Boys Model SHS",
                                                                     "Wioso SHS",
                                                                     "Holy Child SHS",
                                                                     "Twereku Ampem SHS",
                                                                     "Kyem Amponsah SHS",
                                                                     "Gomoa Jukwa SDA SHS",
                                                                     "Santa Esther Girls SHS",
                                                                     "Apagya SHS"))) %>%
      
      
      
      group_by(Name_school_hbk4) %>%
      summarise(
        count_hbk4 = sum(plc_take_place_hbk4 == 1),
        sessions_3 = list(nts_hbk4_Session_hbk4),
        
        male_mean_hbk4 = round(mean(nts_hbk4_male_attendance_hbk4, na.rm = TRUE),0),
        female_mean_hbk4 = round(mean(nts_hbk4_female_attendance_hbk4, na.rm = TRUE),0),
        overall_mean_hbk4 = round(mean(nts_hbk4_total_attendance_hbk4, na.rm = TRUE),0),
        male_pop_mean_hbk4 = round(mean(nts_hbk4_no_male_teachers_hbk4, na.rm = TRUE),0),
        female_pop_mean_hbk4 = round(mean(nts_hbk4_no_female_teachers_hbk4, na.rm = TRUE),0),
        overall_pop_mean_hbk4 = round(mean(nts_hbk4_total_teachers_schoo_hbk4, na.rm = TRUE),0),
        percent_male_attend_hbk4 = scales::percent(male_mean_hbk4/male_pop_mean_hbk4),
        percent_female_attend_hbk4 = scales::percent(female_mean_hbk4/female_pop_mean_hbk4),
        percent_total_attend_hbk4 = scales::percent(overall_mean_hbk4/overall_pop_mean_hbk4)
      )%>%
      rowwise() %>%
      mutate(
        
        
        
        
        
        ############
        units_completed_hbk4 = {
          # Extract all numeric values from the session descriptions
          session_nums_3 <- unlist(str_extract_all(unlist(sessions_3), "^Session \\d+(:.*)?"))
          
          # Remove "Session" and any text after the session number
          session_nums_3 <- as.numeric(gsub("Session |:.*", "", session_nums_3))
          # Remove duplicate session numbers, convert to numeric, and sort
          session_nums_3 <- unique(as.numeric(session_nums_3))
          session_nums_3 <- sort(session_nums_3)
          print(session_nums_3)
          
          valid_sessions <- unique(plc_data_hbk4$nts_hbk4_Session_hbk4)  # Ensure this column exists in nts_hbk4
          print(valid_sessions)  # Debugging: Print valid sessions
          print(session_nums_3)  # Debugging: Print session numbers before filtering
          session_nums <- session_nums_3[session_nums_3 %in% valid_sessions]  # Filter valid sessions
          print(session_nums_3) 
          # Create the string with PLC Session prefix
          session_str_3 <- if (length(session_nums_3) > 0) {
            paste("PLC Session(s):", paste(session_nums_3, collapse = ", "))
          } else {
            "PLC Session(s): None"
          }
          session_str_3
        }
      )
    return(data_hbk4)
  })
  
  
  output$table_plot_hbk4 <- renderRHandsontable({
    table_data_hbk4 <- table_trial_hbk4()
    
    if (is.null(table_data_hbk4)) {
      return(NULL) # Return NULL if table_data is NULL (i.e., an error occurred)
    }
    
    table_data_hbk4$Name_school_hbk4 <- as.character(table_data_hbk4$Name_school_hbk4) # Convert factor to character
    
    table_data_subset_hbk4 <- table_data_hbk4[, c("Name_school_hbk4", "count_hbk4", "units_completed_hbk4", "percent_male_attend_hbk4", "percent_female_attend_hbk4", "percent_total_attend_hbk4")]
    
    rhandsontable(table_data_subset_hbk4,
                  colHeaders = c("School name", "Number of meetings Held","Details of Sessions Completed and Submitted", "Male teacher attendance (percent)", "Female teacher attendance (percent)", "Overall attendance (percent)"),
                  rowHeaders = NULL,
                  search = TRUE,
                  readOnly = TRUE) %>%
      hot_context_menu(
        customOpts = list(
          csv = list(
            name = "Download to CSV",
            callback = JS(
              "function (key, options) {
             var csv = csvString(this, sep = ',', dec = '.');

             var link = document.createElement('a');
             link.setAttribute('href', 'data:text/plain;charset=utf-8,' +
               encodeURIComponent(csv));
             link.setAttribute('download', 'table_data.csv');

             document.body.appendChild(link);
             link.click();
             document.body.removeChild(link);
           }")
          )
        )
      ) %>%
      hot_cols(
        colWidths = c(280, rep(180, 5))  # Adjust column widths as needed
      ) %>%
      onRender(
        JS(
          "function(el, x) {
           var hot = this.hot;  // Reference to the Handsontable instance
           hot.addHook('beforeChange', function(changes, source) {
             if (source === 'alter' && (changes[0][0] === 'insert_row' || changes[0][0] === 'remove_row')) {
               return false;  // Prevent row insertion and deletion
             }
           });
         }"
        )
      )
  })
  
  
  
  output$export_button_hbk4 <- downloadHandler(
    filename = function() {
      paste("data_hbk4", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      table_data_hbk4 <- table_trial_hbk4()  # Get the reactive data
      table_data_subset_hbk4 <- table_data_hbk4[, c("Name_school_hbk4", "count_hbk4", "units_completed_hbk4", "percent_male_attend_hbk4", "percent_female_attend_hbk4", "percent_total_attend_hbk4")]
      write.csv(table_data_subset_hbk4, file, row.names = FALSE)
    }
  )
  
  
  
  
  
  
  ###############################################################################################END OF HANDBOOK 4 SCHOOL LEVEL CODE
  
  
  ##
  
  ##################################################################################################Handbook 5 school level code
  ##########################################################################code for handbook 5 plc attendance
  
  
  
  output$region_ui_hbk5 <- renderUI({
    selectInput("region_select_hbk5", 
                label = h4("Select a region to view the PLC attendance summary of schools in the selected region for Year 2 SSPLC"), 
                choices = unique(plc_data_hbk5$Region_hbk5), 
                selected = unique(plc_data_hbk5$Region_hbk5)[1])
  })
  
  
  table_trial_hbk5 <- reactive({
    data_hbk5 <- plc_data_hbk5 %>% 
      filter(plc_take_place_hbk5 == 1, Region_hbk5 == input$region_select_hbk5) %>%
      mutate(Name_school_hbk5 = factor(Name_school_hbk5, levels = c ("Bechem Presby Senior High",
                                                                     "Derma Comm. Day School",
                                                                     "Samuel Otu Presby Senior High.",
                                                                     "Boakye Tromo Senior High/Tech",
                                                                     "Bomaa Comm. Senior High",
                                                                     "Serwaa Kesse Girls Senior High",
                                                                     "Terchire Senior High",
                                                                     "Yamfo Anglican Senior High School",
                                                                     "Acherensua Senior High",
                                                                     "Hwidiem Senior High",
                                                                     "Gyamfi Kumanini Senior High/Tech",
                                                                     "OLA Girls Senior High, Kenyasi ",
                                                                     "Kukuom Agric Senior High",
                                                                     "Sankore Senior High",
                                                                     "Ahafoman Senior High/Tech",
                                                                     "Mim Senior High",
                                                                     "Adu Gyamfi Senior High",
                                                                     "Agona Senior High/Tech",
                                                                     "Boanim Senior High/ Tech Sch",
                                                                     "Konadu Yiadom Catholic Senior High",
                                                                     "Okomfo Anokye Senior High",
                                                                     "S.D.A. Senior High, Agona",
                                                                     "Bankoman Senior High",
                                                                     "Bodomase Senior High/Tech",
                                                                     "Dadease Agric Senior High",
                                                                     "Tweneboa Kodua Senior High",
                                                                     "Effiduase Senior High/Com",
                                                                     "Effiduase Senior High/Tech",
                                                                     "T. I. Ahmadiyya Girl's Senior High, Asokore",
                                                                     "Tijjaniya Senior High",
                                                                     "Ghana Muslim Mission Senior High",
                                                                     "Nsutaman Cath. Senior High",
                                                                     "Presby Senior High/Tech, Kwamang",
                                                                     "Akumadan Senior High",
                                                                     "Asuoso Comm. Senior High",
                                                                     "Nkenkansu Community Senior High",
                                                                     "Wiafe Akenten Presby Senior High",
                                                                     "Dwamena Akenten Senior High",
                                                                     "Namong Senior High/Tech",
                                                                     "St. Jerome Senior High, Abofour",
                                                                     "Christ the King Cath., Obuasi",
                                                                     "Obuasi Senior High/Tech",
                                                                     "Spiritan Senior High",
                                                                     "Amaniampong Senior High",
                                                                     "Kofiase Adventist Senior High/Tech.",
                                                                     "Opoku Agyeman Senior High/Tech",
                                                                     "St. Joseph Sem/Senior High, Mampong",
                                                                     "St. Monica's Senior High, Mampong",
                                                                     "Adanwomase Senior High",
                                                                     "Adventist Girls Senior High, Ntonso",
                                                                     "Antoa Senior High",
                                                                     "Gyaama Pensan Senior High/Tech",
                                                                     "Kofi Adjei Senior High/Tech",
                                                                     "Simms Senior High/Com.",
                                                                     "Islamic Senior High,Kumasi",
                                                                     "Adventist Senior High, Kumasi",
                                                                     "Agric Nzema Senior High, Kumasi",
                                                                     "Al-Azariya Islamic Snr. High, Kumasi",
                                                                     "Anglican Senior High, Kumasi",
                                                                     "Armed Forces Senior High/Tech, Kumasi",
                                                                     "Asanteman Senior High",
                                                                     "J. A. Kufuor Senior High",
                                                                     "KNUST Senior High",
                                                                     "Kumasi Girls Senior High,",
                                                                     "Kumasi High School",
                                                                     "Kumasi Senior High/Tech",
                                                                     "Kumasi Wesley Girls High Sch",
                                                                     "Mancell Senior High",
                                                                     "Nuru-Ameen Islamic Senior High, Asewase",
                                                                     "Opoku Ware School",
                                                                     "Osei Kyeretwie Senior High",
                                                                     "Pentecost Senior High, Kumasi",
                                                                     "Prempeh College",
                                                                     "Prince Of Peace Girls",
                                                                     "Serwaah Nyarko Girls' Snr. High",
                                                                     "St. Hubert Sem/Senior High, Kumasi",
                                                                     "St. Louis Senior High, Kumasi",
                                                                     "T. I. Ahmadiyya Senior High , Kumasi",
                                                                     "Uthmaniya Senior High, Tafo",
                                                                     "Yaa Asantewaa Girls Senior High .",
                                                                     "Juaben Senior High",
                                                                     "Akwesi Awobaa Senior High",
                                                                     "Ejuraman Anglican Senior High",
                                                                     "Sekyedumase Senior High/Tech",
                                                                     "Onwe senior High Senior",
                                                                     "Ejisu Senior High/Tech",
                                                                     "Achinakrom Senior High",
                                                                     "Bonwire Senior High/Tech",
                                                                     "Ejisuman Senior High",
                                                                     "Church Of Christ Senior High",
                                                                     "St. Sebastian Cath. Senior High",
                                                                     "Ghana STEM Academy, Deduako",
                                                                     "Ghana STEM Academy, Jachie",
                                                                     "Beposo Senior High",
                                                                     "Bosomtwe Oyoko Comm. Senior High",
                                                                     "Jachie Pramso Senior High",
                                                                     "Osei Adutwum Senior High",
                                                                     "St. George's Senior High Tech.",
                                                                     "Bosomtwe Senior High/Tech",
                                                                     "Bosome Senior High/Tech.",
                                                                     "Denyaseman Cath.Senior High",
                                                                     "Ofoase Kokoben Senior High",
                                                                     "Oppong Mem. Senior High",
                                                                     "S.D.A. Senior High, Bekwai",
                                                                     "St. Joseph Senior High/Tech, Ahwiren",
                                                                     "Wesley High School, Bekwai",
                                                                     "Barekese Senior High",
                                                                     "Nkawie Senior High/Tech",
                                                                     "Osei Tutu Senior High, Akropong",
                                                                     "Toase Senior High",
                                                                     "Adobewora Comm. Senior High",
                                                                     "Mpasatia Senior High/Tech",
                                                                     "Nyinahin Cath. Senior High",
                                                                     "Afua Kobi Ampem Girls' Senior High",
                                                                     "Anum Asamoah Senior High/Tech",
                                                                     "Atwima Kwanwoma Snr High/Tech",
                                                                     "Presbyterian Girls Senior High",
                                                                     "Ibadur Rahman Academy",
                                                                     "Kumasi Academy",
                                                                     "Parkoso Comm. Senior High",
                                                                     "Sakafia Islamic Senior High",
                                                                     "Tawheed Senior High.",
                                                                     "Banka Comm. Senior High",
                                                                     "Bompata Presby Senior High",
                                                                     "Juaso Senior High/Tech",
                                                                     "Jubilee Senior High",
                                                                     "Kurofa Methodist Senior High Tech",
                                                                     "Morso Senior High/Tech",
                                                                     "Ofoase Senior High/Tech",
                                                                     "Agogo State College",
                                                                     "Collins Senior High/Commercial, Agogo",
                                                                     "Owerriman Senior High Tech",
                                                                     "Konongo Odumase Senior High .",
                                                                     "St. Mary's Girl's Senior High, Konongo",
                                                                     "Wesley Senior High, Konongo .",
                                                                     "Esaase Bontefufuo Snr. High/Tech.",
                                                                     "Manso-Adubia Senior High",
                                                                     "Mansoman Senior High",
                                                                     "Jacobu Senior High/Tech.",
                                                                     "Tweapease Senior High School",
                                                                     "Adugyama Comm. Senior High",
                                                                     "Mankranso Senior High",
                                                                     "Sabronum Methodist Senior High/Tech",
                                                                     "Maabang Senior High/Tech",
                                                                     "Tepa Senior High",
                                                                     "Afigya Senior High/Tech",
                                                                     "Afigyaman Senior High School",
                                                                     "St. Michael's Senior High, Ahenkro",
                                                                     "Aduman Senior High",
                                                                     "Otumfuo Osei Tutu II College",
                                                                     "Akrofuom Senior High/Tech",
                                                                     "New Edubiase Senior High",
                                                                     "Asare Bediako Senior High .",
                                                                     "Bodwesango Senior High",
                                                                     "Dompoase Senior High",
                                                                     "Fomena T.I. Ahmad Senior High",
                                                                     "Ghana STEM Academy, Koase",
                                                                     "Istiquaama Snr. High",
                                                                     "Koase Senior High/Tech",
                                                                     "Nkyeraa Senior High Sch.",
                                                                     "Wenchi Meth. Senior High",
                                                                     "Badu Senior High/Tech.",
                                                                     "Menji Senior High",
                                                                     "Nkoranman Senior High",
                                                                     "Nsawkaw State Senior High",
                                                                     "Chiraa Senior High",
                                                                     "Notre Dame Girls Senior High, Sunyani",
                                                                     "Odomaseman Senior High",
                                                                     "Sacred Heart Senior High, Nsoatre",
                                                                     "S.D.A Senior High, Sunyani",
                                                                     "St. James Sem & Senior High, Abesim",
                                                                     "Sunyani Senior High",
                                                                     "Twene Amanfo Senior High/Tech.",
                                                                     "Drobo Senior High",
                                                                     "Our Lady of Providence Senior High",
                                                                     "Diamono Senior High Sch.",
                                                                     "Duadaso No. 1 Senior High/Tech.",
                                                                     "Goka Senior High/Tech.",
                                                                     "Nafana Senior High",
                                                                     "St. Ann's Girls Senior High, Sampa",
                                                                     "Sumaman Senior High",
                                                                     "Nkrankwanta Comm Senior High",
                                                                     "Mansen Senior High",
                                                                     "Wamanafo Senior High/Tech",
                                                                     "Dormaa Senior High",
                                                                     "Salvation Army Senior High, Aboabo Dormaa",
                                                                     "Berekum Presby Senior High",
                                                                     "Berekum Senior High",
                                                                     "Jinijini Senior High",
                                                                     "Methodist Senior High/Tech.,Biadan",
                                                                     "St. Augustine Senior High, Nsapor-Berekum",
                                                                     "Bandaman Senior High",
                                                                     "Ameyaw Akumfi Senior High/Tech.",
                                                                     "Guakro Effah Senior High",
                                                                     "Krobo Comm.Senior High",
                                                                     "St. Francis Seminary/Senior High, Buoyem",
                                                                     "Tuobodom Senior High/Tech",
                                                                     "Gyarko Comm. Day Senior High",
                                                                     "Kesse Basahyia Senior High",
                                                                     "Kwarteng Ankomah Senior High",
                                                                     "Our Lady of Mount Carmel Girls Senior High, Techiman",
                                                                     "Techiman Senior High",
                                                                     "Yeboah Asuamah Senior High",
                                                                     "Abrafi Senior High",
                                                                     "Kwame Danso Senior High/Tech",
                                                                     "Bassa Community Senior High",
                                                                     "Kajaji Senior High",
                                                                     "Abeaseman Comm. Day Senior High",
                                                                     "Prang Senior High",
                                                                     "Yeji Senior High/Tech",
                                                                     "Donkro- Nkwanta Senior High",
                                                                     "Kwabre Senior High",
                                                                     "Nkoranza Senior High/Tech",
                                                                     "Busunya Senior High",
                                                                     "Osei Bonsu Senior High",
                                                                     "Jema Senior High",
                                                                     "Kintampo Senior High",
                                                                     "New Longoro Comm.School (Dega)",
                                                                     "Amanten Senior High",
                                                                     "Atebubu Senior High",
                                                                     "New Krokompe Comm. Senior High",
                                                                     "Ayanfuri Senior High",
                                                                     "Diaso Senior High",
                                                                     "Boa-Amponsem Senior High",
                                                                     "Dunkwa Senior High/Tech",
                                                                     "Kyekyewere Comm. Senior High School",
                                                                     "Mokwaa Senior High Sch",
                                                                     "Jukwa Senior High",
                                                                     "Twifo Hemang Senior High/Tech",
                                                                     "Twifo Praso Senior High",
                                                                     "Abeadze State College",
                                                                     "Kwegyir Aggrey Senior High",
                                                                     "Mankessim Senior High/Tech",
                                                                     "Methodist High School,Saltpond",
                                                                     "Mfantsiman Girls Senior High",
                                                                     "Kobina Ansah SHS",
                                                                     "Edinaman Senior High",
                                                                     "Eguafo-Abrem Senior High",
                                                                     "Komenda Senior High/Tech.",
                                                                     "Apam Senior High",
                                                                     "College of Music Senior, Mozano",
                                                                     "Gomoa Senior High/Tech",
                                                                     "Mozano Senior High",
                                                                     "Fettehman Senior High",
                                                                     "Gomoa Gyaman Senior High",
                                                                     "Potsin T.I. Ahm. Senior High",
                                                                     "S.D.A SHS, Jukwa",
                                                                     "St. Gregory Catholic Senior High School",
                                                                     "Ogyeedom Comm.Snr High/Tech",
                                                                     "Akyin Senior High School",
                                                                     "Ekumfi T. I. Ahmadiiyya Snr. High",
                                                                     "J.E.A. Mills Senior High",
                                                                     "Winneba Senior High",
                                                                     "Academy of Christ the King, Cape Coast",
                                                                     "Adisadel College",
                                                                     "Effutu Senior High/Tech",
                                                                     "Ghana National College",
                                                                     "Holy Child School, Cape Coast",
                                                                     "Mfantsipim School",
                                                                     "Oguaa Senior High/Tech",
                                                                     "St. Augustine's College, Cape Coast",
                                                                     "University Practice Senior High",
                                                                     "Wesley Girls Senior High, Cape Coast",
                                                                     "Awutu Bawjiase Comm. Senior High",
                                                                     "Awutu Winton Senior High",
                                                                     "Obrachire Senior High/Tech",
                                                                     "Odupong Comm. Day School",
                                                                     "Senya Senior High",
                                                                     "Bontrase Senior High Tech. Sch",
                                                                     "Adankwaman Senior High",
                                                                     "Assin Manso Senior High",
                                                                     "Assin Nsuta Agric. Senior High",
                                                                     "Nyankumase Ahenkro Snr. High",
                                                                     "Assin North Senior High/Tech",
                                                                     "Assin State College",
                                                                     "Gyaase Community Senior High",
                                                                     "Obiri Yeboah Senior High/Technical",
                                                                     "Brakwa Senior High/Tech",
                                                                     "Breman Asikuma Senior High",
                                                                     "Odoben Senior High",
                                                                     "Bisease Senior High/Com",
                                                                     "Enyan Denkyira Senior High",
                                                                     "Enyan Maim Comm. Day School",
                                                                     "Mando Senior High/Tech.",
                                                                     "Agona Fankobaa Senior High",
                                                                     "Nyakrom Senior High Tech",
                                                                     "Siddiq Senior High Sch.",
                                                                     "Swedru Sch. Of Business",
                                                                     "Agona Namonwora Comm.Senior High",
                                                                     "Ampim Darko Senior High School",
                                                                     "Kwanyako Senior High ",
                                                                     "Nsaba Presby Senior High",
                                                                     "Swedru Senior High",
                                                                     "Abakrampa Senior High/Tech",
                                                                     "Aburaman Senior High",
                                                                     "Aggrey Mem. A.M.E.Zion Snr. High",
                                                                     "Moree Comm. Senior High",
                                                                     "Apesua Comm. Senior High",
                                                                     "Klo-Agogo Senior High",
                                                                     "Yilo Krobo Senior High/Com",
                                                                     "Asamankese Senior High",
                                                                     "St. Thomas Senior High/Tech",
                                                                     "Adeiso Presby Senior High",
                                                                     "Kwaobaah Nyanoa Comm. Senior High",
                                                                     "Asesewa Senior High School",
                                                                     "Islamic Girls Senior High,Suhum",
                                                                     "Presby Senior High, Suhum",
                                                                     "Suhum Senior High/Tech",
                                                                     "Nsawam Senior High",
                                                                     "St. Martin's Senior High, Nsawam",
                                                                     "Ghana Senior High, Koforidua ",
                                                                     "Koforidua Senior High/Tech",
                                                                     "New Juaben Senior High/Com",
                                                                     "Oti Boateng Senior High",
                                                                     "Oyoko Methodist Senior High",
                                                                     "Pope John Snr. High & Min. Sem., Koforidua",
                                                                     "S.D.A Senior High, Koforidua",
                                                                     "Pentecost Senior High,Koforidua",
                                                                     "Akro Senior High/Tech",
                                                                     "Akuse Methodist Senior High/Tech",
                                                                     "Krobo Girls Senior High",
                                                                     "Manya Krobo Senior High",
                                                                     "Fodoa Comm. Senior High",
                                                                     "Nkawkaw Senior High",
                                                                     "Bepong Senior High School",
                                                                     "Kwahu Ridge Senior High",
                                                                     "Mpraeso Senior High",
                                                                     "St. Paul's Senior High, Asakraka Kwahu",
                                                                     "St. Peter's Senior High, Nkwatia",
                                                                     "Abetifi Presby Senior High",
                                                                     "Kwahu Tafo Senior High",
                                                                     "Nkwatia Presby Senior High/Com",
                                                                     "St. Dominic's Senior High/Tech, Pepease",
                                                                     "Asuom Senior High",
                                                                     "Kade Senior High/Tech.",
                                                                     "New Nsutam Senior High/Tech",
                                                                     "Osino Presby Senior High/Tech.",
                                                                     "Presby Senior High, Begoro",
                                                                     "Abuakwa State College",
                                                                     "Akim Asafo Senior High",
                                                                     "Apedwa Presby Senior High",
                                                                     "Kibi Senior High/Tech",
                                                                     "Ofori Panin Senior High",
                                                                     "Saviour Senior High, Osiem",
                                                                     "St. Stephen's Presby Snr. High/Tech, Asiakwa",
                                                                     "W.B.M. Zion Senior High, Old Tafo",
                                                                     "St. Rose's Senior High, Akwatia",
                                                                     "Salvation Army Senior High, Akim Wenchi",
                                                                     "Tarkrowase Comm. Senior High",
                                                                     "Achiase Senior High",
                                                                     "Akim Swedru Senior High",
                                                                     "Aperade Senior High/Tech.",
                                                                     "Amuana Praso Senior High",
                                                                     "New Abirem/Afosu Senior High",
                                                                     "St. Michael's Senior High, Akoase (Nkawkaw)",
                                                                     "Akroso Senior High/Tech",
                                                                     "Attafuah Senior High/Tech",
                                                                     "Atweaman Senior High",
                                                                     "Oda Senior High",
                                                                     "St. Francis Senior High/Tech, Akim Oda",
                                                                     "Anum Apapam Comm. Day",
                                                                     "Kraboa-Coaltar Presby Snr. High/Tech.",
                                                                     "STEM Academy, Abomosu",
                                                                     "S.D.A. Senior High. Akim Sekyere",
                                                                     "Kwabeng Anglican Senior High/Tech",
                                                                     "Adjena Senior High/Tech.",
                                                                     "Akwamuman Senior High",
                                                                     "Anum Presby Senior High",
                                                                     "Apeguso Senior High",
                                                                     "Boso Senior High Technical",
                                                                     "Akokoaso Senior High/Tech",
                                                                     "Ayirebi Senior High",
                                                                     "Aburi Girls Senior High",
                                                                     "Adonten Senior High",
                                                                     "Diaspora Girls' Senior High",
                                                                     "Presby Senior High/Tech, Aburi",
                                                                     "Benkum Senior High",
                                                                     "H'Mount Sinai Senior High",
                                                                     "Mampong/Akw Snr. High/Tech for the Deaf",
                                                                     "Mangoase Senior High",
                                                                     "Methodist Girls Senior High, Mamfe",
                                                                     "Nifa Senior High",
                                                                     "Okuapeman Senior High",
                                                                     "Presby Senior High, Mampong Akwapim",
                                                                     "Presby Senior High/Tech, Adukrom",
                                                                     "Presby Senior High/Tech, Larteh",
                                                                     "Maame Krobo Comm. Senior High",
                                                                     "St. Fidelis Senior High/Tech",
                                                                     "Donkorkrom Agric Senior High",
                                                                     "Mem-Chemfre Comm. Senior High",
                                                                     "Lashibi Comm. Day",
                                                                     "Chemu Senior High/Tech",
                                                                     "Our Lady of Mercy Senior High",
                                                                     "Presby Senior High, Tema",
                                                                     "Tema Manhean Senior High/Tech",
                                                                     "Tema Meth. Day Senior High",
                                                                     "Tema Senior High ",
                                                                     "Ghanata Senior High",
                                                                     "Osudoku Senior High/Tech.",
                                                                     "Ningo Senior High",
                                                                     "Prampram Senior High",
                                                                     "O'Reilly Senior High",
                                                                     "Presby Senior High, Teshie",
                                                                     "West Africa Senior High",
                                                                     "Presby Boys Senior High, Legon",
                                                                     "Forces Senior High/Tech, Burma Camp",
                                                                     "La Presby Senior High",
                                                                     "Labone Senior High",
                                                                     "St. Thomas Aquinas Senior High, Cantoments",
                                                                     "Nungua Senior High",
                                                                     "Kpone Comm. Senior High",
                                                                     "Adjen Kotoku Senior High",
                                                                     "Akramaman Senior High",
                                                                     "Amasaman Senior High/Tech",
                                                                     "St. John's Grammar Senior High",
                                                                     "Christian Methodist Senior High",
                                                                     "Ngleshie Amanfro Senior High",
                                                                     "Kwabenya Comm. Senior High",
                                                                     "Odorgonno Senior High",
                                                                     "Ashiaman Senior High",
                                                                     "Frafraha Comm. Senior High",
                                                                     "Ada Senior High/Tech.",
                                                                     "Ada Senior High",
                                                                     "Accra Academy",
                                                                     "Accra Girls Senior High .",
                                                                     "Accra Senior High",
                                                                     "Accra Wesley Girls High",
                                                                     "Achimota Senior High",
                                                                     "Ebenezer Senior High",
                                                                     "Holy Trinity Senior High",
                                                                     "Kaneshie Senior High/Tech.",
                                                                     "Kinbu Senior High/Tech",
                                                                     "Presby Senior High, Osu",
                                                                     "St. Margaret Mary Snr.High/Tech",
                                                                     "St. Mary's Senior High, Korle Gonno ",
                                                                     "Wesley Grammar Senior High",
                                                                     "Yunyoo-Nasuan Comm. SHS",
                                                                     "Ghana STEM Academy, Kpasenpke",
                                                                     "Janga Senior High/Tech",
                                                                     "Walewale Senior High",
                                                                     "Wulugu Senior High",
                                                                     "Yagaba Senior High School",
                                                                     "Gambaga Girls Senior High",
                                                                     "Langbinsi Senior High/Tech",
                                                                     "Nalerigu Senior High",
                                                                     "Sakogu Senior High/Tech",
                                                                     "Chereponi Senior High/Tech.",
                                                                     "Bunkpurugu Senior High/Tech",
                                                                     "Nakpanduri Senior High",
                                                                     "Presby SHTS, Nankpanduri",
                                                                     "Zabzugu Senior High",
                                                                     "Dagbon State Senior High/Tech",
                                                                     "Yendi Senior High",
                                                                     "Kasuliyili Senior High",
                                                                     "Tolon Senior High",
                                                                     "E. P. Agric Senior High/Tech.",
                                                                     "Anbariya Senior High Sch.",
                                                                     "Business Senior High, Tamale",
                                                                     "Ghana Senior High, Tamale",
                                                                     "Presby Senior High, Tamale",
                                                                     "St. Charles Senior High, Tamale",
                                                                     "Tamale Girls Senior High",
                                                                     "Vitting Senior High/Tech.",
                                                                     "Pong-Tamale Senior High",
                                                                     "Savelugu Senior High",
                                                                     "Islamic Science Senior High, Tamale",
                                                                     "Kalpohin Senior High",
                                                                     "Northern School of Business",
                                                                     "Tamale Senior High .",
                                                                     "Saboba E.P. Senior High",
                                                                     "Wapuli Comm. Senior High",
                                                                     "Wulensi Senior High",
                                                                     "Bimbilla Senior High",
                                                                     "Sang Comm. Day School",
                                                                     "Kumbungu Senior High",
                                                                     "Kpandai Senior High",
                                                                     "Karaga Senior High",
                                                                     "Gushegu Senior High",
                                                                     "Kyabobo Girls' School",
                                                                     "Nkwanta Comm.Senior High",
                                                                     "Nkwanta Senior High",
                                                                     "Ntruboman Senior High",
                                                                     "Kpassa Senior High/Tech",
                                                                     "Kete Krachi Senior High/Tech.",
                                                                     "Krachi Senior High",
                                                                     "Nchumuruman Comm. Day Senior High",
                                                                     "Asukawkaw Senior High",
                                                                     "Oti Senior High/Tech Sch",
                                                                     "Yabram Comm. Day School",
                                                                     "Ahamansu Islamic Senior High School",
                                                                     "Dodi-Papase Senior High/Tech",
                                                                     "Kadjebi-Asato Senior High",
                                                                     "Baglo Ridge Senior High/Tech.",
                                                                     "Bueman Senior High .",
                                                                     "Okadjakrom Senior High/Tech.",
                                                                     "Biakoye Comm. School",
                                                                     "Bowiri Comm. Day School",
                                                                     "Nkonya Senior High",
                                                                     "Tapaman Senior High/Tech",
                                                                     "Worawora Senior High",
                                                                     "Damongo Senior High",
                                                                     "Ndewura Jakpa Senior High/Tech.",
                                                                     "Sawla Senior High Sch.",
                                                                     "Tuna Senior High/Tech.",
                                                                     "Daboya Comm. Day School",
                                                                     "Salaga Senior High",
                                                                     "Salaga T.I. Ahmad Senior High",
                                                                     "Buipe Senior High",
                                                                     "Mpaha Comm. Senior High",
                                                                     "Bamboi Comm. Senior High",
                                                                     "Bole Senior High",
                                                                     "St. Anthony of Padua Senior High/Tech",
                                                                     "Bolgatanga Senior High ",
                                                                     "Tongo Senior High/Tech",
                                                                     "Pusiga Comm. Day Senior High Sch.",
                                                                     "Kongo Senior High",
                                                                     "Chiana Senior High",
                                                                     "Mirigu Community Day Senior High",
                                                                     "Nabango Senior High Tech",
                                                                     "Paga Senior High",
                                                                     "Sirigu Senior High",
                                                                     "Awe Senior High/Tech.",
                                                                     "Navrongo Senior High ",
                                                                     "Notre Dame Sem/ Senior High, Navrongo",
                                                                     "St. John's Integrated Snr. High/Tech",
                                                                     "O.L.L. Girls Senior High",
                                                                     "Tempane Senior High",
                                                                     "Garu Comm. Day Senior High",
                                                                     "Fumbisi Senior High",
                                                                     "Kanjaga Comm. Senior High",
                                                                     "Naab Azantilow Senior High/Tech.",
                                                                     "Sandema Senior High",
                                                                     "Wiaga Comm. Senior High",
                                                                     "Azeem-Namoa Senior High/Tech",
                                                                     "Bongo Senior High",
                                                                     "Gowrie Senior High/Tech.",
                                                                     "Zorkor Senior High",
                                                                     "Bolga Girls Senior High ",
                                                                     "Bolga Sherigu Comm. Senior High",
                                                                     "Zamse Senior High/Tech",
                                                                     "Zuarungu Senior High",
                                                                     "Gambigo Comm. Day Senior High",
                                                                     "Binduri Comm. Senior High",
                                                                     "Kusanaba Senior High",
                                                                     "Zebilla Senior High/Tech",
                                                                     "Bawku Senior High",
                                                                     "Bawku Senior High/Tech.",
                                                                     "Lassie-Tuolu Senior High",
                                                                     "Islamic Senior High, Wa",
                                                                     "Jamiat Al-Hidaya Islamic Girls",
                                                                     "Northern Star Senior High",
                                                                     "T. I. Ahmadiyya Senior High, Wa",
                                                                     "Wa Senior High .",
                                                                     "Wa Senior High/Tech.",
                                                                     "Funsi Senior High School",
                                                                     "Loggu Comm. Day School",
                                                                     "Dr. Hila Liman Senior High School",
                                                                     "Kanton Senior High",
                                                                     "Tumu Senior High/Tech.",
                                                                     "Ko Senior High",
                                                                     "Nandom Senior High",
                                                                     "Sombo Senior High",
                                                                     "Kaleo Senior High/Tech",
                                                                     "Queen of Peace Senior High, Nadowli",
                                                                     "St. Augustine Senior High/Tech, Saan Charikpong",
                                                                     "Takpo Senior High Sch.",
                                                                     "Birifoh Senior High Sch.",
                                                                     "Eremon Senior High/Tech.",
                                                                     "Lawra Senior High ",
                                                                     "Lambussie Comm. Senior High",
                                                                     "Piina Senior High",
                                                                     "Holy Family Senior High",
                                                                     "Han Senior High",
                                                                     "Jirapa Senior High",
                                                                     "St. Francis Girls Senior High, Jirapa ",
                                                                     "Ullo Senior High",
                                                                     "Daffiamah Senior High",
                                                                     "Dabala Senior High/Tech.",
                                                                     "Sogakope Senior High",
                                                                     "St. Catherine Girls Senior High",
                                                                     "Kpeve Senior High Tech",
                                                                     "Peki Senior High",
                                                                     "Peki Senior High/Technical",
                                                                     "Tongor Senior High Tech.",
                                                                     "Aveyime Battor Senior High/Tech.",
                                                                     "Battor Senior High",
                                                                     "Dofor Senior High",
                                                                     "Mepe St. Kizito Senior High/Tech.",
                                                                     "Volo Comm. Senior High",
                                                                     "Anfoega Senior High",
                                                                     "Vakpo Senior High",
                                                                     "Vakpo Senior High/Tech",
                                                                     "Bishop Herman College",
                                                                     "Kpando Senior High .",
                                                                     "Aflao Community SHS",
                                                                     "Klikor Senior High/Tech.",
                                                                     "Some Senior High",
                                                                     "St. Paul's Senior High, Denu",
                                                                     "Three Town Senior High",
                                                                     "Afife Senior High Tech.",
                                                                     "Dzodze Penyi Senior High",
                                                                     "Weta Senior High/Tech.",
                                                                     "Wovenu Senior High Technical",
                                                                     "Keta Senior High/Tech .",
                                                                     "Afadjato Senior High/Tech.",
                                                                     "Akpafu Senior High/Tech.",
                                                                     "Alavanyo Senior High/Tech.",
                                                                     "E. P. Senior High",
                                                                     "Likpe Senior High",
                                                                     "St. Mary's Sem.& Senior High, Lolobi",
                                                                     "Abutia Senior High/Tchnical",
                                                                     "Akome Senior High/Tech.",
                                                                     "Avatime Senior High",
                                                                     "Dzolo Senior High",
                                                                     "Kpedze Senior High",
                                                                     "Tsito Senior High/Tech",
                                                                     "Awudome Senior High .",
                                                                     "E.P.C. Mawuko Girls Senior High",
                                                                     "Mawuli School, Ho",
                                                                     "OLA Girls Senior High, Ho",
                                                                     "Shia Senior HighTechnical",
                                                                     "Sokode Senior High/Tech",
                                                                     "Tanyigbe Senior High",
                                                                     "Taviefe Senior High",
                                                                     "Ziavi Senior High/Tech",
                                                                     "Adidome Senior High",
                                                                     "Mafi-Kumasi Senior High/Tech",
                                                                     "Abor Senior High",
                                                                     "Anlo Afiadenyigba Senior High",
                                                                     "Anlo Awomefia Senior High",
                                                                     "Anlo Senior High",
                                                                     "Atiavi Senior High/Tech",
                                                                     "Keta Business Senior High",
                                                                     "Tsiame Senior High",
                                                                     "Volta Senior High School",
                                                                     "Zion Senior High",
                                                                     "Avenor Senior High",
                                                                     "Ave Senior High",
                                                                     "Akatsi Senior High/Tech",
                                                                     "Agotime Senior High",
                                                                     "Ziope Senior High Sch.",
                                                                     "Agate Comm. Senior High",
                                                                     "Jim Bourton Mem Agric. Senior High",
                                                                     "Leklebi Senior High",
                                                                     "Ve Comm. Senior High",
                                                                     "Adaklu Senior High",
                                                                     "Gbekor Senior High",
                                                                     "Asankrangwa Senior High",
                                                                     "Asankrangwa Senior High/Tech",
                                                                     "Amenfiman Senior High",
                                                                     "Benso Senior High/Tech",
                                                                     "Fiaseman Senior High",
                                                                     "Tarkwa Senior High",
                                                                     "Ahantaman Girls' Senior High",
                                                                     "Shama Senior High",
                                                                     "Adiembra Senior High",
                                                                     "Archbishop Porter Girls Snr.High .",
                                                                     "Bompeh Senior High./Tech",
                                                                     "Diabene Senior High/Tech",
                                                                     "Fijai Senior High",
                                                                     "Ghana Senior High/Tech",
                                                                     "Methodist Senior High, Sekondi",
                                                                     "Sekondi College ",
                                                                     "St. John's Senior High, Sekondi",
                                                                     "Huni Valley Senior High",
                                                                     "Prestea Senior High/Tech",
                                                                     "St. Augustine's Senior High, Bogoso",
                                                                     "Axim Girls Senior High",
                                                                     "Gwiraman Comm.Senior High",
                                                                     "Kwame Nkrumah SHS",
                                                                     "Daboase Senior High/Tech",
                                                                     "Mpohor Senior High",
                                                                     "Annor Adjaye Senior High",
                                                                     "Half Assini Senior High",
                                                                     "Bonzo-Kaku Senior High",
                                                                     "Esiama Senior High/Tech",
                                                                     "Nkroful Agric. Senior High",
                                                                     "Uthman Bin Afam SHS",
                                                                     "Takoradi Senior High",
                                                                     "Baidoo Bonso Senior High/Tech",
                                                                     "Sankor Senior High School",
                                                                     "St. Mary's Boys' Senior High, Apowa",
                                                                     "Manso-Amenfi Comm. Day School",
                                                                     "Dadieso Senior High",
                                                                     "Asawinso Senior High",
                                                                     "Sefwi-Wiawso Senior High",
                                                                     "Sefwi-Wiawso Senior High/Tech",
                                                                     "St. Joseph Senior High, Sefwi Wiawso",
                                                                     "Akontombra Senior High",
                                                                     "Nsawora Edumafa Comm. Senior High School",
                                                                     "Juaboso Senior High",
                                                                     "Bodi Senior High",
                                                                     "Bibiani Senior High/Tech.",
                                                                     "Chirano Comm. Day School",
                                                                     "Ghana STEM Academy, Awaso",
                                                                     "Queens Girls' Senior High, Sefwi Awhiaso",
                                                                     "Sefwi Bekwai Senior High",
                                                                     "Adjoafua Comm. Senior High",
                                                                     "Bia Senior High/Tech",
                                                                     "Adabokrom Comm. SHS",
                                                                     "Nana Brentu Senior High/Tech",
                                                                     "Nuriya Islamic SHS",
                                                                     "Presbyterian Boys Model SHS",
                                                                     "Wioso SHS",
                                                                     "Holy Child SHS",
                                                                     "Twereku Ampem SHS",
                                                                     "Kyem Amponsah SHS",
                                                                     "Gomoa Jukwa SDA SHS",
                                                                     "Santa Esther Girls SHS",
                                                                     "Apagya SHS",
                                                                     "Gbintiri SHTS",
                                                                     "Yizesi SHS",
                                                                     "Nasuan SHS",
                                                                     "Bimbagu SHTS",
                                                                     "Danso Adjei SHTS",
                                                                     "Larbanga SHS",
                                                                     "Pishigu SHS",
                                                                     "Nanton SHS",
                                                                     "Nsuaem SHS",
                                                                     "Takoradi Islamic SHS",
                                                                     "Bepoase State College",
                                                                     "Sekyere Kusi SHS",
                                                                     "Bortiannor SHS",
                                                                     "Hialaaya Islamic SHS"
                                                                     
                                                                     
                                                                     
      ))) %>%
      
      
      
      group_by(Name_school_hbk5) %>%
      summarise(
        count_hbk5 = sum(plc_take_place_hbk5 == 1),
        sessions_3 = list(nts_hbk5_Session_hbk5),
        
        male_mean_hbk5 = round(mean(nts_hbk5_male_attendance_hbk5, na.rm = TRUE),0),
        female_mean_hbk5 = round(mean(nts_hbk5_female_attendance_hbk5, na.rm = TRUE),0),
        overall_mean_hbk5 = round(mean(nts_hbk5_total_attendance_hbk5, na.rm = TRUE),0),
        male_pop_mean_hbk5 = round(mean(nts_hbk5_no_male_teachers_hbk5, na.rm = TRUE),0),
        female_pop_mean_hbk5 = round(mean(nts_hbk5_no_female_teachers_hbk5, na.rm = TRUE),0),
        overall_pop_mean_hbk5 = round(mean(nts_hbk5_total_teachers_schoo_hbk5, na.rm = TRUE),0),
        percent_male_attend_hbk5 = scales::percent(male_mean_hbk5/male_pop_mean_hbk5),
        percent_female_attend_hbk5 = scales::percent(female_mean_hbk5/female_pop_mean_hbk5),
        percent_total_attend_hbk5 = scales::percent(overall_mean_hbk5/overall_pop_mean_hbk5)
      )%>%
      rowwise() %>%
      mutate(
        
        
        
        
        
        ############
        units_completed_hbk5 = {
          # Extract all numeric values from the session descriptions (including decimals)
          session_nums_3 <- unlist(str_extract_all(unlist(sessions_3), "^Session \\d+(\\.\\d+)?"))
          
          # Strip "Session " but keep as character first
          session_chars <- gsub("Session ", "", session_nums_3)
          
          # For sorting, convert to numeric temporarily
          session_nums_sorted <- sort(as.numeric(session_chars))
          
          # Map back to character but remove trailing .0 if present
          session_nums_3 <- gsub("\\.0$", "", as.character(session_nums_sorted))
          
          # Remove duplicates
          session_nums_3 <- unique(session_nums_3)
          print(session_nums_3)
          
          # Check against valid sessions (coerce valid sessions also to character)
          valid_sessions <- unique(plc_data_hbk5$nts_hbk5_Session_hbk5)
          print(valid_sessions)   
          print(session_nums_3)   
          
          # Filtering (compare as character so "0.5" stays intact)
          session_nums <- session_nums_3[session_nums_3 %in% as.character(valid_sessions)]
          print(session_nums) 
          
          # Create the string with PLC Session prefix
          session_str_3 <- if (length(session_nums_3) > 0) {
            paste("PLC Session(s):", paste(session_nums_3, collapse = ", "))
          } else {
            "PLC Session(s): None"
          }
          
          session_str_3
        }
        
      )
    return(data_hbk5)
  })
  
  
  output$table_plot_hbk5 <- renderRHandsontable({
    table_data_hbk5 <- table_trial_hbk5()
    
    if (is.null(table_data_hbk5)) {
      return(NULL) # Return NULL if table_data is NULL (i.e., an error occurred)
    }
    
    table_data_hbk5$Name_school_hbk5 <- as.character(table_data_hbk5$Name_school_hbk5) # Convert factor to character
    
    table_data_subset_hbk5 <- table_data_hbk5[, c("Name_school_hbk5", "count_hbk5", "units_completed_hbk5", "percent_male_attend_hbk5", "percent_female_attend_hbk5", "percent_total_attend_hbk5")]
    
    rhandsontable(table_data_subset_hbk5,
                  colHeaders = c("School name", "Number of meetings Held","Details of Sessions Completed and Submitted", "Male teacher attendance (percent)", "Female teacher attendance (percent)", "Overall attendance (percent)"),
                  rowHeaders = NULL,
                  search = TRUE,
                  readOnly = TRUE) %>%
      hot_context_menu(
        customOpts = list(
          csv = list(
            name = "Download to CSV",
            callback = JS(
              "function (key, options) {
             var csv = csvString(this, sep = ',', dec = '.');

             var link = document.createElement('a');
             link.setAttribute('href', 'data:text/plain;charset=utf-8,' +
               encodeURIComponent(csv));
             link.setAttribute('download', 'table_data.csv');

             document.body.appendChild(link);
             link.click();
             document.body.removeChild(link);
           }")
          )
        )
      ) %>%
      hot_cols(
        colWidths = c(280, rep(180, 5))  # Adjust column widths as needed
      ) %>%
      onRender(
        JS(
          "function(el, x) {
           var hot = this.hot;  // Reference to the Handsontable instance
           hot.addHook('beforeChange', function(changes, source) {
             if (source === 'alter' && (changes[0][0] === 'insert_row' || changes[0][0] === 'remove_row')) {
               return false;  // Prevent row insertion and deletion
             }
           });
         }"
        )
      )
  })
  
  
  
  output$export_button_hbk5 <- downloadHandler(
    filename = function() {
      paste("data_hbk5", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      table_data_hbk5 <- table_trial_hbk5()  # Get the reactive data
      table_data_subset_hbk5 <- table_data_hbk5[, c("Name_school_hbk5", "count_hbk5", "units_completed_hbk5", "percent_male_attend_hbk5", "percent_female_attend_hbk5", "percent_total_attend_hbk5")]
      write.csv(table_data_subset_hbk5, file, row.names = FALSE)
    }
  )
  
  
  
  
  
  
  ###############################################################################################END OF HANDBOOK 5 SCHOOL LEVEL CODE
  
  
  
  ###########################################################################school level for curriculum trial schools
  
  # Generating dropdown for region selection
  
  
  table_trial_school <- reactive({
    # Start with the base data
    plc_base_data <- plc_trial_school
    
    # Apply academic year filter if not "All"
    if(input$academic_year_filter_school != "All") {
      plc_base_data <- plc_base_data %>%
        filter(Academic_Year_Trial == input$academic_year_filter_school)
    }
    
    # Continue with the existing filtering and processing
    data_school <- plc_base_data %>% 
      filter(plc_take_place_curri_trial == 1) %>%
      mutate(school_curri_trial = factor(school_curri_trial)) %>%
      
      group_by(school_curri_trial) %>%
      summarise(
        count_trial = sum(plc_take_place_curri_trial == 1),
        sessions_trial = list(nts_curri_trial.Session_curri_trial),
        
        male_mean_trial = round(mean(nts_curri_trial.male_attendance_curri_trial, na.rm = TRUE), 3),
        female_mean_trial = round(mean(nts_curri_trial.female_attendance_curri_trial, na.rm = TRUE), 3),
        overall_mean_trial = round(mean(nts_curri_trial.total_attendance_curri_trial, na.rm = TRUE), 3),
        male_pop_mean_trial = round(mean(nts_curri_trial.no_male_teachers_curri_trial, na.rm = TRUE), 3),
        female_pop_mean_trial = round(mean(nts_curri_trial.no_female_teachers_curri_trial, na.rm = TRUE), 3),
        overall_pop_mean_trial = round(mean(nts_curri_trial.total_teachers_schoo_curri_trial, na.rm = TRUE), 3),
        percent_male_attend_trial = scales::percent(male_mean_trial/male_pop_mean_trial),
        percent_female_attend_trial = scales::percent(female_mean_trial/female_pop_mean_trial),
        percent_total_attend_trial = scales::percent(overall_mean_trial/overall_pop_mean_trial)
      ) %>%
      rowwise() %>%
      mutate(
        units_completed_trial = {
          # Extract all numeric values from the session descriptions
          session_nums_trial <- unlist(str_extract_all(unlist(sessions_trial), "\\d+"))
          # Remove duplicate session numbers, convert to numeric, and sort
          session_nums_trial <- unique(as.numeric(session_nums_trial))
          session_nums_trial <- sort(session_nums_trial)
          # Create the string with PLC Session prefix
          session_str_trial <- if (length(session_nums_trial) > 0) {
            paste("PLC Session(s):", paste(session_nums_trial, collapse = ", "))
          } else {
            "PLC Session(s): None"
          }
          session_str_trial
        }
      )
    
    return(data_school)
  })
  
  output$table_plot_school_level <- renderRHandsontable({
    table_data_school <- table_trial_school()
    
    if (is.null(table_data_school)) {
      return(NULL)  # Return NULL if the data is NULL
    }
    
    table_data_school$school_curri_trial <- as.character(table_data_school$school_curri_trial)  # Convert factor to character
    
    table_data_subset_school <- table_data_school[, c("school_curri_trial", "count_trial", "units_completed_trial", "percent_male_attend_trial", "percent_female_attend_trial", "percent_total_attend_trial")]
    
    rhandsontable(table_data_subset_school,
                  colHeaders = c("School Name", "Number of PLC Meetings Held", "Details of Sessions Completed and Submitted", "Male Teacher Attendance (%)", "Female Teacher Attendance (%)", "Overall Attendance (%)"),
                  rowHeaders = NULL,
                  search = TRUE,
                  readOnly = TRUE) %>%
      hot_context_menu(
        customOpts = list(
          csv = list(
            name = "Download to CSV",
            callback = JS(
              "function (key, options) {
                var csv = csvString(this, sep = ',', dec = '.');
                var link = document.createElement('a');
                link.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(csv));
                link.setAttribute('download', 'school_level_data.csv');
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
              }"
            )
          )
        )
      ) %>%
      hot_cols(
        colWidths = c(280, rep(180, 5))  # Adjust column widths as needed
      ) %>%
      onRender(
        JS(
          "function(el, x) {
            var hot = this.hot;
            hot.addHook('beforeChange', function(changes, source) {
              if (source === 'alter' && (changes[0][0] === 'insert_row' || changes[0][0] === 'remove_row')) {
                return false;  // Prevent row insertion and deletion
              }
            });
          }"
        )
      )
  })
  
  output$export_button_school_level <- downloadHandler(
    filename = function() {
      paste("school_level_data", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      # Get the reactive data from table_trial_school
      table_data_school <- table_trial_school()
      # Subset the data with the relevant columns
      table_data_subset_school <- table_data_school[, c("school_curri_trial", "count_trial", "units_completed_trial", "percent_male_attend_trial", "percent_female_attend_trial", "percent_total_attend_trial")]
      # Write the data to a CSV file
      write.csv(table_data_subset_school, file, row.names = FALSE)
    }
  )
  
  #########################################################################code for handbook 1 leadership attendance to PLC session
  
  leadership_table <- reactive({
    data <- plc_data_new %>%
      filter(plc_take_place == 1, Region == input$region_select) %>%
      group_by(Name_school) %>%
      summarise(
        count = sum(plc_take_place == 1),
        head_attendance = ifelse(all(is.na(nts.headteacher_attendance_2)), NA, sum(nts.headteacher_attendance_2, na.rm = TRUE)),
        assistant_attendance_academic = ifelse(all(is.na(nts.assitant_academic_2)), NA, sum(nts.assitant_academic_2, na.rm = TRUE)),
        assistant_attendance_admin = ifelse(all(is.na(nts.assistant_admin_2)), NA, sum(nts.assistant_admin_2, na.rm = TRUE)),
        assistant_attendance_domestic = ifelse(all(is.na(nts.assistant_domestic_2)), NA, sum(nts.assistant_domestic_2, na.rm = TRUE))
      )
    
    if(nrow(data) == 0) return(NULL)
    return(data)
  })
  
  output$table_plot1 <- renderRHandsontable({
    data <- leadership_table()
    
    if(is.null(data)) {
      return(NULL) # Return NULL if data is empty
    }
    
    colnames(data) <- c("School Name", "Number of Meetings Held", 
                        "Number of times headteacher attended PLC session", 
                        "Number of times assistant head academic attended PLC session", 
                        "Number of times assistant admin attended PLC session", 
                        "Number of times assistant domestic attended PLC session")
    
    # Convert columns to character type
    data <- data %>% mutate(across(everything(), as.character))
    
    # Replace NA with "NA"
    data[is.na(data)] <- "NA"
    
    # Create a handsontable
    rhandsontable(data) %>%
      hot_col(col = "School Name", readOnly = TRUE)  # Setting the first column to readOnly as an example
  })
  
  
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      data <- leadership_table()
      write.csv(data, file, row.names = FALSE)
    },
    contentType = "text/csv"
  )
  
  
  ##########################################################leadership attendance to PLC session for handbook 2
  
  leadership_table_hbk2 <- reactive({
    data_hbk2 <- plc_data_hbk2 %>%
      filter(plc_take_place_hbk2 == 1, Region_hbk2 == input$region_select_hbk2) %>%
      group_by(Name_school_hbk2) %>%
      summarise(
        count_hbk2 = sum(plc_take_place_hbk2 == 1),
        head_attendance_hbk2 = ifelse(all(is.na(nts_hbk2.headteacher_attendance_2_hbk2)), NA, sum(nts_hbk2.headteacher_attendance_2_hbk2, na.rm = TRUE)),
        assistant_attendance_academic_hbk2 = ifelse(all(is.na(nts_hbk2.assitant_academic_2_hbk2)), NA, sum(nts_hbk2.assitant_academic_2_hbk2, na.rm = TRUE)),
        assistant_attendance_admin_hbk2 = ifelse(all(is.na(nts_hbk2.assistant_admin_2_hbk2)), NA, sum(nts_hbk2.assistant_admin_2_hbk2, na.rm = TRUE)),
        assistant_attendance_domestic_hbk2 = ifelse(all(is.na(nts_hbk2.assistant_domestic_2_hbk2)), NA, sum(nts_hbk2.assistant_domestic_2_hbk2, na.rm = TRUE))
      )
    
    if(nrow(data_hbk2) == 0) return(NULL)
    return(data_hbk2)
  })
  
  output$table_plot1_hbk2 <- renderRHandsontable({
    data_hbk2 <- leadership_table_hbk2()
    
    if(is.null(data_hbk2)) {
      return(NULL) # Return NULL if data is empty
    }
    
    colnames(data_hbk2) <- c("School Name", "Number of Meetings Held", 
                             "Number of times headteacher attended PLC session", 
                             "Number of times assistant head academic attended PLC session", 
                             "Number of times assistant admin attended PLC session", 
                             "Number of times assistant domestic attended PLC session")
    
    # Convert columns to character type
    data_hbk2 <- data_hbk2 %>% mutate(across(everything(), as.character))
    
    # Replace NA with "NA"
    data_hbk2[is.na(data_hbk2)] <- "NA"
    
    # Create a handsontable
    rhandsontable(data_hbk2) %>%
      hot_col(col = "School Name", readOnly = TRUE)  # Setting the first column to readOnly as an example
  })
  
  
  
  ##########################################################################################################leadership attendance for handbook 3
  leadership_table_hbk3 <- reactive({
    data_hbk3 <- plc_data_hbk3 %>%
      filter(plc_take_place_hbk3 == 1, Region_hbk3 == input$region_select_hbk3) %>%
      group_by(Name_school_hbk3) %>%
      summarise(
        count_hbk3 = sum(plc_take_place_hbk3 == 1),
        head_attendance_hbk3 = ifelse(all(is.na(nts_hbk3.headteacher_attendance_2_hbk3)), NA, sum(nts_hbk3.headteacher_attendance_2_hbk3, na.rm = TRUE)),
        assistant_attendance_academic_hbk3 = ifelse(all(is.na(nts_hbk3.assitant_academic_2_hbk3)), NA, sum(nts_hbk3.assitant_academic_2_hbk3, na.rm = TRUE)),
        assistant_attendance_admin_hbk3 = ifelse(all(is.na(nts_hbk3.assistant_admin_2_hbk3)), NA, sum(nts_hbk3.assistant_admin_2_hbk3, na.rm = TRUE)),
        assistant_attendance_domestic_hbk3 = ifelse(all(is.na(nts_hbk3.assistant_domestic_2_hbk3)), NA, sum(nts_hbk3.assistant_domestic_2_hbk3, na.rm = TRUE))
      )
    
    if(nrow(data_hbk3) == 0) return(NULL)
    return(data_hbk3)
  })
  
  output$table_plot1_hbk3 <- renderRHandsontable({
    data_hbk3 <- leadership_table_hbk3()
    
    if(is.null(data_hbk3)) {
      return(NULL) # Return NULL if data is empty
    }
    
    colnames(data_hbk3) <- c("School Name", "Number of Meetings Held", 
                             "Number of times headteacher attended PLC session", 
                             "Number of times assistant head academic attended PLC session", 
                             "Number of times assistant admin attended PLC session", 
                             "Number of times assistant domestic attended PLC session")
    
    # Convert columns to character type
    data_hbk3 <- data_hbk3 %>% mutate(across(everything(), as.character))
    
    # Replace NA with "NA"
    data_hbk3[is.na(data_hbk3)] <- "NA"
    
    # Create a handsontable
    rhandsontable(data_hbk3) %>%
      hot_col(col = "School Name", readOnly = TRUE)  # Setting the first column to readOnly as an example
  })
  
  
  
  output$export_button_hbk3_led <- downloadHandler(
    filename = function() {
      paste("data_hbk3", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      table_data_hbk3_led <- leadership_table_hbk3()  # Get the reactive data
      table_data_subset_hbk3_led <- table_data_hbk3_led[, c("Name_school_hbk3", "count_hbk3", "head_attendance_hbk3", "assistant_attendance_academic_hbk3", "assistant_attendance_admin_hbk3", "assistant_attendance_domestic_hbk3")]
      write.csv(table_data_subset_hbk3_led, file, row.names = FALSE)
    }
  )
  ########################################################end of code for leadership attendance to handbook 3
  
  ##
  ###################################################################################
  
  ##########################################################################################################leadership attendance for handbook 4
  leadership_table_hbk4 <- reactive({
    data_hbk4 <- plc_data_hbk4 %>%
      filter(plc_take_place_hbk4 == 1, Region_hbk4 == input$region_select_hbk4) %>%
      group_by(Name_school_hbk4) %>%
      summarise(
        count_hbk4 = sum(plc_take_place_hbk4 == 1),
        head_attendance_hbk4 = ifelse(all(is.na(nts_hbk4_headteacher_attendance_2_hbk4)), NA, sum(nts_hbk4_headteacher_attendance_2_hbk4, na.rm = TRUE)),
        assistant_attendance_academic_hbk4 = ifelse(all(is.na(nts_hbk4_assitant_academic_2_hbk4)), NA, sum(nts_hbk4_assitant_academic_2_hbk4, na.rm = TRUE)),
        assistant_attendance_admin_hbk4 = ifelse(all(is.na(nts_hbk4_assistant_admin_2_hbk4)), NA, sum(nts_hbk4_assistant_admin_2_hbk4, na.rm = TRUE)),
        assistant_attendance_domestic_hbk4 = ifelse(all(is.na(nts_hbk4_assistant_domestic_2_hbk4)), NA, sum(nts_hbk4_assistant_domestic_2_hbk4, na.rm = TRUE))
      )
    
    if(nrow(data_hbk4) == 0) return(NULL)
    return(data_hbk4)
  })
  
  output$table_plot1_hbk4 <- renderRHandsontable({
    data_hbk4 <- leadership_table_hbk4()
    
    if(is.null(data_hbk4)) {
      return(NULL) # Return NULL if data is empty
    }
    
    colnames(data_hbk4) <- c("School Name", "Number of Meetings Held", 
                             "Number of times headteacher attended PLC session", 
                             "Number of times assistant head academic attended PLC session", 
                             "Number of times assistant admin attended PLC session", 
                             "Number of times assistant domestic attended PLC session")
    
    # Convert columns to character type
    data_hbk4 <- data_hbk4 %>% mutate(across(everything(), as.character))
    
    # Replace NA with "NA"
    data_hbk4[is.na(data_hbk4)] <- "NA"
    
    # Create a handsontable
    rhandsontable(data_hbk4) %>%
      hot_col(col = "School Name", readOnly = TRUE)  # Setting the first column to readOnly as an example
  })
  
  
  
  output$export_button_hbk4_led <- downloadHandler(
    filename = function() {
      paste("data_hbk4", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      table_data_hbk4_led <- leadership_table_hbk4()  # Get the reactive data
      table_data_subset_hbk4_led <- table_data_hbk4_led[, c("Name_school_hbk4", "count_hbk4", "head_attendance_hbk4", "assistant_attendance_academic_hbk4", "assistant_attendance_admin_hbk4", "assistant_attendance_domestic_hbk4")]
      write.csv(table_data_subset_hbk4_led, file, row.names = FALSE)
    }
  ) 
  
  ########################################################end of code for leadership attendance to handbook 4
  
  
  #####################################leadership year 2 SSPLC
  
  ##########################################################################################################leadership attendance for handbook 4
  leadership_table_hbk5 <- reactive({
    data_hbk5 <- plc_data_hbk5 %>%
      filter(plc_take_place_hbk5 == 1, Region_hbk5 == input$region_select_hbk5) %>%
      group_by(Name_school_hbk5) %>%
      summarise(
        count_hbk5 = sum(plc_take_place_hbk5 == 1),
        head_attendance_hbk5 = ifelse(all(is.na(nts_hbk5_headteacher_attendance_2_hbk5)), NA, sum(nts_hbk5_headteacher_attendance_2_hbk5, na.rm = TRUE)),
        assistant_attendance_academic_hbk5 = ifelse(all(is.na(nts_hbk5_assitant_academic_2_hbk5)), NA, sum(nts_hbk5_assitant_academic_2_hbk5, na.rm = TRUE)),
        assistant_attendance_admin_hbk5 = ifelse(all(is.na(nts_hbk5_assistant_admin_2_hbk5)), NA, sum(nts_hbk5_assistant_admin_2_hbk5, na.rm = TRUE)),
        assistant_attendance_domestic_hbk5 = ifelse(all(is.na(nts_hbk5_assistant_domestic_2_hbk5)), NA, sum(nts_hbk5_assistant_domestic_2_hbk5, na.rm = TRUE))
      )
    
    if(nrow(data_hbk5) == 0) return(NULL)
    return(data_hbk5)
  })
  
  output$table_plot1_hbk5 <- renderRHandsontable({
    data_hbk5 <- leadership_table_hbk5()
    
    if(is.null(data_hbk5)) {
      return(NULL) # Return NULL if data is empty
    }
    
    colnames(data_hbk5) <- c("School Name", "Number of Meetings Held", 
                             "Number of times headteacher attended PLC session", 
                             "Number of times assistant head academic attended PLC session", 
                             "Number of times assistant admin attended PLC session", 
                             "Number of times assistant domestic attended PLC session")
    
    # Convert columns to character type
    data_hbk5 <- data_hbk5 %>% mutate(across(everything(), as.character))
    
    # Replace NA with "NA"
    data_hbk5[is.na(data_hbk5)] <- "NA"
    
    # Create a handsontable
    rhandsontable(data_hbk5) %>%
      hot_col(col = "School Name", readOnly = TRUE)  # Setting the first column to readOnly as an example
  })
  
  
  
  output$export_button_hbk5_led <- downloadHandler(
    filename = function() {
      paste("data_hbk5", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      table_data_hbk5_led <- leadership_table_hbk5()  # Get the reactive data
      table_data_subset_hbk5_led <- table_data_hbk5_led[, c("Name_school_hbk5", "count_hbk5", "head_attendance_hbk5", "assistant_attendance_academic_hbk5", "assistant_attendance_admin_hbk5", "assistant_attendance_domestic_hbk5")]
      write.csv(table_data_subset_hbk5_led, file, row.names = FALSE)
    }
  ) 
  
  ########################################################end of code for leadership attendance to handbook 5 yEAR 2 SSPLC
  
  
  
  ######################################################################################leadership code for curriculum trial schools
  leadership_table_trial <- reactive({
    # Start with the base data
    plc_base_data <- plc_trial_school
    
    # Apply academic year filter if not "All"
    if(input$academic_year_filter_school != "All") {
      plc_base_data <- plc_base_data %>%
        filter(Academic_Year_Trial == input$academic_year_filter_school)
    }
    
    # Continue with the existing filtering and processing
    data_trial <- plc_base_data %>%
      filter(plc_take_place_curri_trial == 1) %>%
      group_by(school_curri_trial) %>%
      summarise(
        count_trial = sum(plc_take_place_curri_trial == 1),
        head_attendance_trial = ifelse(all(is.na(nts_curri_trial.headteacher_attendance_2_curri_trial)), NA, sum(nts_curri_trial.headteacher_attendance_2_curri_trial, na.rm = TRUE)),
        assistant_attendance_academic_trial = ifelse(all(is.na(nts_curri_trial.assitant_academic_2_curri_trial)), NA, sum(nts_curri_trial.assitant_academic_2_curri_trial, na.rm = TRUE)),
        assistant_attendance_admin_trial = ifelse(all(is.na(nts_curri_trial.assistant_admin_2_curri_trial)), NA, sum(nts_curri_trial.assistant_admin_2_curri_trial, na.rm = TRUE)),
        assistant_attendance_domestic_trial = ifelse(all(is.na(nts_curri_trial.assistant_domestic_2_curri_trial)), NA, sum(nts_curri_trial.assistant_domestic_2_curri_trial, na.rm = TRUE))
      )
    
    if(nrow(data_trial) == 0) return(NULL)
    return(data_trial)
  })
  
  output$table_plot_school_level_2 <- renderRHandsontable({
    data_trial <- leadership_table_trial()
    
    if(is.null(data_trial)) {
      return(NULL)  # Return NULL if data is empty
    }
    
    colnames(data_trial) <- c("School Name", "Number of Meetings Held", 
                              "Number of Times Headteacher Attended PLC Session", 
                              "Number of Times Assistant Head Academic Attended PLC Session", 
                              "Number of Times Assistant Admin Attended PLC Session", 
                              "Number of Times Assistant Domestic Attended PLC Session")
    
    # Convert columns to character type and replace NA with "NA"
    data_trial <- data_trial %>% 
      mutate(across(everything(), ~ifelse(is.na(.), "NA", as.character(.))))
    
    # Create a handsontable
    rhandsontable(data_trial) %>%
      hot_col(col = "School Name", readOnly = TRUE)  # Setting the first column to readOnly
  })
  
  
  
  ####################### Access data and visualsation section. 
  # Read data from the CSV directly into a global variable
  
  # Reactive expression for filtering data based on year_access
  filtered_data_year <- reactive({
    subset(access_data, year_access == input$year_access)
  })
  
  # Observer to update Region_access based on year_access
  observe({
    updateSelectInput(session, "Region_access", choices = unique(filtered_data_year()$Region_access))
  })
  
  # Reactive expression for filtering data based on year_access and Region_access
  filtered_data_region <- reactive({
    subset(filtered_data_year(), Region_access == input$Region_access)
  })
  
  # Observer to update Name_school_access based on year_access and Region_access
  observe({
    updateSelectInput(session, "Name_school_access", choices = unique(filtered_data_region()$Name_school_access))
  })
  
  
  
  
  
  output$plot_teachers <- renderPlot({
    # Access the value from the reactive and filter by the selected inputs
    teacher_data <- access_data %>%
      filter(
        year_access == input$year_access,
        Region_access == input$Region_access,
        Name_school_access == input$Name_school_access
      ) %>%
      select(Name_school_access, no_male_teachers_access, no_female_teachers_access, total_teachers_schoo_access) %>%
      pivot_longer(
        cols = -Name_school_access,
        names_to = "category",
        values_to = "count"
      )
    
    ggplot(teacher_data, aes(x = Name_school_access, y = count, fill = category)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label=count), position=position_dodge(width=0.9), vjust=-0.25) +
      theme_minimal() +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      labs(title = "Number of teachers in the school", x = NULL, y = "Count") + 
      scale_fill_discrete(name = "Category", labels = c("Female Teachers", "Male Teachers", "Total No. of Teachers"))
  })
  
  
  output$plot_non_teaching_staff <- renderPlot({
    # Access the value from the reactive and filter by the selected inputs
    non_teaching_staff_data <- access_data %>%
      filter(
        year_access == input$year_access,
        Region_access == input$Region_access,
        Name_school_access == input$Name_school_access
      ) %>%
      select(Name_school_access, no_male_nonteachers_access, no_female_nonteachers_access, total_nonteachers_schoo_access) %>%
      pivot_longer(
        cols = -Name_school_access,
        names_to = "category",
        values_to = "count"
      )
    
    ggplot(non_teaching_staff_data, aes(x = Name_school_access, y = count, fill = category)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label=count), position=position_dodge(width=0.9), vjust=-0.25) +
      theme_minimal() +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      labs(title = "Number of non-teaching staff in the school", x = NULL, y = "Count") + 
      scale_fill_discrete(name = "Category", labels = c("Female Non-Teaching Staff", "Male Non-Teaching Staff", "Total Non-Teaching Staff"))
  })
  
  
  output$plot_students <- renderPlot({
    # Access the value from the reactive and filter by the selected inputs
    student_data <- access_data %>%
      filter(
        year_access == input$year_access,
        Region_access == input$Region_access,
        Name_school_access == input$Name_school_access
      )
    
    # If "All Students" is selected, create new variables that are the sum of all years' data
    if (input$year_select == "All Students") {
      student_data <- student_data %>%
        mutate(
          no_male_students_access = no_male_year1_access + no_male_year2_access + no_male_year3_access,
          no_female_students_access = no_female_year1_access + no_female_year2_access + no_female_year3_access,
          total_students_schoo_access = total_year1_schoo_access + total_year2_schoo_access + total_year3_schoo_access
        ) %>%
        select(Name_school_access, no_male_students_access, no_female_students_access, total_students_schoo_access)
    } else {
      # Map the input selection to the correct columns in your data
      selected_year <- switch(input$year_select,
                              "Year 1" = c("no_male_year1_access", "no_female_year1_access", "total_year1_schoo_access"),
                              "Year 2" = c("no_male_year2_access", "no_female_year2_access", "total_year2_schoo_access"),
                              "Year 3" = c("no_male_year3_access", "no_female_year3_access", "total_year3_schoo_access")
      )
      
      student_data <- student_data %>%
        select(Name_school_access, one_of(selected_year))
    }
    
    student_data <- student_data %>%
      pivot_longer(
        cols = -Name_school_access,
        names_to = "category",
        values_to = "count"
      )
    
    ggplot(student_data, aes(x = Name_school_access, y = count, fill = category)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label=count), position=position_dodge(width=0.9), vjust=-0.25) +
      theme_minimal() +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      labs(title = "Number of students in the school", x = NULL, y = "Count") +
      scale_fill_discrete(name = "Category", labels = c("Female Students", "Male Students", "Total No. of Students"))
  })
  
  output$plot_students_sen <- renderPlot({
    # Access the value from the reactive and filter by the selected inputs
    student_data_sen <- access_data %>%
      filter(
        year_access == input$year_access,
        Region_access == input$Region_access,
        Name_school_access == input$Name_school_access
      )
    
    # If "All Students" is selected, create new variables that are the sum of all years' data
    if (input$year_select_sen == "All Students") {
      student_data_sen <- student_data_sen %>%
        mutate(
          no_male_students_sen = no_male_year1_sen + no_male_year2_sen + no_male_year3_sen,
          no_female_students_sen = no_female_year1_sen + no_female_year2_sen + no_female_year3_sen,
          total_students_schoo_sen = total_year1_schoo_sen + total_year2_schoo_sen + total_year3_schoo_sen
        ) %>%
        select(Name_school_access, no_male_students_sen, no_female_students_sen, total_students_schoo_sen)
    } else {
      # Map the input selection to the correct columns in your data
      selected_year_sen <- switch(input$year_select_sen,
                                  "Year 1" = c("no_male_year1_sen", "no_female_year1_sen", "total_year1_schoo_sen"),
                                  "Year 2" = c("no_male_year2_sen", "no_female_year2_sen", "total_year2_schoo_sen"),
                                  "Year 3" = c("no_male_year3_sen", "no_female_year3_sen", "total_year3_schoo_sen")
      )
      
      student_data_sen <- student_data_sen %>%
        select(Name_school_access, one_of(selected_year_sen))
    }
    
    student_data_sen <- student_data_sen %>%
      pivot_longer(
        cols = -Name_school_access,
        names_to = "category",
        values_to = "count"
      )
    
    ggplot(student_data_sen, aes(x = Name_school_access, y = count, fill = category)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label=count), position=position_dodge(width=0.9), vjust=-0.25) +
      theme_minimal() +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      labs(title = "Number of SEN students in the school", x = NULL, y = "Count") +
      scale_fill_discrete(name = "Category", labels = c("No. SEN Female Students", "No. SEN Male Students", "Total No. of SEN Students"))
  })
  
  ###### regional level summary of access data
  
  filtered_data_year_regional <- reactive({
    subset(access_data, year_access == input$year_access_regional_analysis)
  })
  
  # Observer to update Region_access based on year_access_regional
  observe({
    updateSelectInput(session, "Region_access_regional_analysis", choices = unique(filtered_data_year_regional()$Region_access))
  })
  
  
  # Reactive aggregate data for the selected year and region
  aggregate_data_by_region <- reactive({
    req(input$year_access_regional_analysis, input$Region_access_regional_analysis)
    
    access_data %>%
      filter(year_access == input$year_access_regional_analysis, 
             Region_access == input$Region_access_regional_analysis) %>%
      group_by(Region_access) %>%
      summarise(
        total_male_teachers = sum(no_male_teachers_access, na.rm = TRUE),
        total_female_teachers = sum(no_female_teachers_access, na.rm = TRUE),
        total_teachers = sum(total_teachers_schoo_access, na.rm = TRUE),
        total_male_nonteachers = sum(no_male_nonteachers_access, na.rm = TRUE),
        total_female_nonteachers = sum(no_female_nonteachers_access, na.rm = TRUE),
        total_nonteachers = sum(total_nonteachers_schoo_access, na.rm = TRUE)
      )
  })
  
  # Teachers plot for the regional level
  
  output$plot_teachers_region <- renderPlot({
    # Extracting the aggregated teacher data based on the selected region and year
    teacher_data <- aggregate_data_by_region() %>%
      ungroup() %>%
      pivot_longer(cols = c(total_male_teachers, total_female_teachers, total_teachers),
                   names_to = "category",
                   values_to = "count") %>%
      mutate(category = factor(category, 
                               levels = c("total_male_teachers", "total_female_teachers", "total_teachers"),
                               labels = c("Male Teachers", "Female Teachers", "Total Teachers")))
    
    # Building the ggplot2 plot
    p <- ggplot(teacher_data, aes(x = category, y = count, fill = category)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(
        title = "Teachers by Gender in Selected Region",
        subtitle = paste("Year:", input$year_access_regional_analysis, "Region:", input$Region_access_regional_analysis),
        x = "Category",
        y = "Number of Teachers"
      ) +
      theme_minimal() +
      scale_fill_manual(values = c("Male Teachers" = "red", "Female Teachers" = "blue", "Total Teachers" = "green")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      geom_text(aes(label = count), position = position_dodge(width = 0.9), vjust = -0.25)
    
    print(p)
  })
  
  
  
  aggregate_data_non_teaching <- reactive({
    req(input$year_access_regional_analysis, input$Region_access_regional_analysis)
    
    access_data %>%
      filter(year_access == input$year_access_regional_analysis, 
             Region_access == input$Region_access_regional_analysis) %>%
      group_by(Region_access) %>%
      summarise(
        total_male_nonteachers = sum(no_male_nonteachers_access, na.rm = TRUE),
        total_female_nonteachers = sum(no_female_nonteachers_access, na.rm = TRUE),
        total_nonteachers = sum(total_nonteachers_schoo_access, na.rm = TRUE)
      )
  })
  
  
  output$plot_nonteaching_staff_region <- renderPlot({
    # Extracting the aggregated non-teaching staff data based on the selected region and year
    nonteaching_data <- aggregate_data_non_teaching() %>%
      ungroup() %>%
      pivot_longer(cols = c(total_male_nonteachers, total_female_nonteachers, total_nonteachers),
                   names_to = "category",
                   values_to = "count") %>%
      mutate(category = factor(category, 
                               levels = c("total_male_nonteachers", "total_female_nonteachers", "total_nonteachers"),
                               labels = c("Male Non-Teaching Staff", "Female Non-Teaching Staff", "Total Non-Teaching Staff")))
    
    # Building the ggplot2 plot
    p <- ggplot(nonteaching_data, aes(x = category, y = count, fill = category)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(
        title = "Non-Teaching Staff by Gender in Selected Region",
        subtitle = paste("Year:", input$year_access_regional_analysis),
        x = "Category",
        y = "Number of Non-Teaching Staff"
      ) +
      theme_minimal() +
      scale_fill_manual(values = c("Male Non-Teaching Staff" = "red", "Female Non-Teaching Staff" = "blue", "Total Non-Teaching Staff" = "green")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      geom_text(aes(label = count), position = position_dodge(width = 0.9), vjust = -0.25)
    
    return(p)
  })
  
  
  output$plot_students_region <- renderPlot({
    # Access the value from the reactive and filter by the selected inputs
    student_data <- access_data %>%
      filter(year_access == input$year_access_regional_analysis, Region_access == input$Region_access_regional_analysis)
    
    # If "All Students" is selected, create new variables that are the sum of all years' data
    if (input$year_select_students == "All Students") {
      student_data <- student_data %>%
        mutate(
          no_male_students_access = no_male_year1_access + no_male_year2_access + no_male_year3_access,
          no_female_students_access = no_female_year1_access + no_female_year2_access + no_female_year3_access,
          total_students_schoo_access = total_year1_schoo_access + total_year2_schoo_access + total_year3_schoo_access
        ) %>%
        select(Region_access, no_male_students_access, no_female_students_access, total_students_schoo_access)
    } else {
      # Map the input selection to the correct columns in your data
      selected_year <- switch(input$year_select_students,
                              "Year 1" = c("no_male_year1_access", "no_female_year1_access", "total_year1_schoo_access"),
                              "Year 2" = c("no_male_year2_access", "no_female_year2_access", "total_year2_schoo_access"),
                              "Year 3" = c("no_male_year3_access", "no_female_year3_access", "total_year3_schoo_access")
      )
      
      student_data <- student_data %>%
        select(Region_access, one_of(selected_year))
    }
    
    student_data <- student_data %>%
      group_by(Region_access) %>%
      summarise(across(everything(), sum, na.rm = TRUE)) %>%
      pivot_longer(
        cols = -Region_access,
        names_to = "category",
        values_to = "count"
      )
    
    ggplot(student_data, aes(x = Region_access, y = count, fill = category)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label = count), position = position_dodge(width = 0.9), vjust = -0.25) +
      theme_minimal() +
      labs(title = "Number of students by Region", x = "Region", y = "Count") +
      scale_fill_discrete(name = "Category", labels = c("Male Students", "Female Students", "Total Students")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  output$plot_sen_students_region <- renderPlot({
    
    # Access the value from the reactive and filter by the selected inputs
    sen_student_data <- access_data %>%
      filter(year_access == input$year_access_regional_analysis, Region_access == input$Region_access_regional_analysis)
    
    if (input$year_select_sen_students == "All Students") {
      
      # First, aggregate yearly data for each region
      sen_student_data <- sen_student_data %>%
        group_by(Region_access) %>%
        summarise(
          no_male_year1_sen = sum(no_male_year1_sen, na.rm = TRUE),
          no_female_year1_sen = sum(no_female_year1_sen, na.rm = TRUE),
          total_year1_schoo_sen = sum(total_year1_schoo_sen, na.rm = TRUE),
          no_male_year2_sen = sum(no_male_year2_sen, na.rm = TRUE),
          no_female_year2_sen = sum(no_female_year2_sen, na.rm = TRUE),
          total_year2_schoo_sen = sum(total_year2_schoo_sen, na.rm = TRUE),
          no_male_year3_sen = sum(no_male_year3_sen, na.rm = TRUE),
          no_female_year3_sen = sum(no_female_year3_sen, na.rm = TRUE),
          total_year3_schoo_sen = sum(total_year3_schoo_sen, na.rm = TRUE)
        )
      
      # Now, aggregate the yearly totals for the "All Students" category for each region
      sen_student_data <- sen_student_data %>%
        mutate(
          no_male_sen_students_access = no_male_year1_sen + no_male_year2_sen + no_male_year3_sen,
          no_female_sen_students_access = no_female_year1_sen + no_female_year2_sen + no_female_year3_sen,
          total_sen_students_schoo_access = total_year1_schoo_sen + total_year2_schoo_sen + total_year3_schoo_sen
        ) %>%
        select(Region_access, no_male_sen_students_access, no_female_sen_students_access, total_sen_students_schoo_access)
      
    } else {
      
      # Map the input selection to the correct columns in your data
      selected_year_sen <- switch(input$year_select_sen_students,
                                  "Year 1" = c("no_male_year1_sen", "no_female_year1_sen", "total_year1_schoo_sen"),
                                  "Year 2" = c("no_male_year2_sen", "no_female_year2_sen", "total_year2_schoo_sen"),
                                  "Year 3" = c("no_male_year3_sen", "no_female_year3_sen", "total_year3_schoo_sen")
      )
      
      sen_student_data <- sen_student_data %>%
        select(Region_access, one_of(selected_year_sen))
    }
    
    # Aggregate data by Region_access and pivot for visualization
    sen_student_data <- sen_student_data %>%
      group_by(Region_access) %>%
      summarise(across(everything(), sum, na.rm = TRUE)) %>%
      pivot_longer(
        cols = -Region_access,
        names_to = "category",
        values_to = "count"
      )
    
    # Plotting
    ggplot(sen_student_data, aes(x = Region_access, y = count, fill = category)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label = count), position = position_dodge(width = 0.9), vjust = -0.25) +
      theme_minimal() +
      labs(title = "Number of SEN students by Region", x = "Region", y = "Count") +
      scale_fill_discrete(name = "Category", labels = c("Male SEN Students", "Female SEN Students", "Total SEN Students")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  
  expected_schools_data <- data.frame(
    Region = c("Ahafo", "Ashanti", "Bono", "Bono East", "Central", "Eastern", "Greater Accra", "North East", "Northern", "Oti", "Savannah", "Upper East", "Upper West", "Volta", "Western", "Western North"),
    no_schools_region = c(16, 140, 35, 29, 75, 93, 46, 15, 29, 22, 12, 34, 30, 70, 36, 18)
  )
  
  distinct_schools_count <- reactive({
    req(input$year_access_regional_analysis, input$Region_access_regional_analysis)
    
    data <- access_data %>% filter(year_access == input$year_access_regional_analysis, Region_access == input$Region_access_regional_analysis)
    
    distinct_schools <- data %>%
      summarise(no_of_schools = n_distinct(Name_school_access)) %>%
      pull(no_of_schools)
    
    return(distinct_schools)
  })
  
  output$distinct_school_text <- renderText({
    actual_count <- distinct_schools_count()
    expected_count <- expected_schools_data$no_schools_region[expected_schools_data$Region == input$Region_access_regional_analysis]
    
    if (length(expected_count) > 0) {
      return(paste("Number of schools that submitted data in", input$Region_access_regional_analysis, ":", actual_count, "/", expected_count))
    } else {
      return(paste("Region not found:", input$Region_access_regional_analysis))
    }
  })
  
  
  
  ####################### the below codes are for national level summary of the access data
  
  
  output$distinct_schools_output <- renderText({
    # Filter data based on the year selected in the dropdown
    filtered_data <- access_data %>%
      filter(year_access == input$year_select_national)
    
    # Calculate the number of distinct schools
    distinct_schools <- filtered_data %>%
      summarise(no_of_schools = n_distinct(Name_school_access)) %>%
      pull(no_of_schools)
    
    # Create output text
    paste("Please note that ", distinct_schools, " out of the 700 secondary schools submitted data")
  })
  
  
  
  output$plot_teachers_national <- renderPlot({
    # Filtering data based on selected year
    teacher_data_national <- access_data %>%
      filter(year_access == input$year_select_national) %>%
      summarise(
        total_male_teachers = sum(no_male_teachers_access, na.rm = TRUE),
        total_female_teachers = sum(no_female_teachers_access, na.rm = TRUE),
        total_teachers = sum(total_teachers_schoo_access, na.rm = TRUE)
      ) %>%
      pivot_longer(everything(), names_to = "category", values_to = "count")
    
    # Plotting
    ggplot(teacher_data_national, aes(x = category, y = count, fill = category)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = count), vjust = -0.5, position = position_dodge(width = 0.9)) +  # This line adds data values on top of bars
      labs(title = "Teachers by Gender (National)", x = "Category", y = "Number of Teachers") +
      theme_minimal() +
      scale_fill_discrete(name = "Gender Category", labels = c("Female Teachers", "Male Teachers", "Total Teachers"))
    
  })
  
  output$year_ui_national <- renderUI({
    # Ensure years are unique and not NA
    years <- unique(access_data$year_access)
    
    # Generate the dropdown menu with "2023/2024 academic year" selected by default
    selectInput("year_select_national", 
                "Select Year:", 
                choices = years,
                selected = "2023/2024 academic year")
  })
  
  
  
  output$plot_nonteaching_national <- renderPlot({
    # Filtering and summarizing data
    nonteaching_data_national <- access_data %>%
      filter(year_access == input$year_select_national) %>%
      summarise(
        total_male_nonteachers = sum(no_male_nonteachers_access, na.rm = TRUE),
        total_female_nonteachers = sum(no_female_nonteachers_access, na.rm = TRUE),
        total_nonteachers = sum(total_nonteachers_schoo_access, na.rm = TRUE)
      ) %>%
      pivot_longer(everything(), names_to = "category", values_to = "count")
    
    # Plotting
    ggplot(nonteaching_data_national, aes(x = category, y = count, fill = category)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = count), vjust = -0.5, position = position_dodge(width = 0.9)) +  # This line adds data values on top of bars
      labs(title = "Non-Teaching Staff by Gender (National)", x = "Category", y = "Number of Staff") +
      theme_minimal() +
      scale_fill_discrete(name = "Gender Category", labels = c("Female Staff", "Male Staff", "Total Staff"))
    
  })
  
  
  
  output$plot_students_national <- renderPlot({
    
    # Filter data based on the selected year_access and the selected year
    students_data_national <- access_data %>%
      filter(year_access == input$year_select_national)
    
    
    if (input$year_select_students_national == "Year 1") {
      students_data_national <- students_data_national %>%
        mutate(
          no_male = no_male_year1_access,
          no_female = no_female_year1_access,
          total = total_year1_schoo_access
        )
    } else if (input$year_select_students_national == "Year 2") {
      students_data_national <- students_data_national %>%
        mutate(
          no_male = no_male_year2_access,
          no_female = no_female_year2_access,
          total = total_year2_schoo_access
        )
    } else if (input$year_select_students_national == "Year 3") {
      students_data_national <- students_data_national %>%
        mutate(
          no_male = no_male_year3_access,
          no_female = no_female_year3_access,
          total = total_year3_schoo_access
        )
    } else if (input$year_select_students_national == "All Students") {
      students_data_national <- students_data_national %>%
        mutate(
          no_male = no_male_year1_access + no_male_year2_access + no_male_year3_access,
          no_female = no_female_year1_access + no_female_year2_access + no_female_year3_access,
          total = total_year1_schoo_access + total_year2_schoo_access + total_year3_schoo_access
        )
    }
    
    students_data_national <- students_data_national %>%
      select(no_male, no_female, total) %>%
      summarise(across(everything(), sum, na.rm = TRUE)) %>%
      pivot_longer(everything(), names_to = "category", values_to = "count")
    
    ggplot(students_data_national, aes(x = category, y = count, fill = category)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = count), vjust = -0.5, position = position_dodge(width = 0.9)) +
      labs(title = "Students by Gender (National)", x = "Category", y = "Number of Students") +
      theme_minimal() +
      scale_fill_discrete(name = "Gender Category", labels = c("Male Students", "Female Students", "Total Students"))
  })
  
  output$plot_sen_students_national <- renderPlot({
    
    # Filter data based on the selected year
    sen_students_data_national <- access_data %>%
      filter(year_access == input$year_select_national)
    
    if (input$year_select_national_sen == "Year 1") {
      sen_students_data_national <- sen_students_data_national %>%
        select(no_male_year1_sen, no_female_year1_sen, total_year1_schoo_sen)
    } else if (input$year_select_national_sen == "Year 2") {
      sen_students_data_national <- sen_students_data_national %>%
        select(no_male_year2_sen, no_female_year2_sen, total_year2_schoo_sen)
    } else if (input$year_select_national_sen == "Year 3") {
      sen_students_data_national <- sen_students_data_national %>%
        select(no_male_year3_sen, no_female_year3_sen, total_year3_schoo_sen)
    } else if (input$year_select_national_sen == "All Students") {
      sen_students_data_national <- sen_students_data_national %>%
        mutate(
          no_male_sen_students_access = no_male_year1_sen + no_male_year2_sen + no_male_year3_sen,
          no_female_sen_students_access = no_female_year1_sen + no_female_year2_sen + no_female_year3_sen,
          total_sen_students_schoo_access = total_year1_schoo_sen + total_year2_schoo_sen + total_year3_schoo_sen
        ) %>%
        select(no_male_sen_students_access, no_female_sen_students_access, total_sen_students_schoo_access)
    }
    
    # Summarize and reshape the data for plotting
    sen_students_data_national <- sen_students_data_national %>%
      summarise(across(everything(), sum, na.rm = TRUE)) %>%
      pivot_longer(everything(), names_to = "category", values_to = "count")
    
    # Plotting
    ggplot(sen_students_data_national, aes(x = category, y = count, fill = category)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = count), vjust = -0.5, position = position_dodge(width = 0.9)) +
      labs(title = "Students with Special Needs by Gender (National)", x = "Category", y = "Number of Students") +
      theme_minimal() +
      scale_fill_discrete(name = "Gender Category", labels = c("Female SEN Students", "Male SEN Students", "Total SEN Students"))
    
  })
  
  
  
  ##################################Lesson observation section
  output$summary_text <- renderText({
    # Get the selected school
    selected_school <- input$school_select_lesson
    
    # Filter the data for the selected school
    filtered_data <- lesson_data[lesson_data$school_lesson_old == selected_school, ]
    
    # Compute the number of lessons observed
    num_lessons <- nrow(filtered_data)
    
    # Compute the number of male and female teachers
    num_male_teachers <- nrow(filtered_data[filtered_data$begin_group_0yMn9SYN9_b1_sex == "Male", ])
    num_female_teachers <- nrow(filtered_data[filtered_data$begin_group_0yMn9SYN9_b1_sex == "Female", ])
    
    num_year_1 <- nrow(filtered_data[filtered_data$begin_group_0yMn9SYN9_aa7_class == "Year 1", ])
    num_year_2 <- nrow(filtered_data[filtered_data$begin_group_0yMn9SYN9_aa7_class == "Year 2", ])
    num_year_3 <- nrow(filtered_data[filtered_data$begin_group_0yMn9SYN9_aa7_class == "Year 3", ])
    
    # Construct the summary string
    summary_string <- paste(num_lessons, "lesson(s) were observed in", selected_school, ".")
    
    if (num_male_teachers > 0) {
      summary_string <- paste(summary_string, num_male_teachers, "male teacher(s) were observed.")
    }
    
    if (num_female_teachers > 0) {
      summary_string <- paste(summary_string, num_female_teachers, "female teacher(s) were observed.")
    }
    
    if (num_year_1 > 0) {
      summary_string <- paste(summary_string, num_year_1, "year 1 lesson(s) were observed.")
    }
    
    if (num_year_2 > 0) {
      summary_string <- paste(summary_string, num_year_2, "year 2 lesson(s) were observed.")
    }
    
    if (num_year_3 > 0) {
      summary_string <- paste(summary_string, num_year_3, "year 3 lesson(s) were observed.")
    }
    
    return(summary_string)
  })
  
  
  
  
  ############ This section of the server code is related to the lesson observation menu. As mentioned earlier, there is a need for users to display result by school.
  # we can't generate a table with all schools, it will be a lot. So I figured, filtering by region first, and then the below code will populate the school drop down with the names of 
  ## of the schools in the region is the best. Subsequently, when a user selects the school, the result for the school is displayed. 
  
  
  #########################################################code for lesson observation 2022/2023 academic year
  
  
  output$region_ui_lesson <- renderUI({
    selectInput("region_select_lesson", label = h4("Select a region"), 
                choices = unique(lesson_data$region_lesson_old), 
                selected = unique(lesson_data$region_lesson_old)[3])
  })
  
  output$term_ui <- renderUI({
    selectInput("term_select_lesson", label = h4("Select a Semester"), 
                choices = unique(lesson_data$term_lesson_old), 
                selected = unique(lesson_data$term_lesson_old)[2])
  })
  
  output$school_ui <- renderUI({
    # Filter the data to include only schools in the selected region
    filtered_data <- lesson_data[lesson_data$region_lesson_old == input$region_select_lesson, ]
    
    selectInput("school_select_lesson", label = h4("Select a school"), 
                choices = unique(filtered_data$school_lesson_old), 
                selected = unique(filtered_data$school_lesson_old)[1])
  })
  
  
  output$summaryTable <- DT::renderDataTable({
    # defining factor names and labels
    factor_names <- c("Is the purpose of the lesson clearly stated in the lesson plan and focused on learners achieving the lesson learning outcomes?" = "lesson_purpose_old",
                      "Are the unique needs of female learners, male learners, and learners with special education needs adequately catered for in the lesson plan?" = "lesson_unique_needs_learners_old",
                      "Does the teacher maintain a positive and nonthreatening learning environment throughout the lesson?" = "lesson_teacher_positive_old",
                      "Are teaching/learning materials and other resources including ICT being used to support learning of all categories of learners?" = "lesson_TLRs_old",
                      "Are learners engaged on tasks that challenge them and demonstrate the teacher’s high expectation of learner achievement?" = "lesson_learners_challenged_old",
                      "Is there evidence that students are learning?" = "lesson_students_learning_old",
                      "Is teaching differentiated to cater for the varied needs of all male learners, female learners, learners with special education needs etc?" = "lesson_teaching_differentiated_old",
                      "Does the teacher use real life examples which are familiar to learners to explain concepts and their relevance?" = "lesson_reallife_objects_old",
                      "Does the teacher point out or question traditional gender roles when they come up during the lessons as appropriate?" = "lesson_traditional_role_old",
                      "Does the lesson include appropriate interactive and creative approaches e.g., group work, role play, storytelling to support learners achieving the learning outcomes?" = "lesson_interactive_approaches_old",
                      "Have cross-cutting issues and /or 21st century skills been integrated in the lesson e.g., problem-solving, critical thinking, communication?" = "lesson_integrating_21stcentury_old",
                      "Does the teacher incorporate ICT into their practice to support learning?" = "lesson_integrating_ICT_old",
                      "Does the teacher encourage learners to ask questions during the lesson?" = "lesson_questioning_old",
                      "Evidence of assessment in the lesson" = "lesson_assessment_old",
                      "Do learners make use of feedback from teacher and peers?" = "lesson_feedback_old",
                      "Does the teacher evaluate the lesson against the learning outcomes?" = "lesson_evaluate_learning_outcome_old")
    
    # defining factor labels
    # defining factor labels
    factor_labels <- names(factor_names)
    
    # pre-processing data
    filtered_data <- lesson_data %>%
      filter(region_lesson_old == input$region_select_lesson,
             term_lesson_old == input$term_select_lesson,
             if (input$school_select_lesson == "") {TRUE} else {school_lesson_old == input$school_select_lesson})
    
    # renaming factor names with labels before reshaping data
    for (label in factor_labels) {
      name <- factor_names[[label]]
      colnames(filtered_data)[colnames(filtered_data) == name] <- label
    }
    
    # reshaping data
    table_data <- filtered_data %>%
      select(all_of(factor_labels)) %>%
      pivot_longer(everything(), names_to = "Factor", values_to = "Value") %>%
      group_by(Factor, Value) %>%
      summarise(Count = n(), .groups = "drop") 
    
    # Defining all the possible values
    possible_values <- c("Yes", "In Part", "No")
    
    # Use complete() to ensure all combinations of Factor and possible_values
    table_data <- table_data %>%
      tidyr::complete(Factor, Value = possible_values, fill = list(Count = 0)) %>%
      pivot_wider(names_from = Value, values_from = Count, values_fill = list(Count = 0))
    
    # Ensure consistent column order
    table_data <- table_data %>%
      select(Factor, `Yes`, `In Part`, `No`)
    
    # calculating total for each factor
    table_data <- table_data %>%
      rowwise() %>%
      mutate(Total = sum(c_across(where(is.numeric))))
    
    # calculating percentages
    table_data <- table_data %>%
      mutate(across(where(is.numeric), ~ . / Total * 100))
    
    # converting percentages to formatted strings with '%' symbol
    table_data <- table_data %>%
      mutate(across(where(is.numeric), ~ sprintf("%.2f%%", .)))
    
    # removing the total column
    table_data <- table_data %>%
      select(-Total)
    
    # returning DTtable
    
    DT::datatable(table_data, options = list(pageLength = 10, dom = 'rtip'))
    
    
  })
  
  
  
  
  # Display newtextstrength and additional variables for selected region, term, and school
  output$strengthTextDisplay <- renderDataTable({
    
    # Filter data based on user's selection
    filtered_data <- lesson_data %>%
      filter(
        region_lesson_old == input$region_select_lesson,
        term_lesson_old == input$term_select_lesson,
        if (input$school_select_lesson == "") {TRUE} else {school_lesson_old == input$school_select_lesson}
      )
    
    # Select the desired columns for display
    display_data <- filtered_data %>%
      select(
        subject = begin_group_0yMn9SYN9_aa6_subject,
        class = begin_group_0yMn9SYN9_aa7_class,
        gender = begin_group_0yMn9SYN9_b1_sex,
        strengths = newtextstrength_old
      )
    
    # Render the table
    DT::datatable(display_data, options = list(pageLength = 5, autoWidth = TRUE))
  })
  
  
  
  
  # Display newtextareasfordev and additional variables for selected region, term, and school
  output$areasForDevDisplay <- renderDataTable({
    
    # Filter data based on user's selection
    filtered_data <- lesson_data %>%
      filter(
        region_lesson_old == input$region_select_lesson,
        term_lesson_old == input$term_select_lesson,
        if (input$school_select_lesson == "") {TRUE} else {school_lesson_old == input$school_select_lesson}
      )
    
    # Select the desired columns for display
    display_data <- filtered_data %>%
      select(
        subject = begin_group_0yMn9SYN9_aa6_subject,
        class = begin_group_0yMn9SYN9_aa7_class,
        gender = begin_group_0yMn9SYN9_b1_sex,
        areas_for_development = newtextareasfordev_old
      )
    
    # Render the table
    DT::datatable(display_data, options = list(pageLength = 5, autoWidth = TRUE))
  })
  
  observe({
    if (input$academic_year == 'lesson_data') {
      current_data <- lesson_data
    } else if (input$academic_year == 'lesson_data_new') {
      current_data <- lesson_data_new
    }
  })
  
  
  
  
  ### national level thematics on areas of strength and improvements
  
  # Define the data for strengths
  strengths_data <- data.frame(
    MainTheme = c("Teacher's Ability", 
                  "Lesson Quality", 
                  "Good Practices", 
                  "Learner Involvement", 
                  "Subject Mastery", 
                  "Student Participation"),
    Description = c("A recurring strength observed in lessons was the teachers' competence and capability. Their ability to manage and deliver lessons effectively was evident.",
                    "Many observations highlighted the quality of lessons, suggesting well-structured and comprehensive content that resonated with the learners.",
                    "The term 'good' appearing frequently implies that many positive teaching practices were identified, contributing to effective learning.",
                    "One notable strength across lessons was the active participation of learners. Teachers made commendable efforts to involve students and ensure a participatory learning environment.",
                    "A significant number of teachers displayed a robust knowledge of their subject matter, providing confidence to their students and ensuring a comprehensive understanding of topics.",
                    "The involvement of students in discussions and activities was evident, pointing towards an engaging teaching approach that values student input.")
  )
  
  # Render the data as a table in Shiny
  output$strengthsOutput <- renderTable({
    strengths_data
  }, rownames = FALSE)  # Disable row names for cleaner output
  
  
  # Define the data for areas for improvement
  areas_for_dev_data <- data.frame(
    MainTheme = c("Lesson Aspects", 
                  "Usage of Tools & Methods", 
                  "Teacher's Approach", 
                  "ICT Integration", 
                  "Attention to Learners", 
                  "Teaching Strategies",
                  "Learning Processes",
                  "Lesson Planning",
                  "Delivery"),
    Description = c("Some lessons may benefit from revisiting certain aspects, refining the content or approach to enhance their effectiveness.",
                    "The frequent mention of the term 'use' suggests a need for diversifying or improving the tools, methods, or resources utilized in lessons.",
                    "Feedback on the teacher's approach indicates potential areas for pedagogical improvement or diversification of teaching strategies.",
                    "A prominent area for development is the integration of ICT in lessons. Leveraging technology can enhance the learning experience and cater to varied learning needs.",
                    "Ensuring that all learners are catered to and involved is crucial. Feedback suggests that more attention may be required to ensure inclusivity.",
                    "Observations indicate that there's room for diversifying or improving teaching strategies to better engage students and enhance understanding.",
                    "There might be a need to revisit and refine certain learning processes or methods to ensure they align with learners' needs and promote understanding.",
                    "Effective lesson planning is paramount. Feedback suggests that some lessons could benefit from improved planning to ensure clarity, structure, and alignment with learning objectives.",
                    "The manner in which content is delivered is crucial. Some lessons might benefit from revisiting the delivery approach to ensure clarity and engagement.")
  )
  
  # Render the data as a table in Shiny
  output$areasForDevOutput <- renderTable({
    areas_for_dev_data
  }, rownames = FALSE)  # Disable row names for cleaner output
  
  
  ###############################################################################
  
  # For 2023/2024 academic year
  output$year_ui_new <- renderUI({
    selectInput("year_select_lesson_new", label = h4("Select an Academic Year"), 
                choices = unique(lesson_data_new$year_lesson), 
                selected = unique(lesson_data_new$year_lesson)[1])
  })
  
  output$region_ui_lesson_new <- renderUI({
    # Filter data based on the selected year
    filtered_data_year <- lesson_data_new[lesson_data_new$year_lesson == input$year_select_lesson_new, ]
    
    selectInput("region_select_lesson_new", label = h4("Select a Region"), 
                choices = unique(filtered_data_year$Region_lesson), 
                selected = unique(filtered_data_year$Region_lesson)[1])
  })
  
  output$term_ui_new <- renderUI({
    # Further filter data based on the selected year and region
    filtered_data_region <- lesson_data_new[lesson_data_new$year_lesson == input$year_select_lesson_new &
                                              lesson_data_new$Region_lesson == input$region_select_lesson_new, ]
    
    selectInput("term_select_lesson_new", label = h4("Select a Semester"), 
                choices = unique(filtered_data_region$term_lesson), 
                selected = unique(filtered_data_region$term_lesson)[2])
  })
  
  output$school_ui_new <- renderUI({
    # Filter the data based on the selected year, region, and term
    filtered_data_all <- lesson_data_new[lesson_data_new$year_lesson == input$year_select_lesson_new &
                                           lesson_data_new$Region_lesson == input$region_select_lesson_new &
                                           lesson_data_new$term_lesson == input$term_select_lesson_new, ]
    
    selectInput("school_select_lesson_new", label = h4("Select a School"), 
                choices = unique(filtered_data_all$school_lesson), 
                selected = unique(filtered_data_all$school_lesson)[1])
  })
  
  
  
  
  output$summaryTable_new <- DT::renderDataTable({
    # defining factor names and labels
    factor_names <- c("Is the purpose of the lesson clearly stated in the lesson plan and focused on learners achieving the lesson learning outcomes?" = "lesson_purpose",
                      "Are the unique needs of female learners, male learners, and learners with special education needs adequately catered for in the lesson plan?" = "lesson_unique_needs_learners",
                      "Does the teacher maintain a positive and nonthreatening learning environment throughout the lesson?" = "lesson_teacher_positive",
                      "Are teaching/learning materials and other resources including ICT being used to support learning of all categories of learners?" = "lesson_TLRs",
                      "Are learners engaged on tasks that challenge them and demonstrate the teacher’s high expectation of learner achievement?" = "lesson_learners_challenged",
                      "Is there evidence that students are learning?" = "lesson_students_learning",
                      "Is teaching differentiated to cater for the varied needs of all male learners, female learners, learners with special education needs etc?" = "lesson_teaching_differentiated",
                      "Does the teacher use real life examples which are familiar to learners to explain concepts and their relevance?" = "lesson_reallife_objects",
                      "Does the teacher point out or question traditional gender roles when they come up during the lessons as appropriate?" = "lesson_traditional_role",
                      "Does the lesson include appropriate interactive and creative approaches e.g., group work, role play, storytelling to support learners achieving the learning outcomes?" = "lesson_interactive_approaches",
                      "Have cross-cutting issues and /or 21st century skills been integrated in the lesson e.g., problem-solving, critical thinking, communication?" = "lesson_integrating_21stcentury",
                      "Does the teacher incorporate ICT into their practice to support learning?" = "lesson_integrating_ICT",
                      "Does the teacher encourage learners to ask questions during the lesson?" = "lesson_questioning",
                      "Evidence of assessment in the lesson" = "lesson_assessment",
                      "Do learners make use of feedback from teacher and peers?" = "lesson_feedback",
                      "Does the teacher evaluate the lesson against the learning outcomes?" = "lesson_evaluate_learning_outcome",
                      "Does the teachers’ planning of lessons taught before the one observed show how they plan for learning over time, considering individual and group needs?" = "learning_overtime",
                      "Does the teacher pay attention to the composition of females and males during group work and assigns females leadership roles." = "composition_male_fem",
                      "Does the teacher provide constructive verbal feedback to both females and males and learners with special education needs?" = "constructive_male_fem",
                      "Does the teacher provide constructive written feedback to both females and males and learners with special education needs in their exercise book?" = "constructive_written_male_fem"
    )
    
    # defining factor labels
    # defining factor labels
    factor_labels <- names(factor_names)
    
    # pre-processing data
    filtered_data <- lesson_data_new %>%
      filter(year_lesson == input$year_select_lesson_new,                   # Filter by selected year
             Region_lesson == input$region_select_lesson_new,               # Filter by selected region
             term_lesson == input$term_select_lesson_new,                   # Filter by selected term
             if (input$school_select_lesson_new == "") {TRUE} else {school_lesson == input$school_select_lesson_new})
    
    # renaming factor names with labels before reshaping data
    for (label in factor_labels) {
      name <- factor_names[[label]]
      colnames(filtered_data)[colnames(filtered_data) == name] <- label
    }
    
    # reshaping data
    table_data <- filtered_data %>%
      select(all_of(factor_labels)) %>%
      pivot_longer(everything(), names_to = "Factor", values_to = "Value") %>%
      group_by(Factor, Value) %>%
      summarise(Count = n(), .groups = "drop") 
    
    # Defining all the possible values
    possible_values <- c("Yes", "In Part", "No")
    
    # Use complete() to ensure all combinations of Factor and possible_values
    table_data <- table_data %>%
      tidyr::complete(Factor, Value = possible_values, fill = list(Count = 0)) %>%
      pivot_wider(names_from = Value, values_from = Count, values_fill = list(Count = 0))
    
    # Ensure consistent column order
    table_data <- table_data %>%
      select(Factor, `Yes`, `In Part`, `No`)
    
    # calculating total for each factor
    table_data <- table_data %>%
      rowwise() %>%
      mutate(Total = sum(c_across(where(is.numeric))))
    
    # calculating percentages
    table_data <- table_data %>%
      mutate(across(where(is.numeric), ~ . / Total * 100))
    
    # converting percentages to formatted strings with '%' symbol
    table_data <- table_data %>%
      mutate(across(where(is.numeric), ~ sprintf("%.2f%%", .)))
    
    # removing the total column
    table_data <- table_data %>%
      select(-Total)
    
    # returning DTtable
    
    DT::datatable(table_data, options = list(pageLength = 10, dom = 'rtip'))
    
    
  })
  
  # Display newtextstrength and additional variables for selected region, term, and school
  output$strengthTextDisplay_new <- renderDataTable({
    
    # Filter data based on user's selection
    filtered_data <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_lesson_new,                   # Filter by selected year
        Region_lesson == input$region_select_lesson_new,               # Filter by selected region
        term_lesson == input$term_select_lesson_new,                   # Filter by selected term
        if (input$school_select_lesson_new == "") {TRUE} else {school_lesson == input$school_select_lesson_new} # Filter by selected school if not empty
      )
    
    # Select the desired columns for display
    display_data <- filtered_data %>%
      select(
        subject = begin_group_RRNG5Kxfl_aa6_subject,
        class = begin_group_RRNG5Kxfl_aa7_class,
        gender = begin_group_RRNG5Kxfl_b1_sex,
        strengths = newtextstrength
      )
    
    # Render the table
    DT::datatable(display_data, options = list(pageLength = 5, autoWidth = TRUE))
  })
  
  
  
  
  # Display newtextareasfordev and additional variables for selected region, term, and school
  output$areasForDevDisplay_new <- renderDataTable({
    
    # Filter data based on user's selection
    filtered_data <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_lesson_new,                   # Filter by selected year
        Region_lesson == input$region_select_lesson_new,               # Filter by selected region
        term_lesson == input$term_select_lesson_new,                   # Filter by selected term
        if (input$school_select_lesson_new == "") {TRUE} else {school_lesson == input$school_select_lesson_new} # Filter by selected school if not empty
      )
    
    # Select the desired columns for display
    display_data <- filtered_data %>%
      select(
        subject = begin_group_RRNG5Kxfl_aa6_subject,
        class = begin_group_RRNG5Kxfl_aa7_class,
        gender = begin_group_RRNG5Kxfl_b1_sex,
        areas_for_development = newtextareasfordev
      )
    
    # Render the table
    DT::datatable(display_data, options = list(pageLength = 5, autoWidth = TRUE))
  })
  
  
  ##################summary insight for 2023/2024 academic year
  output$summary_text_new <- renderText({
    # Get the selected school
    selected_school1 <- input$school_select_lesson_new
    
    # Filter the data based on selected year, region, term, and school
    filtered_data_kk <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_lesson_new,       # Filter by selected year
        Region_lesson == input$region_select_lesson_new,   # Filter by selected region
        term_lesson == input$term_select_lesson_new,       # Filter by selected term
        school_lesson == selected_school1                  # Filter by selected school
      )
    
    # Compute the number of lessons observed
    num_lessons1 <- nrow(filtered_data_kk)
    
    # Compute the number of male and female teachers
    num_male_teachers1 <- nrow(filtered_data_kk[filtered_data_kk$begin_group_RRNG5Kxfl_b1_sex == "Male", ])
    num_female_teachers1 <- nrow(filtered_data_kk[filtered_data_kk$begin_group_RRNG5Kxfl_b1_sex == "Female", ])
    
    num1_year_1 <- nrow(filtered_data_kk[filtered_data_kk$begin_group_RRNG5Kxfl_aa7_class == "Year 1", ])
    num1_year_2 <- nrow(filtered_data_kk[filtered_data_kk$begin_group_RRNG5Kxfl_aa7_class == "Year 2", ])
    num1_year_3 <- nrow(filtered_data_kk[filtered_data_kk$begin_group_RRNG5Kxfl_aa7_class == "Year 3", ])
    
    # Construct the summary string
    summary_string_kk <- paste(num_lessons1, "lesson(s) were observed in", selected_school1, "for the selected academic year, region, and term.")
    
    if (num_male_teachers1 > 0) {
      summary_string_kk <- paste(summary_string_kk, num_male_teachers1, "male teacher(s) were observed.")
    }
    
    if (num_female_teachers1 > 0) {
      summary_string_kk <- paste(summary_string_kk, num_female_teachers1, "female teacher(s) were observed.")
    }
    
    if (num1_year_1 > 0) {
      summary_string_kk <- paste(summary_string_kk, num1_year_1, "year 1 lesson(s) were observed.")
    }
    
    if (num1_year_2 > 0) {
      summary_string_kk <- paste(summary_string_kk, num1_year_2, "year 2 lesson(s) were observed.")
    }
    
    if (num1_year_3 > 0) {
      summary_string_kk <- paste(summary_string_kk, num1_year_3, "year 3 lesson(s) were observed.")
    }
    
    return(summary_string_kk)
  })
  
  
  ##################################################################national server code lesson observation 2022/2023
  
  factor_names_nat <- c("Is the purpose of the lesson clearly stated in the lesson plan and focused on learners achieving the lesson learning outcomes?" = "lesson_purpose_old",
                        "Are the unique needs of female learners, male learners, and learners with special education needs adequately catered for in the lesson plan?" = "lesson_unique_needs_learners_old",
                        "Does the teacher maintain a positive and nonthreatening learning environment throughout the lesson?" = "lesson_teacher_positive_old",
                        "Are teaching/learning materials and other resources including being used to support learning of all categories of learners?" = "lesson_TLRs_old",
                        "Are learners engaged on tasks that challenge them and demonstrate the teacher’s high expectation of learner achievement?" = "lesson_learners_challenged_old",
                        "Is there evidence that students are learning?" = "lesson_students_learning_old",
                        "Is teaching differentiated to cater for the varied needs of all male learners, female learners, learners with special education needs etc?" = "lesson_teaching_differentiated_old",
                        "Does the teacher use real life examples which are familiar to learners to explain concepts and their relevance?" = "lesson_reallife_objects_old",
                        "Does the teacher point out or question traditional gender roles when they come up during the lessons as appropriate?" = "lesson_traditional_role_old",
                        "Does the lesson include appropriate interactive and creative approaches e.g., group work, role play, storytelling to support learners achieving the learning outcomes?" = "lesson_interactive_approaches_old",
                        "Have cross-cutting issues and /or 21st century skills been integrated in the lesson e.g., problem-solving, critical thinking, communication?" = "lesson_integrating_21stcentury_old",
                        "Does the teacher incorporate ICT into their practice to support learning?" = "lesson_integrating_ICT_old",
                        "Does the teacher encourage learners to ask questions during the lesson?" = "lesson_questioning_old",
                        "Evidence of assessment in the lesson" = "lesson_assessment_old",
                        "Do learners make use of feedback from teacher and peers?" = "lesson_feedback_old",
                        "Does the teacher evaluate the lesson against the learning outcomes?" = "lesson_evaluate_learning_outcome_old")
  
  columns_of_interest = unlist(factor_names_nat)
  
  percentage_data_2022_2023 <- reactive({
    lesson_data %>%
      select(all_of(unlist(factor_names_nat))) %>%
      pivot_longer(cols = everything(), names_to = "Factor", values_to = "Value") %>%
      group_by(Factor, Value) %>%
      tally() %>%
      spread(Value, n, fill = 0) %>%
      mutate(across(c("Yes", "In Part", "No"), ~ sprintf("%.2f%%", . / sum(c(Yes, `In Part`, No)) * 100))) %>%
      select(Factor, `Yes`, `In Part`, `No`)
  })
  
  output$summaryTableNational <- DT::renderDataTable({
    DT::datatable(percentage_data_2022_2023(), 
                  options = list(pageLength = 10, dom = 'rtip'),
                  rownames = FALSE,
                  class = 'cell-border stripe')
  })
  
  
  
  # Download handler remains the same
  output$downloadData_old <- downloadHandler(
    filename = function() {
      paste("lesson_data_new_results_22_23", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      # Call the reactive expression as a function
      table_data_less223 <-  percentage_data_2022_2023()
      write.csv(table_data_less223, file, row.names = FALSE)
    }
  )
  
  
  
  ########################################national level lesson observation for 2023/2024 academic year
  
  output$year_ui_nat_new <- renderUI({
    selectInput("year_select_nat_new", label = h4("Select an Academic Year"), 
                choices = unique(lesson_data_new$year_lesson), 
                selected = unique(lesson_data_new$year_lesson)[1])
  })
  
  output$term_ui_nat_new <- renderUI({
    selectInput("term_select_nat_new", label = h4("Select a Semester"), 
                choices = unique(lesson_data_new$term_lesson), 
                selected = unique(lesson_data_new$term_lesson)[2])
  })
  
  output$year_level_ui_nat <- renderUI({
    selectInput(
      inputId = "year_lesson_delivery_nat", 
      label = h4("Select the Year"), 
      choices = c("Overall", na.omit(unique(lesson_data_new$begin_group_RRNG5Kxfl_aa7_class))), 
      selected = "Overall"
    )
  })
  
  
  factor_names_nat_new <- c("Is the purpose of the lesson clearly stated in the lesson plan and focused on learners achieving the lesson learning outcomes?" = "lesson_purpose",
                            "Are the unique needs of female learners, male learners, and learners with special education needs adequately catered for in the lesson plan?" = "lesson_unique_needs_learners",
                            "Does the teacher maintain a positive and nonthreatening learning environment throughout the lesson?" = "lesson_teacher_positive",
                            "Are teaching/learning materials and other resources including ICT being used to support learning of all categories of learners?" = "lesson_TLRs",
                            "Are learners engaged on tasks that challenge them and demonstrate the teacher’s high expectation of learner achievement?" = "lesson_learners_challenged",
                            "Is there evidence that students are learning?" = "lesson_students_learning",
                            "Is teaching differentiated to cater for the varied needs of all male learners, female learners, learners with special education needs etc?" = "lesson_teaching_differentiated",
                            "Does the teacher use real life examples which are familiar to learners to explain concepts and their relevance?" = "lesson_reallife_objects",
                            "Does the teacher point out or question traditional gender roles when they come up during the lessons as appropriate?" = "lesson_traditional_role",
                            "Does the lesson include appropriate interactive and creative approaches e.g., group work, role play, storytelling to support learners achieving the learning outcomes?" = "lesson_interactive_approaches",
                            "Have cross-cutting issues and /or 21st century skills been integrated in the lesson e.g., problem-solving, critical thinking, communication?" = "lesson_integrating_21stcentury",
                            "Does the teacher incorporate ICT into their practice to support learning?" = "lesson_integrating_ICT",
                            "Does the teacher encourage learners to ask questions during the lesson?" = "lesson_questioning",
                            "Evidence of assessment in the lesson" = "lesson_assessment",
                            "Do learners make use of feedback from teacher and peers?" = "lesson_feedback",
                            "Does the teacher evaluate the lesson against the learning outcomes?" = "lesson_evaluate_learning_outcome",
                            "Does the teachers’ planning of lessons taught before the one observed show how they plan for learning over time, considering individual and group needs?" = "learning_overtime",
                            "Does the teacher pay attention to the composition of females and males during group work and assigns females leadership roles." = "composition_male_fem",
                            "Does the teacher provide constructive verbal feedback to both females and males and learners with special education needs?" = "constructive_male_fem",
                            "Does the teacher provide constructive written feedback to both females and males and learners with special education needs in their exercise book?" = "constructive_written_male_fem")
  
  columns_of_interest = unlist(factor_names_nat_new)
  
  percentage_data_2023_2024 <- reactive({
    lesson_data_new %>%
      filter(
        year_lesson == input$year_select_nat_new,       # Filter by selected year
        term_lesson == input$term_select_nat_new ,       # Filter by selected term
        if (input$year_lesson_delivery_nat != "Overall") begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_nat else TRUE  # Filter by Year Level
      ) %>%
      select(all_of(unlist(factor_names_nat_new))) %>%
      pivot_longer(cols = everything(), names_to = "Factor", values_to = "Value") %>%
      group_by(Factor, Value) %>%
      tally() %>%
      spread(Value, n, fill = 0) %>%
      mutate(across(c("Yes", "In Part", "No"), ~ sprintf("%.2f%%", . / sum(c(Yes, `In Part`, No)) * 100))) %>%
      select(Factor, `Yes`, `In Part`, `No`)
  })
  
  
  
  
  output$summaryTableNational_new <- DT::renderDataTable({
    DT::datatable(percentage_data_2023_2024(), 
                  options = list(pageLength = 25, dom = 'rtip'),
                  rownames = FALSE,
                  class = 'cell-border stripe')
  })
  
  
  # Download handler remains the same
  output$downloadData_new <- downloadHandler(
    filename = function() {
      paste("lesson_data_new_results_23_24", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      # Call the reactive expression as a function
      table_data_less234 <- percentage_data_2023_2024()
      write.csv(table_data_less234, file, row.names = FALSE)
    }
  )
  
  ############################################################################school code
  
  ##################summary insight for 2023/2024 academic year
  output$summary_text_new <- renderUI({
    # Get the selected school
    selected_school <- input$school_select_schl_new
    
    # Filter the data based on selected year, region, and school
    filtered_data <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_schl_new,
        Region_lesson == input$region_select_schl_new,
        school_lesson == input$school_select_schl_new
      )
    
    # Compute the number of lessons observed
    num_lessons <- nrow(filtered_data)
    
    # Return empty string if no data
    if (num_lessons == 0) {
      return(HTML("No lesson data available for the selected filters."))
    }
    
    # Compute the number of male and female teachers
    num_male_teachers <- sum(filtered_data$begin_group_RRNG5Kxfl_b1_sex == "Male", na.rm = TRUE)
    num_female_teachers <- sum(filtered_data$begin_group_RRNG5Kxfl_b1_sex == "Female", na.rm = TRUE)
    
    # Count lessons by year
    num_year_1 <- sum(filtered_data$begin_group_RRNG5Kxfl_aa7_class == "Year 1", na.rm = TRUE)
    num_year_2 <- sum(filtered_data$begin_group_RRNG5Kxfl_aa7_class == "Year 2", na.rm = TRUE)
    num_year_3 <- sum(filtered_data$begin_group_RRNG5Kxfl_aa7_class == "Year 3", na.rm = TRUE)
    
    # Count lessons by term (semester)
    num_first_sem <- sum(filtered_data$term_lesson == "First Semester", na.rm = TRUE)
    num_second_sem <- sum(filtered_data$term_lesson == "Second Semester", na.rm = TRUE)
    
    # Construct the summary string with improved formatting
    summary_parts <- c()
    
    # Main summary
    summary_parts <- c(summary_parts, paste0("<strong>", num_lessons, " lesson(s)</strong> were observed in <strong>", 
                                             selected_school, "</strong> for the selected academic year and region."))
    
    # Term breakdown
    term_text <- ""
    if (num_first_sem > 0 && num_second_sem > 0) {
      term_text <- paste0("<strong>", num_first_sem, "</strong> in First Semester and <strong>", 
                          num_second_sem, "</strong> in Second Semester.")
    } else if (num_first_sem > 0) {
      term_text <- paste0("All lessons were observed in First Semester.")
    } else if (num_second_sem > 0) {
      term_text <- paste0("All lessons were observed in Second Semester.")
    }
    
    if (term_text != "") {
      summary_parts <- c(summary_parts, term_text)
    }
    
    # Teacher gender breakdown
    if (num_male_teachers > 0 || num_female_teachers > 0) {
      teacher_text <- "Teacher breakdown: "
      if (num_male_teachers > 0) {
        teacher_text <- paste0(teacher_text, "<strong>", num_male_teachers, "</strong> male")
      }
      if (num_male_teachers > 0 && num_female_teachers > 0) {
        teacher_text <- paste0(teacher_text, " and ")
      }
      if (num_female_teachers > 0) {
        teacher_text <- paste0(teacher_text, "<strong>", num_female_teachers, "</strong> female")
      }
      teacher_text <- paste0(teacher_text, " teacher(s).")
      summary_parts <- c(summary_parts, teacher_text)
    }
    
    # Year level breakdown
    if (num_year_1 > 0 || num_year_2 > 0 || num_year_3 > 0) {
      year_text <- "Class year breakdown: "
      year_parts <- c()
      
      if (num_year_1 > 0) {
        year_parts <- c(year_parts, paste0("<strong>", num_year_1, "</strong> Year 1"))
      }
      if (num_year_2 > 0) {
        year_parts <- c(year_parts, paste0("<strong>", num_year_2, "</strong> Year 2"))
      }
      if (num_year_3 > 0) {
        year_parts <- c(year_parts, paste0("<strong>", num_year_3, "</strong> Year 3"))
      }
      
      year_text <- paste0(year_text, paste(year_parts, collapse = ", "), " lesson(s).")
      summary_parts <- c(summary_parts, year_text)
    }
    
    # Join all parts with line breaks for better readability
    HTML(paste(summary_parts, collapse = "<br><br>"))
  })
  
  
  
  
  
  
  
  
  ############## 
  
  observe({
    # Get the selected region
    selected_region <- input$region_select_schl_new
    
    # Filter schools based on the selected region
    filtered_schools <- lesson_data_new %>%
      filter(Region_lesson == selected_region) %>%
      pull(school_lesson) %>%
      unique()
    
    # Update the school selection input
    updateSelectInput(session, 
                      "school_select_schl_new", 
                      choices = filtered_schools,
                      selected = if(length(filtered_schools) > 0) filtered_schools[1] else NULL)
  })
  
  
  factor_names_schl_new <- list(
    "Percentage of lessons with clear objectives and structured planning" = c("lesson_purpose", "lesson_unique_needs_learners", "learning_overtime"),
    "Percentage of lessons using learner-centred and interactive teaching approaches" = c("lesson_learners_challenged","lesson_interactive_approaches", "lesson_teaching_differentiated", "lesson_reallife_objects"),
    "Percentage of lessons where ICT tools and resources are effectively used" = c("lesson_TLRs", "lesson_integrating_ICT"),
    "Percentage of lessons where teachers maintain an inclusive and engaging learning environment" = c("lesson_teacher_positive","constructive_male_fem", "composition_male_fem","lesson_questioning"),
    "Percentage of lessons where students demonstrate learning progress" = c("lesson_students_learning", "lesson_learners_challenged", "lesson_evaluate_learning_outcome"),
    "Percentage of lessons where teachers use assessment to guide learning and provide feedback" = c("lesson_assessment", "lesson_feedback", "lesson_evaluate_learning_outcome", "constructive_male_fem", "constructive_written_male_fem")
  )
  
  # Calculate summary scores for indicators
  compute_school_indicators <- function(data, mapping) {
    # Print debug information
    print(paste("Processing school with", nrow(data), "data points"))
    
    indicator_scores <- lapply(names(mapping), function(indicator) {
      selected_cols <- mapping[[indicator]]
      
      # Debug: Check which columns exist in the data
      existing_cols <- selected_cols[selected_cols %in% names(data)]
      missing_cols <- selected_cols[!selected_cols %in% names(data)]
      
      if (length(existing_cols) == 0) {
        print(paste("Indicator:", indicator, "- All columns missing:", paste(missing_cols, collapse=", ")))
        return(data.frame(Indicator = indicator, Score = NA_real_, stringsAsFactors = FALSE))
      }
      
      # Only use columns that exist in the data
      data_subset <- data[, existing_cols, drop = FALSE]
      
      # Count the number of "Yes", "In Part", and "No" values
      yes_count <- sum(data_subset == "Yes", na.rm = TRUE)
      in_part_count <- sum(data_subset == "In Part", na.rm = TRUE)
      no_count <- sum(data_subset == "No", na.rm = TRUE)
      total_responses <- yes_count + in_part_count + no_count
      
      # Debug
      print(paste("Indicator:", indicator))
      print(paste("  Yes count:", yes_count))
      print(paste("  In Part count:", in_part_count))
      print(paste("  No count:", no_count))
      print(paste("  Total valid responses:", total_responses))
      
      # Check if we have enough data
      if (total_responses < 3) {  # Set minimum threshold
        print(paste("  Too few responses:", total_responses))
        return(data.frame(Indicator = indicator, Score = NA_real_, stringsAsFactors = FALSE))
      }
      
      # Calculate percentage of "Yes" responses
      yes_percentage <- (yes_count / total_responses) * 100
      
      print(paste("  Yes percentage:", round(yes_percentage, 2), "%"))
      
      data.frame(Indicator = indicator, Score = round(yes_percentage, 2), stringsAsFactors = FALSE)
    })
    
    result <- do.call(rbind, indicator_scores)
    return(result)
  }
  
  
  percentage_difference_data_school <- reactive({
    # Retrieve semester 1 data
    data_semester1 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_schl_new,
        Region_lesson == input$region_select_schl_new,
        school_lesson == input$school_select_schl_new,
        term_lesson == "First Semester",
        (input$year_lesson_delivery_schl == "Overall" | begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_schl)
      )
    
    # Retrieve semester 2 data
    data_semester2 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_schl_new,
        Region_lesson == input$region_select_schl_new,
        school_lesson == input$school_select_schl_new,
        term_lesson == "Second Semester",
        (input$year_lesson_delivery_schl == "Overall" | begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_schl)
      )
    
    # Store sample sizes
    n_semester1 <- nrow(data_semester1)
    n_semester2 <- nrow(data_semester2)
    
    # Try to compute indicators with a lower threshold
    result_semester1 <- tryCatch(
      compute_school_indicators(data_semester1, factor_names_schl_new),
      error = function(e) {
        # Create a placeholder result if computation fails
        data.frame(
          Indicator = names(factor_names_schl_new),
          Score = rep(NA_real_, length(factor_names_schl_new)),
          stringsAsFactors = FALSE
        )
      }
    )
    
    # Attempt to compute second semester indicators
    result_semester2 <- tryCatch(
      compute_school_indicators(data_semester2, factor_names_schl_new),
      error = function(e) {
        # Create a placeholder result if computation fails
        data.frame(
          Indicator = names(factor_names_schl_new),
          Score = rep(NA_real_, length(factor_names_schl_new)),
          stringsAsFactors = FALSE
        )
      })
    
    # Merge results
    result_combined <- merge(
      result_semester1, 
      result_semester2, 
      by = "Indicator", 
      suffixes = c("_Sem1", "_Sem2"),
      all = TRUE
    )
    
    # Compute differences and format output
    result_combined <- result_combined %>%
      mutate(
        Difference = case_when(
          is.na(Score_Sem1) & is.na(Score_Sem2) ~ "📊 Not enough data points for analysis",
          is.na(Score_Sem1) ~ "📊 Few data points (Sem 1)",
          is.na(Score_Sem2) ~ "📊 Few data points (Sem 2)",
          TRUE ~ {
            diff_val <- round(Score_Sem2 - Score_Sem1, 2)
            case_when(
              diff_val > 0 ~ paste0("📈 +", diff_val, "%"),
              diff_val < 0 ~ paste0("📉 ", diff_val, "%"),
              TRUE ~ "📊 No Change"
            )
          }
        ),
        N_Sem1 = n_semester1,
        N_Sem2 = n_semester2
      )
    
    # Add N row
    n_row <- data.frame(
      Indicator = "N",
      Score_Sem1 = n_semester1,
      Score_Sem2 = n_semester2,
      Difference = "",
      N_Sem1 = n_semester1,
      N_Sem2 = n_semester2,
      stringsAsFactors = FALSE
    )
    
    # Combine original results with N row
    result_combined <- rbind(result_combined, n_row)
    
    return(result_combined)
  })
  
  # Modify data formatting to handle various data scenarios
  data_formatted_school <- reactive({
    data <- percentage_difference_data_school()
    
    # Check if all data are NA
    if (all(is.na(data$Score_Sem1) & is.na(data$Score_Sem2))) {
      return(NULL)  # Return NULL if no data at all
    }
    
    # Format data, handling the N row separately
    formatted_data <- data %>%
      mutate(
        `Semester One Result (%)` = ifelse(
          Indicator == "N", 
          as.character(N_Sem1), 
          ifelse(
            is.na(Score_Sem1), 
            "Few data points", 
            paste0(round(Score_Sem1, 2), "%")
          )
        ),
        `Semester Two Result (%)` = ifelse(
          Indicator == "N", 
          as.character(N_Sem2), 
          ifelse(
            is.na(Score_Sem2), 
            "Few data points", 
            paste0(round(Score_Sem2, 2), "%")
          )
        )
      ) %>%
      select(Indicator, `Semester One Result (%)`, `Semester Two Result (%)`, Difference)
    
    # Customize the N row appearance
    formatted_data$Indicator[formatted_data$Indicator == "N"] <- "Number of lessons observed (N)"
    
    return(formatted_data)
  })
  
  # Update school choices based on selected region
  observeEvent(input$region_select_schl_new, {
    # Filter schools based on selected region
    filtered_schools <- lesson_data_new %>%
      filter(Region_lesson == input$region_select_schl_new) %>%
      pull(school_lesson) %>%
      unique() %>%
      sort()
    
    # Update school selection dropdown
    updateSelectInput(session, "school_select_schl_new", 
                      choices = filtered_schools,
                      selected = filtered_schools[1])
  })
  
  # Render summary table with improved styling and export options
  output$summaryTableSchool_new <- DT::renderDataTable({
    req(nrow(data_formatted_school()) > 0)
    
    DT::datatable(
      data_formatted_school(),
      colnames = c("Indicator", "Semester One Result (%)", "Semester Two Result (%)", "Difference (%)"),
      extensions = 'Buttons',
      options = list(
        pageLength = 7,
        dom = 'Bfrtip',
        buttons = list(
          list(extend = 'copy', className = 'btn btn-outline-primary btn-sm'),
          list(extend = 'csv', className = 'btn btn-outline-success btn-sm'),
          list(extend = 'excel', className = 'btn btn-outline-info btn-sm'),
          list(extend = 'pdf', className = 'btn btn-outline-danger btn-sm'),
          list(extend = 'print', className = 'btn btn-outline-warning btn-sm')
        ),
        autoWidth = TRUE,
        columnDefs = list(
          list(className = 'dt-center', targets = c(1, 2, 3)),
          list(width = '40%', targets = 0)
        ),
        initComplete = DT::JS(
          "function(settings, json) {",
          "  $(this.api().table().header()).css({'background-color': '#f0f0f0', 'color': 'black', 'font-weight': 'bold'});",
          "}"
        )
      ),
      rownames = FALSE,
      class = 'display nowrap table-striped table-bordered compact' # Compact adds less padding
    ) %>%
      DT::formatStyle(
        "Difference",
        backgroundColor = DT::styleInterval(
          0, c("rgba(250, 128, 114, 0.5)", "rgba(144, 238, 144, 0.5)") # lighter colors with alpha
        ),
        color = DT::JS("value < 0 ? 'red' : 'green'"), # Red for negative, green for positive
        fontWeight = "bold",
        padding = "8px" # Reduced padding
      ) %>%
      DT::formatStyle(
        columns = names(data_formatted_school()),
        fontSize = "13px", # Slightly smaller font
        fontFamily = "Segoe UI, sans-serif", # modern font
        fontWeight = "500" # Less bold
      )
  })
  
  # Create a reactive trend data for the school level plot
  trend_data_school <- reactive({
    # Get the processed data from the table
    trend_df_school <- percentage_difference_data_school() %>%
      filter(Indicator != "N") %>% # Exclude the N row
      select(Indicator, Score_Sem1, Score_Sem2) %>%
      pivot_longer(cols = c("Score_Sem1", "Score_Sem2"), 
                   names_to = "Semester", 
                   values_to = "Score")
    
    # Rename semesters for better readability
    trend_df_school <- trend_df_school %>%
      mutate(Semester = case_when(
        Semester == "Score_Sem1" ~ "First Semester",
        Semester == "Score_Sem2" ~ "Second Semester"
      ))
    
    return(trend_df_school)
  })
  
  # Render the trend plot for school level
  output$trendPlot_school <- renderPlot({
    # Get trend data
    data_trend_school <- trend_data_school()
    
    # Validate if data exists
    req(nrow(data_trend_school) > 0)
    
    # Convert Semester into a factor for correct ordering
    data_trend_school$Semester <- factor(data_trend_school$Semester, levels = c("First Semester", "Second Semester"))
    
    # School name for the title
    school_name <- input$school_select_schl_new
    
    # Generate the trend plot
    ggplot(data_trend_school, aes(x = Semester, y = Score, group = Indicator, color = Indicator)) +
      geom_line(size = 1.2) +  # Line plot for trends
      geom_point(size = 3) +   # Highlight points for each semester
      labs(title = paste0("Lesson Observation Indicators for ", school_name), 
           x = "Semester", 
           y = "Average Score (%)",
           color = "Indicator") +  # Legend title
      theme_minimal() +
      theme(
        legend.position = "bottom",  # Move legend to bottom for better visualization
        axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels
        plot.title = element_text(face = "bold", size = 14),
        legend.text = element_text(size = 10)
      )
  })
  
  ##################################################################region analysis server code
  factor_names_reg_new <- list(
    "Percentage of lessons with clear objectives and structured planning" = c("lesson_purpose", "lesson_unique_needs_learners", "learning_overtime"),
    "Percentage of lessons using learner-centred and interactive teaching approaches" = c("lesson_learners_challenged","lesson_interactive_approaches", "lesson_teaching_differentiated", "lesson_reallife_objects"),
    "Percentage of lessons where ICT tools and resources are effectively used" = c("lesson_TLRs", "lesson_integrating_ICT"),
    "Percentage of lessons where teachers maintain an inclusive and engaging learning environment" = c("lesson_teacher_positive","constructive_male_fem", "composition_male_fem","lesson_questioning"),
    "Percentage of lessons where students demonstrate learning progress" = c("lesson_students_learning", "lesson_learners_challenged", "lesson_evaluate_learning_outcome"),
    "Percentage of lessons where teachers use assessment to guide learning and provide feedback" = c("lesson_assessment", "lesson_feedback", "lesson_evaluate_learning_outcome", "constructive_male_fem", "constructive_written_male_fem")
  )
  
  # Calculate summary scores for indicators
  compute_regional_indicators <- function(data, mapping) {
    
    # Print debug information
    print(paste("Processing school with", nrow(data), "data points"))
    
    indicator_scores <- lapply(names(mapping), function(indicator) {
      selected_cols <- mapping[[indicator]]
      
      # Debug: Check which columns exist in the data
      existing_cols <- selected_cols[selected_cols %in% names(data)]
      missing_cols <- selected_cols[!selected_cols %in% names(data)]
      
      if (length(existing_cols) == 0) {
        print(paste("Indicator:", indicator, "- All columns missing:", paste(missing_cols, collapse=", ")))
        return(data.frame(Indicator = indicator, Score = NA_real_, stringsAsFactors = FALSE))
      }
      
      # Only use columns that exist in the data
      data_subset <- data[, existing_cols, drop = FALSE]
      
      # Count the number of "Yes", "In Part", and "No" values
      yes_count <- sum(data_subset == "Yes", na.rm = TRUE)
      in_part_count <- sum(data_subset == "In Part", na.rm = TRUE)
      no_count <- sum(data_subset == "No", na.rm = TRUE)
      total_responses <- yes_count + in_part_count + no_count
      
      # Debug
      print(paste("Indicator:", indicator))
      print(paste("  Yes count:", yes_count))
      print(paste("  In Part count:", in_part_count))
      print(paste("  No count:", no_count))
      print(paste("  Total valid responses:", total_responses))
      
      # Check if we have enough data
      if (total_responses < 3) {  # Set minimum threshold
        print(paste("  Too few responses:", total_responses))
        return(data.frame(Indicator = indicator, Score = NA_real_, stringsAsFactors = FALSE))
      }
      
      # Calculate percentage of "Yes" responses
      yes_percentage <- (yes_count / total_responses) * 100
      
      print(paste("  Yes percentage:", round(yes_percentage, 2), "%"))
      
      data.frame(Indicator = indicator, Score = round(yes_percentage, 2), stringsAsFactors = FALSE)
    })
    
    result <- do.call(rbind, indicator_scores)
    return(result)
  }
  
  
  percentage_difference_data_regional <- reactive({
    # Retrieve semester 1 data
    data_semester1 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_reg_new,
        Region_lesson == input$region_select_reg_new,
        term_lesson == "First Semester",
        (input$year_lesson_delivery_reg == "Overall" | begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_reg)
      )
    
    # Retrieve semester 2 data
    data_semester2 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_reg_new,
        Region_lesson == input$region_select_reg_new,
        term_lesson == "Second Semester",
        (input$year_lesson_delivery_reg == "Overall" | begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_reg)
      )
    
    # Store sample sizes
    n_semester1 <- nrow(data_semester1)
    n_semester2 <- nrow(data_semester2)
    
    # Try to compute indicators with a lower threshold
    result_semester1 <- tryCatch(
      compute_regional_indicators(data_semester1, factor_names_reg_new),
      error = function(e) {
        # Create a placeholder result if computation fails
        data.frame(
          Indicator = names(factor_names_reg_new),
          Score = rep(NA_real_, length(factor_names_reg_new)),
          stringsAsFactors = FALSE
        )
      }
    )
    
    # Attempt to compute second semester indicators
    result_semester2 <- tryCatch(
      compute_regional_indicators(data_semester2, factor_names_reg_new),
      error = function(e) {
        # Create a placeholder result if computation fails
        data.frame(
          Indicator = names(factor_names_reg_new),
          Score = rep(NA_real_, length(factor_names_reg_new)),
          stringsAsFactors = FALSE
        )
      })
    
    # Merge results
    result_combined <- merge(
      result_semester1, 
      result_semester2, 
      by = "Indicator", 
      suffixes = c("_Sem1", "_Sem2"),
      all = TRUE
    )
    
    # Compute differences and format output
    result_combined <- result_combined %>%
      mutate(
        Difference = case_when(
          is.na(Score_Sem1) & is.na(Score_Sem2) ~ "📊 Not enough data points for analysis",
          is.na(Score_Sem1) ~ "📊 Few data points (Sem 1)",
          is.na(Score_Sem2) ~ "📊 Few data points (Sem 2)",
          TRUE ~ {
            diff_val <- round(Score_Sem2 - Score_Sem1, 2)
            case_when(
              diff_val > 0 ~ paste0("📈 +", diff_val, "%"),
              diff_val < 0 ~ paste0("📉 ", diff_val, "%"),
              TRUE ~ "📊 No Change"
            )
          }
        ),
        N_Sem1 = n_semester1,
        N_Sem2 = n_semester2
      )
    
    # Add N row
    n_row <- data.frame(
      Indicator = "N",
      Score_Sem1 = n_semester1,
      Score_Sem2 = n_semester2,
      Difference = "",
      N_Sem1 = n_semester1,
      N_Sem2 = n_semester2,
      stringsAsFactors = FALSE
    )
    
    # Combine original results with N row
    result_combined <- rbind(result_combined, n_row)
    
    return(result_combined)
  })
  
  # Modify data formatting to handle various data scenarios
  data_formatted_regional <- reactive({
    data <- percentage_difference_data_regional()
    
    # Check if all data are NA
    if (all(is.na(data$Score_Sem1) & is.na(data$Score_Sem2))) {
      return(NULL)  # Return NULL if no data at all
    }
    
    # Format data, handling the N row separately
    formatted_data <- data %>%
      mutate(
        `Semester One Result (%)` = ifelse(
          Indicator == "N", 
          as.character(N_Sem1), 
          ifelse(
            is.na(Score_Sem1), 
            "Few data points", 
            paste0(round(Score_Sem1, 2), "%")
          )
        ),
        `Semester Two Result (%)` = ifelse(
          Indicator == "N", 
          as.character(N_Sem2), 
          ifelse(
            is.na(Score_Sem2), 
            "Few data points", 
            paste0(round(Score_Sem2, 2), "%")
          )
        )
      ) %>%
      select(Indicator, `Semester One Result (%)`, `Semester Two Result (%)`, Difference)
    
    # Customize the N row appearance
    formatted_data$Indicator[formatted_data$Indicator == "N"] <- "Number of lessons observed (N)"
    
    return(formatted_data)
  })
  
  
  
  
  
  
  
  output$summaryTableRegional_new <- DT::renderDataTable({
    req(nrow(data_formatted_regional()) > 0)
    
    DT::datatable(
      data_formatted_regional(),
      colnames = c("Indicator", "Semester One Result (%)", "Semester Two Result (%)", "Difference (%)"),
      extensions = 'Buttons',
      options = list(
        pageLength = 7,
        dom = 'Bfrtip',
        buttons = list(
          list(extend = 'copy', className = 'btn btn-outline-primary btn-sm'),
          list(extend = 'csv', className = 'btn btn-outline-success btn-sm'),
          list(extend = 'excel', className = 'btn btn-outline-info btn-sm'),
          list(extend = 'pdf', className = 'btn btn-outline-danger btn-sm'),
          list(extend = 'print', className = 'btn btn-outline-warning btn-sm')
        ),
        autoWidth = TRUE,
        columnDefs = list(
          list(className = 'dt-center', targets = c(1, 2, 3)),
          list(width = '40%', targets = 0)
        ),
        initComplete = DT::JS(
          "function(settings, json) {",
          "  $(this.api().table().header()).css({'background-color': '#f0f0f0', 'color': 'black', 'font-weight': 'bold'});",
          "}"
        )
      ),
      rownames = FALSE,
      class = 'display nowrap table-striped table-bordered compact' # Compact adds less padding
    ) %>%
      DT::formatStyle(
        "Difference",
        backgroundColor = DT::styleInterval(
          0, c("rgba(250, 128, 114, 0.5)", "rgba(144, 238, 144, 0.5)") # lighter colors with alpha
        ),
        color = DT::JS("value < 0 ? 'red' : 'green'"), # Red for negative, green for positive
        fontWeight = "bold",
        padding = "8px" # Reduced padding
      ) %>%
      DT::formatStyle(
        columns = names(data_formatted_regional()),
        fontSize = "13px", # Slightly smaller font
        fontFamily = "Segoe UI, sans-serif", # modern font
        fontWeight = "500" # Less bold
      )
  })
  
  
  # Reactive function to format data for the trend plot
  trend_data_reg <- reactive({
    # Get the processed data from the table
    trend_df_reg <- data_formatted_regional() %>%
      select(Indicator, Score_Sem1, Score_Sem2) %>%
      pivot_longer(cols = c("Score_Sem1", "Score_Sem2"), 
                   names_to = "Semester", 
                   values_to = "Score")
    
    # Rename semesters for better readability
    trend_df_reg <- trend_df_reg %>%
      
      mutate(Semester = case_when(
        Semester == "Score_Sem1" ~ "First Semester",
        Semester == "Score_Sem2" ~ "Second Semester"
      ))
    
    return(trend_df_reg)
  })
  
  # Render the trend plot
  output$trendPlot_reg <- renderPlot({
    # Get trend data
    data_trend_reg <- trend_data_reg()
    
    # Validate if data exists
    req(nrow(data_trend_reg) > 0)
    
    # Convert Semester into a factor for correct ordering
    data_trend_reg$Semester <- factor(data_trend_reg$Semester, levels = c("First Semester", "Second Semester"))
    
    
    
    # Generate the trend plot
    ggplot(data_trend_reg, aes(x = Semester, y = Score, group = Indicator, color = Indicator)) +
      geom_line(size = 1.2) +  # Line plot for trends
      geom_point(size = 3) +   # Highlight points for each semester
      labs(title = "Trend of Lesson Observation Indicators Over Time", 
           x = "Semester", 
           y = "Average Score (%)",
           color = "Indicator") +  # Legend title
      theme_minimal() +
      theme(
        legend.position = "bottom",  # Move legend to bottom for better visualization
        axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels
        plot.title = element_text(face = "bold", size = 14),
        legend.text = element_text(size = 10)
      )
  })
  
  
  
  
  ############################################################################qualitative for region
  
  # Define theme categories for analysis
  # Enhanced Theme Categories for Lesson Observation Qualitative Analysis
  # These categories have been refined based on actual data from the lesson_data_new dataset
  
  theme_categories <- list(
    # Content Knowledge
    "Subject Matter Mastery" = c("subject matter", "content knowledge", "mastery over", "demonstrated mastery", 
                                 "subject content", "pedagogical content", "command of subject", "sound knowledge",
                                 "mastery of content", "concept explanation", "concepts clearly", "deep understanding",
                                 "subject expertise", "good knowledge", "mastery", "professional knowledge", "competence"),
    
    # Pedagogy and Teaching
    "Interactive Teaching Methods" = c("interactive", "learner centered", "child centered", "student centered", 
                                       "real life", "examples", "group work", "group discussion", "collaborative",
                                       "work in groups", "group activities", "pair work", "think pair", "share",
                                       "participatory", "discussions", "demonstration", "creative approaches",
                                       "interactive lesson", "interactive approach", "brainstorming", "role play"),
    
    # ICT Integration
    "ICT Integration" = c("ict tools", "ict integration", "incorporate ict", "integrate ict", "use of ict", 
                          "ict in lesson", "digital", "technology", "computer", "projector", "multimedia",
                          "audio visual", "video", "digital resources", "technology integration", "powerpoint",
                          "slides", "electronic", "laptop", "educational software", "digital content", "virtual"),
    
    # 21st Century Skills
    "21st Century Skills" = c("21st century", "century skills", "critical thinking", "problem solving", 
                              "creativity", "innovation", "communication skills", "collaboration", 
                              "global awareness", "digital literacy", "leadership", "productivity",
                              "social skills", "analytical", "reflective thinking", "computational thinking",
                              "creativity", "innovative", "critical thinkers", "problem solvers"),
    
    # Classroom Management
    "Classroom Management" = c("class control", "classroom management", "discipline", "class organization", 
                               "arranged", "seating arrangement", "classroom arrangement", "order", 
                               "behavior", "behaviour", "conducive", "environment", "learning environment",
                               "noise level", "classroom noise", "attention", "attentive", "focus",
                               "calm", "orderly", "organized", "clean", "classroom cleanliness"),
    
    # Student Engagement
    "Learner Engagement" = c("engaged learners", "student participation", "active participation", "actively involved",
                             "involvement", "engage students", "engagement", "interest", "motivation", "attentive", 
                             "enthusiastic", "eager", "captivated", "all learners", "active learners", "full participation",
                             "student interest", "motivated", "responsive", "answering questions", "asking questions",
                             "participation", "voluntary participation", "attention", "focused"),
    
    # Questioning Skills
    "Questioning Techniques" = c("questioning", "questions", "distribution of questions", "higher order", "open ended", 
                                 "probing", "thought provoking", "critical questions", "fair distribution", "distribute questions",
                                 "wait time", "varied questions", "challenging questions", "analytical questions", "question types",
                                 "question and answer", "questioning skills", "effective questioning", "inquiry", "follow-up questions"),
    
    # Assessment and Feedback
    "Assessment & Feedback" = c("assessment", "feedback", "evaluate", "evaluation", "formative assessment", 
                                "exercises", "assignments", "classwork", "homework", "diagnostic", "summative",
                                "checking understanding", "checking progress", "monitoring learning", "praise",
                                "constructive feedback", "positive reinforcement", "corrective feedback",
                                "immediate feedback", "peer assessment", "self assessment"),
    
    # Lesson Planning
    "Lesson Planning & Structure" = c("lesson plan", "planned", "structure", "organized", "sequence", "systematic", 
                                      "learning objectives", "objectives", "outcomes", "logical flow", "coherent",
                                      "step by step", "beginning middle end", "introduction development conclusion",
                                      "closure", "lesson closure", "lesson notes", "lesson preparation", "stages",
                                      "vetting", "lesson organization", "lesson delivery", "pacing", "time management"),
    
    # Teaching and Learning Resources
    "Teaching Resources & Materials" = c("tlrs", "tlm", "learning materials", "teaching materials", "resources", 
                                         "teaching aids", "learning resources", "teaching resources", "manipulatives",
                                         "visual aids", "charts", "models", "realia", "textbooks", "workbooks",
                                         "handouts", "worksheets", "board", "marker board", "chalk board", "illustrations",
                                         "diagrams", "learning materials", "concrete materials", "didactic materials"),
    
    # Communication Skills                            
    "Communication Skills" = c("communication", "clear explanation", "concise", "understandable", "voice projection", 
                               "audible voice", "audible", "clear voice", "articulate", "eloquent", "expressive",
                               "clarity", "clear instructions", "language use", "appropriate language", "simple language",
                               "vocabulary", "terminologies", "explanations", "pronunciation", "fluency", "confidence"),
    
    # Inclusion and Equity                         
    "Inclusion & Equity" = c("inclusion", "inclusive", "diversity", "gender", "equality", "equity", "gesi", 
                             "special needs", "differentiation", "individualized", "accommodations", "equal opportunities",
                             "fair treatment", "non-discrimination", "gender balance", "gender responsive", "gender sensitive",
                             "individual differences", "cultural sensitivity", "diverse learners", "learning styles"),
    
    # Pedagogical Content Knowledge
    "Pedagogical Skills" = c("pedagogy", "pedagogical", "teaching methods", "strategies", "approaches", "techniques", 
                             "methodologies", "instructional", "scaffolding", "pace", "instruction", "delivery",
                             "teaching style", "teaching approach", "facilitation", "guiding", "modelling",
                             "demonstration", "explanation", "presentation", "teaching skill", "teaching technique"),
    
    # Student-Teacher Relationship
    "Teacher-Learner Relationship" = c("rapport", "relationship", "friendly", "approachable", "respect", "trust", 
                                       "positive attitude", "caring", "supportive", "encouraging", "motivation", 
                                       "mentoring", "guidance", "interaction", "connection", "empathy", "understanding",
                                       "patience", "kind", "helpful", "courteous", "professional relationship")
  )
  
  
  
  #' Analyze qualitative text data to identify themes
  #' 
  #' @param text The text to analyze
  #' @param categories List of theme categories and their keywords
  #' @return Vector of identified themes
  analyze_themes <- function(text, categories) {
    if (is.na(text) || nchar(trimws(text)) == 0) {
      return(character(0))
    }
    
    text_lower <- tolower(text)
    found_themes <- character(0)
    
    for (theme_name in names(categories)) {
      keywords <- categories[[theme_name]]
      if (any(sapply(keywords, function(keyword) grepl(keyword, text_lower)))) {
        found_themes <- c(found_themes, theme_name)
      }
    }
    
    return(found_themes)
  }
  
  #' Extract representative quotes from text data
  #' 
  #' @param text_list List of text entries
  #' @param theme The theme to extract quotes for
  #' @param theme_categories List of theme categories with keywords
  #' @param max_quotes Maximum number of quotes to extract
  #' @return Character vector of representative quotes
  extract_theme_quotes <- function(text_list, theme, theme_categories, max_quotes = 3) {
    # Filter out empty or very short entries
    valid_texts <- text_list[sapply(text_list, function(x) !is.na(x) && nchar(trimws(x)) > 10)]
    
    if (length(valid_texts) == 0) {
      return(character(0))
    }
    
    # Score each text entry based on relevance to the theme
    theme_keywords <- theme_categories[[theme]]
    
    # Calculate relevance scores
    text_scores <- sapply(valid_texts, function(text) {
      text_lower <- tolower(text)
      # Count keyword matches
      keyword_matches <- sum(sapply(theme_keywords, function(keyword) {
        if (grepl(keyword, text_lower)) 1 else 0
      }))
      # Score is number of matches plus length factor (prefer shorter, focused quotes)
      score <- keyword_matches + (1 / log(nchar(text) + 10))
      return(score)
    })
    
    # Get top quotes by score
    if (length(text_scores) > 0) {
      # Sort by score
      sorted_indices <- order(text_scores, decreasing = TRUE)
      top_texts <- valid_texts[sorted_indices[1:min(max_quotes, length(sorted_indices))]]
      
      # Clean up the quotes
      clean_quotes <- sapply(top_texts, function(quote) {
        # Remove bullet points, numbering, etc.
        clean <- gsub("^[a-z0-9\\.\\)\\-•]+\\s*", "", quote)
        # Trim whitespace
        clean <- trimws(clean)
        # Ensure it ends with punctuation
        if (!grepl("[.!?]$", clean)) {
          clean <- paste0(clean, ".")
        }
        # Format as a quoted observation
        return(paste0('"', clean, '"'))
      })
      
      return(clean_quotes)
    }
    
    return(character(0))
  }
  
  #' Generate thematic analysis for filtered data
  #' 
  #' @param data Filtered dataframe with lesson observation data
  #' @param theme_categories List of theme categories
  #' @return List containing strength_themes and improvement_themes
  generate_thematic_analysis <- function(data, theme_categories) {
    if (nrow(data) == 0) {
      return(list(
        strength_themes = list(),
        improvement_themes = list()
      ))
    }
    
    # Initialize theme counters
    strength_themes <- sapply(names(theme_categories), function(x) 0)
    names(strength_themes) <- names(theme_categories)
    
    improvement_themes <- sapply(names(theme_categories), function(x) 0)
    names(improvement_themes) <- names(theme_categories)
    
    # Collect all text examples
    strength_texts <- character(0)
    improvement_texts <- character(0)
    
    # Analyze each observation
    for (i in 1:nrow(data)) {
      # Analyze strengths
      strength_text <- data$newtextstrength[i]
      if (!is.na(strength_text) && nchar(trimws(strength_text)) > 5) {
        themes <- analyze_themes(strength_text, theme_categories)
        strength_themes[themes] <- strength_themes[themes] + 1
        
        # Add to examples if it's meaningful
        if (nchar(strength_text) > 10 && !grepl("Vc|vc", strength_text)) {
          strength_texts <- c(strength_texts, strength_text)
        }
      }
      
      # Analyze areas for improvement
      dev_text <- data$newtextareasfordev[i]
      if (!is.na(dev_text) && nchar(trimws(dev_text)) > 5) {
        themes <- analyze_themes(dev_text, theme_categories)
        improvement_themes[themes] <- improvement_themes[themes] + 1
        
        # Add to examples if it's meaningful
        if (nchar(dev_text) > 10 && !grepl("^B$|^b$", dev_text)) {
          improvement_texts <- c(improvement_texts, dev_text)
        }
      }
    }
    
    # Calculate percentages
    total_observations <- nrow(data)
    
    # Get top strength themes (only those with mentions)
    strength_themes_filtered <- strength_themes[strength_themes > 0]
    sorted_strength_indices <- order(strength_themes_filtered, decreasing = TRUE)
    top_strength_themes <- names(strength_themes_filtered)[sorted_strength_indices]
    
    # Get top improvement themes (only those with mentions)
    improvement_themes_filtered <- improvement_themes[improvement_themes > 0]
    sorted_improvement_indices <- order(improvement_themes_filtered, decreasing = TRUE)
    top_improvement_themes <- names(improvement_themes_filtered)[sorted_improvement_indices]
    
    # Create strength theme summaries
    strength_summaries <- list()
    for (i in seq_along(top_strength_themes)[1:min(4, length(top_strength_themes))]) {
      theme <- top_strength_themes[i]
      count <- strength_themes[theme]
      percentage <- round((count / total_observations) * 100)
      
      # Extract representative quotes
      quotes <- extract_theme_quotes(strength_texts, theme, theme_categories)
      
      # Generate description based on frequency
      if (percentage >= 75) {
        description <- paste0("Most teachers demonstrated strong ", tolower(theme), ", effectively applying these skills in their lessons.")
      } else if (percentage >= 50) {
        description <- paste0("Many teachers showed good ", tolower(theme), ", which positively impacted student learning.")
      } else if (percentage >= 25) {
        description <- paste0("Some teachers displayed effective ", tolower(theme), ", though this was not consistent across all observations.")
      } else {
        description <- paste0("A few teachers exhibited ", tolower(theme), ", but this was not widely observed across classrooms.")
      }
      
      # Create numbered theme with emoji
      number_emoji <- c("1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣")[i]
      title <- paste(number_emoji, theme)
      
      strength_summaries[[i]] <- list(
        title = title,
        description = paste0("📌 ", description),
        evidence = paste0("💡 Supporting Evidence:"),
        quotes = quotes,
        percentage = percentage
      )
    }
    
    # Create improvement theme summaries
    improvement_summaries <- list()
    for (i in seq_along(top_improvement_themes)[1:min(4, length(top_improvement_themes))]) {
      theme <- top_improvement_themes[i]
      count <- improvement_themes[theme]
      percentage <- round((count / total_observations) * 100)
      
      # Extract representative quotes
      quotes <- extract_theme_quotes(improvement_texts, theme, theme_categories)
      
      # Generate description based on frequency
      if (percentage >= 75) {
        description <- paste0("Most teachers need significant improvement in ", tolower(theme), ". This is a critical area requiring immediate attention.")
      } else if (percentage >= 50) {
        description <- paste0("Many teachers would benefit from enhancing their ", tolower(theme), ". This presents an important development opportunity.")
      } else if (percentage >= 25) {
        description <- paste0("Some teachers should focus on improving their ", tolower(theme), ", as inconsistencies were observed in this area.")
      } else {
        description <- paste0("A few teachers need to strengthen their ", tolower(theme), ", though this was not a widespread concern.")
      }
      
      # Create numbered theme with emoji
      number_emoji <- c("1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣")[i]
      title <- paste(number_emoji, paste0("Enhancing ", theme))
      
      improvement_summaries[[i]] <- list(
        title = title,
        description = paste0("📌 ", description),
        evidence = paste0("💡 Supporting Evidence:"),
        quotes = quotes,
        percentage = percentage
      )
    }
    
    return(list(
      strength_themes = strength_summaries,
      improvement_themes = improvement_summaries
    ))
  }
  
  #' Format thematic analysis for display
  #' 
  #' @param analysis List containing thematic analysis results
  #' @param type Either "strengths" or "improvements"
  #' @return HTML formatted text for display
  format_thematic_display <- function(analysis, type = "strengths") {
    if (type == "strengths") {
      themes <- analysis$strength_themes
      title <- "Key strengths of teachers in the schools"
    } else {
      themes <- analysis$improvement_themes
      title <- "Areas that need improvement"
    }
    
    if (length(themes) == 0) {
      return("<p>No thematic analysis data available.</p>")
    }
    
    # Start with the title
    html <- paste0("<h4>", title, "</h4>")
    
    # Add each theme section
    for (theme in themes) {
      html <- paste0(html, 
                     "<div class='theme-section'>",
                     "<h5>", theme$title, " (", theme$percentage, "%)</h5>",
                     "<p>", theme$description, "</p>",
                     "<p>", theme$evidence, "</p>",
                     "<ul>")
      
      # Add quotes
      for (quote in theme$quotes) {
        html <- paste0(html, "<li>", quote, "</li>")
      }
      
      html <- paste0(html, "</ul></div>")
    }
    
    return(html)
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Process the qualitative data with the same filters as quantitative data
  qualitative_analysis <- reactive({
    # Apply the same filters used in your quantitative analysis
    filtered_data <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_reg_new,
        Region_lesson == input$region_select_reg_new,
        (input$year_lesson_delivery_reg == "Overall" | begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_reg)
      )
    
    # Generate the thematic analysis using the filtered data
    generate_thematic_analysis(filtered_data, theme_categories)
  })
  
  # Render thematic analysis output
  observe({
    # No need to get selected region separately as it's already filtered in qualitative_analysis()
    
    # Get the analysis result
    analysis_result <- qualitative_analysis()
    
    # Render the strength HTML output
    output$strengthsOutput_new_region <- renderUI({
      HTML(format_thematic_display(analysis_result, "strengths"))
    })
    
    # Render the development HTML output
    output$areasForDevOutput_new_region <- renderUI({
      HTML(format_thematic_display(analysis_result, "improvements"))
    })
  })
  
  
  
  #####################################school qualitative
  
  theme_categories_sch <- list(
    # Content Knowledge
    "Subject Matter Mastery" = c("subject matter", "content knowledge", "mastery over", "demonstrated mastery", 
                                 "subject content", "pedagogical content", "command of subject", "sound knowledge",
                                 "mastery of content", "concept explanation", "concepts clearly", "deep understanding",
                                 "subject expertise", "good knowledge", "mastery", "professional knowledge", "competence"),
    
    # Pedagogy and Teaching
    "Interactive Teaching Methods" = c("interactive", "learner centered", "child centered", "student centered", 
                                       "real life", "examples", "group work", "group discussion", "collaborative",
                                       "work in groups", "group activities", "pair work", "think pair", "share",
                                       "participatory", "discussions", "demonstration", "creative approaches",
                                       "interactive lesson", "interactive approach", "brainstorming", "role play"),
    
    # ICT Integration
    "ICT Integration" = c("ict tools", "ict integration", "incorporate ict", "integrate ict", "use of ict", 
                          "ict in lesson", "digital", "technology", "computer", "projector", "multimedia",
                          "audio visual", "video", "digital resources", "technology integration", "powerpoint",
                          "slides", "electronic", "laptop", "educational software", "digital content", "virtual"),
    
    # 21st Century Skills
    "21st Century Skills" = c("21st century", "century skills", "critical thinking", "problem solving", 
                              "creativity", "innovation", "communication skills", "collaboration", 
                              "global awareness", "digital literacy", "leadership", "productivity",
                              "social skills", "analytical", "reflective thinking", "computational thinking",
                              "creativity", "innovative", "critical thinkers", "problem solvers"),
    
    # Classroom Management
    "Classroom Management" = c("class control", "classroom management", "discipline", "class organization", 
                               "arranged", "seating arrangement", "classroom arrangement", "order", 
                               "behavior", "behaviour", "conducive", "environment", "learning environment",
                               "noise level", "classroom noise", "attention", "attentive", "focus",
                               "calm", "orderly", "organized", "clean", "classroom cleanliness"),
    
    # Student Engagement
    "Learner Engagement" = c("engaged learners", "student participation", "active participation", "actively involved",
                             "involvement", "engage students", "engagement", "interest", "motivation", "attentive", 
                             "enthusiastic", "eager", "captivated", "all learners", "active learners", "full participation",
                             "student interest", "motivated", "responsive", "answering questions", "asking questions",
                             "participation", "voluntary participation", "attention", "focused"),
    
    # Questioning Skills
    "Questioning Techniques" = c("questioning", "questions", "distribution of questions", "higher order", "open ended", 
                                 "probing", "thought provoking", "critical questions", "fair distribution", "distribute questions",
                                 "wait time", "varied questions", "challenging questions", "analytical questions", "question types",
                                 "question and answer", "questioning skills", "effective questioning", "inquiry", "follow-up questions"),
    
    # Assessment and Feedback
    "Assessment & Feedback" = c("assessment", "feedback", "evaluate", "evaluation", "formative assessment", 
                                "exercises", "assignments", "classwork", "homework", "diagnostic", "summative",
                                "checking understanding", "checking progress", "monitoring learning", "praise",
                                "constructive feedback", "positive reinforcement", "corrective feedback",
                                "immediate feedback", "peer assessment", "self assessment"),
    
    # Lesson Planning
    "Lesson Planning & Structure" = c("lesson plan", "planned", "structure", "organized", "sequence", "systematic", 
                                      "learning objectives", "objectives", "outcomes", "logical flow", "coherent",
                                      "step by step", "beginning middle end", "introduction development conclusion",
                                      "closure", "lesson closure", "lesson notes", "lesson preparation", "stages",
                                      "vetting", "lesson organization", "lesson delivery", "pacing", "time management"),
    
    # Teaching and Learning Resources
    "Teaching Resources & Materials" = c("tlrs", "tlm", "learning materials", "teaching materials", "resources", 
                                         "teaching aids", "learning resources", "teaching resources", "manipulatives",
                                         "visual aids", "charts", "models", "realia", "textbooks", "workbooks",
                                         "handouts", "worksheets", "board", "marker board", "chalk board", "illustrations",
                                         "diagrams", "learning materials", "concrete materials", "didactic materials"),
    
    # Communication Skills                            
    "Communication Skills" = c("communication", "clear explanation", "concise", "understandable", "voice projection", 
                               "audible voice", "audible", "clear voice", "articulate", "eloquent", "expressive",
                               "clarity", "clear instructions", "language use", "appropriate language", "simple language",
                               "vocabulary", "terminologies", "explanations", "pronunciation", "fluency", "confidence"),
    
    # Inclusion and Equity                         
    "Inclusion & Equity" = c("inclusion", "inclusive", "diversity", "gender", "equality", "equity", "gesi", 
                             "special needs", "differentiation", "individualized", "accommodations", "equal opportunities",
                             "fair treatment", "non-discrimination", "gender balance", "gender responsive", "gender sensitive",
                             "individual differences", "cultural sensitivity", "diverse learners", "learning styles"),
    
    # Pedagogical Content Knowledge
    "Pedagogical Skills" = c("pedagogy", "pedagogical", "teaching methods", "strategies", "approaches", "techniques", 
                             "methodologies", "instructional", "scaffolding", "pace", "instruction", "delivery",
                             "teaching style", "teaching approach", "facilitation", "guiding", "modelling",
                             "demonstration", "explanation", "presentation", "teaching skill", "teaching technique"),
    
    # Student-Teacher Relationship
    "Teacher-Learner Relationship" = c("rapport", "relationship", "friendly", "approachable", "respect", "trust", 
                                       "positive attitude", "caring", "supportive", "encouraging", "motivation", 
                                       "mentoring", "guidance", "interaction", "connection", "empathy", "understanding",
                                       "patience", "kind", "helpful", "courteous", "professional relationship")
  )
  
  
  
  # School-Level Thematic Analysis for Lesson Observations
  # This code implements a comprehensive thematic analysis of qualitative data
  # for individual schools, following a similar approach to the regional analysis
  
  library(dplyr)
  library(stringr)
  
  # We'll use the same enhanced theme categories from the regional analysis
  # theme_categories_sch is already defined from the regional analysis
  
  # ---- School-Level Analysis Function ----
  
  #' Generate thematic analysis for an individual school
  #' 
  #' @param data Filtered dataframe with lesson observation data for a specific school
  #' @param theme_categories_sch List of theme categories
  #' @param term_filter Optional term filter (e.g., "First Semester", "Second Semester", or NULL for all)
  #' @return List containing strength_themes and improvement_themes
  generate_school_thematic_analysis <- function(data, theme_categories_sch, term_filter = NULL) {
    # Apply term filter if specified
    if (!is.null(term_filter)) {
      data <- data %>% filter(term_lesson == term_filter)
    }
    
    # Check if we have enough data
    if (nrow(data) < 3) {
      return(list(
        school_name = if(nrow(data) > 0) data$school_lesson[1] else "Unknown",
        strength_themes = list(),
        improvement_themes = list(),
        insufficient_data = TRUE,
        observation_count = nrow(data)
      ))
    }
    
    # Initialize theme counters
    strength_themes <- sapply(names(theme_categories_sch), function(x) 0)
    names(strength_themes) <- names(theme_categories_sch)
    
    improvement_themes <- sapply(names(theme_categories_sch), function(x) 0)
    names(improvement_themes) <- names(theme_categories_sch)
    
    # Collect all text examples
    strength_texts <- character(0)
    improvement_texts <- character(0)
    
    # Analyze each observation
    for (i in 1:nrow(data)) {
      # Analyze strengths
      strength_text <- data$newtextstrength[i]
      if (!is.na(strength_text) && nchar(trimws(strength_text)) > 5) {
        themes <- analyze_themes(strength_text, theme_categories_sch)
        strength_themes[themes] <- strength_themes[themes] + 1
        
        # Add to examples if it's meaningful
        if (nchar(strength_text) > 10 && !grepl("Vc|vc", strength_text)) {
          strength_texts <- c(strength_texts, strength_text)
        }
      }
      
      # Analyze areas for improvement
      dev_text <- data$newtextareasfordev[i]
      if (!is.na(dev_text) && nchar(trimws(dev_text)) > 5) {
        themes <- analyze_themes(dev_text, theme_categories_sch)
        improvement_themes[themes] <- improvement_themes[themes] + 1
        
        # Add to examples if it's meaningful
        if (nchar(dev_text) > 10 && !grepl("^B$|^b$", dev_text)) {
          improvement_texts <- c(improvement_texts, dev_text)
        }
      }
    }
    
    # Calculate percentages
    total_observations <- nrow(data)
    
    # Get top strength themes (only those with mentions)
    strength_themes_filtered <- strength_themes[strength_themes > 0]
    sorted_strength_indices <- order(strength_themes_filtered, decreasing = TRUE)
    top_strength_themes <- names(strength_themes_filtered)[sorted_strength_indices]
    
    # Get top improvement themes (only those with mentions)
    improvement_themes_filtered <- improvement_themes[improvement_themes > 0]
    sorted_improvement_indices <- order(improvement_themes_filtered, decreasing = TRUE)
    top_improvement_themes <- names(improvement_themes_filtered)[sorted_improvement_indices]
    
    # Create strength theme summaries
    strength_summaries <- list()
    for (i in seq_along(top_strength_themes)[1:min(4, length(top_strength_themes))]) {
      theme <- top_strength_themes[i]
      count <- strength_themes[theme]
      percentage <- round((count / total_observations) * 100)
      
      # Extract representative quotes
      quotes <- extract_theme_quotes(strength_texts, theme, theme_categories_sch)
      
      # Generate school-specific description
      if (percentage >= 75) {
        description <- paste0("Most teachers in this school demonstrate strong ", tolower(theme), ".")
      } else if (percentage >= 50) {
        description <- paste0("Many teachers in this school show good ", tolower(theme), ".")
      } else if (percentage >= 25) {
        description <- paste0("Some teachers in this school display effective ", tolower(theme), ", though this is not consistent across all observations.")
      } else {
        description <- paste0("A few teachers in this school exhibit ", tolower(theme), ", but this is not widely observed.")
      }
      
      # Create numbered theme with emoji
      number_emoji <- c("1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣")[i]
      title <- paste(number_emoji, theme)
      
      strength_summaries[[i]] <- list(
        title = title,
        description = paste0("📌 ", description),
        evidence = paste0("💡 Supporting Evidence:"),
        quotes = quotes,
        percentage = percentage
      )
    }
    
    # Create improvement theme summaries
    improvement_summaries <- list()
    for (i in seq_along(top_improvement_themes)[1:min(4, length(top_improvement_themes))]) {
      theme <- top_improvement_themes[i]
      count <- improvement_themes[theme]
      percentage <- round((count / total_observations) * 100)
      
      # Extract representative quotes
      quotes <- extract_theme_quotes(improvement_texts, theme, theme_categories_sch)
      
      # Generate school-specific description
      if (percentage >= 75) {
        description <- paste0("Most lessons observed in this school need improvement in ", tolower(theme), ".")
      } else if (percentage >= 50) {
        description <- paste0("Many teachers in this school would benefit from enhancing their ", tolower(theme), ".")
      } else if (percentage >= 25) {
        description <- paste0("Some teachers in this school should focus on improving their ", tolower(theme), ".")
      } else {
        description <- paste0("A few teachers in this school need to strengthen their ", tolower(theme), ".")
      }
      
      # Create numbered theme with emoji
      number_emoji <- c("1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣")[i]
      title <- paste(number_emoji, paste0("Enhancing ", theme))
      
      improvement_summaries[[i]] <- list(
        title = title,
        description = paste0("📌 ", description),
        evidence = paste0("💡 Supporting Evidence:"),
        quotes = quotes,
        percentage = percentage
      )
    }
    
    # Get the school name from the data
    school_name <- data$school_lesson[1]
    
    return(list(
      school_name = school_name,
      strength_themes = strength_summaries,
      improvement_themes = improvement_summaries,
      insufficient_data = FALSE,
      observation_count = total_observations
    ))
  }
  
  #' Format school thematic analysis for display
  #' 
  #' @param analysis List containing thematic analysis results
  #' @param type Either "strengths" or "improvements"
  #' @return HTML formatted text for display
  format_school_thematic_display <- function(analysis, type = "strengths") {
    # Check if analysis is missing or NULL
    if (is.null(analysis)) {
      return("<div class='alert alert-warning'><p>No analysis data available.</p></div>")
    }
    
    # Check for insufficient data
    if (!is.null(analysis$insufficient_data) && analysis$insufficient_data) {
      return(paste0("<div class='alert alert-warning'>
                  <h4>Insufficient Data</h4>
                  <p>There are not enough lesson observations (", 
                    ifelse(is.null(analysis$observation_count), "0", analysis$observation_count), 
                    " available) to conduct a meaningful thematic analysis for this school. 
                  A minimum of 3 observations is required.</p></div>"))
    }
    
    # Safely get the themes
    if (type == "strengths") {
      themes <- analysis$strength_themes
      title <- paste0("Key strengths of teachers in ", 
                      ifelse(is.null(analysis$school_name), "this school", analysis$school_name))
    } else {
      themes <- analysis$improvement_themes
      title <- paste0("Areas that need improvement in ", 
                      ifelse(is.null(analysis$school_name), "this school", analysis$school_name))
    }
    
    # Check if themes is NULL or empty
    if (is.null(themes) || length(themes) == 0) {
      return(paste0("<div class='alert alert-info'>
                  <h4>No Themes Identified</h4>
                  <p>No significant ", type, " themes were identified from the available 
                  observations (", ifelse(is.null(analysis$observation_count), "0", analysis$observation_count), 
                    " lessons analyzed).</p></div>"))
    }
    
    # Start with the title
    html <- paste0("<h4>", title, "</h4>",
                   "<p class='text-muted'>Based on analysis of ", 
                   ifelse(is.null(analysis$observation_count), "multiple", analysis$observation_count), 
                   " lesson observations</p>")
    
    # Add each theme section
    for (theme in themes) {
      # Verify theme is not NULL
      if (is.null(theme)) {
        next
      }
      
      # Safely access theme properties
      theme_title <- ifelse(is.null(theme$title), "Unnamed Theme", theme$title)
      theme_percentage <- ifelse(is.null(theme$percentage), "?", theme$percentage)
      theme_description <- ifelse(is.null(theme$description), "", theme$description)
      theme_evidence <- ifelse(is.null(theme$evidence), "", theme$evidence)
      
      html <- paste0(html, 
                     "<div class='theme-section'>",
                     "<h5>", theme_title, " (", theme_percentage, "%)</h5>",
                     "<p>", theme_description, "</p>",
                     "<p>", theme_evidence, "</p>",
                     "<ul>")
      
      # Add quotes, checking if they exist
      if (!is.null(theme$quotes) && length(theme$quotes) > 0) {
        for (quote in theme$quotes) {
          html <- paste0(html, "<li>", quote, "</li>")
        }
      } else {
        html <- paste0(html, "<li>No specific examples available.</li>")
      }
      
      html <- paste0(html, "</ul></div>")
    }
    
    return(html)
  }
  # ---- Server Logic for School-Level Analysis ----
  
  # Reactive function to generate school thematic analysis
  school_qualitative_analysis <- reactive({
    # Get the filtered data
    filtered_data <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_schl_new,
        Region_lesson == input$region_select_schl_new,
        school_lesson == input$school_select_schl_new,
        (input$year_lesson_delivery_schl == "Overall" | begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_schl)
      )
    
    # Debug: Print info about filtered data
    print(paste("Filtered rows:", nrow(filtered_data)))
    
    # Rest of your function...
    
    
    # Generate separate analyses for each semester if requested
    if (input$show_semester_comparison_schl) {
      # Semester 1 analysis
      semester1_analysis <- generate_school_thematic_analysis(
        filtered_data, 
        theme_categories_sch, 
        term_filter = "First Semester"
      )
      
      # Semester 2 analysis
      semester2_analysis <- generate_school_thematic_analysis(
        filtered_data, 
        theme_categories_sch, 
        term_filter = "Second Semester"
      )
      
      return(list(
        combined = generate_school_thematic_analysis(filtered_data, theme_categories_sch),
        semester1 = semester1_analysis,
        semester2 = semester2_analysis,
        show_semesters = TRUE
      ))
    } else {
      # Combined analysis (all data)
      return(list(
        combined = generate_school_thematic_analysis(filtered_data, theme_categories_sch),
        show_semesters = FALSE
      ))
    }
  })
  
  # Render the school thematic analysis outputs
  # Modify the renderUI block to handle potential NULL values
  output$strengthsOutput_schl_new <- renderUI({
    analysis_result <- school_qualitative_analysis()
    
    # Check if analysis_result is NULL or missing components
    if (is.null(analysis_result)) {
      return(HTML("<div class='alert alert-warning'>No analysis data available.</div>"))
    }
    
    show_semesters <- !is.null(analysis_result$show_semesters) && analysis_result$show_semesters
    
    if (show_semesters) {
      # Make sure semester objects exist
      if (is.null(analysis_result$semester1) || is.null(analysis_result$semester2)) {
        return(HTML("<div class='alert alert-warning'>Semester data is missing.</div>"))
      }
      
      # Show semester comparison
      HTML(paste0(
        "<div class='row'>",
        
        # Semester 1
        "<div class='col-md-6'>",
        "<div class='panel panel-primary'>",
        "<div class='panel-heading'><h4 class='panel-title'>First Semester</h4></div>",
        "<div class='panel-body'>",
        format_school_thematic_display(analysis_result$semester1, "strengths"),
        "</div>",
        "</div>",
        "</div>",
        
        # Semester 2
        "<div class='col-md-6'>",
        "<div class='panel panel-primary'>",
        "<div class='panel-heading'><h4 class='panel-title'>Second Semester</h4></div>",
        "<div class='panel-body'>",
        format_school_thematic_display(analysis_result$semester2, "strengths"),
        "</div>",
        "</div>",
        "</div>",
        
        "</div>"
      ))
    } else {
      # Make sure combined analysis exists
      if (is.null(analysis_result$combined)) {
        return(HTML("<div class='alert alert-warning'>Combined analysis data is missing.</div>"))
      }
      
      # Show combined analysis
      HTML(format_school_thematic_display(analysis_result$combined, "strengths"))
    }
  })
  
  
  output$areasForDevOutput_schl_new <- renderUI({
    analysis_result <- school_qualitative_analysis()
    
    if (analysis_result$show_semesters) {
      # Show semester comparison
      HTML(paste0(
        "<div class='row'>",
        
        # Semester 1
        "<div class='col-md-6'>",
        "<div class='panel panel-primary'>",
        "<div class='panel-heading'><h4 class='panel-title'>First Semester</h4></div>",
        "<div class='panel-body'>",
        format_school_thematic_display(analysis_result$semester1, "improvements"),
        "</div>",
        "</div>",
        "</div>",
        
        # Semester 2
        "<div class='col-md-6'>",
        "<div class='panel panel-primary'>",
        "<div class='panel-heading'><h4 class='panel-title'>Second Semester</h4></div>",
        "<div class='panel-body'>",
        format_school_thematic_display(analysis_result$semester2, "improvements"),
        "</div>",
        "</div>",
        "</div>",
        
        "</div>"
      ))
    } else {
      # Show combined analysis
      HTML(format_school_thematic_display(analysis_result$combined, "improvements"))
    }
  })
  
  # ---- UI Component for School-Level Thematic Analysis ----
  # Add this to your UI to create the themed display
  
  # Add a toggle for semester comparison
  output$semester_comparison_toggle_ui <- renderUI({
    checkboxInput("show_semester_comparison_schl", 
                  "Show semester comparison", 
                  value = FALSE)
  })
  
  
  
  
  
  ###############################################################################################################################################
  ################################################################################################################################################
  ##############################################################################################################################################
  #2024/2025 lesson observation server code
  
  ##################################################################################################
  
  ############################################GUIDANCE AND COUNSELLING SECTION OF THE DASHBOARD
  
  
  output$navigation_buttons <- renderUI({
    div(
      style = "text-align: center;",
      actionButton("prev_submission", "← Previous Submission"),
      actionButton("next_submission", "Next Submission →")
    )
  })
  
  output$selectRegion_gcc <- renderUI({
    selectInput("regionInput_gcc", "Select Region:", choices = unique(gcc_objectives$Region_gcc_obj))
  })
  
  output$selectSchool_gcc <- renderUI({
    if (!is.null(input$regionInput_gcc)) {
      schools_in_region_gcc <- unique(gcc_objectives$Name_school_gcc_obj[gcc_objectives$Region_gcc_obj == input$regionInput_gcc])
      selectInput("schoolInput_gcc", "Select School:", choices = schools_in_region_gcc)
    }
  })
  
  output$data_table <- renderDataTable({
    req(input$regionInput_gcc, input$schoolInput_gcc)
    
    filtered_objectives <- gcc_objectives %>%
      filter(Region_gcc_obj == input$regionInput_gcc & Name_school_gcc_obj == input$schoolInput_gcc)
    
    if (nrow(filtered_objectives) == 0) {
      return(datatable(data.frame(Objectives = character(0)), options = list(pageLength = 10, autoWidth = TRUE)))
    }
    
    areas <- c("Academic Support", "Career and Tertiary Support", "Psychosocial Support", "Guidance Service")
    previous_area <- NULL
    df_list <- lapply(areas, function(area) {
      vars_info <- getAreaVariables(area)
      
      objective_vars <- intersect(vars_info$objectives, names(filtered_objectives))
      objectives <- filtered_objectives %>%
        select(all_of(objective_vars)) %>%
        pivot_longer(cols = everything(), names_to = "Objective_name", values_to = "Objectives") %>%
        arrange(Objective_name) %>%
        pull(Objectives)
      
      latest_data_gcc <- gcc_data %>%
        filter(Region_gcc == input$regionInput_gcc & Name_school_gcc == input$schoolInput_gcc) %>%
        mutate(endtime = lubridate::ymd_hms(endtime)) %>%
        group_by(Name_school_gcc) %>%
        slice(which.max(endtime)) %>%
        ungroup()
      
      targets <- map_chr(intersect(vars_info$activities, names(latest_data_gcc)), ~ paste(latest_data_gcc[[.]], collapse = ", "))
      outcomes <- map_chr(intersect(vars_info$outcomes, names(latest_data_gcc)), ~ paste(latest_data_gcc[[.]], collapse = ", "))
      ratings <- map_chr(intersect(vars_info$ratings, names(latest_data_gcc)), ~ paste(latest_data_gcc[[.]], collapse = ", "))
      
      area_display <- if (is.null(previous_area) || previous_area != area) area else ""
      previous_area <<- area
      
      data.frame(
        Thematic_Area = area_display,
        Objectives = objectives,
        Activities_Implemented = ifelse(targets == "" | targets == "NA", NA, targets),
        Results = ifelse(outcomes == "" | outcomes == "NA", NA, outcomes),
        Ratings = ifelse(ratings == "" | ratings == "NA", NA, ratings),
        stringsAsFactors = FALSE
      )
    })
    
    df <- do.call(rbind, df_list)
    
    # Explicit filtering of rows where Activities Implemented, Results, and Ratings are all NA or empty
    df <- df %>%
      filter(!(is.na(Activities_Implemented) & is.na(Results) & is.na(Ratings)))
    
    # Rename columns
    colnames(df) <- c("Thematic Area", "Objectives", "Activities Implemented", "Results", "Ratings")
    
    datatable(df, extensions = 'Buttons', options = list(
      pageLength = 10, 
      autoWidth = TRUE, 
      columnDefs = list(list(className = 'dt-center', targets = '_all')),
      order = list(list(0, 'asc')),  # Ordering by the first column (Thematic Area)
      rowGroup = list(dataSrc = 'Thematic Area'),  # Grouping by the first column (Thematic Area)
      dom = 'Bfrtip',  # Adding buttons for exporting and printing
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
      scrollX = TRUE,
      initComplete = JS(
        "function(settings, json) {",
        "$(this.api().table().header()).css({'background-color': '#f2feea', 'color': '#000000'});",
        "}"
      )
    ), escape = FALSE) %>%
      formatStyle(columns = 1:ncol(df), 
                  `border` = 'solid 1px #dddddd',
                  `padding` = '3px',
                  `background-color` = '#FFFFFF',
                  `color` = '#000000') %>%
      formatStyle(1:ncol(df), 
                  `border` = 'solid 1px #dddddd',
                  fontWeight = 'bold') %>%
      formatStyle(
        'Ratings',
        backgroundColor = styleEqual(
          c('Achieved', 'Partially Achieved', 'Not Achieved'),
          c('green', 'gold', 'orange')
        ),
        color = styleEqual(
          c('Achieved', 'Partially Achieved', 'Not Achieved'),
          c('white', 'black', 'white')
        )
      )
  })
  
  
  # Function to return all variables for an area
  getAreaVariables <- function(area) {
    list(
      objectives = switch(area,
                          "Academic Support" = c("area_1_academic_activities_objective1_obj", "area_1_academic_activities_objective2_obj", "area_1_academic_activities_objective3_obj"),
                          "Career and Tertiary Support" = c("area_2_career_objective1_obj", "area_2_career_objective2_obj", "area_2_career_objective3_obj"),
                          "Psychosocial Support" = c("objective_3_psychosocial_objective1_obj", "objective_3_psychosocial_objective2_obj", "objective_3_psychosocial_objective3_obj"),
                          "Guidance Service" = c("objective_4_guidance_objective1_obj", "objective_4_guidance_objective2_obj", "objective_4_guidance_objective3_obj")
      ),
      activities = switch(area,
                          "Academic Support" = c("area_1_academic_activities_activities_implemented", "area_1_academic_activities_activities2_implemented", "area_1_academic_activities_activities3_implemented"),
                          "Career and Tertiary Support" = c("area_2_career_activities_activities_implemented", "area_2_career_activities_activities_implemented2", "area_2_career_activities_activities_implemented3"),
                          "Psychosocial Support" = c("objective_3_psychosocial_activities_activities_implemented", "objective_3_psychosocial_activities_activities_implemented2", "objective_3_psychosocial_activities_activities_implemented3"),
                          "Guidance Service" = c("objective_4_guidance_activities_activities_implemented", "objective_4_guidance_activities_activities_implemented2", "objective_4_guidance_activities_activities_implemented3")
      ),
      outcomes = switch(area,
                        "Academic Support" = c("area_1_academic_activities_progress_obj1", "area_1_academic_activities_progress_obj2", "area_1_academic_activities_progress_obj3"),
                        "Career and Tertiary Support" = c("area_2_career_progress_obj1", "area_2_career_progress_obj2", "area_2_career_progress_obj3"),
                        "Psychosocial Support" = c("objective_3_psychosocial_progress_obj1", "objective_3_psychosocial_progress_obj2", "objective_3_psychosocial_progress_obj3"),
                        "Guidance Service" = c("objective_4_guidance_progress_obj1", "objective_4_guidance_progress_obj2", "objective_4_guidance_progress_obj3")
      ),
      ratings = switch(area,
                       "Academic Support" = c("area_1_academic_activities_rating_obj1", "area_1_academic_activities_rating_obj2", "area_1_academic_activities_rating_obj3"),
                       "Career and Tertiary Support" = c("area_2_career_rating_obj1", "area_2_career_rating_obj2", "area_2_career_rating_obj3"),
                       "Psychosocial Support" = c("objective_3_psychosocial_rating_obj1", "objective_3_psychosocial_rating_obj2", "objective_3_psychosocial_rating_obj3"),
                       "Guidance Service" = c("objective_4_guidance_rating_obj1", "objective_4_guidance_rating_obj2", "objective_4_guidance_rating_obj3")
      )
    )
  }
  
  
  output$latestDateBox_gcc <- renderText({
    req(input$regionInput_gcc, input$schoolInput_gcc)  # Ensure the required inputs are selected
    
    # Fetch the data filtered by the selected region and school
    school_data_gcc <- gcc_data[gcc_data$Region_gcc == input$regionInput_gcc &
                                  gcc_data$Name_school_gcc == input$schoolInput_gcc, ]
    
    # Parse endtime to find the latest entry
    if (nrow(school_data_gcc) > 0) {
      school_data_gcc$endtime <- lubridate::ymd_hms(school_data_gcc$endtime)
      latest_date_gcc <- max(school_data_gcc$endtime)
      
      # Format the latest date for display
      formatted_date <- format(latest_date_gcc, "%Y-%m-%d %H:%M:%S")
      paste("The dashboard is currently visualising the latest submission for each school.", 
            input$schoolInput_gcc, "submitted their latest GCC data on:", formatted_date,".", 
            "Please use the date range below to see previous submissions made.")
    } else {
      "No submissions found for the selected school and region."
    }
  })
  
  
  # Function to return all variables for an area
  getAreaVariables <- function(area) {
    list(
      objectives = switch(area,
                          "Academic Support" = c("area_1_academic_activities_objective1_obj", "area_1_academic_activities_objective2_obj", "area_1_academic_activities_objective3_obj"),
                          "Career and Tertiary Support" = c("area_2_career_objective1_obj", "area_2_career_objective2_obj", "area_2_career_objective3_obj"),
                          "Psychosocial Support" = c("objective_3_psychosocial_objective1_obj", "objective_3_psychosocial_objective2_obj", "objective_3_psychosocial_objective3_obj"),
                          "Guidance Service" = c("objective_4_guidance_objective1_obj", "objective_4_guidance_objective2_obj", "objective_4_guidance_objective3_obj")
      ),
      activities = switch(area,
                          "Academic Support" = c("area_1_academic_activities_activities_implemented", "area_1_academic_activities_activities2_implemented", "area_1_academic_activities_activities3_implemented"),
                          "Career and Tertiary Support" = c("area_2_career_activities_activities_implemented", "area_2_career_activities_activities_implemented2", "area_2_career_activities_activities_implemented3"),
                          "Psychosocial Support" = c("objective_3_psychosocial_activities_activities_implemented", "objective_3_psychosocial_activities_activities_implemented2", "objective_3_psychosocial_activities_activities_implemented3"),
                          "Guidance Service" = c("objective_4_guidance_activities_activities_implemented", "objective_4_guidance_activities_activities_implemented2", "objective_4_guidance_activities_activities_implemented3")
      ),
      outcomes = switch(area,
                        "Academic Support" = c("area_1_academic_activities_progress_obj1", "area_1_academic_activities_progress_obj2", "area_1_academic_activities_progress_obj3"),
                        "Career and Tertiary Support" = c("area_2_career_progress_obj1", "area_2_career_progress_obj2", "area_2_career_progress_obj3"),
                        "Psychosocial Support" = c("objective_3_psychosocial_progress_obj1", "objective_3_psychosocial_progress_obj2", "objective_3_psychosocial_progress_obj3"),
                        "Guidance Service" = c("objective_4_guidance_progress_obj1", "objective_4_guidance_progress_obj2", "objective_4_guidance_progress_obj3")
      ),
      ratings = switch(area,
                       "Academic Support" = c("area_1_academic_activities_rating_obj1", "area_1_academic_activities_rating_obj2", "area_1_academic_activities_rating_obj3"),
                       "Career and Tertiary Support" = c("area_2_career_rating_obj1", "area_2_career_rating_obj2", "area_2_career_rating_obj3"),
                       "Psychosocial Support" = c("objective_3_psychosocial_rating_obj1", "objective_3_psychosocial_rating_obj2", "objective_3_psychosocial_rating_obj3"),
                       "Guidance Service" = c("objective_4_guidance_rating_obj1", "objective_4_guidance_rating_obj2", "objective_4_guidance_rating_obj3")
      )
    )
  }
  
  
  
  
  output$latestDateBox_gcc <- renderText({
    req(input$regionInput_gcc, input$schoolInput_gcc)  # Ensure the required inputs are selected
    
    # Fetch the data filtered by the selected region and school
    school_data_gcc <- gcc_data[gcc_data$Region_gcc == input$regionInput_gcc &
                                  gcc_data$Name_school_gcc == input$schoolInput_gcc, ]
    
    # Parse endtime to find the latest entry
    if (nrow(school_data_gcc) > 0) {
      school_data_gcc$endtime <- lubridate::ymd_hms(school_data_gcc$endtime)
      latest_date_gcc <- max(school_data_gcc$endtime)
      
      # Format the latest date for display
      formatted_date <- format(latest_date_gcc, "%Y-%m-%d %H:%M:%S")
      paste("The dashboard is currently visualising the latest submission for each school.", 
            input$schoolInput_gcc, "submitted their latest GCC data on:", formatted_date,".", 
            "Please use the date range below to see previous submissions made.")
    } else {
      "No submissions found for the selected school and region."
    }
  })
  
  
  
  
  #########################################################################data download server code
  
  
  
  # Render national summary table
  output$nationalSummaryTable <- renderDT({
    national_summary <- sexual_data %>%
      group_by(Region_SH) %>%
      summarise(
        Region_Count = n(),
        Module1_Assessment_Completed = sum(Module1_Assessment == "Completed"),
        Module2_Assessment_Completed = sum(Module2_Assessment == "Completed"),
        Module3_Assessment_Completed = sum(Module3_Assessment == "Completed"),
        Overall_Completed = sum(Overall_completion == "Completed")
      )
    
    datatable(
      national_summary,
      colnames = c(
        "Region", "Number of teachers who have enrolled for the training", "Number of teachers who completed module 1", 
        "Number of teachers who completed module 2", "Number of teachers who completed module 3", 
        "Number of teachers who completed all three modules"
      ),
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        pageLength = 20,
        lengthMenu = c(5, 10, 15, 20, 25, 30),
        autoWidth = TRUE,
        initComplete = JS(
          "function(settings, json) {",
          "$(this.api().table().header()).css({'background-color': '#336699', 'color': '#ffffff'});",
          "}"
        ),
        title = "National Summary of Sexual Harassment Training",
        drawCallback = JS("function(settings) {",
                          "var api = this.api();",
                          "var nrows = api.page.info().recordsDisplay;",
                          "var ncols = api.columns().nodes().length;",
                          "$('#' + settings.sTableId + '_wrapper').append('<div class=\"footnote\">Footnote: This table summarises the completion status of Sexual Harassment Training modules across regions.</div>');",
                          "}")
      )
    ) %>%
      formatStyle(
        columns = 1:6,
        backgroundColor = "white",
        color = "black",
        border = "1px solid #336699",
        fontSize = "14px"
      ) %>%
      formatStyle(
        columns = 0,
        fontWeight = "bold"
      )
  })
  
  
  ##########################Priority schools section of report
  
  # Dynamic UI for region selection
  output$selectRegion <- renderUI({
    selectInput("regionInput", "Select Region:", 
                choices = unique(priority_objectives$Region_sip_obj),
                selected = "Greater Accra")  # Set default selection to Greater Accra
  })
  
  
  # Dynamic UI for school selection based on selected region
  output$selectSchool <- renderUI({
    if (!is.null(input$regionInput)) {
      schools_in_region <- unique(priority_objectives$Name_school_sip_obj[priority_objectives$Region_sip_obj == input$regionInput])
    } else {
      schools_in_region <- NULL
    }
    selectInput("schoolInput", "Select School:", choices = schools_in_region)
  })
  
  output$objectivesTable <- DT::renderDataTable({
    req(input$regionInput, input$schoolInput, input$dateRange)  # Ensure all inputs are selected
    
    # Fetch the row corresponding to the selected region and school from objectives data
    selected_objective_data <- priority_objectives[priority_objectives$Region_sip_obj == input$regionInput &
                                                     priority_objectives$Name_school_sip_obj == input$schoolInput, ]
    if (nrow(selected_objective_data) == 0) return(NULL)  # Check if data is available
    
    # Filter priority_data for the selected region and school
    school_data <- priority_data[priority_data$Region_sip == input$regionInput & 
                                   priority_data$Name_school_sip == input$schoolInput, ]
    
    # Convert the endtime to POSIXct format to find the latest entry
    school_data$endtime <- lubridate::ymd_hms(school_data$endtime)
    school_data <- school_data[school_data$endtime >= input$dateRange[1] & 
                                 school_data$endtime <= input$dateRange[2], ]
    
    # Find the row with the latest endtime
    latest_data <- school_data[which.max(school_data$endtime), ]
    
    # Proceed if data exists
    if (nrow(latest_data) > 0) {
      # Create a list of objectives with their targets, progress, ratings, and evidence
      objectives_list <- list(
        list(
          objective = paste("<b>1</b><br>", selected_objective_data$objective_1_objective_1_name_obj),
          targets = c(selected_objective_data$objective_1_ob1_target_1_obj, selected_objective_data$objective_1_ob1_target_2_obj, selected_objective_data$objective_1_ob1_target_3_obj),
          progress = c(latest_data$objective_1_ob1_target1_progress, latest_data$objective_1_ob1_target2_progress, latest_data$objective_1_ob1_target3_progress),
          ratings = c(latest_data$objective_1_ob1_target1_rating, latest_data$objective_1_ob1_target2_rating, latest_data$objective_1_ob1_target3_rating),
          evidence = latest_data$evidence_obj1
        ),
        list(
          objective = paste("<b>2</b><br>", selected_objective_data$objective_2_objective_2_name_obj),
          targets = c(selected_objective_data$objective_2_ob2_target_1_obj, selected_objective_data$objective_2_ob2_target_2_obj, selected_objective_data$objective_2_ob2_target_3_obj),
          progress = c(latest_data$objective_2_ob2_target1_progress, latest_data$objective_2_ob2_target2_progress, latest_data$objective_2_ob2_target3_progress),
          ratings = c(latest_data$objective_2_ob2_target1_rating, latest_data$objective_2_ob2_target2_rating, latest_data$objective_2_ob2_target3_rating),
          evidence = latest_data$evidence_obj2
        ),
        list(
          objective = paste("<b>3</b><br>", selected_objective_data$objective_3_objective_3_name_obj),
          targets = c(selected_objective_data$objective_3_ob3_target_1_obj, selected_objective_data$objective_3_ob3_target_2_obj, selected_objective_data$objective_3_ob3_target_3_obj),
          progress = c(latest_data$objective_3_ob3_target1_progress, latest_data$objective_3_ob3_target2_progress, latest_data$objective_3_ob3_target3_progress),
          ratings = c(latest_data$objective_3_ob3_target1_rating, latest_data$objective_3_ob3_target2_rating, latest_data$objective_3_ob3_target3_rating),
          evidence = latest_data$evidence_obj3
        ),
        list(
          objective = paste("<b>4</b><br>", selected_objective_data$objective_4_objective_4_name_obj),
          targets = c(selected_objective_data$objective_4_ob4_target_1_obj, selected_objective_data$objective_4_ob4_target_2_obj, selected_objective_data$objective_4_ob4_target_3_obj),
          progress = c(latest_data$objective_4_ob4_target1_progress, latest_data$objective_4_ob4_target2_progress, latest_data$objective_4_ob4_target3_progress),
          ratings = c(latest_data$objective_4_ob4_target1_rating, latest_data$objective_4_ob4_target2_rating, latest_data$objective_4_ob4_target3_rating),
          evidence = latest_data$evidence_obj4
        ),
        list(
          objective = paste("<b>5</b><br>", selected_objective_data$objective_5_objective_5_name_obj),
          targets = c(selected_objective_data$objective_5_ob5_target_1_obj, selected_objective_data$objective_5_ob5_target_2_obj, selected_objective_data$objective_5_ob5_target_3_obj),
          progress = c(latest_data$objective_5_ob5_target1_progress, latest_data$objective_5_ob5_target2_progress, latest_data$objective_5_ob5_target3_progress),
          ratings = c(latest_data$objective_5_ob5_target1_rating, latest_data$objective_5_ob5_target2_rating, latest_data$objective_5_ob5_target3_rating),
          evidence = latest_data$evidence_obj5
        )
      )
      
      # Function to apply background color based on rating
      rating_color <- function(rating) {
        if (rating == "Achieved") {
          return('<td style="background-color: green;">')
        } else if (rating == "Partially Achieved") {
          return('<td style="background-color: yellow;">')
        } else if (rating == "Not Achieved") {
          return('<td style="background-color: red;">')
        } else {
          return('<td>')
        }
      }
      
      # Flatten the list into a data frame, ensuring objectives are only shown in the first row of each group
      rows <- lapply(objectives_list, function(obj) {
        objective_html <- sprintf('<td rowspan="3" style="vertical-align:top">%s</td>', obj$objective)
        targets <- sprintf('<td>%s</td>', obj$targets)
        progress <- sprintf('<td>%s</td>', obj$progress)
        ratings <- sapply(obj$ratings, function(r) paste0(rating_color(r), r, '</td>'))
        evidence <- sprintf('<td rowspan="3" style="vertical-align:top">%s</td>', obj$evidence)
        
        rows_html <- paste0(
          '<tr style="border-bottom: 2px solid black;">', objective_html, targets[1], progress[1], ratings[1], evidence, '</tr>',
          '<tr style="border-bottom: 2px solid black;">', targets[2], progress[2], ratings[2], '</tr>',
          '<tr style="border-bottom: 2px solid black;">', targets[3], progress[3], ratings[3], '</tr>'
        )
        
        return(rows_html)
      })
      
      html_table <- paste0(unlist(rows), collapse = "")
      html_table <- paste0('<table class="display" cellspacing="0" width="100%"><thead><tr><th>Objective</th><th>Target</th><th>Progress</th><th>Rating</th><th>List of Verification Documents</th></tr></thead><tbody>', html_table, '</tbody></table>')
      
      # Render the DataTable with Buttons extension
      datatable(
        data.frame(html = html_table, stringsAsFactors = FALSE), 
        escape = FALSE, 
        extensions = 'Buttons',
        options = list(
          paging = FALSE,  
          searching = FALSE,  # Disable the search box
          info = FALSE,  
          autoWidth = TRUE,  # Enable automatic column width
          dom = 'Bfrtip',  # Positioning of buttons
          buttons = list('copy', 'csv', 'excel', 'pdf', 'print')  # Add export buttons
        )
      )
    } else {
      return(NULL)  # Few data points for the selected school and region
    }
  })
  
  
  output$latestDateBox <- renderText({
    req(input$regionInput, input$schoolInput)  # Ensure the required inputs are selected
    
    # Fetch and prepare data as per existing logic
    school_data_1 <- priority_data[priority_data$Region_sip == input$regionInput & 
                                     priority_data$Name_school_sip == input$schoolInput, ]
    
    # Parse endtime to find the latest entry
    if (nrow(school_data_1) > 0) {
      school_data_1$endtime <- lubridate::ymd_hms(school_data_1$endtime)
      latest_date1 <- max(school_data_1$endtime)
      
      # Format the latest date for display
      formatted_date <- format(latest_date1, "%Y-%m-%d %H:%M:%S")
      paste("The dashboard is currently visualising the latest report from each of the priority school.", 
            input$schoolInput, "submitted their report on:", formatted_date,".")
    } else {
      "No submissions found for the selected school and region."
    }
  })
  
  
  
  ##################Regional SIP server code
  regions_f_region <- c("Ahafo", "Ashanti", "Bono", "Bono East", "Central", "Eastern", 
                        "Greater Accra", "North East", "Northern", "Oti", "Savannah", 
                        "Upper East", "Upper West", "Volta", "Western", "Western North")
  num_schools_f_region <- c(2,4,1,3,4,7,7,3,12,4,4,13,13,15,1,1)
  
  total_schools_df <- data.frame(Region = regions_f_region, Total_Schools = num_schools_f_region)
  
  uploaded_priority_data <- reactive({
    
    uploaded_counts <- priority_objectives %>%
      group_by(Region_sip_obj) %>%
      summarise(Schools_Uploaded_SIP = n_distinct(Name_school_sip_obj), .groups = 'drop') %>%
      mutate(Total_Targets = Schools_Uploaded_SIP * 15) # Assuming 15 targets per school
    
    latest_submissions <- priority_data %>%
      group_by(Region_sip, Name_school_sip) %>%
      ungroup()
    
    # Count "Achieved" ratings for each target variable
    rating_vars <- c("objective_1_ob1_target1_rating", "objective_1_ob1_target2_rating", "objective_1_ob1_target3_rating",
                     "objective_2_ob2_target1_rating", "objective_2_ob2_target2_rating", "objective_2_ob2_target3_rating",
                     "objective_3_ob3_target1_rating", "objective_3_ob3_target2_rating", "objective_3_ob3_target3_rating",
                     "objective_4_ob4_target1_rating", "objective_4_ob4_target2_rating", "objective_4_ob4_target3_rating",
                     "objective_5_ob5_target1_rating", "objective_5_ob5_target2_rating", "objective_5_ob5_target3_rating")
    
    targets_achieved <- latest_submissions %>%
      select(all_of(rating_vars), Region_sip) %>%
      mutate(across(all_of(rating_vars), ~ as.integer(. == "Achieved"))) %>%
      group_by(Region_sip) %>%
      # Sum each column individually and then take the total sum
      summarise(across(all_of(rating_vars), sum, na.rm = TRUE)) %>%
      rowwise() %>%
      mutate(Total_Achieved = sum(c_across(all_of(rating_vars)), na.rm = TRUE)) %>%
      ungroup() %>%
      select(Region_sip, Total_Achieved)
    
    
    
    # Merge with the total schools and SIP upload counts
    merged_data <- left_join(total_schools_df, uploaded_counts, by = c("Region" = "Region_sip_obj"))
    merged_data <- left_join(merged_data, targets_achieved, by = c("Region" = "Region_sip"))
    
    # Fill NA values with 0
    merged_data$Schools_Uploaded_SIP[is.na(merged_data$Schools_Uploaded_SIP)] <- 0
    merged_data$Total_Targets[is.na(merged_data$Total_Targets)] <- 0
    merged_data$Total_Achieved[is.na(merged_data$Total_Achieved)] <- 0
    
    merged_data$Targets_Remaining <- merged_data$Total_Targets - merged_data$Total_Achieved
    
    # Calculate the % of SIP completion rate
    merged_data$SIP_Completion_Percentage <- ifelse(merged_data$Total_Targets > 0,
                                                    sprintf("%.1f%%", (merged_data$Total_Achieved / merged_data$Total_Targets) * 100), 
                                                    "0.0%")
    
    # Rename the columns
    colnames(merged_data) <- c("Region", "Number of priority schools in the region", 
                               "Number of priority schools that uploaded SIP report",
                               "Total number of targets in priority schools' SIP per region", 
                               "Total number of targets achieved by priority schools in each region",
                               "Number of targets remaining to be achieved by the priority schools", 
                               "% SIP completion rate by priority schools")
    
    merged_data
  })
  
  output$regionTable <- renderDataTable({
    datatable(
      uploaded_priority_data(),
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        autoWidth = TRUE,
        scrollX = TRUE,
        pageLength = 20,
        language = list(search = "Filter:")
      )
    )
  })
  
  
  ######################################################################################################################################
  ##############################################LEADERSHIP MODULE 3 TRAINING 
  
  lead_filtered_data<- reactive({
    req(input$region)
    plc_monitoring_data %>% filter(Region_moni == input$region)
  })
  
  
  
  # ValueBox Outputs for Summary Metrics
  output$total_trainings <- renderValueBox({
    total_trainings <- lead_filtered_data()%>% 
      filter(leadership_training == 1) %>% 
      nrow()
    valueBox(
      value = total_trainings, 
      subtitle = "Leadership training organised", 
      icon = icon("chalkboard-teacher")
    )
  })
  
  
  
  library(stringr)
  
  output$total_leaders_trained <- renderValueBox({
    # Calculate the total number of leaders trained by summing counts for each row
    total_leaders <- lead_filtered_data()%>%
      pull(leadership_report.leaders_attended) %>% 
      sapply(function(x) length(unlist(str_split(x, " ")))) %>%  # Count leaders in each row
      sum()  # Sum up all counts for the region
    
    valueBox(
      value = total_leaders,
      subtitle = "School leaders trained",
      icon = icon("users")
    )
  })
  
  
  
  
  output$session_coverage <- renderValueBox({
    # Calculate the average number of sessions completed by each school in the selected region
    avg_sessions_completed <- lead_filtered_data()%>%
      group_by(Name_school_moni) %>%
      summarise(sessions_completed = n_distinct(leadership_report.leader_session)) %>%
      summarise(avg_sessions = mean(sessions_completed)) %>%
      pull(avg_sessions)
    
    # Round up if the decimal part is 0.5 or higher, otherwise round down
    avg_sessions_completed <- ifelse(
      avg_sessions_completed %% 1 >= 0.5,
      ceiling(avg_sessions_completed),
      floor(avg_sessions_completed)
    )
    
    valueBox(
      value = avg_sessions_completed,
      subtitle = "Out of 5 sessions completed on average",
      icon = icon("chart-line")
    )
  })
  
  
  
  
  # DataTable Output for School-Level Summary
  
  
  output$school_summary_table <- renderRHandsontable({
    # Define the total number of expected sessions
    total_sessions <- 5
    
    # Calculate the required metrics for each school
    summary_data <- lead_filtered_data() %>%
      group_by(Name_school_moni) %>%
      summarise(
        # Number of leadership meetings held
        `Number of Leadership Meetings Held` = sum(leadership_training == 1, na.rm = TRUE),
        
        # List completed sessions as a comma-separated string
        `Completed Sessions` = if (any(leadership_training == 1, na.rm = TRUE)) {
          paste(sort(unique(na.omit(leadership_report.leader_session))), collapse = ", ")
        } else {
          "None"
        },
        
        # Calculate session completion rate based on incomplete sessions
        `Session Completion Rate (%)` = if (any(leadership_training == 1, na.rm = TRUE)) {
          completed_sessions <- sort(unique(na.omit(leadership_report.leader_session)))
          ((length(completed_sessions) / total_sessions) * 100)
        } else {
          0
        },
        
        # Total leaders who attended
        `Total Leaders Who Attended` = if (any(leadership_training == 1, na.rm = TRUE)) {
          sum(sapply(
            na.omit(leadership_report.leaders_attended),
            function(x) length(unlist(str_split(as.character(x), " ")))
          ))
        } else {
          0
        }
      ) %>%
      ungroup()
    
    
    
    # Render as a handsontable
    rhandsontable(summary_data, rowHeaders = NULL, search = TRUE, readOnly = TRUE) %>%
      hot_context_menu(
        customOpts = list(
          csv = list(
            name = "Download to CSV",
            callback = JS(
              "function (key, options) {
             var csv = csvString(this, sep = ',', dec = '.');

             var link = document.createElement('a');
             link.setAttribute('href', 'data:text/plain;charset=utf-8,' +
               encodeURIComponent(csv));
             link.setAttribute('download', 'table_data.csv');

             document.body.appendChild(link);
             link.click();
             document.body.removeChild(link);
           }")
          )
        )
      ) %>%
      hot_cols(
        colWidths = c(280, 180, 180, 180, 180)  # Adjust column widths for 5 columns
      ) %>%
      onRender(
        JS(
          "function(el, x) {
           var hot = this.hot;  // Reference to the Handsontable instance
           hot.addHook('beforeChange', function(changes, source) {
             if (source === 'alter' && (changes[0][0] === 'insert_row' || changes[0][0] === 'remove_row')) {
               return false;  // Prevent row insertion and deletion
             }
           });
         }"
        )
      )
  })
  
  output$download_table <- downloadHandler(
    filename = function() {
      paste("School_Summary_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      # Explicitly call the reactive function
      summary_data <- lead_filtered_data()
      
      # Write the data to a CSV file
      write.csv(as.data.frame(summary_data), file, row.names = FALSE)
    }
  )
  
  
  
  
  
  
  
  
  # DataTable Output for Key Activities
  output$activities_table <- renderDT({
    lead_filtered_data()%>%
      # Filter rows where leadership training was conducted
      filter(leadership_training == 1) %>%
      # Handle missing or blank values
      mutate(
        leadership_report.leader_session = ifelse(
          is.na(leadership_report.leader_session) | leadership_report.leader_session == "",
          "No Data",
          as.character(leadership_report.leader_session)
        ),
        leadership_report.leader_activity = ifelse(
          is.na(leadership_report.leader_activity) | leadership_report.leader_activity == "",
          "No Data",
          leadership_report.leader_activity
        )
      ) %>%
      # Select and rename columns
      select(
        School = Name_school_moni,
        `Sessions Completed` = leadership_report.leader_session,
        `Activities Undertaken by SIAs During Session` = leadership_report.leader_activity
      ) %>%
      # Render the DataTable
      datatable(
        options = list(pageLength = 10, autoWidth = TRUE),
        rownames = FALSE
      )
  })
  
  
  
  
  
  
  
  
  
  
  #################################################################################Intervention English and Maths
  
  #############################UI Intervention English and Maths
  
  
  
  
  
  
  
  
  ###########################Server Intervention English and Maths
  
  ###############################school level 
  
  regions <- reactive({
    unique(inter_data$region_inter)
  })
  
  # Update the region selectInput
  observe({
    updateSelectInput(
      session,
      "region_select",
      choices = regions(),
      selected = NULL
    )
  })
  
  # Reactive to extract schools based on selected region
  schools <- reactive({
    if (!is.null(input$region_select)) {
      unique(inter_data$school_inter[inter_data$region_inter == input$region_select])
    } else {
      NULL
    }
  })
  
  # Update the school selectInput
  observe({
    updateSelectInput(
      session,
      "school_select",
      choices = schools(),
      selected = NULL
    )
  })
  
  
  filtered_data <- reactive({
    req(input$region_select)  # Ensure region is selected
    data <- inter_data[inter_data$region_inter == input$region_select, ]
    if (!is.null(input$school_select) && input$school_select != "") {
      data <- data[data$school_inter == input$school_select, ]
    }
    data
  })
  
  # Total Students
  output$total_students <- renderValueBox({
    # Filter to only rows that have a non-NA value in maths_inter
    valid_data <- filtered_data() %>%
      dplyr::filter(!is.na(maths_inter))
    
    total_students <- nrow(valid_data)
    
    valueBox(
      total_students,
      "Total Students",
      icon = icon("users"),
      color = "blue"
    )
  })
  
  
  # Average English Score
  output$avg_english_score <- renderValueBox({
    avg_english_percentage <- mean((filtered_data()$english_inter / 40) * 100, na.rm = TRUE)  # Calculate average percentage
    valueBox(
      paste0(round(avg_english_percentage, 2), "%"),  # Add percentage symbol
      "Average English Percentage Score",
      icon = icon("book"),
      color = "green"  # Retain green color for success
    )
  })
  
  
  # Average Math Score
  output$avg_maths_score <- renderValueBox({
    avg_maths_percentage <- mean((filtered_data()$maths_inter / 35) * 100, na.rm = TRUE)  # Calculate average percentage
    valueBox(
      paste0(round(avg_maths_percentage, 2), "%"),  # Add percentage symbol
      "Average Math Percentage Score",
      icon = icon("calculator"),
      color = "aqua"
    )
  })
  
  
  # Percentage Needing Intervention
  output$percentage_intervention <- renderValueBox({
    intervention_rate <- sum(filtered_data()$real_inter == "Yes", na.rm = TRUE)
    
    valueBox(
      intervention_rate,  # Display the count
      "Students Needing Intervention",
      icon = icon("exclamation-circle"),
      color = "yellow"
    )
  })
  
  ##Maths proficiency
  filtered_data_by_sex <- reactive({
    data <- filtered_data()
    
    if (input$sex_filter != "overall") {
      data <- data[data$sex_inter == input$sex_filter, ]
    }
    
    data
  })
  
  
  math_proficiency <- reactive({
    data <- filtered_data_by_sex()
    data$math_percentage <- (data$maths_inter / 35) * 100  # Calculate percentage
    data$math_proficiency <- cut(
      data$math_percentage,
      breaks = c(-Inf, 39, 53, 67, 79, Inf),
      labels = c("Emerging", "Developing", "Approaching Proficiency", "Proficient", "Highly Proficient"),
      right = TRUE
    )
    data
  })
  
  math_proficiency_summary <- reactive({
    data <- math_proficiency()
    summary <- as.data.frame(table(data$math_proficiency))
    colnames(summary) <- c("Proficiency Level", "Count")
    
    # Calculate percentage for each proficiency level
    total_students <- sum(summary$Count)
    summary$Percentage <- (summary$Count / total_students) * 100
    
    summary
  })
  
  output$math_proficiency_plot <- renderPlot({
    library(ggplot2)
    
    # Get the proficiency summary
    summary <- math_proficiency_summary()
    
    # Define custom colors for the proficiency levels
    custom_colors <- c(
      "Emerging" = "#FF6F61",       # Red
      "Developing" = "#6B5B95",     # Purple
      "Approaching Proficiency" = "#88B04B", # Green
      "Proficient" = "#F7CAC9",     # Pink
      "Highly Proficient" = "#92A8D1"  # Light Blue
    )
    
    # Create the bar plot using ggplot2
    ggplot(summary, aes(x = `Proficiency Level`, y = Count, fill = `Proficiency Level`)) +
      geom_bar(stat = "identity", width = 0.7) +
      geom_text(
        aes(label = paste0(round(Percentage, 1), "%")),
        vjust = -0.5,  # Position labels above the bars
        size = 4,
        color = "black"
      ) +
      scale_fill_manual(values = custom_colors) +  # Apply custom colors
      labs(
        title = paste("Mathematics Proficiency Levels -", input$sex_filter),
        x = "Proficiency Level",
        y = "Number of Students",
        fill = "Proficiency Level"
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for better readability
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        legend.position = "none"  # Hide legend for simplicity
      )
  })
  
  
  ###########english
  
  filtered_data_by_sex <- reactive({
    data <- filtered_data()
    
    if (input$sex_filter != "overall") {
      data <- data[data$sex_inter == input$sex_filter, ]
    }
    
    data
  })
  
  english_proficiency <- reactive({
    data <- filtered_data_by_sex()  # Filter by selected gender
    data$english_percentage <- (data$english_inter / 40) * 100  # Calculate percentage
    data$english_proficiency <- cut(
      data$english_percentage,
      breaks = c(-Inf, 39, 53, 67, 79, Inf),
      labels = c("Emerging", "Developing", "Approaching Proficiency", "Proficient", "Highly Proficient"),
      right = TRUE
    )
    data
  })
  
  english_proficiency_summary <- reactive({
    data <- english_proficiency()
    summary <- as.data.frame(table(data$english_proficiency))
    colnames(summary) <- c("Proficiency Level", "Count")
    
    # Calculate percentage for each proficiency level
    total_students <- sum(summary$Count)
    summary$Percentage <- (summary$Count / total_students) * 100
    
    summary
  })
  
  output$english_proficiency_plot <- renderPlot({
    library(ggplot2)
    
    # Get the proficiency summary
    summary <- english_proficiency_summary()
    
    # Define custom colors for the proficiency levels
    custom_colors <- c(
      "Emerging" = "#FF6F61",       # Red
      "Developing" = "#6B5B95",     # Purple
      "Approaching Proficiency" = "#88B04B", # Green
      "Proficient" = "#F7CAC9",     # Pink
      "Highly Proficient" = "#92A8D1"  # Light Blue
    )
    
    # Create the bar plot using ggplot2
    ggplot(summary, aes(x = `Proficiency Level`, y = Count, fill = `Proficiency Level`)) +
      geom_bar(stat = "identity", width = 0.7) +
      geom_text(
        aes(label = paste0(round(Percentage, 1), "%")),
        vjust = -0.5,  # Position labels above the bars
        size = 4,
        color = "black"
      ) +
      scale_fill_manual(values = custom_colors) +  # Apply custom colors
      labs(
        title = paste("English Proficiency Levels -", input$sex_filter),
        x = "Proficiency Level",
        y = "Number of Students",
        fill = "Proficiency Level"
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for better readability
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        legend.position = "none"  # Hide legend for simplicity
      )
  })
  
  
  ###########################histogram english
  
  # Render Histogram for English Scores
  output$english_scores_histogram <- renderPlot({
    # Get the filtered data by region, school, and gender
    data <- filtered_data_by_sex()
    
    # Plot the histogram for English scores
    hist(
      data$english_inter,
      breaks = 10,  # Define the number of bins
      col = "lightblue",
      border = "black",
      main = "Distribution of English Scores",
      xlab = "English Scores",
      ylab = "Frequency"
    )
  })
  
  #############################histogramm maths
  output$math_scores_histogram <- renderPlot({
    # Get the filtered data by region, school, and gender
    data <- filtered_data_by_sex()
    
    # Plot the histogram for Mathematics scores
    hist(
      data$maths_inter,
      breaks = 10,  # Define the number of bins
      col = "lightgreen",
      border = "black",
      main = "Distribution of Mathematics Scores",
      xlab = "Mathematics Scores",
      ylab = "Frequency"
    )
  })
  
  
  ###########students needing remedials
  
  output$remedial_level_distribution <- renderPlot({
    data <- filtered_data_by_sex()
    
    # Create a summary of remedial needs
    remedial_summary <- as.data.frame(table(data$inter_level))
    colnames(remedial_summary) <- c("Need Remedial", "Count")
    remedial_summary$Percentage <- (remedial_summary$Count / sum(remedial_summary$Count)) * 100
    
    # Create the pie chart
    ggplot(remedial_summary, aes(x = "", y = Count, fill = `Need Remedial`)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(
        aes(label = paste0(round(Percentage, 1), "%")),
        position = position_stack(vjust = 0.5),
        size = 5,
        color = "white"
      ) +
      scale_fill_manual(values = c("orange", "lightblue")) +
      labs(
        title = "Students Needing Remedial Support - Maths",
        fill = "Need Remedial"
      ) +
      theme_minimal() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold")
      )
  })
  
  
  ############needing remedial
  
  output$students_needing_remedial_pie <- renderPlot({
    library(ggplot2)
    
    # Summarize the need_inter variable
    data <- filtered_data_by_sex()
    remedial_summary <- as.data.frame(table(data$need_inter))
    colnames(remedial_summary) <- c("Need Remedial", "Count")
    
    # Calculate percentages
    remedial_summary$Percentage <- (remedial_summary$Count / sum(remedial_summary$Count)) * 100
    
    # Create the pie chart
    ggplot(remedial_summary, aes(x = "", y = Count, fill = `Need Remedial`)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(
        aes(label = paste0(round(Percentage, 1), "%")),
        position = position_stack(vjust = 0.5),
        size = 5,
        color = "white"
      ) +
      scale_fill_manual(values = c("orange", "lightblue")) +
      labs(
        title = "Students Needing Remedial Support - English",
        fill = "Need Remedial"
      ) +
      theme_minimal() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold")
      )
  })
  
  
  
  ############################### Regional Level ###############################
  
  # Reactive to extract unique regions for the selectInput
  regions_reg <- reactive({
    unique(inter_data$region_inter)
  })
  
  # Update the region selectInput for regional-level results
  observe({
    updateSelectInput(
      session,
      "region_select_reg",
      choices = regions_reg(),
      selected = NULL
    )
  })
  
  # Filter data based on selected region
  filtered_data_reg <- reactive({
    req(input$region_select_reg)  # Ensure a region is selected
    inter_data[inter_data$region_inter == input$region_select_reg, ]
  })
  
  
  
  output$total_students_reg <- renderValueBox({
    # Filter to only rows that have a non-NA value in maths_inter
    valid_data <- filtered_data_reg() %>%
      dplyr::filter(!is.na(maths_inter))
    
    total_students <- nrow(valid_data)
    
    valueBox(
      total_students,
      "Total Students",
      icon = icon("users"),
      color = "blue"
    )
  })
  
  # Average English Score
  output$avg_english_score_reg <- renderValueBox({
    avg_english_percentage <- mean((filtered_data_reg()$english_inter / 40) * 100, na.rm = TRUE)  # Calculate average percentage
    valueBox(
      paste0(round(avg_english_percentage, 2), "%"),
      "Average English Percentage Score",
      icon = icon("book"),
      color = "green"
    )
  })
  
  # Average Math Score
  output$avg_maths_score_reg <- renderValueBox({
    avg_maths_percentage <- mean((filtered_data_reg()$maths_inter / 35) * 100, na.rm = TRUE)  # Calculate average percentage
    valueBox(
      paste0(round(avg_maths_percentage, 2), "%"),
      "Average Math Percentage Score",
      icon = icon("calculator"),
      color = "aqua"
    )
  })
  
  # Percentage Needing Intervention
  output$percentage_intervention_reg <- renderValueBox({
    intervention_rate <- sum(filtered_data_reg()$real_inter == "Yes", na.rm = TRUE)
    
    valueBox(
      intervention_rate,  # Display the count
      "Students Needing Intervention",
      icon = icon("exclamation-circle"),
      color = "yellow"
    )
  })
  
  
  
  
  
  # Reactive to filter by gender for proficiency analysis
  filtered_data_by_sex_reg <- reactive({
    data <- filtered_data_reg()
    if (input$sex_filter_reg != "overall") {
      data <- data[data$sex_inter == input$sex_filter_reg, ]
    }
    data
  })
  
  # Mathematics Proficiency
  math_proficiency_reg <- reactive({
    data <- filtered_data_by_sex_reg()
    data$math_percentage <- (data$maths_inter / 35) * 100
    data$math_proficiency <- cut(
      data$math_percentage,
      breaks = c(-Inf, 39, 53, 67, 79, Inf),
      labels = c("Emerging", "Developing", "Approaching Proficiency", "Proficient", "Highly Proficient"),
      right = TRUE
    )
    data
  })
  
  math_proficiency_summary_reg <- reactive({
    data <- math_proficiency_reg()
    summary <- as.data.frame(table(data$math_proficiency))
    colnames(summary) <- c("Proficiency Level", "Count")
    total_students <- sum(summary$Count)
    summary$Percentage <- (summary$Count / total_students) * 100
    summary
  })
  
  output$math_proficiency_plot_reg <- renderPlot({
    library(ggplot2)
    summary <- math_proficiency_summary_reg()
    custom_colors <- c(
      "Emerging" = "#FF6F61",
      "Developing" = "#6B5B95",
      "Approaching Proficiency" = "#88B04B",
      "Proficient" = "#F7CAC9",
      "Highly Proficient" = "#92A8D1"
    )
    ggplot(summary, aes(x = `Proficiency Level`, y = Count, fill = `Proficiency Level`)) +
      geom_bar(stat = "identity", width = 0.7) +
      geom_text(aes(label = paste0(round(Percentage, 1), "%")), vjust = -0.5, size = 4, color = "black") +
      scale_fill_manual(values = custom_colors) +
      labs(
        title = paste("Mathematics Proficiency Levels -", input$sex_filter_reg),
        x = "Proficiency Level",
        y = "Number of Students",
        fill = "Proficiency Level"
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        legend.position = "none"
      )
  })
  
  # English Proficiency
  english_proficiency_reg <- reactive({
    data <- filtered_data_by_sex_reg()
    data$english_percentage <- (data$english_inter / 40) * 100
    data$english_proficiency <- cut(
      data$english_percentage,
      breaks = c(-Inf, 39, 53, 67, 79, Inf),
      labels = c("Emerging", "Developing", "Approaching Proficiency", "Proficient", "Highly Proficient"),
      right = TRUE
    )
    data
  })
  
  english_proficiency_summary_reg <- reactive({
    data <- english_proficiency_reg()
    summary <- as.data.frame(table(data$english_proficiency))
    colnames(summary) <- c("Proficiency Level", "Count")
    total_students <- sum(summary$Count)
    summary$Percentage <- (summary$Count / total_students) * 100
    summary
  })
  
  output$english_proficiency_plot_reg <- renderPlot({
    library(ggplot2)
    summary <- english_proficiency_summary_reg()
    custom_colors <- c(
      "Emerging" = "#FF6F61",
      "Developing" = "#6B5B95",
      "Approaching Proficiency" = "#88B04B",
      "Proficient" = "#F7CAC9",
      "Highly Proficient" = "#92A8D1"
    )
    ggplot(summary, aes(x = `Proficiency Level`, y = Count, fill = `Proficiency Level`)) +
      geom_bar(stat = "identity", width = 0.7) +
      geom_text(aes(label = paste0(round(Percentage, 1), "%")), vjust = -0.5, size = 4, color = "black") +
      scale_fill_manual(values = custom_colors) +
      labs(
        title = paste("English Proficiency Levels -", input$sex_filter_reg),
        x = "Proficiency Level",
        y = "Number of Students",
        fill = "Proficiency Level"
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        legend.position = "none"
      )
  })
  
  
  ###########################histogram english
  
  # Render Histogram for English Scores
  output$english_scores_histogram_reg <- renderPlot({
    # Get the filtered data by region, school, and gender
    data <- filtered_data_by_sex_reg()
    
    # Plot the histogram for English scores
    hist(
      data$english_inter,
      breaks = 10,  # Define the number of bins
      col = "lightblue",
      border = "black",
      main = "Distribution of English Scores",
      xlab = "English Scores",
      ylab = "Frequency"
    )
  })
  
  #############################histogramm maths
  output$math_scores_histogram_reg <- renderPlot({
    # Get the filtered data by region, school, and gender
    data <- filtered_data_by_sex_reg()
    
    # Plot the histogram for Mathematics scores
    hist(
      data$maths_inter,
      breaks = 10,  # Define the number of bins
      col = "lightgreen",
      border = "black",
      main = "Distribution of Mathematics Scores",
      xlab = "Mathematics Scores",
      ylab = "Frequency"
    )
  })
  
  
  ###########students needing remedials
  
  
  
  # Students Needing Remedials (Pie Chart)
  output$remedial_level_distribution_reg  <- renderPlot({
    
    # Ensure filtered_data_by_sex_nat() produces the expected dataset
    data <- filtered_data_by_sex_reg()
    
    # Create a summary of remedial needs
    remedial_summary <- as.data.frame(table(data$inter_level))
    colnames(remedial_summary) <- c("Need Remedial", "Count")
    remedial_summary$Percentage <- (remedial_summary$Count / sum(remedial_summary$Count)) * 100
    
    # Create the pie chart
    ggplot(remedial_summary, aes(x = "", y = Count, fill = `Need Remedial`)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(
        aes(label = paste0(round(Percentage, 1), "%")),
        position = position_stack(vjust = 0.5),
        size = 5,
        color = "white"
      ) +
      scale_fill_manual(values = c("orange", "lightblue")) +
      labs(
        title = "Students Needing Remedial Support - Maths",
        fill = "Need Remedial"
      ) +
      theme_minimal() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold")
      )
  })
  
  
  ############needing remedial
  
  output$students_needing_remedial_pie_reg <- renderPlot({
    library(ggplot2)
    
    # Summarize the need_inter variable
    data <- filtered_data_by_sex_reg()
    remedial_summary <- as.data.frame(table(data$need_inter))
    colnames(remedial_summary) <- c("Need Remedial", "Count")
    
    # Calculate percentages
    remedial_summary$Percentage <- (remedial_summary$Count / sum(remedial_summary$Count)) * 100
    
    # Create the pie chart
    ggplot(remedial_summary, aes(x = "", y = Count, fill = `Need Remedial`)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(
        aes(label = paste0(round(Percentage, 1), "%")),
        position = position_stack(vjust = 0.5),
        size = 5,
        color = "white"
      ) +
      scale_fill_manual(values = c("orange", "lightblue")) +
      labs(
        title = "Proportion of Students Needing Remedial Support",
        fill = "Need Remedial"
      ) +
      theme_minimal() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold")
      )
  })
  
  
  
  ############################### National Level ###############################
  
  # No need for region filtering at the national level, use all data
  filtered_data_nat <- reactive({
    inter_data  # Use the full dataset for national level
  })
  
  # Total Students
  
  
  
  output$total_students_nat <- renderValueBox({
    # Filter to only rows that have a non-NA value in maths_inter
    valid_data <- filtered_data_nat() %>%
      dplyr::filter(!is.na(maths_inter))    
    total_students <- nrow(valid_data)
    
    valueBox(
      total_students,
      "Total Students",
      icon = icon("users"),
      color = "blue"
    )
  })
  
  
  # Average English Score
  output$avg_english_score_nat <- renderValueBox({
    avg_english_percentage <- mean((filtered_data_nat()$english_inter / 40) * 100, na.rm = TRUE)  # Calculate average percentage
    valueBox(
      paste0(round(avg_english_percentage, 2), "%"),
      "Average English Percentage Score",
      icon = icon("book"),
      color = "green"
    )
  })
  
  # Average Math Score
  output$avg_maths_score_nat <- renderValueBox({
    avg_maths_percentage <- mean((filtered_data_nat()$maths_inter / 35) * 100, na.rm = TRUE)  # Calculate average percentage
    valueBox(
      paste0(round(avg_maths_percentage, 2), "%"),
      "Average Math Percentage Score",
      icon = icon("calculator"),
      color = "aqua"
    )
  })
  
  # Percentage Needing Intervention
  output$percentage_intervention_nat <- renderValueBox({
    intervention_count <- sum(filtered_data_nat()$real_inter == "Yes", na.rm = TRUE)
    
    valueBox(
      intervention_count,  # Display the count
      "Students Needing Intervention",
      icon = icon("exclamation-circle"),
      color = "yellow"
    )
  })
  
  # Reactive to filter by gender for proficiency analysis
  filtered_data_by_sex_nat <- reactive({
    data <- filtered_data_nat()
    if (input$sex_filter_nat != "overall") {
      data <- data[data$sex_inter == input$sex_filter_nat, ]
    }
    data
  })
  
  # Mathematics Proficiency
  math_proficiency_nat <- reactive({
    data <- filtered_data_by_sex_nat()
    data$math_percentage <- (data$maths_inter / 35) * 100
    data$math_proficiency <- cut(
      data$math_percentage,
      breaks = c(-Inf, 39, 53, 67, 79, Inf),
      labels = c("Emerging", "Developing", "Approaching Proficiency", "Proficient", "Highly Proficient"),
      right = TRUE
    )
    data
  })
  
  math_proficiency_summary_nat <- reactive({
    data <- math_proficiency_nat()
    summary <- as.data.frame(table(data$math_proficiency))
    colnames(summary) <- c("Proficiency Level", "Count")
    total_students <- sum(summary$Count)
    summary$Percentage <- (summary$Count / total_students) * 100
    summary
  })
  
  output$math_proficiency_plot_nat <- renderPlot({
    library(ggplot2)
    summary <- math_proficiency_summary_nat()
    custom_colors <- c(
      "Emerging" = "#FF6F61",
      "Developing" = "#6B5B95",
      "Approaching Proficiency" = "#88B04B",
      "Proficient" = "#F7CAC9",
      "Highly Proficient" = "#92A8D1"
    )
    ggplot(summary, aes(x = `Proficiency Level`, y = Count, fill = `Proficiency Level`)) +
      geom_bar(stat = "identity", width = 0.7) +
      geom_text(aes(label = paste0(round(Percentage, 1), "%")), vjust = -0.5, size = 4, color = "black") +
      scale_fill_manual(values = custom_colors) +
      labs(
        title = paste("Mathematics Proficiency Levels -", input$sex_filter_nat),
        x = "Proficiency Level",
        y = "Number of Students",
        fill = "Proficiency Level"
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        legend.position = "none"
      )
  })
  
  # English Proficiency
  english_proficiency_nat <- reactive({
    data <- filtered_data_by_sex_nat()
    data$english_percentage <- (data$english_inter / 40) * 100
    data$english_proficiency <- cut(
      data$english_percentage,
      breaks = c(-Inf, 39, 53, 67, 79, Inf),
      labels = c("Emerging", "Developing", "Approaching Proficiency", "Proficient", "Highly Proficient"),
      right = TRUE
    )
    data
  })
  
  english_proficiency_summary_nat <- reactive({
    data <- english_proficiency_nat()
    summary <- as.data.frame(table(data$english_proficiency))
    colnames(summary) <- c("Proficiency Level", "Count")
    total_students <- sum(summary$Count)
    summary$Percentage <- (summary$Count / total_students) * 100
    summary
  })
  
  output$english_proficiency_plot_nat <- renderPlot({
    library(ggplot2)
    summary <- english_proficiency_summary_nat()
    custom_colors <- c(
      "Emerging" = "#FF6F61",
      "Developing" = "#6B5B95",
      "Approaching Proficiency" = "#88B04B",
      "Proficient" = "#F7CAC9",
      "Highly Proficient" = "#92A8D1"
    )
    ggplot(summary, aes(x = `Proficiency Level`, y = Count, fill = `Proficiency Level`)) +
      geom_bar(stat = "identity", width = 0.7) +
      geom_text(aes(label = paste0(round(Percentage, 1), "%")), vjust = -0.5, size = 4, color = "black") +
      scale_fill_manual(values = custom_colors) +
      labs(
        title = paste("English Proficiency Levels -", input$sex_filter_nat),
        x = "Proficiency Level",
        y = "Number of Students",
        fill = "Proficiency Level"
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        legend.position = "none"
      )
  })
  
  # Render Histogram for English Scores
  output$english_scores_histogram_nat <- renderPlot({
    data <- filtered_data_by_sex_nat()
    hist(
      data$english_inter,
      breaks = 10,
      col = "lightblue",
      border = "black",
      main = "Distribution of English Scores",
      xlab = "English Scores",
      ylab = "Frequency"
    )
  })
  
  # Render Histogram for Mathematics Scores
  output$math_scores_histogram_nat <- renderPlot({
    data <- filtered_data_by_sex_nat()
    hist(
      data$maths_inter,
      breaks = 10,
      col = "lightgreen",
      border = "black",
      main = "Distribution of Mathematics Scores",
      xlab = "Mathematics Scores",
      ylab = "Frequency"
    )
  })
  
  # Students Needing Remedials (Pie Chart)
  output$students_needing_remedial_pie_nat <- renderPlot({
    library(ggplot2)
    data <- filtered_data_by_sex_nat()
    remedial_summary <- as.data.frame(table(data$need_inter))
    colnames(remedial_summary) <- c("Need Remedial", "Count")
    remedial_summary$Percentage <- (remedial_summary$Count / sum(remedial_summary$Count)) * 100
    ggplot(remedial_summary, aes(x = "", y = Count, fill = `Need Remedial`)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(aes(label = paste0(round(Percentage, 1), "%")), position = position_stack(vjust = 0.5), size = 5, color = "white") +
      scale_fill_manual(values = c("orange", "lightblue")) +
      labs(
        title = "Students Needing Remedial Support - English",
        fill = "Need Remedial"
      ) +
      theme_minimal() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold")
      )
  })
  
  
  ##############
  # Students Needing Remedials (Pie Chart)
  output$students_needing_remedial_pie_nat_maths <- renderPlot({
    
    # Ensure filtered_data_by_sex_nat() produces the expected dataset
    data <- filtered_data_by_sex_nat()
    
    # Create a summary of remedial needs
    remedial_summary <- as.data.frame(table(data$inter_level))
    colnames(remedial_summary) <- c("Need Remedial", "Count")
    remedial_summary$Percentage <- (remedial_summary$Count / sum(remedial_summary$Count)) * 100
    
    # Create the pie chart
    ggplot(remedial_summary, aes(x = "", y = Count, fill = `Need Remedial`)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      geom_text(
        aes(label = paste0(round(Percentage, 1), "%")),
        position = position_stack(vjust = 0.5),
        size = 5,
        color = "white"
      ) +
      scale_fill_manual(values = c("orange", "lightblue")) +
      labs(
        title = "Students Needing Remedial Support - Maths",
        fill = "Need Remedial"
      ) +
      theme_minimal() +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold")
      )
  })
  
  
  ######################### New lesson observation. Overall National Summary
  
  factor_names_nat_new <- list(
    "Percentage of lessons with clear objectives and structured planning" = c("lesson_purpose", "lesson_unique_needs_learners", "learning_overtime"),
    "Percentage of lessons using learner-centred and interactive teaching approaches" = c("lesson_learners_challenged","lesson_interactive_approaches", "lesson_teaching_differentiated", "lesson_reallife_objects"),
    "Percentage of lessons where ICT tools and resources are effectively used" = c("lesson_TLRs", "lesson_integrating_ICT"),
    "Percentage of lessons where teachers maintain an inclusive and engaging learning environment" = c("lesson_teacher_positive","constructive_male_fem", "composition_male_fem","lesson_questioning"),
    "Percentage of lessons where students demonstrate learning progress" = c("lesson_students_learning", "lesson_learners_challenged", "lesson_evaluate_learning_outcome"),
    "Percentage of lessons where teachers use assessment to guide learning and provide feedback" = c("lesson_assessment", "lesson_feedback", "lesson_evaluate_learning_outcome", "constructive_male_fem", "constructive_written_male_fem")
  )
  
  # Calculate summary scores for indicators
  compute_indicators <- function(data, mapping) {
    # Print debug information
    print(paste("Processing school with", nrow(data), "data points"))
    
    indicator_scores <- lapply(names(mapping), function(indicator) {
      selected_cols <- mapping[[indicator]]
      
      # Debug: Check which columns exist in the data
      existing_cols <- selected_cols[selected_cols %in% names(data)]
      missing_cols <- selected_cols[!selected_cols %in% names(data)]
      
      if (length(existing_cols) == 0) {
        print(paste("Indicator:", indicator, "- All columns missing:", paste(missing_cols, collapse=", ")))
        return(data.frame(Indicator = indicator, Score = NA_real_, stringsAsFactors = FALSE))
      }
      
      # Only use columns that exist in the data
      data_subset <- data[, existing_cols, drop = FALSE]
      
      # Count the number of "Yes", "In Part", and "No" values
      yes_count <- sum(data_subset == "Yes", na.rm = TRUE)
      in_part_count <- sum(data_subset == "In Part", na.rm = TRUE)
      no_count <- sum(data_subset == "No", na.rm = TRUE)
      total_responses <- yes_count + in_part_count + no_count
      
      # Debug
      print(paste("Indicator:", indicator))
      print(paste("  Yes count:", yes_count))
      print(paste("  In Part count:", in_part_count))
      print(paste("  No count:", no_count))
      print(paste("  Total valid responses:", total_responses))
      
      # Check if we have enough data
      if (total_responses < 3) {  # Set minimum threshold
        print(paste("  Too few responses:", total_responses))
        return(data.frame(Indicator = indicator, Score = NA_real_, stringsAsFactors = FALSE))
      }
      
      # Calculate percentage of "Yes" responses
      yes_percentage <- (yes_count / total_responses) * 100
      
      print(paste("  Yes percentage:", round(yes_percentage, 2), "%"))
      
      data.frame(Indicator = indicator, Score = round(yes_percentage, 2), stringsAsFactors = FALSE)
    })
    
    result <- do.call(rbind, indicator_scores)
    return(result)
  }
  
  
  # Reactive function to compute differences between two selected semesters
  percentage_difference_data <- reactive({
    # Retrieve semester 1 data
    data_semester1 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_nat_new,
        term_lesson == "First Semester",
        if (input$year_lesson_delivery_nat != "Overall") begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_nat else TRUE
      )
    
    # Retrieve semester 2 data
    data_semester2 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_nat_new,
        term_lesson == "Second Semester",
        if (input$year_lesson_delivery_nat != "Overall") begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_nat else TRUE
      )
    
    # Store sample sizes
    n_semester1 <- nrow(data_semester1)
    n_semester2 <- nrow(data_semester2)
    
    # Try to compute indicators with error handling
    result_semester1 <- tryCatch(
      compute_indicators(data_semester1, factor_names_nat_new),
      error = function(e) {
        # Create a placeholder result if computation fails
        data.frame(
          Indicator = names(factor_names_nat_new),
          Score = rep(NA_real_, length(factor_names_nat_new)),
          stringsAsFactors = FALSE
        )
      }
    )
    
    # Attempt to compute second semester indicators
    result_semester2 <- tryCatch(
      compute_indicators(data_semester2, factor_names_nat_new),
      error = function(e) {
        # Create a placeholder result if computation fails
        data.frame(
          Indicator = names(factor_names_nat_new),
          Score = rep(NA_real_, length(factor_names_nat_new)),
          stringsAsFactors = FALSE
        )
      }
    )
    
    # Merge results
    result_combined <- merge(
      result_semester1, 
      result_semester2, 
      by = "Indicator", 
      suffixes = c("_Sem1", "_Sem2"),
      all = TRUE
    )
    
    # Compute differences and format output
    result_combined <- result_combined %>%
      mutate(
        Difference = case_when(
          is.na(Score_Sem1) & is.na(Score_Sem2) ~ "📊 Not enough data points for analysis",
          is.na(Score_Sem1) ~ "📊 Few data points (Sem 1)",
          is.na(Score_Sem2) ~ "📊 Few data points (Sem 2)",
          TRUE ~ {
            diff_val <- round(Score_Sem2 - Score_Sem1, 2)
            case_when(
              diff_val > 0 ~ paste0("📈 +", diff_val, "%"),
              diff_val < 0 ~ paste0("📉 ", diff_val, "%"),
              TRUE ~ "📊 No Change"
            )
          }
        ),
        N_Sem1 = n_semester1,
        N_Sem2 = n_semester2
      )
    
    # Add N row
    n_row <- data.frame(
      Indicator = "N",
      Score_Sem1 = n_semester1,
      Score_Sem2 = n_semester2,
      Difference = "",
      N_Sem1 = n_semester1,
      N_Sem2 = n_semester2,
      stringsAsFactors = FALSE
    )
    
    # Combine original results with N row
    result_combined <- rbind(result_combined, n_row)
    
    return(result_combined)
  })
  
  # Modify data formatting to handle various data scenarios
  percentage_difference_data_formatted <- reactive({
    data <- percentage_difference_data()
    
    # Check if all data are NA
    if (all(is.na(data$Score_Sem1) & is.na(data$Score_Sem2))) {
      return(NULL)  # Return NULL if no data at all
    }
    
    # Format data, handling the N row separately
    formatted_data <- data %>%
      mutate(
        `Semester One Result (%)` = ifelse(
          Indicator == "N", 
          as.character(N_Sem1), 
          ifelse(
            is.na(Score_Sem1), 
            "Few data points", 
            paste0(round(Score_Sem1, 2), "%")
          )
        ),
        `Semester Two Result (%)` = ifelse(
          Indicator == "N", 
          as.character(N_Sem2), 
          ifelse(
            is.na(Score_Sem2), 
            "Few data points", 
            paste0(round(Score_Sem2, 2), "%")
          )
        )
      ) %>%
      select(Indicator, `Semester One Result (%)`, `Semester Two Result (%)`, Difference)
    
    # Customize the N row appearance
    formatted_data$Indicator[formatted_data$Indicator == "N"] <- "Number of lessons observed (N)"
    
    return(formatted_data)
  })
  
  # Render summary table with improved styling and export options
  output$summaryTableNational_new <- DT::renderDataTable({
    req(nrow(percentage_difference_data_formatted()) > 0)
    
    DT::datatable(
      percentage_difference_data_formatted(),
      colnames = c("Indicator", "Semester One Result (%)", "Semester Two Result (%)", "Difference (%)"),
      extensions = 'Buttons',
      options = list(
        pageLength = 7,
        dom = 'Bfrtip',
        buttons = list(
          list(extend = 'copy', className = 'btn btn-primary'),
          list(extend = 'csv', className = 'btn btn-success'),
          list(extend = 'excel', className = 'btn btn-info'),
          list(extend = 'pdf', className = 'btn btn-danger'),
          list(extend = 'print', className = 'btn btn-warning')
        ),
        autoWidth = FALSE,
        columnDefs = list(
          list(className = 'dt-center', targets = c(1, 2, 3)),
          list(width = '60%', targets = 0),
          list(width = '15%', targets = c(1, 2, 3))
        ),
        initComplete = DT::JS(
          "function(settings, json) {",
          "  $(this.api().table().header()).css({'background-color': '#e8f5e9', 'color': 'black', 'font-weight': 'bold'});", # Light green header
          "}"
        )
      ),
      rownames = FALSE,
      class = 'display nowrap table-striped table-bordered'
    ) %>%
      DT::formatStyle(
        "Difference",
        backgroundColor = DT::styleInterval(
          0, c("rgba(255, 224, 224, 0.7)", "rgba(224, 255, 224, 0.7)") # Lighter red and green
        ),
        color = DT::JS("value < 0 ? 'darkred' : 'darkgreen'"),
        fontWeight = "bold",
        padding = "10px"
      ) %>%
      DT::formatStyle(
        'Indicator',
        target = 'row',
        backgroundColor = DT::styleEqual("Number of lessons observed (N)", '#f0fff0') # Light mint green
      ) %>%
      DT::formatStyle(
        columns = names(percentage_difference_data_formatted()),
        fontSize = "14px",
        fontFamily = "Arial",
        fontWeight = "bold"
      )
  })
  
  
  # Reactive function to format data for the trend plot
  trend_data <- reactive({
    # Get the processed data from the table
    trend_df <- percentage_difference_data() %>%
      select(Indicator, Score_Sem1, Score_Sem2) %>%
      pivot_longer(cols = c("Score_Sem1", "Score_Sem2"), 
                   names_to = "Semester", 
                   values_to = "Score")
    
    # Rename semesters for better readability
    trend_df <- trend_df %>%
      mutate(Semester = case_when(
        Semester == "Score_Sem1" ~ "First Semester",
        Semester == "Score_Sem2" ~ "Second Semester"
      ))
    
    return(trend_df)
  })
  
  # Render the trend plot
  output$trendPlot <- renderPlot({
    # Get trend data
    data_trend <- trend_data()
    
    # Validate if data exists
    req(nrow(data_trend) > 0)
    
    # Convert Semester into a factor for correct ordering
    data_trend$Semester <- factor(data_trend$Semester, levels = c("First Semester", "Second Semester"))
    
    # Generate the trend plot
    ggplot(data_trend, aes(x = Semester, y = Score, group = Indicator, color = Indicator)) +
      geom_line(size = 1.2) +  # Line plot for trends
      geom_point(size = 3) +   # Highlight points for each semester
      labs(title = "Trend of Lesson Observation Indicators Over Time", 
           x = "Semester", 
           y = "Average Score (%)",
           color = "Indicator") +  # Legend title
      theme_minimal() +
      theme(
        legend.position = "bottom",  # Move legend to bottom for better visualization
        axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels
        plot.title = element_text(face = "bold", size = 14),
        legend.text = element_text(size = 10)
      )
  })
  
  #############insights national
  
  thematic_analysis_2023 <- list(
    strengths = paste(
      "1️⃣ Some Teachers Demonstrated Strong Content Knowledge\n",
      "📌 While lesson planning was inconsistent, a few teachers displayed strong subject knowledge, effectively explaining concepts and answering student questions.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher was knowledgeable and explained concepts in a clear and structured manner."\n',
      '"The teacher was confident in delivering subject content, which helped students grasp difficult topics."\n',
      '"Lessons were detailed and covered key concepts comprehensively."\n\n',
      
      "2️⃣ A Few Lessons Were Interactive and Engaging\n",
      "📌 Only a limited number of lessons incorporated student-centered approaches. While most teachers relied on lecture-style delivery, some effectively used questioning and discussions to engage students.\n",
      "💡 Supporting Evidence:\n",
      '"In a few lessons, students were encouraged to ask questions and share their thoughts."\n',
      '"A handful of teachers used real-life examples to make learning more engaging."\n',
      '"There was some effort to use interactive questioning to assess students\' understanding."\n\n',
      
      "3️⃣ Some Teachers Provided Encouraging Feedback\n",
      "📌 Although formative assessment was not widely practiced, some teachers made efforts to provide positive reinforcement and verbal feedback during lessons.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher provided encouragement to students who attempted to answer questions."\n',
      '"Verbal feedback was given to motivate students to participate more in class."\n',
      '"Although feedback was mostly oral, it helped students feel supported."',
      sep = "\n"
    ),
    
    areas_for_improvement = paste(
      "1️⃣ Lack of Lesson Planning and Structured Lesson Delivery\n",
      "📌 Many teachers were not using lesson plans, leading to unstructured, disorganized lessons that lacked clear learning objectives. This affected lesson flow and student comprehension.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher did not follow a structured lesson plan, making the lesson hard to follow."\n',
      '"There was no clear sequence in lesson delivery; concepts were introduced without a structured approach."\n',
      '"Lessons lacked objectives, making it difficult to assess student learning."\n\n',
      
      "2️⃣ Limited Use of Interactive Teaching Methods\n",
      "📌 Most teachers used traditional lecture methods, with minimal student participation. Lessons were teacher-centered, and students had few opportunities for discussion or active engagement.\n",
      "💡 Supporting Evidence:\n",
      '"The lesson was mostly a lecture with little student participation."\n',
      '"Students were not engaged in meaningful discussions or activities."\n',
      '"There was little to no use of interactive teaching methods such as group work or class discussions."\n\n',
      
      "3️⃣ Poor Student Engagement and Classroom Interaction\n",
      "📌 Many students were passive learners, as teachers rarely encouraged discussions or peer interactions. In several cases, only a few students dominated classroom discussions.\n",
      "💡 Supporting Evidence:\n",
      '"Only a few students were actively answering questions, while most remained silent."\n',
      '"The teacher did not distribute questions equally, leading to unbalanced participation."\n',
      '"There was little effort to engage students who were not participating."\n\n',
      
      "4️⃣ Minimal Use of ICT and Teaching Resources\n",
      "📌 Lessons were mostly conducted without the integration of digital tools or teaching aids. Many classrooms lacked visual resources, making learning less engaging.\n",
      "💡 Supporting Evidence:\n",
      '"No teaching aids were used, making the lesson less interactive."\n',
      '"ICT was not integrated into lesson delivery."\n',
      '"There was a lack of multimedia resources such as videos and digital slides."\n\n',
      
      "5️⃣ Weak Classroom Management and Organization\n",
      "📌 Poor classroom management was noted in several observations, with student distractions and disorderly class behavior affecting lesson effectiveness.\n",
      "💡 Supporting Evidence:\n",
      '"Students were not paying attention, and the teacher struggled to manage classroom behavior."\n',
      '"Classroom organization was weak, leading to a noisy and disruptive learning environment."\n',
      '"More classroom discipline strategies are needed to maintain focus."',
      sep = "\n"
    )
  )
  
  
  thematic_analysis_2024 <- list(
    strengths = paste(
      "1️⃣ Effective Lesson Planning and Delivery\n",
      "📌 Many teachers demonstrate strong lesson planning skills, ensuring that learning objectives are clear and structured. Lessons are well-sequenced, allowing for smooth content delivery.\n",
      "💡 Supporting Evidence:\n",
      '"Lesson plan was well-structured with clear learning objectives."\n',
      '"Effective lesson delivery, allowing students to follow concepts easily."\n',
      '"Good lesson planning led to better student engagement."\n\n',
      
      "2️⃣ Use of Interactive and Learner-Centered Approaches\n",
      "📌 Teachers are employing interactive and learner-centered techniques, including group work, student discussions, and active engagement in the learning process. This enhances critical thinking and collaborative learning.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher encouraged group work and class discussions, making the lesson interactive."\n',
      '"Students were given opportunities to actively participate in class activities."\n',
      '"Good use of interactive strategies, such as peer learning and questioning."\n\n',
      
      "3️⃣ Strong Teaching and Learning Techniques\n",
      "📌 Many lessons exhibit effective teaching strategies, such as differentiated instruction and the use of real-life examples to enhance understanding. This allows students to connect theory with practice.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher effectively related lesson content to real-life situations."\n',
      '"Good differentiation techniques were used to cater to diverse learning needs."\n',
      '"Lesson content was simplified using real-world examples."\n\n',
      
      "4️⃣ Encouraging a Positive and Inclusive Learning Environment\n",
      "📌 Teachers are creating a welcoming and engaging classroom atmosphere, where students feel encouraged to participate and express their ideas. Constructive feedback is frequently given to guide learning.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher created a positive classroom environment where students felt confident to ask questions."\n',
      '"Encouraged both male and female students equally in class discussions."\n',
      '"Constructive feedback was given to guide student improvement."', 
      sep = "\n"
    ),
    
    areas_for_improvement = paste(
      "1️⃣ Enhancing the Use of ICT in Teaching\n",
      "📌 While some teachers integrate ICT tools into lessons, there is a need for more widespread use of technology to make learning more engaging and dynamic. Many observations noted a lack of digital teaching resources.\n",
      "💡 Supporting Evidence:\n",
      '"Teacher to integrate ICT into teaching to make lessons more engaging."\n',
      '"Limited use of ICT tools in lesson delivery; more digital resources are needed."\n',
      '"The use of multimedia (videos, digital slides) would improve lesson impact."\n\n',
      
      "2️⃣ Fair Distribution of Questions and Student Engagement\n",
      "📌 Some teachers need to ensure balanced participation by fairly distributing questions among students. Some students dominate discussions, while others remain passive.\n",
      "💡 Supporting Evidence:\n",
      '"Teacher should fairly distribute questions among all students."\n',
      '"Encouraging quieter students to participate will improve engagement."\n',
      '"More inclusive questioning techniques should be applied."\n\n',
      
      "3️⃣ Classroom Management and Organization\n",
      "📌 Some observations indicated that classroom seating arrangements and organization could be improved to enhance student focus and participation.\n",
      "💡 Supporting Evidence:\n",
      '"Classroom arrangements of desks were very poor, limiting student interaction."\n',
      '"Reorganizing seating to promote better group engagement is recommended."\n',
      '"A structured seating plan would enhance classroom discipline."\n\n',
      
      "4️⃣ Strengthening Assessment and Feedback Mechanisms\n",
      "📌 Teachers should increase the use of formative assessment techniques to provide timely and constructive feedback, ensuring that students track their progress effectively.\n",
      "💡 Supporting Evidence:\n",
      '"More use of formative assessments is needed to evaluate learning progress."\n',
      '"Providing written feedback would be helpful for student improvement."\n',
      '"Students benefit more when feedback is immediate and specific."',
      sep = "\n"
    )
  )
  
  #######################################################
  
  thematic_analysis_2025 <- list(
    strengths = paste(
      "1️⃣ Effective Lesson Planning and Delivery\n",
      "📌 Many teachers demonstrate strong lesson planning skills, ensuring that learning objectives are clear and structured. Lessons are well-sequenced, allowing for smooth content delivery.\n",
      "💡 Supporting Evidence:\n",
      '"Lesson plan was well-structured with clear learning objectives."\n',
      '"Effective lesson delivery, allowing students to follow concepts easily."\n',
      '"Good lesson planning led to better student engagement."\n\n',
      
      "2️⃣ Use of Interactive and Learner-Centered Approaches\n",
      "📌 Teachers are employing interactive and learner-centered techniques, including group work, student discussions, and active engagement in the learning process. This enhances critical thinking and collaborative learning.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher encouraged group work and class discussions, making the lesson interactive."\n',
      '"Students were given opportunities to actively participate in class activities."\n',
      '"Good use of interactive strategies, such as peer learning and questioning."\n\n',
      
      "3️⃣ Strong Teaching and Learning Techniques\n",
      "📌 Many lessons exhibit effective teaching strategies, such as differentiated instruction and the use of real-life examples to enhance understanding. This allows students to connect theory with practice.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher effectively related lesson content to real-life situations."\n',
      '"Good differentiation techniques were used to cater to diverse learning needs."\n',
      '"Lesson content was simplified using real-world examples."\n\n',
      
      "4️⃣ Encouraging a Positive and Inclusive Learning Environment\n",
      "📌 Teachers are creating a welcoming and engaging classroom atmosphere, where students feel encouraged to participate and express their ideas. Constructive feedback is frequently given to guide learning.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher created a positive classroom environment where students felt confident to ask questions."\n',
      '"Encouraged both male and female students equally in class discussions."\n',
      '"Constructive feedback was given to guide student improvement."', 
      sep = "\n"
    ),
    
    areas_for_improvement = paste(
      "1️⃣ Enhancing the Use of ICT in Teaching\n",
      "📌 While some teachers integrate ICT tools into lessons, there is a need for more widespread use of technology to make learning more engaging and dynamic. Many observations noted a lack of digital teaching resources.\n",
      "💡 Supporting Evidence:\n",
      '"Teacher to integrate ICT into teaching to make lessons more engaging."\n',
      '"Limited use of ICT tools in lesson delivery; more digital resources are needed."\n',
      '"The use of multimedia (videos, digital slides) would improve lesson impact."\n\n',
      
      "2️⃣ Fair Distribution of Questions and Student Engagement\n",
      "📌 Some teachers need to ensure balanced participation by fairly distributing questions among students. Some students dominate discussions, while others remain passive.\n",
      "💡 Supporting Evidence:\n",
      '"Teacher should fairly distribute questions among all students."\n',
      '"Encouraging quieter students to participate will improve engagement."\n',
      '"More inclusive questioning techniques should be applied."\n\n',
      
      "3️⃣ Classroom Management and Organization\n",
      "📌 Some observations indicated that classroom seating arrangements and organization could be improved to enhance student focus and participation.\n",
      "💡 Supporting Evidence:\n",
      '"Classroom arrangements of desks were very poor, limiting student interaction."\n',
      '"Reorganizing seating to promote better group engagement is recommended."\n',
      '"A structured seating plan would enhance classroom discipline."\n\n',
      
      "4️⃣ Strengthening Assessment and Feedback Mechanisms\n",
      "📌 Teachers should increase the use of formative assessment techniques to provide timely and constructive feedback, ensuring that students track their progress effectively.\n",
      "💡 Supporting Evidence:\n",
      '"More use of formative assessments is needed to evaluate learning progress."\n',
      '"Providing written feedback would be helpful for student improvement."\n',
      '"Students benefit more when feedback is immediate and specific."',
      sep = "\n"
    )
  )
  
  ####################################################
  
  # Reactive function to return the thematic analysis based on selected academic year
  thematic_analysis <- reactive({
    switch(input$year_select_nat_new,
           "2023/2024 academic year" = thematic_analysis_2023,
           "2024/2025 academic year" = thematic_analysis_2024,
           "2025/2026 academic year" = thematic_analysis_2025,
           # Default case
           list(
             strengths = "No data available for the selected academic year.",
             areas_for_improvement = "No data available for the selected academic year."
           )
    )
  })
  
  
  
  # Function to generate well-formatted thematic HTML
  generate_thematic_summary_html <- function(title, content) {
    return(HTML(paste0(
      "<div style='padding:10px;'>",
      "<h4 style='font-weight:bold; color:#004085; background:#CCE5FF; padding:8px; border-radius:5px;'>", title, "</h4>",
      "<ul style='padding-left:15px;'>",
      paste0("<li style='margin-bottom:10px; font-size:14px;'><span style='font-size:16px;'>", gsub("\n", "<br>", content), "</span></li>"),
      "</ul>",
      "</div>"
    )))
  }
  
  # Render Key Strengths Analysis with better styling
  output$strengthsOutput_new <- renderUI({
    thematic_data <- thematic_analysis()
    
    generate_thematic_summary_html("🔹 Key Strengths ", thematic_data$strengths)
  })
  
  # Render Areas for Improvement Analysis with better styling
  output$areasForDevOutput_new <- renderUI({
    thematic_data <- thematic_analysis()
    
    generate_thematic_summary_html("⚠️ Areas That Need Improvement", thematic_data$areas_for_improvement)
  })
  
  
  
  #######################################################################################
  # Track if the modal has been shown
  #first_visit <- reactiveValues(shown = FALSE)
  
  #observe({
  # Print selected menu for debugging
  # print(input$sidebarMenu)  
  
  #if (input$sidebarMenu == "lesson_observation" && !first_visit$shown) {
  # showModal(
  #  modalDialog(
  #   title = "📢 Lesson Observation Dashboard Updates",
  #  HTML("
  # <p>Welcome to the updated <b>Lesson Observation Dashboard</b>! 🚀 Here’s what’s new:</p>
  #<ul>
  # <li>📊 <b>New Key Indicators:</b> Lesson observations now track <b>six core teaching and learning metrics</b>.</li>
  #<li>📈 <b>Qualitative insights:</b> Provide <b>thematic analysis of the strength and </b> areas for improvement across board.</li>
  #<li>🌍 <b>National, Regional & School-Level Insights:</b> Filter observations by <b>location and school</b>.</li>
  #<li>🎨 <b>Improved Computation Methods:</b> Standardized formulas for tracking <b>lesson planning, student engagement, ICT use, and assessment.</b></li>
  #</ul>
  
  #<h4>🔹 <b>The Six Key Indicators</b></h4>
  #<ol>
  # <li><b>Lesson Planning & Objectives:</b> Measures if lessons have <b>clear objectives</b> and structured planning.</li>
  #<li><b>Interactive & Learner-Centered Approaches:</b> Tracks use of <b>interactive teaching strategies</b> (e.g., group work, real-life examples).</li>
  #<li><b>ICT Integration:</b> Evaluates how teachers <b>use digital tools & resources</b> in lesson delivery.</li>
  #<li><b>Inclusive & Engaging Learning Environment:</b> Measures student <b>engagement & teacher classroom management</b>.</li>
  #<li><b>Student Learning Progress:</b> Examines whether students <b>actively participate & demonstrate understanding.</b></li>
  #<li><b>Assessment & Feedback:</b> Monitors how teachers <b>use assessments to guide learning & provide feedback.</b></li>
  #</ol>
  
  #<p>These enhancements ensure that lesson observations <b>align with the new curriculum</b>, providing <b>insightful data for decision making.</b></p>
  
  #<p><i>Click 'Got it!' to continue.</i></p>
  #"),
  # easyClose = TRUE,  # Allows users to close the modal
  #footer = modalButton("Got it!")  # Button to close the modal
  #)
  #)
  
  # Mark the modal as shown to prevent multiple pop-ups
  #first_visit$shown <- TRUE
  #}
  #})
  
  
  ###################################################################################################
  ##########################work on the SIP section of the dashboard
  # Create a reactive list of unique values for each variable
  # Dynamic UI for selecting academic year
  output$selectAcademicYear <- renderUI({
    selectInput("academicYearInput", "Select Academic Year:", 
                choices = unique(sip_objectives$academic_sip_obj),
                selected = max(unique(sip_objectives$academic_sip_obj)))  # Default to latest year
  })
  
  # Dynamic UI for region selection based on academic year
  output$selectRegion <- renderUI({
    req(input$academicYearInput)  # Ensure academic year is selected
    
    regions_for_year <- unique(sip_objectives$Region_sip_obj[sip_objectives$academic_sip_obj == input$academicYearInput])
    
    selectInput("regionInput", "Select Region:", choices = regions_for_year)
  })
  
  # Dynamic UI for school selection based on academic year and region
  output$selectSchool <- renderUI({
    req(input$academicYearInput, input$regionInput)  # Ensure both academic year and region are selected
    
    schools_in_region <- unique(sip_objectives$Name_school_sip_obj[sip_objectives$academic_sip_obj == input$academicYearInput &
                                                                     sip_objectives$Region_sip_obj == input$regionInput])
    
    selectInput("schoolInput", "Select School:", choices = schools_in_region)
  })
  
  output$objectivesTable <- DT::renderDataTable({
    req(input$academicYearInput, input$regionInput, input$schoolInput, input$dateRange)  # Ensure all inputs are selected
    
    # Trim whitespace and convert to character to ensure accurate filtering
    sip_objectives$academic_sip_obj <- trimws(as.character(sip_objectives$academic_sip_obj))
    sip_data$reporting_year_sip <- trimws(as.character(sip_data$reporting_year_sip))
    input_year <- trimws(as.character(input$academicYearInput))
    
    # Debugging: Print values to check matching
    print(paste("Filtering for Academic Year:", input_year))
    print(paste("Available academic_sip_obj:", unique(sip_objectives$academic_sip_obj)))
    print(paste("Available reporting_year_sip:", unique(sip_data$reporting_year_sip)))
    
    # Filter objectives based on selected academic year, region, and school
    selected_objective_data <- sip_objectives[
      sip_objectives$academic_sip_obj == input_year &
        sip_objectives$Region_sip_obj == input$regionInput &
        sip_objectives$Name_school_sip_obj == input$schoolInput, ]
    
    if (nrow(selected_objective_data) == 0) {
      return(DT::datatable(data.frame(Message = "No objectives found for selected year, region, and school"), 
                           options = list(dom = 't'), rownames = FALSE))
    }
    
    # Filter sip_data for selected year, region, and school
    school_data <- sip_data[
      sip_data$reporting_year_sip == input_year &
        sip_data$Region_sip == input$regionInput & 
        sip_data$Name_school_sip == input$schoolInput, ]
    
    # Flag to indicate whether we have actual progress data
    has_progress_data <- TRUE
    
    if (nrow(school_data) == 0) {
      # No data available, but we'll still show objectives with "Yet to Report"
      has_progress_data <- FALSE
      # Create an empty placeholder for latest_data
      latest_data <- data.frame(matrix(ncol = 0, nrow = 1))
    } else {
      # Convert the endtime to POSIXct format to find the latest entry
      school_data$endtime <- lubridate::ymd_hms(school_data$endtime)
      filtered_data <- school_data[school_data$endtime >= input$dateRange[1] & 
                                     school_data$endtime <= input$dateRange[2], ]
      
      if (nrow(filtered_data) == 0) {
        # No data for date range, but we'll still show objectives
        has_progress_data <- FALSE
        # Create an empty placeholder for latest_data
        latest_data <- data.frame(matrix(ncol = 0, nrow = 1))
      } else {
        # Find the row with the latest endtime
        latest_data <- filtered_data[which.max(filtered_data$endtime), ]
      }
    }
    
    # Add summary statistics at the top of the page
    output$objectiveSummary <- renderUI({
      # Calculate summary stats based on the data
      if (has_progress_data) {
        # Count objectives by status
        achieved_count <- 0
        partially_achieved_count <- 0
        not_achieved_count <- 0
        total_objectives <- 0
        
        # First approach: try to use the objective achievement columns
        for (i in 1:7) {
          achievement_col <- paste0("objective_", i, "_objective", i, "_achieved")
          if (achievement_col %in% names(latest_data)) {
            total_objectives <- total_objectives + 1
            status <- latest_data[[achievement_col]]
            if (!is.na(status)) {
              if (status == "Achieved") achieved_count <- achieved_count + 1
              else if (status == "Partially Achieved") partially_achieved_count <- partially_achieved_count + 1
              else if (status == "Not Achieved") not_achieved_count <- not_achieved_count + 1
            }
          }
        }
        
        # If no objectives found via the first method, use an alternative approach based on the target ratings
        if (total_objectives == 0) {
          # Get all column names containing "rating"
          rating_cols <- grep("_rating$", names(latest_data), value = TRUE)
          
          # Count the different ratings
          for (col in rating_cols) {
            if (!is.na(latest_data[[col]])) {
              if (latest_data[[col]] == "Achieved") achieved_count <- achieved_count + 1
              else if (latest_data[[col]] == "Partially Achieved") partially_achieved_count <- partially_achieved_count + 1
              else if (latest_data[[col]] == "Not Achieved") not_achieved_count <- not_achieved_count + 1
            }
          }
          
          # Determine total objective count from objectives list
          objective_names <- grep("_name_obj$", names(selected_objective_data), value = TRUE)
          valid_objectives <- 0
          for (obj_name in objective_names) {
            if (!is.na(selected_objective_data[[obj_name]]) && selected_objective_data[[obj_name]] != "") {
              valid_objectives <- valid_objectives + 1
            }
          }
          total_objectives <- valid_objectives
          
          # If we still have 0 total objectives, set to 1 to avoid division by zero
          if (total_objectives == 0) total_objectives <- 1
        }
        
        # Calculate completion percentage (avoid division by zero)
        completion_percentage <- ifelse(total_objectives > 0, 
                                        round((achieved_count / total_objectives) * 100), 
                                        0)
        
        # Format the summary box
        div(
          class = "panel panel-primary",
          style = "margin-bottom: 20px; border: 1px solid #ddd; border-radius: 4px; overflow: hidden;",
          div(
            class = "panel-heading",
            style = "background-color: #007bff; color: white; padding: 10px 15px;",
            h4(style = "margin: 0;", "Implementation Progress Summary")
          ),
          div(
            class = "panel-body",
            style = "padding: 15px; display: flex; justify-content: space-around; text-align: center;",
            div(
              style = "padding: 10px;",
              div(style = "font-size: 24px; font-weight: bold; color: #28a745;", achieved_count),
              div(style = "color: #28a745;", "Achieved")
            ),
            div(
              style = "padding: 10px;",
              div(style = "font-size: 24px; font-weight: bold; color: #ffc107;", partially_achieved_count),
              div(style = "color: #ffc107;", "Partially Achieved")
            ),
            div(
              style = "padding: 10px;",
              div(style = "font-size: 24px; font-weight: bold; color: #dc3545;", not_achieved_count),
              div(style = "color: #dc3545;", "Not Achieved")
            ),
            div(
              style = "padding: 10px;",
              div(style = "font-size: 24px; font-weight: bold; color: #007bff;", 
                  paste0(completion_percentage, "%")),
              div(style = "color: #007bff;", "Overall Completion")
            )
          )
        )
      } else {
        # No data yet, show placeholder
        div(
          class = "panel panel-primary",
          style = "margin-bottom: 20px; border: 1px solid #ddd; border-radius: 4px; overflow: hidden;",
          div(
            class = "panel-heading",
            style = "background-color: #007bff; color: white; padding: 10px 15px;",
            h4(style = "margin: 0;", "Implementation Progress Summary")
          ),
          div(
            class = "panel-body",
            style = "padding: 15px; text-align: center;",
            p("No progress data available yet. Objectives are displayed below with 'Yet to Report' status.")
          )
        )
      }
    })
    
    # Proceed if data exists
    if (nrow(latest_data) > 0) {
      
      # Determine the max number of targets and objectives based on the academic year
      num_targets <- ifelse(input_year == "2023/2024 Academic Year", 3, 5)
      # Determine max number of objectives - check which ones exist in the data
      max_objectives <- 7
      
      # Create a list of objectives dynamically
      objectives_list <- list()
      
      # Loop through all possible objectives (1 to max_objectives)
      for (i in 1:max_objectives) {
        # Check if this objective exists for this school (by checking if the objective name exists)
        objective_name_col <- paste0("objective_", i, "_objective_", i, "_name_obj")
        
        # Skip if this objective doesn't exist or is NA
        if (!objective_name_col %in% names(selected_objective_data) || 
            is.na(selected_objective_data[[objective_name_col]]) || 
            selected_objective_data[[objective_name_col]] == "") {
          next
        }
        
        # Initialize empty vectors for targets, progress, and ratings
        targets <- c()
        progress <- c()
        ratings <- c()
        
        # Loop through all possible targets for this objective
        for (j in 1:num_targets) {
          target_col <- paste0("objective_", i, "_ob", i, "_target_", j, "_obj")
          progress_col <- paste0("objective_", i, "_ob", i, "_target", j, "_progress")
          rating_col <- paste0("objective_", i, "_ob", i, "_target", j, "_rating")
          
          # Check if target exists and is not NA
          if (target_col %in% names(selected_objective_data) && 
              !is.na(selected_objective_data[[target_col]]) && 
              selected_objective_data[[target_col]] != "") {
            
            # Add target to the list
            targets <- c(targets, selected_objective_data[[target_col]])
            
            # Add progress (or "Yet to Report" if no data)
            if (has_progress_data && progress_col %in% names(latest_data) && !is.na(latest_data[[progress_col]])) {
              progress <- c(progress, latest_data[[progress_col]])
            } else {
              progress <- c(progress, "Yet to Report")
            }
            
            # Add rating (or "Yet to Report" if no data)
            if (has_progress_data && rating_col %in% names(latest_data) && !is.na(latest_data[[rating_col]])) {
              ratings <- c(ratings, latest_data[[rating_col]])
            } else {
              ratings <- c(ratings, "Yet to Report")
            }
          }
        }
        
        # Remove targets that are NA (we'll keep "Yet to Report" values for progress/ratings)
        valid_indexes <- which(!is.na(targets))
        if (length(valid_indexes) > 0) {
          targets <- targets[valid_indexes]
          progress <- progress[valid_indexes]
          ratings <- ratings[valid_indexes]
          
          # Add this objective to the list if it has valid targets
          objectives_list[[length(objectives_list) + 1]] <- list(
            objective = paste("<b>", i, "</b><br>", selected_objective_data[[paste0("objective_", i, "_objective_", i, "_name_obj")]]),
            targets = targets,
            progress = progress,
            ratings = ratings
          )
        }
      }
      
      # Function to apply background color based on rating
      rating_color <- function(rating) {
        if (is.na(rating) || rating == "") {
          return('<td>')
        } else if (rating == "Achieved") {
          return('<td style="background-color: #28a745; color: white; font-weight: bold;">')
        } else if (rating == "Partially Achieved") {
          return('<td style="background-color: #ffc107; font-weight: bold;">')
        } else if (rating == "Not Achieved") {
          return('<td style="background-color: #dc3545; color: white; font-weight: bold;">')
        } else if (rating == "Yet to Report") {
          return('<td style="background-color: #e9ecef; color: #6c757d; font-style: italic;">')
        } else {
          return('<td>')
        }
      }
      
      # Check if we have any objectives to display
      if (length(objectives_list) == 0) {
        return(DT::datatable(data.frame(Message = "No objectives with valid targets found for this school"), 
                             options = list(dom = 't'), rownames = FALSE))
      }
      
      # Flatten the list into a data frame, ensuring objectives are only shown in the first row of each group
      rows <- lapply(objectives_list, function(obj) {
        num_valid_targets <- length(obj$targets)
        objective_html <- sprintf('<td rowspan="%d" style="vertical-align:top">%s</td>', num_valid_targets, obj$objective)
        
        targets <- sprintf('<td>%s</td>', obj$targets)
        progress <- sprintf('<td>%s</td>', obj$progress)
        ratings <- sapply(obj$ratings, function(r) paste0(rating_color(r), r, '</td>'))
        
        # Generate rows dynamically based on the number of valid targets
        rows_html <- paste0(
          '<tr style="border-bottom: 2px solid black;">', objective_html, targets[1], progress[1], ratings[1], '</tr>'
        )
        
        for (j in 2:num_valid_targets) {
          rows_html <- paste0(rows_html,
                              '<tr style="border-bottom: 2px solid black;">', targets[j], progress[j], ratings[j], '</tr>'
          )
        }
        
        return(rows_html)
      })
      
      html_table <- paste0(
        '<table class="display" cellspacing="0" width="100%">',
        '<thead>',
        '<tr>',
        '<th style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">Objective</th>',
        '<th style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">Target</th>',
        '<th style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">Progress</th>',
        '<th style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">Rating</th>',
        '</tr>',
        '</thead>',
        '<tbody>',
        paste0(unlist(rows), collapse = ""), 
        '</tbody>',
        '</table>'
      )
      
      # Add a legend for the color coding
      legend_html <- paste0(
        '<div style="margin-top: 20px; padding: 10px; background-color: #f8f9fa; border-radius: 4px;">',
        '<strong>Legend:</strong> ',
        '<span style="margin-right: 15px; padding: 2px 8px; background-color: #28a745; color: white; border-radius: 3px;">Achieved</span> ',
        '<span style="margin-right: 15px; padding: 2px 8px; background-color: #ffc107; border-radius: 3px;">Partially Achieved</span> ',
        '<span style="margin-right: 15px; padding: 2px 8px; background-color: #dc3545; color: white; border-radius: 3px;">Not Achieved</span> ',
        '<span style="padding: 2px 8px; background-color: #e9ecef; color: #6c757d; font-style: italic; border-radius: 3px;">Yet to Report</span>',
        '</div>'
      )
      
      combined_html <- paste0(legend_html, html_table)
      
      # Render the DataTable with export options
      datatable(
        data.frame(html = combined_html, stringsAsFactors = FALSE), 
        escape = FALSE, 
        extensions = 'Buttons',
        options = list(
          paging = FALSE,  # Disable paging
          searching = FALSE,  # Disable search
          info = FALSE,  # Hide info
          autoWidth = TRUE,  # Enable automatic width
          dom = 'Bfrtip',  # Buttons position
          buttons = list('copy', 'csv', 'excel', 'pdf', 'print')  # Export buttons
        )
      )
    } else {
      return(NULL)  # No data available
    }
  })
  
  output$latestDateBox <- renderText({
    req(input$academicYearInput, input$regionInput, input$schoolInput)  # Ensure inputs are selected
    
    # Fetch and filter data for the selected academic year
    school_data_1 <- sip_data[sip_data$reporting_year_sip == input$academicYearInput &
                                sip_data$Region_sip == input$regionInput & 
                                sip_data$Name_school_sip == input$schoolInput, ]
    
    # Parse endtime and find latest date
    if (nrow(school_data_1) > 0) {
      school_data_1$endtime <- lubridate::ymd_hms(school_data_1$endtime)
      latest_date1 <- max(school_data_1$endtime)
      formatted_date <- format(latest_date1, "%Y-%m-%d %H:%M:%S")
      
      paste("The dashboard is currently visualizing the latest submission for each school.",
            input$schoolInput, "submitted their latest SIP data on:", formatted_date,
            ".", "Please use the date range below to see previous submissions.")
    } else {
      "No submissions found for the selected school, region, and academic year."
    }
  })
  
  
  
  
  
  ##################Regional SIP server code
  
  
  ##################Regional SIP server code
  
  # Academic Year Selection UI
  output$selectRegionalAcademicYear <- renderUI({
    selectInput("academicYearInput_reg", "Select Academic Year:", 
                choices = unique(sip_objectives$academic_sip_obj),
                selected = max(unique(sip_objectives$academic_sip_obj)))  # Default to latest year
  })
  
  
  
  regions_f_region <- c("Ahafo", "Ashanti", "Bono", "Bono East", "Central", "Eastern", 
                        "Greater Accra", "North East", "Northern", "Oti", "Savannah", 
                        "Upper East", "Upper West", "Volta", "Western", "Western North")
  num_schools_f_region <- c(17, 143, 36, 29, 75, 94, 46, 14, 29, 25, 12, 35, 31, 68, 36, 18)
  
  total_schools_df <- data.frame(Region = regions_f_region, Total_Schools = num_schools_f_region)
  
  uploaded_sip_data <- reactive({
    # Filter sip_data based on selected date range
    filtered_sip_data <- sip_data %>%
      mutate(endtime = ymd_hms(endtime)) %>%
      filter(endtime >= input$dateRange_reg[1] & endtime <= input$dateRange_reg[2])
    
    # Only apply academic year filter if a specific year is selected (not "All Years")
    if (!is.null(input$academicYearInput_reg) && input$academicYearInput_reg != "All Years") {
      filtered_sip_data <- filtered_sip_data %>%
        filter(reporting_year_sip == input$academicYearInput_reg)
    }
    
    # Filter objectives data if needed
    objectives_data <- sip_objectives
    if (!is.null(input$academicYearInput_reg) && input$academicYearInput_reg != "All Years") {
      objectives_data <- objectives_data %>%
        filter(academic_sip_obj == input$academicYearInput_reg)
    }
    
    # Rest of your original code unchanged
    uploaded_counts <- objectives_data %>%
      group_by(Region_sip_obj) %>%
      summarise(Schools_Uploaded_SIP = n_distinct(Name_school_sip_obj), .groups = 'drop') %>%
      mutate(Total_Targets = Schools_Uploaded_SIP * 15)
    
    latest_submissions <- filtered_sip_data %>%
      group_by(Region_sip, Name_school_sip) %>%
      filter(endtime == max(endtime)) %>%
      slice(1) %>%  # Ensure one row per school
      ungroup()
    
    # Count "Achieved" ratings for each target variable
    rating_vars <- c("objective_1_ob1_target1_rating", "objective_1_ob1_target2_rating", "objective_1_ob1_target3_rating",
                     "objective_2_ob2_target1_rating", "objective_2_ob2_target2_rating", "objective_2_ob2_target3_rating",
                     "objective_3_ob3_target1_rating", "objective_3_ob3_target2_rating", "objective_3_ob3_target3_rating",
                     "objective_4_ob4_target1_rating", "objective_4_ob4_target2_rating", "objective_4_ob4_target3_rating",
                     "objective_5_ob5_target1_rating", "objective_5_ob5_target2_rating", "objective_5_ob5_target3_rating")
    
    # Safely process targets if we have data
    if (nrow(latest_submissions) > 0) {
      targets_achieved <- latest_submissions %>%
        select(all_of(rating_vars), Region_sip) %>%
        mutate(across(all_of(rating_vars), ~ as.integer(. == "Achieved"))) %>%
        group_by(Region_sip) %>%
        summarise(Total_Achieved = sum(across(all_of(rating_vars)), na.rm = TRUE), .groups = 'drop')
    } else {
      targets_achieved <- data.frame(Region_sip = character(), Total_Achieved = integer())
    }
    
    merged_data <- left_join(total_schools_df, uploaded_counts, by = c("Region" = "Region_sip_obj"))
    merged_data <- left_join(merged_data, targets_achieved, by = c("Region" = "Region_sip"))
    
    # Add condition to cap Total_Achieved at Total_Targets
    merged_data <- merged_data %>%
      mutate(
        Schools_Uploaded_SIP = ifelse(is.na(Schools_Uploaded_SIP), 0, Schools_Uploaded_SIP),
        Total_Targets = ifelse(is.na(Total_Targets), 0, Total_Targets),
        Total_Achieved = ifelse(is.na(Total_Achieved), 0, Total_Achieved),
        Total_Achieved = ifelse(Total_Achieved > Total_Targets, Total_Targets, Total_Achieved), # Cap Total_Achieved
        Targets_Remaining = Total_Targets - Total_Achieved,
        SIP_Completion_Percentage = ifelse(Total_Targets > 0,
                                           sprintf("%.1f%%", (Total_Achieved / Total_Targets) * 100),
                                           "0.0%")
      )
    
    
    colnames(merged_data) <- c("Region", "Number of schools in region", "Number of schools that uploaded SIP report",
                               "Total number of targets in SIP per region", "Total number of targets achieved by schools in each region",
                               "Number of targets remaining to be achieved", "% SIP Completion Rate")
    merged_data
  })
  
  output$regionTable <- renderDataTable({
    datatable(
      uploaded_sip_data(),
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
        autoWidth = TRUE,
        scrollX = TRUE,
        pageLength = 20,
        language = list(search = "Filter:")
      )
    )
  }) 
  
  
  #################################################################VLC code
  vlc_data <- reactive({
    # Print a message to the console to help debug
    cat("Loading VLC data...\n")
    
    # Try to read the CSV file
    tryCatch({
      data <- read.csv("vlc_data.csv", stringsAsFactors = FALSE)
      cat("CSV file loaded. Number of rows:", nrow(data), "\n")
      cat("Columns:", paste(colnames(data), collapse=", "), "\n")
      
      # Check if key columns exist
      required_cols <- c("Region_vlc", "nts_vlc_total_attendance_vlc", "nts_vlc_male_attendance_vlc", 
                         "nts_vlc_female_attendance_vlc", "nts_vlc_participation_rate_vlc")
      
      for(col in required_cols) {
        if(!(col %in% colnames(data))) {
          cat("WARNING: Required column", col, "not found in the data!\n")
        }
      }
      
      # Convert date columns with error handling
      date_cols <- c("start", "end", "nts_vlc_date_session_vlc")
      for(col in date_cols) {
        if(col %in% colnames(data)) {
          tryCatch({
            data[[col]] <- as.Date(data[[col]])
            cat("Converted", col, "to Date type\n")
          }, error = function(e) {
            cat("ERROR: Failed to convert", col, "to Date:", e$message, "\n")
          })
        }
      }
      
      # Create session_date column
      data$session_date <- data$start  # Default to start date
      if("nts_vlc_date_session_vlc" %in% colnames(data)) {
        # Replace with nts_vlc_date_session_vlc where it's not NA
        non_na_indices <- which(!is.na(data$nts_vlc_date_session_vlc))
        if(length(non_na_indices) > 0) {
          data$session_date[non_na_indices] <- data$nts_vlc_date_session_vlc[non_na_indices]
        }
      }
      
      # Ensure numeric columns
      numeric_cols <- c("nts_vlc_total_attendance_vlc", "nts_vlc_male_attendance_vlc", 
                        "nts_vlc_female_attendance_vlc", "nts_vlc_participation_rate_vlc")
      
      for(col in numeric_cols) {
        if(col %in% colnames(data)) {
          data[[col]] <- as.numeric(as.character(data[[col]]))
        }
      }
      
      return(data)
      
    }, error = function(e) {
      # If reading the file fails, print error and return empty data frame
      cat("ERROR: Failed to read CSV file:", e$message, "\n")
      cat("Working directory is:", getwd(), "\n")
      cat("Files in directory:", paste(list.files(), collapse=", "), "\n")
      
      # Return an empty data frame with the required columns
      empty_df <- data.frame(
        Region_vlc = character(0),
        Name_school_vlc = character(0),
        session_date = as.Date(character(0)),
        nts_vlc_total_attendance_vlc = numeric(0),
        nts_vlc_male_attendance_vlc = numeric(0),
        nts_vlc_female_attendance_vlc = numeric(0),
        nts_vlc_participation_rate_vlc = numeric(0)
      )
      return(empty_df)
    })
  })
  
  # Filtered data based on date range (Overall Summary tab)
  filtered_overall_data <- reactive({
    # Get the base data
    data <- vlc_data()
    cat("Filtering data based on date range...\n")
    
    # Default to all data if update button hasn't been clicked yet
    if(is.null(input$vls_overall_update) || input$vls_overall_update == 0) {
      cat("Update button not clicked yet, using all data.\n")
      return(data)
    }
    
    # Apply date filter if update button has been clicked
    tryCatch({
      if("session_date" %in% colnames(data)) {
        filtered <- data[data$session_date >= input$vls_overall_date_range[1] & 
                           data$session_date <= input$vls_overall_date_range[2], ]
        cat("Filtered data by date. Rows after filtering:", nrow(filtered), "\n")
        
        if(nrow(filtered) == 0) {
          cat("No data matches the selected date range. Showing all data.\n")
          return(data)
        }
        return(filtered)
      } else {
        cat("session_date column not found. Showing all data.\n")
        return(data)
      }
    }, error = function(e) {
      # If filtering causes an error, return all data with a warning
      cat("ERROR in filtering data:", e$message, "- Showing all data.\n")
      return(data)
    })
  })
  
  # Value Boxes - Overall Summary
  output$vls_total_sessions <- renderValueBox({
    data <- filtered_overall_data()
    total_sessions <- nrow(data)
    cat("Total sessions:", total_sessions, "\n")
    
    valueBox(
      total_sessions,
      "Total VLC Sessions",
      icon = icon("chalkboard-teacher"),
      color = "yellow"
    )
  })
  
  output$vls_total_participants <- renderValueBox({
    data <- filtered_overall_data()
    
    # Sum total learner attendance with error handling
    if("nts_vlc_total_attendance_vlc" %in% colnames(data)) {
      total_participants <- mean(data$nts_vlc_total_attendance_vlc, na.rm = TRUE)
      if(is.na(total_participants)) total_participants <- 0
    } else {
      total_participants <- 0
      cat("WARNING: nts_vlc_total_attendance_vlc column not found!\n")
    }
    
    cat("Total participants:", total_participants, "\n")
    
    valueBox(
      formatC(total_participants, format = "d", big.mark = ","),
      "Total Learners Participated",
      icon = icon("users"),
      color = "yellow"
    )
  })
  
  output$vls_avg_attendance_rate <- renderValueBox({
    data <- filtered_overall_data()
    
    # Calculate average participation rate as total_attendance/total_teachers
    if("nts_vlc_total_attendance_vlc" %in% colnames(data) && 
       "nts_vlc_total_teachers_schoo_vlc" %in% colnames(data)) {
      
      # Sum up total attendance and total teachers across all records
      total_attendance <- sum(data$nts_vlc_total_attendance_vlc, na.rm = TRUE)
      total_teachers <- sum(data$nts_vlc_total_teachers_schoo_vlc, na.rm = TRUE)
      
      # Calculate the average participation rate
      if(total_teachers > 0) {
        avg_rate <- total_attendance / total_teachers
      } else {
        avg_rate <- 0
        cat("WARNING: Total teachers is zero or missing, cannot calculate rate!\n")
      }
      
      # Alternative calculation method calculating per-school rates then averaging
      # Uncomment if you prefer this approach instead
      # school_rates <- data$nts_vlc_total_attendance_vlc / data$nts_vlc_total_teachers_schoo_vlc
      # avg_rate <- mean(school_rates, na.rm = TRUE)
      
    } else {
      avg_rate <- 0
      cat("WARNING: Required columns for attendance rate calculation not found!\n")
      if(!("nts_vlc_total_attendance_vlc" %in% colnames(data))) {
        cat("Missing: nts_vlc_total_attendance_vlc\n")
      }
      if(!("nts_vlc_total_teachers_schoo_vlc" %in% colnames(data))) {
        cat("Missing: nts_vlc_total_teachers_schoo_vlc\n")
      }
    }
    
    cat("Average attendance rate:", avg_rate, "\n")
    
    valueBox(
      paste0(round(avg_rate * 100, 1), "%"),
      "Average Attendance Rate",
      icon = icon("chart-line"),
      color = "yellow"
    )
  })
  
  
  
  ###########learner patricipation trend overtime
  output$vls_overall_trend_chart <- renderPlotly({
    data <- filtered_overall_data()
    cat("Creating interactive trend chart with percentage attendance and tooltips...\n")
    
    # Basic error checking
    if(nrow(data) == 0) {
      cat("No data available for trend chart\n")
      # Return empty plot with message if no data
      return(
        plotly::plot_ly() %>%
          plotly::add_annotations(
            text = "No data available for the selected period",
            showarrow = FALSE,
            font = list(size = 14)
          )
      )
    }
    
    # Check required columns for percentage calculation
    req_cols <- c("session_date", "nts_vlc_total_attendance_vlc", 
                  "nts_vlc_male_attendance_vlc", "nts_vlc_female_attendance_vlc",
                  "nts_vlc_total_teachers_schoo_vlc")
    missing_cols <- req_cols[!req_cols %in% colnames(data)]
    
    if(length(missing_cols) > 0) {
      cat("Missing columns for trend chart:", paste(missing_cols, collapse=", "), "\n")
      return(
        plotly::plot_ly() %>%
          plotly::add_annotations(
            text = paste("Missing required columns:", paste(missing_cols, collapse=", ")),
            showarrow = FALSE,
            font = list(size = 14)
          )
      )
    }
    
    # Prepare data for trend chart - summarize by date with percentages
    # Use tryCatch to handle errors gracefully
    tryCatch({
      # Group by date and summarize attendance values
      agg_data <- aggregate(
        cbind(
          total_attendance = data$nts_vlc_total_attendance_vlc,
          male_attendance = data$nts_vlc_male_attendance_vlc,
          female_attendance = data$nts_vlc_female_attendance_vlc,
          total_teachers = data$nts_vlc_total_teachers_schoo_vlc
        ) ~ session_date, 
        data = data, 
        FUN = function(x) sum(x, na.rm = TRUE)
      )
      
      # Calculate attendance percentages
      agg_data$total_percent <- agg_data$total_attendance / agg_data$total_teachers * 100
      agg_data$male_percent <- agg_data$male_attendance / agg_data$total_teachers * 100
      agg_data$female_percent <- agg_data$female_attendance / agg_data$total_teachers * 100
      
      # Handle any division by zero
      agg_data$total_percent[is.na(agg_data$total_percent) | is.infinite(agg_data$total_percent)] <- 0
      agg_data$male_percent[is.na(agg_data$male_percent) | is.infinite(agg_data$male_percent)] <- 0
      agg_data$female_percent[is.na(agg_data$female_percent) | is.infinite(agg_data$female_percent)] <- 0
      
      # Format dates for better display
      agg_data$date_formatted <- format(agg_data$session_date, "%d %b %Y")
      
      # Sort by date
      agg_data <- agg_data[order(agg_data$session_date), ]
      
      # Create custom hover text
      agg_data$total_hover <- paste0(
        "Date: ", agg_data$date_formatted, "<br>",
        "Total Attendance: ", round(agg_data$total_percent, 1), "% (", 
        formatC(agg_data$total_attendance, format="d"), "/", 
        formatC(agg_data$total_teachers, format="d"), " learners)"
      )
      
      agg_data$male_hover <- paste0(
        "Date: ", agg_data$date_formatted, "<br>",
        "Male Attendance: ", round(agg_data$male_percent, 1), "% (", 
        formatC(agg_data$male_attendance, format="d"), " learners)"
      )
      
      agg_data$female_hover <- paste0(
        "Date: ", agg_data$date_formatted, "<br>",
        "Female Attendance: ", round(agg_data$female_percent, 1), "% (", 
        formatC(agg_data$female_attendance, format="d"), " learners)"
      )
      
      cat("Interactive trend chart data prepared, rows:", nrow(agg_data), "\n")
      
      # Create the interactive plotly chart directly
      p <- plotly::plot_ly() %>%
        # Total attendance line (primary)
        plotly::add_trace(
          data = agg_data,
          x = ~session_date,
          y = ~total_percent,
          type = "scatter",
          mode = "lines+markers",
          name = "Total",
          line = list(color = "#f39c12", width = 3),
          marker = list(color = "#f39c12", size = 8),
          hoverinfo = "text",
          text = ~total_hover
        ) %>%
        
        # Male attendance line
        plotly::add_trace(
          data = agg_data,
          x = ~session_date,
          y = ~male_percent,
          type = "scatter",
          mode = "lines+markers",
          name = "Male",
          line = list(color = "#3498db", width = 2, dash = "dash"),
          marker = list(color = "#3498db", size = 6),
          hoverinfo = "text",
          text = ~male_hover
        ) %>%
        
        # Female attendance line
        plotly::add_trace(
          data = agg_data,
          x = ~session_date,
          y = ~female_percent,
          type = "scatter",
          mode = "lines+markers",
          name = "Female",
          line = list(color = "#e74c3c", width = 2, dash = "dash"),
          marker = list(color = "#e74c3c", size = 6),
          hoverinfo = "text",
          text = ~female_hover
        ) %>%
        
        # Add reference lines at 25%, 50%, 75% and 100%
        plotly::add_trace(
          x = c(min(agg_data$session_date), max(agg_data$session_date)),
          y = c(25, 25),
          type = "scatter",
          mode = "lines",
          line = list(color = "gray", width = 1, dash = "dot"),
          showlegend = FALSE,
          hoverinfo = "none"
        ) %>%
        plotly::add_trace(
          x = c(min(agg_data$session_date), max(agg_data$session_date)),
          y = c(50, 50),
          type = "scatter",
          mode = "lines",
          line = list(color = "gray", width = 1, dash = "dot"),
          showlegend = FALSE,
          hoverinfo = "none"
        ) %>%
        plotly::add_trace(
          x = c(min(agg_data$session_date), max(agg_data$session_date)),
          y = c(75, 75),
          type = "scatter",
          mode = "lines",
          line = list(color = "gray", width = 1, dash = "dot"),
          showlegend = FALSE,
          hoverinfo = "none"
        ) %>%
        plotly::add_trace(
          x = c(min(agg_data$session_date), max(agg_data$session_date)),
          y = c(100, 100),
          type = "scatter",
          mode = "lines",
          line = list(color = "gray", width = 1, dash = "dot"),
          showlegend = FALSE,
          hoverinfo = "none"
        ) %>%
        
        # Layout configuration
        plotly::layout(
          title = list(
            
            font = list(size = 18)
          ),
          xaxis = list(
            title = "Session Date",
            tickformat = "%d %b %Y"
          ),
          yaxis = list(
            title = "Attendance Percentage (%)",
            ticksuffix = "%",
            range = c(0, max(c(100, max(agg_data$total_percent, na.rm = TRUE) * 1.1))),
            dtick = 25  # Tick marks every 25%
          ),
          legend = list(
            orientation = "h",
            y = -0.2
          ),
          hovermode = "closest",
          annotations = list(
            list(
              text = paste("Based on", formatC(sum(agg_data$total_teachers), format="d", big.mark=","), "total learners "),
              x = 0.5,
              y = 1.05,
              xref = "paper",
              yref = "paper",
              xanchor = "center",
              yanchor = "bottom",
              showarrow = FALSE,
              font = list(size = 12, italic = TRUE)
            )
          )
        ) %>%
        
        # Configuration for better user experience
        plotly::config(
          displayModeBar = TRUE,
          scrollZoom = TRUE,
          modeBarButtonsToRemove = c(
            "select2d", "lasso2d", "zoomIn2d", "zoomOut2d", 
            "autoScale2d", "toggleSpikelines", "hoverCompareCartesian"
          )
        )
      
      return(p)
      
    }, error = function(e) {
      # Return error message in plot if something goes wrong
      cat("ERROR creating interactive trend chart:", e$message, "\n")
      return(
        plotly::plot_ly() %>%
          plotly::add_annotations(
            text = paste("Error creating trend chart:", e$message),
            showarrow = FALSE,
            font = list(size = 14)
          )
      )
    })
  })
  
  
  # Regional Comparison Chart
  output$vls_regional_comparison <- renderPlot({
    data <- filtered_overall_data()
    cat("Creating regional comparison chart...\n")
    
    # Basic error checking
    if(nrow(data) == 0) {
      cat("No data available for regional chart\n")
      # Return empty plot with message if no data
      return(
        ggplot() + 
          annotate("text", x = 0.5, y = 0.5, label = "No data available for the selected period") +
          theme_void()
      )
    }
    
    # Check required columns
    req_cols <- c("Region_vlc", "nts_vlc_total_attendance_vlc")
    missing_cols <- req_cols[!req_cols %in% colnames(data)]
    
    if(length(missing_cols) > 0) {
      cat("Missing columns for regional chart:", paste(missing_cols, collapse=", "), "\n")
      return(
        ggplot() + 
          annotate("text", x = 0.5, y = 0.5, 
                   label = paste("Missing required columns:", paste(missing_cols, collapse=", "))) +
          theme_void()
      )
    }
    
    # Prepare data for regional comparison
    # Use tryCatch to handle errors gracefully
    tryCatch({
      # Group by region and summarize
      # Using base R aggregation for stability
      regional_data <- aggregate(
        cbind(
          avg_attendance = data$nts_vlc_total_attendance_vlc
        ) ~ Region_vlc, 
        data = data, 
        FUN = function(x) mean(x, na.rm = TRUE)
      )
      
      # Sort by average attendance
      regional_data <- regional_data[order(-regional_data$avg_attendance), ]
      
      cat("Regional chart data prepared, rows:", nrow(regional_data), "\n")
      
      # Create regional comparison chart
      p <- ggplot(regional_data, aes(x = reorder(Region_vlc, avg_attendance), y = avg_attendance)) +
        geom_bar(stat = "identity", fill = "#f39c12") +
        geom_text(aes(label = round(avg_attendance, 1)), hjust = -0.2, size = 3) +
        labs(
          title = "Average Learner Attendance by Region",
          x = "Region",
          y = "Average Attendance"
        ) +
        coord_flip() +
        theme_minimal() +
        theme(
          plot.title = element_text(face = "bold"),
          axis.title = element_text(face = "bold")
        )
      return(p)
    }, error = function(e) {
      # Return error message in plot if something goes wrong
      cat("ERROR creating regional chart:", e$message, "\n")
      return(
        ggplot() + 
          annotate("text", x = 0.5, y = 0.5, 
                   label = paste("Error creating regional chart:", e$message)) +
          theme_void()
      )
    })
  })
  ####################################summary of VLC table by region
  
  output$vls_overall_summary_table <- renderDT({
    data <- filtered_overall_data()
    cat("Creating correctly calculated regional summary table...\n")
    
    # Basic error checking
    if(nrow(data) == 0) {
      cat("No data available for summary table\n")
      return(
        DT::datatable(
          data.frame(
            Message = "No data available for the selected period"
          ),
          options = list(dom = 't')
        )
      )
    }
    
    # Check required columns
    req_cols <- c("Region_vlc", "Name_school_vlc", "nts_vlc_total_attendance_vlc", 
                  "nts_vlc_male_attendance_vlc", "nts_vlc_female_attendance_vlc", 
                  "nts_vlc_total_teachers_schoo_vlc", "nts_vlc_no_male_teachers_vlc", 
                  "nts_vlc_no_female_teachers_vlc")
    missing_cols <- req_cols[!req_cols %in% colnames(data)]
    
    if(length(missing_cols) > 0) {
      cat("Missing columns for summary table:", paste(missing_cols, collapse=", "), "\n")
      return(
        DT::datatable(
          data.frame(
            Message = paste("Missing required columns:", paste(missing_cols, collapse=", "))
          ),
          options = list(dom = 't')
        )
      )
    }
    
    # Define total number of schools per region based on provided data
    total_schools_by_region <- c(
      "Ahafo" = 3,
      "Ashanti" = 5,
      "Bono" = 5,
      "Bono East" = 4,
      "Central" = 4,
      "Eastern" = 9, 
      
      "Greater Accra" = 5,
      "North East" = 7,
      "Northern" = 8,
      "Oti" = 7,
      "Savannah" = 5,
      "Upper East" = 7,
      "Upper West" = 7,
      "Volta" = 11,
      "Western" = 6,
      "Western North" = 5
    )
    total_schools_overall <- 98 # Grand total
    
    # Prepare data for summary table with the requested columns
    tryCatch({
      # Create an empty dataframe to store our regional summaries
      summary_data <- data.frame()
      all_regions <- names(total_schools_by_region)
      
      # Process each region, including those that might not be in the filtered data
      for(region in all_regions) {
        # Get the data for this region (if any)
        region_data <- data[data$Region_vlc == region, ]
        
        # Total number of schools in the region from our reference data
        total_schools_in_region <- total_schools_by_region[region]
        if(is.na(total_schools_in_region)) total_schools_in_region <- 0
        
        # If we have no data for this region, create a row with zeros
        if(nrow(region_data) == 0) {
          region_row <- data.frame(
            Region = region,
            Total_Schools_In_Region = total_schools_in_region,
            Schools_With_VLC = 0,
            Number_Of_Sessions = 0,
            Avg_Sessions_Per_School = 0,
            Pct_Male_Learners = "0.0%",
            Pct_Female_Learners = "0.0%",
            Overall_Attendance_Rate = "0.0%",
            Pct_Schools_With_VLC = "0.0%",
            Avg_Learners_With_Disabilities = 0,
            stringsAsFactors = FALSE
          )
          
          summary_data <- rbind(summary_data, region_row)
          next
        }
        
        # Calculate metrics for this region
        schools_with_vlc <- length(unique(region_data$Name_school_vlc))
        number_of_sessions <- nrow(region_data)
        
        # Average sessions per school
        avg_sessions_per_school <- if(schools_with_vlc > 0) {
          number_of_sessions / schools_with_vlc
        } else {
          0
        }
        
        # CORRECTLY CALCULATE Gender percentages based on the example
        # Sum the attendance and teacher counts
        male_attendance <- sum(region_data$nts_vlc_male_attendance_vlc, na.rm = TRUE)
        female_attendance <- sum(region_data$nts_vlc_female_attendance_vlc, na.rm = TRUE)
        total_attendance <- sum(region_data$nts_vlc_total_attendance_vlc, na.rm = TRUE)
        
        male_teachers <- sum(region_data$nts_vlc_no_male_teachers_vlc, na.rm = TRUE)
        female_teachers <- sum(region_data$nts_vlc_no_female_teachers_vlc, na.rm = TRUE)
        total_teachers <- sum(region_data$nts_vlc_total_teachers_schoo_vlc, na.rm = TRUE)
        
        # Calculate percentages - male_attendance/male_teachers and female_attendance/female_teachers
        pct_male_learners <- if(male_teachers > 0) {
          (male_attendance / male_teachers) * 100
        } else {
          0
        }
        
        pct_female_learners <- if(female_teachers > 0) {
          (female_attendance / female_teachers) * 100
        } else {
          0
        }
        
        # Overall attendance rate - total_attendance/total_teachers
        overall_attendance_rate <- if(total_teachers > 0) {
          (total_attendance / total_teachers) * 100
        } else {
          0
        }
        
        # Print debugging information for gender percentages
        cat("Region:", region, "\n",
            "- Male attendance:", male_attendance, "of", male_teachers, "=", round(pct_male_learners, 1), "%\n",
            "- Female attendance:", female_attendance, "of", female_teachers, "=", round(pct_female_learners, 1), "%\n",
            "- Total attendance:", total_attendance, "of", total_teachers, "=", round(overall_attendance_rate, 1), "%\n")
        
        # Percentage of schools with VLC
        pct_schools_with_vlc <- if(total_schools_in_region > 0) {
          (schools_with_vlc / total_schools_in_region) * 100
        } else {
          0
        }
        
        # Average learners with disabilities
        if("nts_vlc_How_many_learners_wi_d_in_the_VLC_session" %in% colnames(data)) {
          learners_with_disabilities <- sum(region_data$nts_vlc_How_many_learners_wi_d_in_the_VLC_session, na.rm = TRUE)
          avg_learners_with_disabilities <- if(number_of_sessions > 0) {
            learners_with_disabilities / number_of_sessions
          } else {
            0
          }
        } else {
          avg_learners_with_disabilities <- 0
        }
        
        # Create row for this region
        region_row <- data.frame(
          Region = region,
          Total_Schools_In_Region = total_schools_in_region,
          Schools_With_VLC = schools_with_vlc,
          Number_Of_Sessions = number_of_sessions,
          Avg_Sessions_Per_School = round(avg_sessions_per_school, 1),
          Pct_Male_Learners = paste0(round(pct_male_learners, 1), "%"),
          Pct_Female_Learners = paste0(round(pct_female_learners, 1), "%"),
          Overall_Attendance_Rate = paste0(round(overall_attendance_rate, 1), "%"),
          Pct_Schools_With_VLC = paste0(round(pct_schools_with_vlc, 1), "%"),
          Avg_Learners_With_Disabilities = round(avg_learners_with_disabilities, 1),
          stringsAsFactors = FALSE
        )
        
        # Add to results dataframe
        summary_data <- rbind(summary_data, region_row)
      }
      
      # Calculate TOTAL row with properly corrected gender percentages
      total_male_attendance <- sum(data$nts_vlc_male_attendance_vlc, na.rm = TRUE)
      total_female_attendance <- sum(data$nts_vlc_female_attendance_vlc, na.rm = TRUE)
      total_attendance <- sum(data$nts_vlc_total_attendance_vlc, na.rm = TRUE)
      
      total_male_teachers <- sum(data$nts_vlc_no_male_teachers_vlc, na.rm = TRUE)
      total_female_teachers <- sum(data$nts_vlc_no_female_teachers_vlc, na.rm = TRUE)
      total_teachers <- sum(data$nts_vlc_total_teachers_schoo_vlc, na.rm = TRUE)
      
      # Calculate percentages for total row
      total_pct_male <- if(total_male_teachers > 0) {
        (total_male_attendance / total_male_teachers) * 100
      } else {
        0
      }
      
      total_pct_female <- if(total_female_teachers > 0) {
        (total_female_attendance / total_female_teachers) * 100
      } else {
        0
      }
      
      total_pct_overall <- if(total_teachers > 0) {
        (total_attendance / total_teachers) * 100
      } else {
        0
      }
      
      # Print debugging for total calculations
      cat("TOTAL:\n",
          "- Male attendance:", total_male_attendance, "of", total_male_teachers, "=", round(total_pct_male, 1), "%\n",
          "- Female attendance:", total_female_attendance, "of", total_female_teachers, "=", round(total_pct_female, 1), "%\n",
          "- Total attendance:", total_attendance, "of", total_teachers, "=", round(total_pct_overall, 1), "%\n")
      
      # Create total row with corrected calculations
      total_row <- data.frame(
        Region = "TOTAL",
        Total_Schools_In_Region = total_schools_overall,
        Schools_With_VLC = length(unique(data$Name_school_vlc)),
        Number_Of_Sessions = nrow(data),
        Avg_Sessions_Per_School = round(
          nrow(data) / max(1, length(unique(data$Name_school_vlc))), 1
        ),
        Pct_Male_Learners = paste0(round(total_pct_male, 1), "%"),
        Pct_Female_Learners = paste0(round(total_pct_female, 1), "%"),
        Overall_Attendance_Rate = paste0(round(total_pct_overall, 1), "%"),
        Pct_Schools_With_VLC = paste0(
          round(length(unique(data$Name_school_vlc)) / total_schools_overall * 100, 1),
          "%"
        ),
        Avg_Learners_With_Disabilities = if("nts_vlc_How_many_learners_wi_d_in_the_VLC_session" %in% colnames(data)) {
          round(
            sum(data$nts_vlc_How_many_learners_wi_d_in_the_VLC_session, na.rm = TRUE) / 
              max(1, nrow(data)), 1
          )
        } else {
          0
        },
        stringsAsFactors = FALSE
      )
      
      # Add totals row at the bottom
      summary_data <- rbind(summary_data, total_row)
      
      # Rename columns for better display
      colnames(summary_data) <- c(
        "Region",
        "Total Schools in Region",
        "Schools Organizing VLC",
        "Number of Sessions",
        "Avg Sessions per School",
        "% Male Learners",
        "% Female Learners",
        "Overall % Attendance",
        "% of Schools with VLC",
        "Avg Learners with Disabilities"
      )
      
      cat("Summary table prepared, rows:", nrow(summary_data), "\n")
      
      # Create the datatable with formatting
      DT::datatable(
        summary_data,
        options = list(
          pageLength = 20,  # Show all regions on one page
          dom = 'Bfrtip',   # Button, filter, processing display, table, info, pagination
          buttons = c('copy', 'csv', 'excel', 'pdf'),
          scrollX = TRUE,
          columnDefs = list(
            list(className = 'dt-center', targets = 1:9),
            list(className = 'dt-head-center', targets = 0:9)
          )
        ),
        rownames = FALSE,
        caption = "Regional VLC Session Summary",
        class = 'cell-border stripe',
        extensions = 'Buttons'
      ) %>%
        # Format with highlighting
        DT::formatStyle(
          'Region',
          target = 'row',
          backgroundColor = DT::styleEqual("TOTAL", "#f8f9fa")
        ) %>%
        # Highlight attendance rates
        DT::formatStyle(
          'Overall % Attendance',
          backgroundColor = DT::styleInterval(
            c(25, 50, 75),
            c('#f8d7da', '#fff3cd', '#d1e7dd', '#c3e6cb')
          )
        ) %>%
        # Highlight % of schools with VLC
        DT::formatStyle(
          '% of Schools with VLC',
          backgroundColor = DT::styleInterval(
            c(25, 50, 75),
            c('#f8d7da', '#fff3cd', '#d1e7dd', '#c3e6cb')
          )
        )
      
    }, error = function(e) {
      # Return error message if something goes wrong
      cat("ERROR creating summary table:", e$message, "\n")
      cat("Error traceback:", paste(capture.output(traceback()), collapse="\n"), "\n")
      return(
        DT::datatable(
          data.frame(
            Error_Message = paste("Error creating summary table:", e$message)
          ),
          options = list(dom = 't')
        )
      )
    })
  })
  
  
  ############################################school level server code
  # Minimal School Level Table Code - Removing all problematic styling
  # This version removes all styling that could cause errors
  
  # Keep using the filtered_school_data reactive
  filtered_school_data <- reactive({
    # Get the base data
    data <- vlc_data()
    
    # Apply region filter immediately (no button click required)
    if(!is.null(input$vls_school_region) && input$vls_school_region != "All Regions") {
      data <- data[data$Region_vlc == input$vls_school_region, ]
    }
    
    # Apply other filters only if update button has been clicked
    if(!is.null(input$vls_school_update) && input$vls_school_update > 0) {
      
      # Date range filter
      if(!is.null(input$vls_school_date_range)) {
        # Ensure dates are properly formatted
        start_date <- as.Date(input$vls_school_date_range[1])
        end_date <- as.Date(input$vls_school_date_range[2])
        
        # Make sure session_date is a Date object
        if(!"session_date" %in% colnames(data)) {
          if("start" %in% colnames(data)) {
            data$session_date <- as.Date(data$start)
          } else if("nts_vlc_date_session_vlc" %in% colnames(data)) {
            data$session_date <- as.Date(data$nts_vlc_date_session_vlc)
          } else {
            # Use today's date as fallback
            data$session_date <- Sys.Date()
          }
        } else if(!inherits(data$session_date, "Date")) {
          data$session_date <- as.Date(data$session_date)
        }
        
        # Apply date filter
        data <- data[!is.na(data$session_date) & 
                       data$session_date >= start_date & 
                       data$session_date <= end_date, ]
      }
      
      # School search filter
      if(!is.null(input$vls_school_search) && input$vls_school_search != "") {
        search_term <- tolower(input$vls_school_search)
        data <- data[grepl(search_term, tolower(data$Name_school_vlc)), ]
      }
    }
    
    return(data)
  })
  
  # Fixed school table data preparation
  vls_school_table_data <- reactive({
    # Get filtered data
    filtered_data <- filtered_school_data()
    
    # Check if we have data
    if(is.null(filtered_data) || nrow(filtered_data) == 0) {
      return(NULL)
    }
    
    # Get unique schools
    unique_schools <- unique(filtered_data$Name_school_vlc)
    
    # Create a dataframe to store the results
    school_summary <- data.frame()
    
    # Process each school
    for(school in unique_schools) {
      # Get data for this school
      school_data <- filtered_data[filtered_data$Name_school_vlc == school, ]
      
      # Get region for this school
      region <- school_data$Region_vlc[1]
      
      # Count meetings for this school
      meetings_count <- nrow(school_data)
      
      # Gather session information
      sessions <- school_data$nts_vlc_Session_vlc
      # Remove NA values
      sessions <- sessions[!is.na(sessions)]
      # Create session text
      sessions_text <- if(length(sessions) > 0) {
        unique_sessions <- unique(sessions)
        if(length(unique_sessions) > 0) {
          paste("VLC Session(s):", paste(unique_sessions, collapse = ", "))
        } else {
          "VLC Session(s): None"
        }
      } else {
        "VLC Session(s): None"
      }
      
      # Calculate attendance metrics with error handling
      male_attendance <- mean(school_data$nts_vlc_male_attendance_vlc, na.rm = TRUE)
      male_teachers <- max(school_data$nts_vlc_no_male_teachers_vlc, na.rm = TRUE)
      male_pct <- if(male_teachers > 0) {
        (male_attendance / male_teachers) * 100
      } else {
        0
      }
      
      female_attendance <- mean(school_data$nts_vlc_female_attendance_vlc, na.rm = TRUE)
      female_teachers <- max(school_data$nts_vlc_no_female_teachers_vlc, na.rm = TRUE)
      female_pct <- if(female_teachers > 0) {
        (female_attendance / female_teachers) * 100
      } else {
        0
      }
      
      total_attendance <- mean(school_data$nts_vlc_total_attendance_vlc, na.rm = TRUE)
      total_teachers <- max(school_data$nts_vlc_total_teachers_schoo_vlc, na.rm = TRUE)
      total_pct <- if(total_teachers > 0) {
        (total_attendance / total_teachers) * 100
      } else {
        0
      }
      
      # Check for learners with disabilities
      disability_count <- if("nts_vlc_How_many_learners_wi_d_in_the_VLC_session" %in% colnames(school_data)) {
        sum(school_data$nts_vlc_How_many_learners_wi_d_in_the_VLC_session, na.rm = TRUE)
      } else {
        0
      }
      
      # Create a row for this school
      school_row <- data.frame(
        Region = region,
        School = school,
        Meetings_Count = meetings_count,
        Sessions_Completed = sessions_text,
        Male_Attendance = male_attendance,
        Male_Teachers = male_teachers,
        Male_Pct = male_pct,
        Female_Attendance = female_attendance,
        Female_Teachers = female_teachers,
        Female_Pct = female_pct,
        Total_Attendance = total_attendance,
        Total_Teachers = total_teachers,
        Total_Pct = total_pct,
        Disability_Count = disability_count,
        stringsAsFactors = FALSE
      )
      
      # Add to school summary dataframe
      school_summary <- rbind(school_summary, school_row)
    }
    
    # Format the display values
    school_summary$Male_Pct_Display <- paste0(round(school_summary$Male_Pct, 1), "%")
    school_summary$Female_Pct_Display <- paste0(round(school_summary$Female_Pct, 1), "%")
    school_summary$Total_Pct_Display <- paste0(round(school_summary$Total_Pct, 1), "%")
    
    # Format the attendance counts
    school_summary$Male_Attendance_Display <- paste0(
      formatC(school_summary$Male_Attendance, format = "d", big.mark = ","), 
      " of ", 
      formatC(school_summary$Male_Teachers, format = "d", big.mark = ",")
    )
    
    school_summary$Female_Attendance_Display <- paste0(
      formatC(school_summary$Female_Attendance, format = "d", big.mark = ","), 
      " of ", 
      formatC(school_summary$Female_Teachers, format = "d", big.mark = ",")
    )
    
    school_summary$Total_Attendance_Display <- paste0(
      formatC(school_summary$Total_Attendance, format = "d", big.mark = ","), 
      " of ", 
      formatC(school_summary$Total_Teachers, format = "d", big.mark = ",")
    )
    
    return(school_summary)
  })
  
  # Minimal school table output with no styling
  output$vls_school_table <- renderDT({
    # Get the processed data
    school_data <- vls_school_table_data()
    
    # Check if we have data
    if(is.null(school_data) || nrow(school_data) == 0) {
      return(
        DT::datatable(
          data.frame(
            Message = "No data available for the selected filters. Try adjusting your search criteria."
          ),
          options = list(dom = 't')
        )
      )
    }
    
    # Create a subset of columns for display
    display_data <- school_data %>%
      select(
        Region,
        School,
        Meetings_Count,
        Sessions_Completed,
        Total_Attendance_Display,
        Total_Pct_Display,
        Male_Attendance_Display,
        Male_Pct_Display,
        Female_Attendance_Display,
        Female_Pct_Display,
        Disability_Count
      )
    
    # Rename columns for better display
    colnames(display_data) <- c(
      "Region",
      "School Name",
      "Meetings Held",
      "Sessions Completed",
      "Total Learners",
      "Overall Attendance (%)",
      "Male Learners",
      "Male Attendance (%)",
      "Female Learners",
      "Female Attendance (%)",
      "Learners with Disabilities"
    )
    
    # Create the datatable with safe styling options
    # Create the datatable with safe styling options
    DT::datatable(
      display_data,
      options = list(
        pageLength = 100,
        dom = 'Blfrtip',
        buttons = c('copy', 'csv', 'excel', 'pdf'),
        scrollX = TRUE,           # ← Enable horizontal scrolling
        scrollY = "500px",        # ← Add vertical scrolling height
        autoWidth = TRUE,         # ← Let DataTable auto-size columns
        columnDefs = list(
          list(className = 'dt-center', targets = 2:10),
          list(className = 'dt-head-center', targets = 0:10),
          # Add column width definitions
          list(width = "100px", targets = c(0)),      # Region
          list(width = "150px", targets = c(1)),      # School Name
          list(width = "80px", targets = c(2)),       # Meetings Held
          list(width = "200px", targets = c(3)),      # Sessions Completed
          list(width = "100px", targets = c(4:9)),    # Attendance columns
          list(width = "80px", targets = c(10))       # Disabilities column
        ),
        # ... rest of your existing rowCallback and createdRow code stays the same,
        # Safe JavaScript-based styling for alternating rows
        rowCallback = JS("function(row, data, index) {
        if(index % 2 === 0) {
          $(row).css({'background-color': '#f9f9f9'});
        } else {
          $(row).css({'background-color': 'white'});
        }
      }"),
        # Safe JavaScript-based styling for attendance rates
        createdRow = JS("function(row, data, dataIndex) {
        // Parse the overall attendance percentage
        var overallPct = parseFloat(data[5]);
        if (!isNaN(overallPct)) {
          // Remove the % sign for comparison
          overallPct = parseFloat(data[5].replace('%', ''));
          
          // Apply color based on value
          if (overallPct >= 75) {
            $('td:eq(5)', row).css('background-color', '#c3e6cb');
          } else if (overallPct >= 50) {
            $('td:eq(5)', row).css('background-color', '#d1e7dd');
          } else if (overallPct >= 25) {
            $('td:eq(5)', row).css('background-color', '#fff3cd');
          } else {
            $('td:eq(5)', row).css('background-color', '#f8d7da');
          }
        }
        
        // Parse the male attendance percentage
        var malePct = parseFloat(data[7]);
        if (!isNaN(malePct)) {
          // Remove the % sign for comparison
          malePct = parseFloat(data[7].replace('%', ''));
          
          // Apply color based on value
          if (malePct >= 75) {
            $('td:eq(7)', row).css('background-color', '#c3e6cb');
          } else if (malePct >= 50) {
            $('td:eq(7)', row).css('background-color', '#d1e7dd');
          } else if (malePct >= 25) {
            $('td:eq(7)', row).css('background-color', '#fff3cd');
          } else {
            $('td:eq(7)', row).css('background-color', '#f8d7da');
          }
        }
        
        // Parse the female attendance percentage
        var femalePct = parseFloat(data[9]);
        if (!isNaN(femalePct)) {
          // Remove the % sign for comparison
          femalePct = parseFloat(data[9].replace('%', ''));
          
          // Apply color based on value
          if (femalePct >= 75) {
            $('td:eq(9)', row).css('background-color', '#c3e6cb');
          } else if (femalePct >= 50) {
            $('td:eq(9)', row).css('background-color', '#d1e7dd');
          } else if (femalePct >= 25) {
            $('td:eq(9)', row).css('background-color', '#fff3cd');
          } else {
            $('td:eq(9)', row).css('background-color', '#f8d7da');
          }
        }
      }")
      ),
      rownames = FALSE,
      caption = "School Level VLC Session Data",
      extensions = c('Buttons')
    )
  })
  # Add download handler for the school table
  output$vls_school_download <- downloadHandler(
    filename = function() {
      paste("VLC_School_Data_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      # Get the processed data
      school_data <- vls_school_table_data()
      
      if(!is.null(school_data) && nrow(school_data) > 0) {
        # Create export version with formatted columns
        export_data <- data.frame(
          Region = school_data$Region,
          School = school_data$School,
          Meetings_Held = school_data$Meetings_Count,
          Sessions_Completed = school_data$Sessions_Completed,
          Male_Attendance = paste0(school_data$Male_Attendance, " of ", school_data$Male_Teachers),
          Male_Attendance_Pct = paste0(round(school_data$Male_Pct, 1), "%"),
          Female_Attendance = paste0(school_data$Female_Attendance, " of ", school_data$Female_Teachers),
          Female_Attendance_Pct = paste0(round(school_data$Female_Pct, 1), "%"),
          Total_Attendance = paste0(school_data$Total_Attendance, " of ", school_data$Total_Teachers),
          Overall_Attendance_Pct = paste0(round(school_data$Total_Pct, 1), "%"),
          Learners_With_Disabilities = school_data$Disability_Count
        )
        
        write.csv(export_data, file, row.names = FALSE)
      } else {
        # Create an empty CSV with column headers if no data
        write.csv(
          data.frame(
            Region = character(0),
            School = character(0),
            Meetings_Held = integer(0),
            Sessions_Completed = character(0),
            Male_Attendance = character(0),
            Male_Attendance_Pct = character(0),
            Female_Attendance = character(0),
            Female_Attendance_Pct = character(0),
            Total_Attendance = character(0),
            Overall_Attendance_Pct = character(0),
            Learners_With_Disabilities = integer(0)
          ),
          file, row.names = FALSE
        )
      }
    }
  )
  
  
  ###########################Tablet server code
  
  
  filtered_data <- reactive({
    data <- tablet_survey
    
    if(input$region_filter != "all") {
      data <- data[data$region_tablet == input$region_filter, ]
    }
    
    return(data)
  })
  
  # Total schools per region data
  total_schools_per_region <- data.frame(
    Region = c("Ahafo", "Ashanti", "Bono", "Bono East", "Central", "Eastern", 
               "Greater Accra", "North East", "Northern", "Oti", "Savannah", 
               "Upper East", "Upper West", "Volta", "Western", "Western North"),
    Total_Schools = c(18, 142, 36, 29, 75, 94, 46, 18, 29, 25, 12, 35, 31, 68, 36, 18)
  )
  
  # Update filter choices
  observe({
    regions <- c("All" = "all", sort(unique(tablet_survey$region_tablet)))
    updateSelectInput(session, "region_filter", choices = regions)
  })
  
  # Reset filters
  observeEvent(input$reset_filters, {
    updateSelectInput(session, "region_filter", selected = "all")
  })
  
  # Value Boxes
  output$total_schools <- renderValueBox({
    data <- filtered_data()
    reported_schools <- nrow(data)
    
    # Get total schools for the region
    if(input$region_filter == "all") {
      total_schools <- sum(total_schools_per_region$Total_Schools)
    } else {
      # Find matching region (case-insensitive)
      region_match <- total_schools_per_region$Total_Schools[
        tolower(total_schools_per_region$Region) == tolower(input$region_filter)
      ]
      total_schools <- ifelse(length(region_match) > 0, region_match, reported_schools)
    }
    
    # Avoid division by zero
    if(total_schools > 0) {
      percentage <- round((reported_schools/total_schools) * 100, 1)
      value_text <- paste0(reported_schools, "/", total_schools)
      subtitle_text <- paste0("Schools Reported (", percentage, "%)")
    } else {
      value_text <- reported_schools
      subtitle_text <- "Schools Reported"
    }
    
    valueBox(
      value = value_text,
      subtitle = subtitle_text,
      icon = icon("school"),
      color = "blue"
    )
  })
  
  output$tablets_received <- renderValueBox({
    data <- filtered_data()
    received <- sum(data$received_tablet == "Yes", na.rm = TRUE)
    
    # Get total schools for the region (same logic as total_schools value box)
    if(input$region_filter == "all") {
      total_schools <- sum(total_schools_per_region$Total_Schools)
    } else {
      # Find matching region (case-insensitive)
      region_match <- total_schools_per_region$Total_Schools[
        tolower(total_schools_per_region$Region) == tolower(input$region_filter)
      ]
      total_schools <- ifelse(length(region_match) > 0, region_match, nrow(data))
    }
    
    # Calculate percentage based on total schools in region, not just reported schools
    percentage <- round((received/total_schools) * 100, 1)
    
    valueBox(
      value = paste0(received, " (", percentage, "%)"),
      subtitle = "Schools with Tablets",
      icon = icon("tablet"),
      color = "green"
    )
  })
  
  output$tablets_total <- renderValueBox({
    data <- filtered_data()
    total_tablets <- sum(as.numeric(data$number_received), na.rm = TRUE)
    
    valueBox(
      value = total_tablets,
      subtitle = "Total Tablets Received",
      icon = icon("tablet"),
      color = "yellow"
    )
  })
  
  
  
  output$students_using <- renderValueBox({
    data <- filtered_data()
    schools_with_usage <- sum(data$learners_using_tablet %in% c("Yes, regularly (daily/weekly)", "Yes, occasionally"), na.rm = TRUE)
    
    # Get total schools for the region (same logic as other value boxes)
    if(input$region_filter == "all") {
      total_schools <- sum(total_schools_per_region$Total_Schools)
    } else {
      # Find matching region (case-insensitive)
      region_match <- total_schools_per_region$Total_Schools[
        tolower(total_schools_per_region$Region) == tolower(input$region_filter)
      ]
      total_schools <- ifelse(length(region_match) > 0, region_match, nrow(data))
    }
    
    received <- sum(data$received_tablet == "Yes", na.rm = TRUE)
    
    # Calculate percentage based on total schools in region
    percentage <- round((schools_with_usage/received) * 100, 1)
    
    valueBox(
      value = paste0(schools_with_usage, " (", percentage, "%)"),
      subtitle = "Schools with Students Using Tablets",
      icon = icon("users"),
      color = "purple"
    )
  })
  
  
  # tablet receipt status
  output$receipt_status_plot <- renderPlot({
    data <- filtered_data()
    
    # Get total schools for the region
    if(input$region_filter == "all") {
      total_schools <- sum(total_schools_per_region$Total_Schools)
    } else {
      # Find matching region (case-insensitive)
      region_match <- total_schools_per_region$Total_Schools[
        tolower(total_schools_per_region$Region) == tolower(input$region_filter)
      ]
      total_schools <- ifelse(length(region_match) > 0, region_match, nrow(data))
    }
    
    # Count actual responses
    yes_count <- sum(data$received_tablet == "Yes", na.rm = TRUE)
    no_count <- sum(data$received_tablet == "No", na.rm = TRUE)
    not_reported <- total_schools - nrow(data)
    
    # Create summary with proper categories
    receipt_summary <- data.frame(
      received_tablet = factor(c("Yes", "No", "Not Reported"), 
                               levels = c("Yes", "No", "Not Reported")),
      n = c(yes_count, no_count, not_reported),
      percentage = c(yes_count/total_schools * 100, 
                     no_count/total_schools * 100, 
                     not_reported/total_schools * 100)
    ) %>%
      filter(n > 0)  # Only show categories with data
    
    ggplot(receipt_summary, aes(x = received_tablet, y = n, fill = received_tablet)) +
      geom_col() +
      geom_text(aes(label = paste0(n, "\n(", round(percentage, 1), "%)")), 
                vjust = 0.5, color = "white", fontface = "bold", size = 4) +
      labs(title = "Has your school received the tablets ?",
           x = "Receipt Status",
           y = "Number of Schools") +
      theme_minimal() +
      theme(legend.position = "none") +
      scale_fill_manual(values = c("Yes" = "#2E8B57", "No" = "#DC143C", "Yet to Report" = "#808080"))
  })
  
  ###########tablet setup status
  output$setup_status_plot <- renderPlot({
    data <- filtered_data() %>%
      filter(received_tablet == "Yes")
    
    if(nrow(data) > 0) {
      # Get total schools that received tablets for the region
      if(input$region_filter == "all") {
        total_schools_received <- sum(tablet_survey$received_tablet == "Yes", na.rm = TRUE)
      } else {
        total_schools_received <- sum(tablet_survey$received_tablet == "Yes" & 
                                        tablet_survey$region_tablet == input$region_filter, na.rm = TRUE)
      }
      
      setup_summary <- data %>%
        count(tablet_setup) %>%
        mutate(percentage = n / total_schools_received * 100) %>%
        # Order with desired sequence
        mutate(tablet_setup = factor(tablet_setup, levels = c("Yes, all tablets", 
                                                              "Yes, some tablets", 
                                                              "No, none of the tablets")))
      
      ggplot(setup_summary, aes(x = tablet_setup, y = n, fill = tablet_setup)) +
        geom_col() +
        geom_text(aes(label = paste0(n, "\n(", round(percentage, 1), "%)")), 
                  vjust = 0.5, color = "white", fontface = "bold", size = 4) +
        labs(title = "Have the tablets been fully set up and configured for use, including being loaded with learner materials?",
             x = "Setup Status",
             y = "Number of Schools") +
        theme_minimal() +
        theme(legend.position = "none",
              axis.text.x = element_text(angle = 45, hjust = 1)) +
        scale_fill_manual(values = c("Yes, all tablets" = "#2E8B57", 
                                     "Yes, some tablets" = "#FFD700", 
                                     "No, none of the tablets" = "#DC143C"))
    }
  })
  
  ###########################################################################################################  
  # tablet distribution
  # Tablet Distribution Table with Export
  output$tablet_distribution_table <- DT::renderDataTable({
    
    # Get total schools per region from reference data
    total_schools_ref <- total_schools_per_region %>%
      rename(region_tablet = Region)
    
    # Count schools that have reported by region
    schools_reported <- filtered_data() %>%
      group_by(region_tablet) %>%
      summarise(schools_reported = n(), .groups = "drop")
    
    # Aggregate data by region
    distribution_summary <- filtered_data() %>%
      group_by(region_tablet) %>%
      summarise(
        schools_received_tablet = sum(received_tablet == "Yes", na.rm = TRUE),
        tablets_received = sum(as.numeric(number_received), na.rm = TRUE),
        year1_students = sum(as.numeric(No_year1_learners), na.rm = TRUE),
        .groups = "drop"
      ) %>%
      # Join with total schools and reported schools data
      left_join(total_schools_ref, by = "region_tablet") %>%
      left_join(schools_reported, by = "region_tablet") %>%
      mutate(
        difference = year1_students - tablets_received,
        schools_reported = ifelse(is.na(schools_reported), 0, schools_reported)
      ) %>%
      select(
        Region = region_tablet,
        `No. of schools in the region` = Total_Schools,
        `No. of schools that have reported` = schools_reported,
        `No. of schools that have received tablets` = schools_received_tablet,
        `No. of tablets received` = tablets_received,
        `No. of year 1 students` = year1_students,
        Difference = difference
      )
    
    DT::datatable(distribution_summary,
                  options = list(
                    pageLength = 20,
                    scrollX = TRUE,
                    dom = 'Bfrtip',  # B = buttons, f = filter, r = processing, t = table, i = info, p = pagination
                    buttons = list(
                      list(extend = 'copy', text = 'Copy'),
                      list(extend = 'csv', filename = 'tablet_distribution'),
                      list(extend = 'excel', filename = 'tablet_distribution')
                    )
                  ),
                  extensions = 'Buttons',
                  class = 'cell-border stripe') %>%
      DT::formatStyle(
        'Difference',
        backgroundColor = DT::styleInterval(0, c('#ffcccc', '#ccffcc'))
      )
  }, server = FALSE)
  
  
  ####################################################################################tablet usage
  output$tablet_usage_table <- DT::renderDataTable({
    
    # Get total schools per region from reference data
    total_schools_ref <- total_schools_per_region %>%
      rename(region_tablet = Region)
    
    # Count schools that have reported by region
    schools_reported <- filtered_data() %>%
      group_by(region_tablet) %>%
      summarise(schools_reported = n(), .groups = "drop")
    
    # Aggregate usage data by region
    usage_summary <- filtered_data() %>%
      group_by(region_tablet) %>%
      summarise(
        schools_received_tablet = sum(received_tablet == "Yes", na.rm = TRUE),
        schools_using_tablet = sum(learners_using_tablet %in% c("Yes, regularly (daily/weekly)", "Yes, occasionally"), na.rm = TRUE),
        .groups = "drop"
      ) %>%
      # Join with total schools and reported schools data
      left_join(total_schools_ref, by = "region_tablet") %>%
      left_join(schools_reported, by = "region_tablet") %>%
      mutate(
        difference = schools_received_tablet - schools_using_tablet,
        schools_reported = ifelse(is.na(schools_reported), 0, schools_reported),
        usage_percentage = ifelse(schools_received_tablet > 0, 
                                  round((schools_using_tablet / schools_received_tablet) * 100, 1), 
                                  0),
        # Create cleaner status indicators
        usage_status = case_when(
          usage_percentage < 30 ~ "🚨 LOW USAGE",
          usage_percentage < 60 ~ "⚠️ MEDIUM USAGE", 
          TRUE ~ "✅ HIGH USAGE"
        )
      ) %>%
      # Sort by usage percentage (highest first) and add ranking
      arrange(desc(usage_percentage)) %>%
      mutate(
        # Use rank() instead of row_number() to handle ties properly
        usage_rank = rank(-usage_percentage, ties.method = "min"),
        rank_display = case_when(
          usage_rank == 1 ~ "🥇 1st",
          usage_rank == 2 ~ "🥈 2nd", 
          usage_rank == 3 ~ "🥉 3rd",
          TRUE ~ paste0(usage_rank, 
                        case_when(
                          usage_rank %% 10 == 1 & usage_rank != 11 ~ "st",
                          usage_rank %% 10 == 2 & usage_rank != 12 ~ "nd",
                          usage_rank %% 10 == 3 & usage_rank != 13 ~ "rd",
                          TRUE ~ "th"
                        ))
        )
      ) %>%
      select(
        `Rank` = rank_display,
        Region = region_tablet,
        `Total No. schools` = Total_Schools,
        `No. of schools reporting` = schools_reported,
        `No. of schools that have received tablets` = schools_received_tablet,
        `No. schools using tablets` = schools_using_tablet,
        `Usage %` = usage_percentage,
        `Status` = usage_status,
        `Differences` = difference
      )
    
    # Create the clean DataTable
    DT::datatable(
      usage_summary,
      rownames = FALSE,  # Remove automatic row numbering
      options = list(
        pageLength = 20,
        scrollX = TRUE,
        dom = 'Bfrtip',
        buttons = list(
          list(extend = 'copy', text = 'Copy'),
          list(extend = 'csv', filename = 'tablet_usage_ranked'),
          list(extend = 'excel', filename = 'tablet_usage_ranked')
        ),
        order = list(list(6, 'desc')),  # Sort by Usage % (highest to lowest)
        columnDefs = list(
          list(targets = c(0, 6, 7), className = "dt-center"),  # Rank, Usage %, Status
          list(targets = c(2, 3, 4, 5, 8), className = "dt-center")  # Numeric columns
        )
      ),
      extensions = 'Buttons',
      class = 'cell-border stripe'
    ) %>%
      # Highlight regions based on usage performance
      DT::formatStyle(
        'Region',
        'Usage %',
        backgroundColor = DT::styleInterval(
          c(30, 60), 
          c('#ffebee', '#fff8e1', '#e8f5e8')
        ),
        fontWeight = DT::styleInterval(
          c(30, 70), 
          c('bold', 'normal', 'bold')
        )
      ) %>%
      # Rank column styling - highlight top performers
      DT::formatStyle(
        'Rank',
        backgroundColor = DT::styleEqual(
          c("🥇 1st", "🥈 2nd", "🥉 3rd"),
          c('#ffd700', '#c0c0c0', '#cd7f32')
        ),
        fontWeight = 'bold',
        textAlign = 'center'
      ) %>%
      # Clean usage percentage column - just color coding
      DT::formatStyle(
        'Usage %',
        backgroundColor = DT::styleInterval(
          c(30, 60), 
          c('#ef5350', '#ff9800', '#66bb6a')
        ),
        color = 'white',
        fontWeight = 'bold',
        textAlign = 'center'
      ) %>%
      # Status column styling
      DT::formatStyle(
        'Status',
        backgroundColor = DT::styleEqual(
          c("🚨 LOW USAGE", "⚠️ MEDIUM USAGE", "✅ HIGH USAGE"),
          c('#d32f2f', '#f57c00', '#388e3c')
        ),
        color = 'white',
        fontWeight = 'bold',
        textAlign = 'center'
      ) %>%
      # Differences column with traffic light system
      DT::formatStyle(
        'Differences',
        backgroundColor = DT::styleInterval(
          c(1, 10), 
          c('#4caf50', '#ff9800', '#f44336')
        ),
        color = DT::styleInterval(
          c(1, 10), 
          c('white', 'white', 'white')
        ),
        fontWeight = 'bold',
        textAlign = 'center'
      ) %>%
      # Add subtle background bars for schools that received tablets
      DT::formatStyle(
        'No. of schools that have received tablets',
        background = DT::styleColorBar(usage_summary$`No. of schools that have received tablets`, '#e3f2fd'),
        backgroundSize = '100% 50%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center bottom'
      ) %>%
      # Add subtle background bars for schools using tablets
      DT::formatStyle(
        'No. schools using tablets',
        background = DT::styleColorBar(usage_summary$`No. schools using tablets`, '#e8f5e8'),
        backgroundSize = '100% 50%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center bottom'
      )
    
  }, server = FALSE)
  
  ####################################################################################################################  
  
  ################################non usage barriers
  output$non_usage_reasons_table <- DT::renderDataTable({
    
    # Get schools not using tablets
    non_usage_data <- filtered_data() %>%
      filter(learners_using_tablet == "No")
    
    if(nrow(non_usage_data) > 0) {
      # Count reasons by region and calculate percentages
      reasons_summary <- non_usage_data %>%
        group_by(region_tablet) %>%
        summarise(
          not_setup = sum(reasons_setup == 1, na.rm = TRUE),
          teachers_not_trained = sum(reasons_teacher_training == 1, na.rm = TRUE),
          students_not_trained = sum(reason_student_training == 1, na.rm = TRUE),
          content_not_accessible = sum(reason_content_available == 1, na.rm = TRUE),
          charging_issues = sum(reason_charging == 1, na.rm = TRUE),
          prefer_hard_copy = sum(reason_hard_copy == 1, na.rm = TRUE),
          security_concerns = sum(reason_security == 1, na.rm = TRUE),
          total_schools = n(),
          .groups = "drop"
        ) %>%
        # Convert counts to percentages
        mutate(
          not_setup = round((not_setup / total_schools) * 100, 1),
          teachers_not_trained = round((teachers_not_trained / total_schools) * 100, 1),
          students_not_trained = round((students_not_trained / total_schools) * 100, 1),
          content_not_accessible = round((content_not_accessible / total_schools) * 100, 1),
          charging_issues = round((charging_issues / total_schools) * 100, 1),
          prefer_hard_copy = round((prefer_hard_copy / total_schools) * 100, 1),
          security_concerns = round((security_concerns / total_schools) * 100, 1)
        ) %>%
        select(-total_schools) %>%  # Remove the helper column
        rename(
          Region = region_tablet,
          `Not Set Up (%)` = not_setup,
          `Teachers Not Trained (%)` = teachers_not_trained,
          `Students Not Trained (%)` = students_not_trained,
          `Content Not Accessible (%)` = content_not_accessible,
          `Charging Issues (%)` = charging_issues,
          `Prefer Hard Copy (%)` = prefer_hard_copy,
          `Security Concerns (%)` = security_concerns
        )
    } else {
      # Create empty dataframe with correct structure
      reasons_summary <- data.frame(
        Region = character(0),
        `Not Set Up (%)` = numeric(0),
        `Teachers Not Trained (%)` = numeric(0),
        `Students Not Trained (%)` = numeric(0),
        `Content Not Accessible (%)` = numeric(0),
        `Charging Issues (%)` = numeric(0),
        `Prefer Hard Copy (%)` = numeric(0),
        `Security Concerns (%)` = numeric(0)
      )
    }
    
    DT::datatable(reasons_summary,
                  options = list(
                    pageLength = 20,
                    scrollX = TRUE,
                    dom = 't'
                  ),
                  class = 'cell-border stripe') %>%
      DT::formatStyle(
        columns = 2:8,
        backgroundColor = DT::styleInterval(c(25, 50, 75), c('#ffffff', '#fff3cd', '#ffeaa7', '#ff7675'))
      )
  }, server = FALSE)
  
  ##########usage by region
  output$usage_by_region <- renderPlot({
    data <- filtered_data() %>%
      filter(received_tablet == "Yes")
    
    if(nrow(data) > 0) {
      usage_summary <- data %>%
        group_by(region_tablet, learners_using_tablet) %>%
        summarise(count = n(), .groups = "drop") %>%
        mutate(percentage = count / sum(count) * 100)
      
      ggplot(usage_summary, aes(x = region_tablet, y = count, fill = learners_using_tablet)) +
        geom_col(position = "dodge") +
        geom_text(aes(label = count), position = position_dodge(width = 0.9), vjust = -0.5) +
        labs(title = "Tablet Usage Status by Region",
             x = "Region",
             y = "Number of Schools",
             fill = "Usage Status") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        scale_fill_manual(values = c("Yes, regularly (daily/weekly)" = "#228B22",
                                     "Yes, occasionally" = "#FFD700",
                                     "No" = "#DC143C"))
    }
  })
  
  # Tables
  output$setup_issues_table <- renderTable({
    data <- filtered_data()
    
    # Count setup issues
    issues <- data.frame(
      Issue = c("Technical Issues", "Lack of Knowledge", "Materials Not Installed", 
                "Authorization", "Software Problems", "Charging Issues"),
      Count = c(
        sum(data$reason_technical_issue == "Technical issues with the tablets", na.rm = TRUE),
        sum(data$reason_lack_knowledge == "Lack of technical staff/knowledge to set them up", na.rm = TRUE),
        sum(data$reason_learner_materials == "Learner materials not installed on tablets", na.rm = TRUE),
        sum(data$reason_authorisation == "Waiting for authorization/credentials", na.rm = TRUE),
        sum(data$reason_software == "Software installation problems", na.rm = TRUE),
        sum(data$reason_chargin == "Charging/power issues", na.rm = TRUE)
      )
    ) %>%
      filter(Count > 0) %>%
      arrange(desc(Count))
    
    issues
  }, striped = TRUE, hover = TRUE)
  
  output$usage_barriers_table <- renderTable({
    data <- filtered_data()
    
    barriers <- data.frame(
      Barrier = c("Not Set Up", "Teachers Not Trained", "Students Not Trained", 
                  "Content Issues", "Charging Issues", "Prefer Hard Copy", "Security"),
      Count = c(
        sum(data$reasons_setup == "Not yet set up", na.rm = TRUE),
        sum(data$reasons_teacher_training == "Teachers not trained", na.rm = TRUE),
        sum(data$reason_student_training == "Students not trained", na.rm = TRUE),
        sum(data$reason_content_available == "Content not accessible", na.rm = TRUE),
        sum(data$reason_charging == "Lack of charging facilities", na.rm = TRUE),
        sum(data$reason_hard_copy == "Prefer hard copies", na.rm = TRUE),
        sum(data$reason_security == "Security concerns", na.rm = TRUE)
      )
    ) %>%
      filter(Count > 0) %>%
      arrange(desc(Count))
    
    barriers
  }, striped = TRUE, hover = TRUE)
  
  
  
  
  
  # Detailed Data Table
  output$detailed_table <- DT::renderDataTable({
    data <- filtered_data() %>%
      select(school_tablet, region_tablet, district_tablet, received_tablet, 
             number_received, no_working_tablet, tablet_setup, learners_using_tablet,reasons_not_using_tablet,
             no_learners_tablet, No_year1_learners) %>%
      rename(
        School = school_tablet,
        Region = region_tablet,
        District = district_tablet,
        `Received Tablets` = received_tablet,
        `Total Received` = number_received,
        `Working Tablets` = no_working_tablet,
        `Setup Status` = tablet_setup,
        `Students Using` = learners_using_tablet,
        `Reason For Not Using Tablet` =  reasons_not_using_tablet,
        
        `No. Using Tablets` = no_learners_tablet,
        `Total Year 1` = No_year1_learners
      )
    
    DT::datatable(data, 
                  options = list(
                    pageLength = 800,
                    dom = 'Blfrtip',
                    buttons = c('copy', 'csv', 'excel', 'pdf'),
                    scrollX = TRUE,           
                    scrollY = "500px",       
                    autoWidth = TRUE,         
                    columnDefs = list(
                      list(className = 'dt-center', targets = 2:10),
                      list(className = 'dt-head-center', targets = 0:10),
                      # Add column width definitions
                      list(width = "100px", targets = c(0)),     
                      list(width = "150px", targets = c(1)),      
                      list(width = "80px", targets = c(2)),       
                      list(width = "200px", targets = c(3)),      
                      list(width = "100px", targets = c(4:9)),    
                      list(width = "80px", targets = c(10))       
                    )
                  ),
                  class = 'cell-border stripe')
  })
  
  
  
  ####################LESSON OBSERVATION DISAGGREGATED
  
  
  
  # Simple function to get variable percentages
  get_variable_percentages <- function(data, variable_list) {
    results <- data.frame()
    
    for (var in variable_list) {
      if (var %in% names(data)) {
        yes_count <- sum(data[[var]] == "Yes", na.rm = TRUE)
        total_count <- sum(!is.na(data[[var]]) & data[[var]] %in% c("Yes", "In Part", "No"))
        
        if (total_count > 0) {
          percentage <- round((yes_count / total_count) * 100, 2)
          results <- rbind(results, data.frame(
            Variable = var,
            Percentage = percentage,
            stringsAsFactors = FALSE
          ))
        }
      }
    }
    return(results)
  }
  
  # Get all variables from factor_names_nat_new
  all_variables <- unique(unlist(factor_names_nat_new))
  
  # Reactive for detailed breakdown
  # Add this debugging code to your reactive function to identify the issue
  
  detailed_breakdown_formatted <- reactive({
    # Get semester 1 data
    data_sem1 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_nat_new,
        term_lesson == "First Semester",
        if (input$year_lesson_delivery_nat != "Overall") begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_nat else TRUE
      )
    
    # Get semester 2 data
    data_sem2 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_nat_new,
        term_lesson == "Second Semester",
        if (input$year_lesson_delivery_nat != "Overall") begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_nat else TRUE
      )
    
    # DEBUG: Print all_variables to console
    print(paste("Total variables in all_variables:", length(all_variables)))
    print("All variables:")
    print(all_variables)
    
    # Get percentages for both semesters
    sem1_results <- get_variable_percentages(data_sem1, all_variables)
    sem2_results <- get_variable_percentages(data_sem2, all_variables)
    
    # DEBUG: Check what's returned by get_variable_percentages
    print(paste("Semester 1 results rows:", nrow(sem1_results)))
    print("Semester 1 variables:")
    print(sem1_results$Variable)
    
    print(paste("Semester 2 results rows:", nrow(sem2_results)))
    print("Semester 2 variables:")
    print(sem2_results$Variable)
    
    # Find missing variables
    missing_sem1 <- setdiff(all_variables, sem1_results$Variable)
    missing_sem2 <- setdiff(all_variables, sem2_results$Variable)
    
    print("Missing from Semester 1:")
    print(missing_sem1)
    print("Missing from Semester 2:")
    print(missing_sem2)
    
    # Merge results with debugging
    if (nrow(sem1_results) > 0 && nrow(sem2_results) > 0) {
      combined <- merge(sem1_results, sem2_results, by = "Variable", all = TRUE, suffixes = c("_Sem1", "_Sem2"))
      print(paste("Combined results after merge:", nrow(combined)))
    } else if (nrow(sem1_results) > 0) {
      combined <- sem1_results
      combined$Percentage_Sem2 <- NA
      print("Only semester 1 data available")
    } else if (nrow(sem2_results) > 0) {
      combined <- sem2_results
      combined$Percentage_Sem1 <- NA
      names(combined)[names(combined) == "Percentage"] <- "Percentage_Sem2"
      print("Only semester 2 data available")
    } else {
      print("No data available for either semester")
      return(data.frame(
        Variable = "No data available",
        `Semester 1 (%)` = "",
        `Semester 2 (%)` = "",
        `Difference (%)` = "",
        stringsAsFactors = FALSE,
        check.names = FALSE
      ))
    }
    
    # DEBUG: Print variables in combined result before formatting
    print("Variables in combined result before formatting:")
    print(combined$Variable)
    print(paste("Total rows in combined:", nrow(combined)))
    
    # Calculate differences and format (your existing code continues...)
    combined <- combined %>%
      mutate(
        `Semester 1 (%)` = ifelse(is.na(Percentage_Sem1), "N/A", paste0(Percentage_Sem1, "%")),
        `Semester 2 (%)` = ifelse(is.na(Percentage_Sem2), "N/A", paste0(Percentage_Sem2, "%")),
        `Difference (%)` = case_when(
          is.na(Percentage_Sem1) | is.na(Percentage_Sem2) ~ "N/A",
          TRUE ~ {
            diff_val <- round(Percentage_Sem2 - Percentage_Sem1, 2)
            case_when(
              diff_val > 0 ~ paste0("+", diff_val, "%"),
              diff_val < 0 ~ paste0(diff_val, "%"),
              TRUE ~ "0%"
            )
          }
        ),
        # Map variable names to descriptions
        Variable = case_when(
          Variable == "lesson_purpose" ~ "Is the purpose of the lesson clearly stated in the lesson plan and focused on learners achieving the lesson learning outcomes?",
          Variable == "lesson_unique_needs_learners" ~ "Are the unique needs of female learners, male learners, and learners with special education needs adequately catered for in the lesson plan?",
          Variable == "lesson_teacher_positive" ~ "Does the teacher maintain a positive and nonthreatening learning environment throughout the lesson?",
          Variable == "lesson_TLRs" ~ "Are teaching/learning materials and other resources including ICT being used to support learning of all categories of learners?",
          Variable == "lesson_learners_challenged" ~ "Are learners engaged on tasks that challenge them and demonstrate the teacher's high expectation of learner achievement?",
          Variable == "lesson_students_learning" ~ "Is there evidence that students are learning?",
          Variable == "lesson_teaching_differentiated" ~ "Is teaching differentiated to cater for the varied needs of all male learners, female learners, learners with special education needs etc?",
          Variable == "lesson_reallife_objects" ~ "Does the teacher use real life examples which are familiar to learners to explain concepts and their relevance?",
          Variable == "lesson_traditional_role" ~ "Does the teacher point out or question traditional gender roles when they come up during the lessons as appropriate?",
          Variable == "lesson_interactive_approaches" ~ "Does the lesson include appropriate interactive and creative approaches e.g., group work, role play, storytelling to support learners achieving the learning outcomes?",
          Variable == "lesson_integrating_21stcentury" ~ "Have cross-cutting issues and /or 21st century skills been integrated in the lesson e.g., problem-solving, critical thinking, communication?",
          Variable == "lesson_integrating_ICT" ~ "Does the teacher incorporate ICT into their practice to support learning?",
          Variable == "lesson_questioning" ~ "Does the teacher encourage learners to ask questions during the lesson?",
          Variable == "lesson_assessment" ~ "Evidence of assessment in the lesson",
          Variable == "lesson_feedback" ~ "Do learners make use of feedback from teacher and peers?",
          Variable == "lesson_evaluate_learning_outcome" ~ "Does the teacher evaluate the lesson against the learning outcomes?",
          Variable == "learning_overtime" ~ "Does the teachers' planning of lessons taught before the one observed show how they plan for learning over time, considering individual and group needs?",
          Variable == "composition_male_fem" ~ "Does the teacher pay attention to the composition of females and males during group work and assigns females leadership roles.",
          Variable == "constructive_male_fem" ~ "Does the teacher provide constructive verbal feedback to both females and males and learners with special education needs?",
          Variable == "constructive_written_male_fem" ~ "Does the teacher provide constructive written feedback to both females and males and learners with special education needs in their exercise book?",
          TRUE ~ Variable
        )
      ) %>%
      select(Variable, `Semester 1 (%)`, `Semester 2 (%)`, `Difference (%)`)
    
    # DEBUG: Final check
    print(paste("Final result rows:", nrow(combined)))
    
    return(combined)
  })
  
  # Alternative approach - inspect your get_variable_percentages function
  # Add this temporary debugging function to check what it's doing:
  
  debug_get_variable_percentages <- function(data, variables) {
    print("=== DEBUG get_variable_percentages ===")
    print(paste("Input data rows:", nrow(data)))
    print(paste("Input variables:", length(variables)))
    
    # Check if the function exists and what it returns
    result <- get_variable_percentages(data, variables)
    print(paste("Output rows:", nrow(result)))
    print("Output variables:")
    print(result$Variable)
    
    # Check for any filtering that might be happening
    print("=== END DEBUG ===")
    return(result)
  }
  
  # Use this in your reactive instead of get_variable_percentages temporarily:
  # sem1_results <- debug_get_variable_percentages(data_sem1, all_variables)
  # sem2_results <- debug_get_variable_percentages(data_sem2, all_variables)
  
  # Render the detailed table
  output$detailedTableNational_new <- DT::renderDataTable({
    req(nrow(detailed_breakdown_formatted()) > 0)
    
    DT::datatable(
      detailed_breakdown_formatted(),
      extensions = 'Buttons',
      options = list(
        pageLength = -1,
        dom = 'Bfrtip',
        buttons = list(
          list(extend = 'copy', className = 'btn btn-primary'),
          list(extend = 'csv', className = 'btn btn-success'),
          list(extend = 'excel', className = 'btn btn-info'),
          list(extend = 'pdf', className = 'btn btn-danger'),
          list(extend = 'print', className = 'btn btn-warning')
        ),
        scrollX = TRUE,
        scrollY = "600px",
        autoWidth = FALSE,
        columnDefs = list(
          list(className = 'dt-center', targets = c(1, 2, 3)),
          list(className = 'dt-left', targets = 0),
          list(width = '60%', targets = 0),
          list(width = '15%', targets = c(1, 2, 3))
        ),
        initComplete = DT::JS(
          "function(settings, json) {",
          "  $(this.api().table().header()).css({'background-color': '#fff3e0', 'color': 'black', 'font-weight': 'bold'});",
          "}"
        )
      ),
      rownames = FALSE,
      class = 'display nowrap table-striped table-bordered'
    ) %>%
      DT::formatStyle(
        "Difference (%)",
        backgroundColor = DT::styleInterval(
          0, c("rgba(255, 224, 224, 0.7)", "rgba(224, 255, 224, 0.7)")
        ),
        color = DT::JS("value.includes('-') ? 'darkred' : (value.includes('+') ? 'darkgreen' : 'black')"),
        fontWeight = "bold"
      ) %>%
      DT::formatStyle(
        columns = c("Variable", "Semester 1 (%)", "Semester 2 (%)", "Difference (%)"),
        fontSize = "13px",
        fontFamily = "Arial"
      )
  })
  ##################################regional breakdown
  # Regional Detailed Breakdown Server Code
  # Add this to your server section
  
  # Reactive for regional detailed breakdown
  regional_detailed_breakdown_formatted <- reactive({
    # Get semester 1 data for selected region
    data_sem1 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_reg_new,
        Region_lesson == input$region_select_reg_new,
        term_lesson == "First Semester",
        if (input$year_lesson_delivery_reg != "Overall") begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_reg else TRUE
      )
    
    # Get semester 2 data for selected region
    data_sem2 <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_reg_new,
        Region_lesson == input$region_select_reg_new,
        term_lesson == "Second Semester",
        if (input$year_lesson_delivery_reg != "Overall") begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_reg else TRUE
      )
    
    # Store sample sizes
    n_sem1 <- nrow(data_sem1)
    n_sem2 <- nrow(data_sem2)
    
    # Get percentages for both semesters
    sem1_results <- get_variable_percentages(data_sem1, all_variables)
    sem2_results <- get_variable_percentages(data_sem2, all_variables)
    
    # Merge results
    if (nrow(sem1_results) > 0 && nrow(sem2_results) > 0) {
      combined <- merge(sem1_results, sem2_results, by = "Variable", all = TRUE, suffixes = c("_Sem1", "_Sem2"))
    } else if (nrow(sem1_results) > 0) {
      combined <- sem1_results
      combined$Percentage_Sem2 <- NA
      n_sem2 <- 0
    } else if (nrow(sem2_results) > 0) {
      combined <- sem2_results
      combined$Percentage_Sem1 <- NA
      names(combined)[names(combined) == "Percentage"] <- "Percentage_Sem2"
      n_sem1 <- 0
    } else {
      return(data.frame(
        Variable = "No data available for this region",
        `Semester 1 (%)` = "",
        `Semester 2 (%)` = "",
        `Difference (%)` = "",
        stringsAsFactors = FALSE,
        check.names = FALSE
      ))
    }
    
    # Calculate differences and format
    combined <- combined %>%
      mutate(
        `Semester 1 (%)` = ifelse(is.na(Percentage_Sem1), "N/A", paste0(Percentage_Sem1, "%")),
        `Semester 2 (%)` = ifelse(is.na(Percentage_Sem2), "N/A", paste0(Percentage_Sem2, "%")),
        `Difference (%)` = case_when(
          is.na(Percentage_Sem1) | is.na(Percentage_Sem2) ~ "N/A",
          TRUE ~ {
            diff_val <- round(Percentage_Sem2 - Percentage_Sem1, 2)
            case_when(
              diff_val > 0 ~ paste0("+", diff_val, "%"),
              diff_val < 0 ~ paste0(diff_val, "%"),
              TRUE ~ "0%"
            )
          }
        ),
        # Map variable names to descriptions (same as national)
        Variable = case_when(
          Variable == "lesson_purpose" ~ "Is the purpose of the lesson clearly stated in the lesson plan and focused on learners achieving the lesson learning outcomes?",
          Variable == "lesson_unique_needs_learners" ~ "Are the unique needs of female learners, male learners, and learners with special education needs adequately catered for in the lesson plan?",
          Variable == "lesson_teacher_positive" ~ "Does the teacher maintain a positive and nonthreatening learning environment throughout the lesson?",
          Variable == "lesson_TLRs" ~ "Are teaching/learning materials and other resources including ICT being used to support learning of all categories of learners?",
          Variable == "lesson_learners_challenged" ~ "Are learners engaged on tasks that challenge them and demonstrate the teacher's high expectation of learner achievement?",
          Variable == "lesson_students_learning" ~ "Is there evidence that students are learning?",
          Variable == "lesson_teaching_differentiated" ~ "Is teaching differentiated to cater for the varied needs of all male learners, female learners, learners with special education needs etc?",
          Variable == "lesson_reallife_objects" ~ "Does the teacher use real life examples which are familiar to learners to explain concepts and their relevance?",
          Variable == "lesson_traditional_role" ~ "Does the teacher point out or question traditional gender roles when they come up during the lessons as appropriate?",
          Variable == "lesson_interactive_approaches" ~ "Does the lesson include appropriate interactive and creative approaches e.g., group work, role play, storytelling to support learners achieving the learning outcomes?",
          Variable == "lesson_integrating_21stcentury" ~ "Have cross-cutting issues and /or 21st century skills been integrated in the lesson e.g., problem-solving, critical thinking, communication?",
          Variable == "lesson_integrating_ICT" ~ "Does the teacher incorporate ICT into their practice to support learning?",
          Variable == "lesson_questioning" ~ "Does the teacher encourage learners to ask questions during the lesson?",
          Variable == "lesson_assessment" ~ "Evidence of assessment in the lesson",
          Variable == "lesson_feedback" ~ "Do learners make use of feedback from teacher and peers?",
          Variable == "lesson_evaluate_learning_outcome" ~ "Does the teacher evaluate the lesson against the learning outcomes?",
          Variable == "learning_overtime" ~ "Does the teachers' planning of lessons taught before the one observed show how they plan for learning over time, considering individual and group needs?",
          Variable == "composition_male_fem" ~ "Does the teacher pay attention to the composition of females and males during group work and assigns females leadership roles.",
          Variable == "constructive_male_fem" ~ "Does the teacher provide constructive verbal feedback to both females and males and learners with special education needs?",
          Variable == "constructive_written_male_fem" ~ "Does the teacher provide constructive written feedback to both females and males and learners with special education needs in their exercise book?",
          TRUE ~ Variable
        )
      ) %>%
      select(Variable, `Semester 1 (%)`, `Semester 2 (%)`, `Difference (%)`)
    
    # Add N row at the bottom
    n_row <- data.frame(
      Variable = "Number of lessons observed (N)",
      `Semester 1 (%)` = as.character(n_sem1),
      `Semester 2 (%)` = as.character(n_sem2),
      `Difference (%)` = "",
      stringsAsFactors = FALSE,
      check.names = FALSE
    )
    
    # Combine results with N row
    combined <- rbind(combined, n_row)
    
    return(combined)
  })
  
  # Render the regional detailed table
  output$detailedTableRegional_new <- DT::renderDataTable({
    req(nrow(regional_detailed_breakdown_formatted()) > 0)
    
    DT::datatable(
      regional_detailed_breakdown_formatted(),
      extensions = 'Buttons',
      options = list(
        pageLength = -1,
        dom = 'Bfrtip',
        buttons = list(
          list(extend = 'copy', className = 'btn btn-primary'),
          list(extend = 'csv', className = 'btn btn-success'),
          list(extend = 'excel', className = 'btn btn-info'),
          list(extend = 'pdf', className = 'btn btn-danger'),
          list(extend = 'print', className = 'btn btn-warning')
        ),
        scrollX = TRUE,
        scrollY = "600px",
        autoWidth = FALSE,
        columnDefs = list(
          list(className = 'dt-center', targets = c(1, 2, 3)),
          list(className = 'dt-left', targets = 0),
          list(width = '60%', targets = 0),
          list(width = '15%', targets = c(1, 2, 3))
        ),
        initComplete = DT::JS(
          "function(settings, json) {",
          "  $(this.api().table().header()).css({'background-color': '#e3f2fd', 'color': 'black', 'font-weight': 'bold'});", # Light blue header for regional
          "}"
        )
      ),
      rownames = FALSE,
      class = 'display nowrap table-striped table-bordered'
    ) %>%
      DT::formatStyle(
        'Variable',
        target = 'row',
        backgroundColor = DT::styleEqual("Number of lessons observed (N)", '#e8f5e9') # Light green for N row
      ) %>%
      DT::formatStyle(
        "Difference (%)",
        backgroundColor = DT::styleInterval(
          0, c("rgba(255, 224, 224, 0.7)", "rgba(224, 255, 224, 0.7)")
        ),
        color = DT::JS("value.includes('-') ? 'darkred' : (value.includes('+') ? 'darkgreen' : 'black')"),
        fontWeight = "bold"
      ) %>%
      DT::formatStyle(
        columns = c("Variable", "Semester 1 (%)", "Semester 2 (%)", "Difference (%)"),
        fontSize = "13px",
        fontFamily = "Arial"
      )
  })
  
  ###################school level strengths and weaknesses
  
  # Debug and Fixed code for school-level strength and areas display
  
  # Display strengths for selected school with debugging
  output$strengthTextDisplay_new <- renderDataTable({
    
    # Add validation for required inputs
    req(input$year_select_schl_new, input$region_select_schl_new, input$school_select_schl_new)
    
    # Filter data based on school UI selections
    filtered_data <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_schl_new,
        Region_lesson == input$region_select_schl_new,
        name_school == input$school_select_schl_new,
        if (input$year_lesson_delivery_schl != "Overall") begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_schl else TRUE
      )
    
    # Debug: Check if data exists
    if (nrow(filtered_data) == 0) {
      return(DT::datatable(
        data.frame(Message = "No data available for selected school"),
        options = list(dom = 't'),
        rownames = FALSE
      ))
    }
    
    # Select and clean the data
    display_data <- filtered_data %>%
      select(
        subject = begin_group_RRNG5Kxfl_aa6_subject,
        class = begin_group_RRNG5Kxfl_aa7_class,
        gender = begin_group_RRNG5Kxfl_b1_sex,
        term = term_lesson,
        strengths = newtextstrength
      ) %>%
      mutate(
        # Convert all columns to character and handle NAs
        subject = as.character(subject),
        class = as.character(class),
        gender = as.character(gender),
        term = as.character(term),
        strengths = as.character(strengths)
      ) %>%
      mutate(
        # Replace NAs and empty strings
        subject = ifelse(is.na(subject) | subject == "", "Not specified", subject),
        class = ifelse(is.na(class) | class == "", "Not specified", class),
        gender = ifelse(is.na(gender) | gender == "", "Not specified", gender),
        term = ifelse(is.na(term) | term == "", "Not specified", term),
        strengths = ifelse(is.na(strengths) | strengths == "", "No strengths recorded", strengths)
      ) %>%
      # Remove rows where strengths is truly empty
      filter(strengths != "No strengths recorded")
    
    # If no meaningful data, show message
    if (nrow(display_data) == 0) {
      return(DT::datatable(
        data.frame(Message = "No strengths recorded for this school selection"),
        options = list(dom = 't'),
        rownames = FALSE
      ))
    }
    
    # Render the table with improved styling
    DT::datatable(
      display_data, 
      options = list(
        pageLength = 10, 
        autoWidth = TRUE,
        scrollX = TRUE,
        dom = 'frtip',
        columnDefs = list(
          list(width = '15%', targets = c(0, 1, 2, 3)),  # subject, class, gender, term
          list(width = '40%', targets = 4),  # strengths column
          list(className = 'text-center', targets = c(0, 1, 2, 3)),
          list(className = 'text-left', targets = 4)
        )
      ),
      colnames = c('Subject', 'Class', 'Gender', 'Term', 'Key Strengths'),
      rownames = FALSE,
      escape = FALSE  # Allow HTML in cells if needed
    ) %>%
      DT::formatStyle(
        columns = c('Subject', 'Class', 'Gender', 'Term', 'Key Strengths'),
        fontSize = '12px',
        fontFamily = 'Arial'
      )
  })
  
  # Display areas for development for selected school with debugging
  output$areasForDevDisplay_new <- renderDataTable({
    
    # Add validation for required inputs
    req(input$year_select_schl_new, input$region_select_schl_new, input$school_select_schl_new)
    
    # Filter data based on school UI selections
    filtered_data <- lesson_data_new %>%
      filter(
        year_lesson == input$year_select_schl_new,
        Region_lesson == input$region_select_schl_new,
        name_school == input$school_select_schl_new,
        if (input$year_lesson_delivery_schl != "Overall") begin_group_RRNG5Kxfl_aa7_class == input$year_lesson_delivery_schl else TRUE
      )
    
    # Debug: Check if data exists
    if (nrow(filtered_data) == 0) {
      return(DT::datatable(
        data.frame(Message = "No data available for selected school"),
        options = list(dom = 't'),
        rownames = FALSE
      ))
    }
    
    # Select and clean the data
    display_data <- filtered_data %>%
      select(
        subject = begin_group_RRNG5Kxfl_aa6_subject,
        class = begin_group_RRNG5Kxfl_aa7_class,
        gender = begin_group_RRNG5Kxfl_b1_sex,
        term = term_lesson,
        areas_for_development = newtextareasfordev
      ) %>%
      mutate(
        # Convert all columns to character and handle NAs
        subject = as.character(subject),
        class = as.character(class),
        gender = as.character(gender),
        term = as.character(term),
        areas_for_development = as.character(areas_for_development)
      ) %>%
      mutate(
        # Replace NAs and empty strings
        subject = ifelse(is.na(subject) | subject == "", "Not specified", subject),
        class = ifelse(is.na(class) | class == "", "Not specified", class),
        gender = ifelse(is.na(gender) | gender == "", "Not specified", gender),
        term = ifelse(is.na(term) | term == "", "Not specified", term),
        areas_for_development = ifelse(is.na(areas_for_development) | areas_for_development == "", "No areas recorded", areas_for_development)
      ) %>%
      # Remove rows where areas is truly empty
      filter(areas_for_development != "No areas recorded")
    
    # If no meaningful data, show message
    if (nrow(display_data) == 0) {
      return(DT::datatable(
        data.frame(Message = "No areas for development recorded for this school selection"),
        options = list(dom = 't'),
        rownames = FALSE
      ))
    }
    
    # Render the table with improved styling
    DT::datatable(
      display_data, 
      options = list(
        pageLength = 10, 
        autoWidth = TRUE,
        scrollX = TRUE,
        dom = 'frtip',
        columnDefs = list(
          list(width = '15%', targets = c(0, 1, 2, 3)),  # subject, class, gender, term
          list(width = '40%', targets = 4),  # areas for development column
          list(className = 'text-center', targets = c(0, 1, 2, 3)),
          list(className = 'text-left', targets = 4)
        )
      ),
      colnames = c('Subject', 'Class', 'Gender', 'Term', 'Areas for Development'),
      rownames = FALSE,
      escape = FALSE  # Allow HTML in cells if needed
    ) %>%
      DT::formatStyle(
        columns = c('Subject', 'Class', 'Gender', 'Term', 'Areas for Development'),
        fontSize = '12px',
        fontFamily = 'Arial'
      )
  })
  
  
  
  
  thematic_analysis_2023_schl <- list(
    strengths = paste(
      "1️⃣ Some Teachers Demonstrated Strong Content Knowledge\n",
      "📌 While lesson planning was inconsistent, a few teachers displayed strong subject knowledge, effectively explaining concepts and answering student questions.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher was knowledgeable and explained concepts in a clear and structured manner."\n',
      '"The teacher was confident in delivering subject content, which helped students grasp difficult topics."\n',
      '"Lessons were detailed and covered key concepts comprehensively."\n\n',
      
      "2️⃣ A Few Lessons Were Interactive and Engaging\n",
      "📌 Only a limited number of lessons incorporated student-centered approaches. While most teachers relied on lecture-style delivery, some effectively used questioning and discussions to engage students.\n",
      "💡 Supporting Evidence:\n",
      '"In a few lessons, students were encouraged to ask questions and share their thoughts."\n',
      '"A handful of teachers used real-life examples to make learning more engaging."\n',
      '"There was some effort to use interactive questioning to assess students\' understanding."\n\n',
      
      "3️⃣ Some Teachers Provided Encouraging Feedback\n",
      "📌 Although formative assessment was not widely practiced, some teachers made efforts to provide positive reinforcement and verbal feedback during lessons.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher provided encouragement to students who attempted to answer questions."\n',
      '"Verbal feedback was given to motivate students to participate more in class."\n',
      '"Although feedback was mostly oral, it helped students feel supported."',
      sep = "\n"
    ),
    
    areas_for_improvement = paste(
      "1️⃣ Lack of Lesson Planning and Structured Lesson Delivery\n",
      "📌 Many teachers were not using lesson plans, leading to unstructured, disorganized lessons that lacked clear learning objectives. This affected lesson flow and student comprehension.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher did not follow a structured lesson plan, making the lesson hard to follow."\n',
      '"There was no clear sequence in lesson delivery; concepts were introduced without a structured approach."\n',
      '"Lessons lacked objectives, making it difficult to assess student learning."\n\n',
      
      "2️⃣ Limited Use of Interactive Teaching Methods\n",
      "📌 Most teachers used traditional lecture methods, with minimal student participation. Lessons were teacher-centered, and students had few opportunities for discussion or active engagement.\n",
      "💡 Supporting Evidence:\n",
      '"The lesson was mostly a lecture with little student participation."\n',
      '"Students were not engaged in meaningful discussions or activities."\n',
      '"There was little to no use of interactive teaching methods such as group work or class discussions."\n\n',
      
      "3️⃣ Poor Student Engagement and Classroom Interaction\n",
      "📌 Many students were passive learners, as teachers rarely encouraged discussions or peer interactions. In several cases, only a few students dominated classroom discussions.\n",
      "💡 Supporting Evidence:\n",
      '"Only a few students were actively answering questions, while most remained silent."\n',
      '"The teacher did not distribute questions equally, leading to unbalanced participation."\n',
      '"There was little effort to engage students who were not participating."\n\n',
      
      "4️⃣ Minimal Use of ICT and Teaching Resources\n",
      "📌 Lessons were mostly conducted without the integration of digital tools or teaching aids. Many classrooms lacked visual resources, making learning less engaging.\n",
      "💡 Supporting Evidence:\n",
      '"No teaching aids were used, making the lesson less interactive."\n',
      '"ICT was not integrated into lesson delivery."\n',
      '"There was a lack of multimedia resources such as videos and digital slides."\n\n',
      
      "5️⃣ Weak Classroom Management and Organization\n",
      "📌 Poor classroom management was noted in several observations, with student distractions and disorderly class behavior affecting lesson effectiveness.\n",
      "💡 Supporting Evidence:\n",
      '"Students were not paying attention, and the teacher struggled to manage classroom behavior."\n',
      '"Classroom organization was weak, leading to a noisy and disruptive learning environment."\n',
      '"More classroom discipline strategies are needed to maintain focus."',
      sep = "\n"
    )
  )
  
  
  thematic_analysis_2024_schl <- list(
    strengths = paste(
      "1️⃣ Effective Lesson Planning and Delivery\n",
      "📌 Many teachers demonstrate strong lesson planning skills, ensuring that learning objectives are clear and structured. Lessons are well-sequenced, allowing for smooth content delivery.\n",
      "💡 Supporting Evidence:\n",
      '"Lesson plan was well-structured with clear learning objectives."\n',
      '"Effective lesson delivery, allowing students to follow concepts easily."\n',
      '"Good lesson planning led to better student engagement."\n\n',
      
      "2️⃣ Use of Interactive and Learner-Centered Approaches\n",
      "📌 Teachers are employing interactive and learner-centered techniques, including group work, student discussions, and active engagement in the learning process. This enhances critical thinking and collaborative learning.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher encouraged group work and class discussions, making the lesson interactive."\n',
      '"Students were given opportunities to actively participate in class activities."\n',
      '"Good use of interactive strategies, such as peer learning and questioning."\n\n',
      
      "3️⃣ Strong Teaching and Learning Techniques\n",
      "📌 Many lessons exhibit effective teaching strategies, such as differentiated instruction and the use of real-life examples to enhance understanding. This allows students to connect theory with practice.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher effectively related lesson content to real-life situations."\n',
      '"Good differentiation techniques were used to cater to diverse learning needs."\n',
      '"Lesson content was simplified using real-world examples."\n\n',
      
      "4️⃣ Encouraging a Positive and Inclusive Learning Environment\n",
      "📌 Teachers are creating a welcoming and engaging classroom atmosphere, where students feel encouraged to participate and express their ideas. Constructive feedback is frequently given to guide learning.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher created a positive classroom environment where students felt confident to ask questions."\n',
      '"Encouraged both male and female students equally in class discussions."\n',
      '"Constructive feedback was given to guide student improvement."', 
      sep = "\n"
    ),
    
    areas_for_improvement = paste(
      "1️⃣ Enhancing the Use of ICT in Teaching\n",
      "📌 While some teachers integrate ICT tools into lessons, there is a need for more widespread use of technology to make learning more engaging and dynamic. Many observations noted a lack of digital teaching resources.\n",
      "💡 Supporting Evidence:\n",
      '"Teacher to integrate ICT into teaching to make lessons more engaging."\n',
      '"Limited use of ICT tools in lesson delivery; more digital resources are needed."\n',
      '"The use of multimedia (videos, digital slides) would improve lesson impact."\n\n',
      
      "2️⃣ Fair Distribution of Questions and Student Engagement\n",
      "📌 Some teachers need to ensure balanced participation by fairly distributing questions among students. Some students dominate discussions, while others remain passive.\n",
      "💡 Supporting Evidence:\n",
      '"Teacher should fairly distribute questions among all students."\n',
      '"Encouraging quieter students to participate will improve engagement."\n',
      '"More inclusive questioning techniques should be applied."\n\n',
      
      "3️⃣ Classroom Management and Organization\n",
      "📌 Some observations indicated that classroom seating arrangements and organization could be improved to enhance student focus and participation.\n",
      "💡 Supporting Evidence:\n",
      '"Classroom arrangements of desks were very poor, limiting student interaction."\n',
      '"Reorganizing seating to promote better group engagement is recommended."\n',
      '"A structured seating plan would enhance classroom discipline."\n\n',
      
      "4️⃣ Strengthening Assessment and Feedback Mechanisms\n",
      "📌 Teachers should increase the use of formative assessment techniques to provide timely and constructive feedback, ensuring that students track their progress effectively.\n",
      "💡 Supporting Evidence:\n",
      '"More use of formative assessments is needed to evaluate learning progress."\n',
      '"Providing written feedback would be helpful for student improvement."\n',
      '"Students benefit more when feedback is immediate and specific."',
      sep = "\n"
    )
  )
  
  #######################################################
  
  thematic_analysis_2025_schl <- list(
    strengths = paste(
      "1️⃣ Effective Lesson Planning and Delivery\n",
      "📌 Many teachers demonstrate strong lesson planning skills, ensuring that learning objectives are clear and structured. Lessons are well-sequenced, allowing for smooth content delivery.\n",
      "💡 Supporting Evidence:\n",
      '"Lesson plan was well-structured with clear learning objectives."\n',
      '"Effective lesson delivery, allowing students to follow concepts easily."\n',
      '"Good lesson planning led to better student engagement."\n\n',
      
      "2️⃣ Use of Interactive and Learner-Centered Approaches\n",
      "📌 Teachers are employing interactive and learner-centered techniques, including group work, student discussions, and active engagement in the learning process. This enhances critical thinking and collaborative learning.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher encouraged group work and class discussions, making the lesson interactive."\n',
      '"Students were given opportunities to actively participate in class activities."\n',
      '"Good use of interactive strategies, such as peer learning and questioning."\n\n',
      
      "3️⃣ Strong Teaching and Learning Techniques\n",
      "📌 Many lessons exhibit effective teaching strategies, such as differentiated instruction and the use of real-life examples to enhance understanding. This allows students to connect theory with practice.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher effectively related lesson content to real-life situations."\n',
      '"Good differentiation techniques were used to cater to diverse learning needs."\n',
      '"Lesson content was simplified using real-world examples."\n\n',
      
      "4️⃣ Encouraging a Positive and Inclusive Learning Environment\n",
      "📌 Teachers are creating a welcoming and engaging classroom atmosphere, where students feel encouraged to participate and express their ideas. Constructive feedback is frequently given to guide learning.\n",
      "💡 Supporting Evidence:\n",
      '"The teacher created a positive classroom environment where students felt confident to ask questions."\n',
      '"Encouraged both male and female students equally in class discussions."\n',
      '"Constructive feedback was given to guide student improvement."', 
      sep = "\n"
    ),
    
    areas_for_improvement = paste(
      "1️⃣ Enhancing the Use of ICT in Teaching\n",
      "📌 While some teachers integrate ICT tools into lessons, there is a need for more widespread use of technology to make learning more engaging and dynamic. Many observations noted a lack of digital teaching resources.\n",
      "💡 Supporting Evidence:\n",
      '"Teacher to integrate ICT into teaching to make lessons more engaging."\n',
      '"Limited use of ICT tools in lesson delivery; more digital resources are needed."\n',
      '"The use of multimedia (videos, digital slides) would improve lesson impact."\n\n',
      
      "2️⃣ Fair Distribution of Questions and Student Engagement\n",
      "📌 Some teachers need to ensure balanced participation by fairly distributing questions among students. Some students dominate discussions, while others remain passive.\n",
      "💡 Supporting Evidence:\n",
      '"Teacher should fairly distribute questions among all students."\n',
      '"Encouraging quieter students to participate will improve engagement."\n',
      '"More inclusive questioning techniques should be applied."\n\n',
      
      "3️⃣ Classroom Management and Organization\n",
      "📌 Some observations indicated that classroom seating arrangements and organization could be improved to enhance student focus and participation.\n",
      "💡 Supporting Evidence:\n",
      '"Classroom arrangements of desks were very poor, limiting student interaction."\n',
      '"Reorganizing seating to promote better group engagement is recommended."\n',
      '"A structured seating plan would enhance classroom discipline."\n\n',
      
      "4️⃣ Strengthening Assessment and Feedback Mechanisms\n",
      "📌 Teachers should increase the use of formative assessment techniques to provide timely and constructive feedback, ensuring that students track their progress effectively.\n",
      "💡 Supporting Evidence:\n",
      '"More use of formative assessments is needed to evaluate learning progress."\n',
      '"Providing written feedback would be helpful for student improvement."\n',
      '"Students benefit more when feedback is immediate and specific."',
      sep = "\n"
    )
  )
  
  ####################################################
  # Reactive: pick the right year's list, with a robust default
  thematic_analysis_schl <- reactive({
    req(input$year_select_schl_new)
    
    out <- switch(
      input$year_select_schl_new,
      "2023/2024 academic year" = thematic_analysis_2023_schl,
      "2024/2025 academic year" = thematic_analysis_2024_schl,
      "2025/2026 academic year" = thematic_analysis_2025_schl,
      NULL
    )
    
    if (is.null(out) || !all(c("strengths", "areas_for_improvement") %in% names(out))) {
      out <- list(
        strengths = "No data available for the selected academic year.",
        areas_for_improvement = "No data available for the selected academic year."
      )
    }
    out
  })
  
  # Helper: make <li> for each line; accept vector or newline-separated string
  generate_thematic_summary_html_schl <- function(title, content) {
    if (length(content) == 1) {
      content <- unlist(strsplit(content %||% "", "\n+"))
    }
    content <- content[!is.na(content) & nzchar(trimws(content))]
    
    htmltools::HTML(
      paste0(
        "<div style='padding:10px;'>",
        "<h4 style='font-weight:bold; color:#004085; background:#CCE5FF; padding:8px; border-radius:5px;'>",
        title, "</h4>",
        "<ul style='padding-left:18px; margin-top:10px;'>",
        paste0(
          vapply(
            content,
            function(x) paste0(
              "<li style='margin-bottom:10px; font-size:14px;'>",
              "<span style='font-size:16px;'>", htmltools::htmlEscape(x), "</span></li>"
            ),
            character(1)
          ),
          collapse = ""
        ),
        "</ul>",
        "</div>"
      )
    )
  }
  
  # Render: Key Strengths
  output$strengthsOutput_new_schl <- renderUI({
    d <- thematic_analysis_schl()
    generate_thematic_summary_html_schl("🔹 Key Strengths", d$strengths)
  })
  
  # Render: Areas for Improvement
  output$areasForDevOutput_new_schl <- renderUI({
    d <- thematic_analysis_schl()
    generate_thematic_summary_html_schl("⚠️ Areas That Need Improvement", d$areas_for_improvement)
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}






#section 4
### running the ui and server using the shinyApp function
shinyApp(ui = ui, server = server)


