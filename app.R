library(shiny)
library(shinythemes) 
library(shinydashboard)
library(shinyWidgets) 
library(shinyjs) 
library(ECharts2Shiny) 
library(DT)
library(ggimage) 
library(ggrepel)
library(ggpubr) 
library(fmsb)
library(grid)
library(kableExtra)
library(RColorBrewer)
library(tidyverse)
library(readxl)
library(reshape2)
library(stats)
library(fontawesome)
library(rsconnect)

jogos <- read_excel("jogos_futevolei.xlsx")

resumo <- read_excel("resumo_futevolei.xlsx")

medias <- read_excel("medias_futevolei.xlsx")

ui <- dashboardPage(skin = "black",
                    
  dashboardHeader(title = "Futevôlei", titleWidth = 180),
  
  dashboardSidebar(width = 200,             
    selectInput("jogadores", 
                label = tags$h5(fa("futbol", fill = "orange"), class = "orange--h5--dashboard", 
                                "Selecione o jogador:"),
                           choices = medias$Jogador,
                   selected = NULL, selectize = FALSE, size = 15),
       uiOutput("ui"),
    
    tags$br(),
    menuItem(tags$h5(fa("pen-square", fill = "orange"), class = "orange--h5--dashboard", 
                                         "Design: Eduardo Cecconi")),
    
    menuItem(tags$h5(fa("linkedin", fill = "orange"), class = "orange--h5--dashboard", 
                     "Contato"), href = "https://www.linkedin.com/in/eduardocecconi/"),
    
    menuItem(tags$h5(fa("book", fill = "orange"), class = "orange--h5--dashboard", 
                     "Comprar Livro"), href = "https://www.editoraappris.com.br/produto/4835-futevlei-compreender-para-jogar-melhor"),
    
    menuItem(tags$h5(fa("handshake", fill = "orange"), class = "orange--h5--dashboard", 
                     "Apoio: SQD Futevôlei")),

    menuItem(tags$h5(fa("instagram", fill = "orange"), class = "orange--h5--dashboard", 
                     "Contato"), href = "https://www.instagram.com/sqdfutevolei/?hl=pt-br")
    
    ),
    dashboardBody(includeCSS("style.css"),
      tags$head(tags$style(HTML('  /* body */
                                .content-wrapper, .center {
                                background-color: #333333;
                                }'))),
      
      tabsetPanel(type = "pills", id = 'futevolei',
        tabPanel("Geral", 
                 fluidRow(
                   column(width = 12,
                          verbatimTextOutput("abregeral"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Jogos Analisados", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Ações por jogo", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                        tags$img(src = "jogos.png", height = 150, weight = 150, 
                                 style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("jogos", width = 12)),
                   column(width = 2, 
                          tags$img(src = "acoes.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("acoes", width = 12))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Pontos por jogo", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Erros por jogo", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "pontos.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("pontos", width = 12)),
                   column(width = 2, 
                          tags$img(src = "cedidos.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("cedidos", width = 12))
                 ),

        ),
        
        tabPanel("Mapa de Ataque",
                 fluidRow(
                   column(width = 12,
                          verbatimTextOutput("abreataquegeral"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Total de Ataques", class = "white--h3")),
                   column(width = 6,
                          tags$h3("3º toque de graça", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "volume.png", height = 150, weight = 150, 
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("ataqueporjogo", width = 12)),
                   column(width = 2, 
                          tags$img(src = "degraca.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("degraca3media", width = 12))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Ponto de Ataque", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Erro de Ataque", class = "white--h3"))
                 ),
                 
                 tags$br(), 
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "acertoataque.png", height = 150, weight = 150, 
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("acertoataqueperc", width = 12)),
                   column(width = 2, 
                          tags$img(src = "erroataque.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("erroataqueperc", width = 12))
                 ),
                 
                 tags$br(), 
                 tags$br(), 
                 tags$br(), 
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Volume de Ataque", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Mapa de Calor por Quadrante", class = "white--h3"))
                 ),
                
                fluidRow(
                  column(width = 4, align = "center", 
                         DT::dataTableOutput("tabelamapaataque")),
                  column(width = 8, align = "center", 
                         plotOutput("mapaataque", width = 750, height = 750))
           
                )

        ),
        
        tabPanel("Ataque - Comparativo",
                 fluidRow(
                   verbatimTextOutput("abrevolumeataque")
                 ),

                 tags$br(),
                 fluidRow(
                   column(width = 4, align = "center", 
                          DT::dataTableOutput("tabelavolume")),
                   column(width = 8, align = "center", 
                          plotOutput("sonarvolume"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   verbatimTextOutput("abreacertoataque")
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 4, align = "center", 
                          DT::dataTableOutput("tabelaacerto")),
                   column(width = 8, align = "center", 
                          plotOutput("sonaracerto"))
                 )
                 
        ),
        
        tabPanel("Defesa",
                 fluidRow(
                   verbatimTextOutput("abredefesa")
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Defesas por jogo", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Defesas para Levantada", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "muralha.png", height = 150, weight = 150, 
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("defesaporjogo", width = 12)),
                   column(width = 2, 
                          tags$img(src = "defesa.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("defesalevantadajogo", width = 12))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Rebatidas de 1ª", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Defesas Erradas", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "rebatida.png", height = 150, weight = 150, 
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("rebatidaprimeira", width = 12)),
                   column(width = 2, 
                          tags$img(src = "voleio.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("defesaerradajogo", width = 12))
                 ),
                 
                 tags$br(), 
                 fluidRow(
                   column(width = 12,
                          tags$h3("Quando os Adversários da Direita Atacaram...", class = "orange--h3"))
                 ),
                 
                 tags$br(), 
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Pontos Sofridos (total)", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Mapa de Defesas (individual)", class = "white--h3"))
                 ),
                 
                 fluidRow(
                   column(width = 6, align = "center", 
                          plotOutput("mapapontossofridosdireita", width = 700, height = 700)),
                   column(width = 6, align = "center", 
                          plotOutput("mapadefesasdireitaadv", width = 700, height = 700))
                   
                 ),
                 
                 tags$br(), 
                 fluidRow(
                   column(width = 12,
                          tags$h3("Quando os Adversários da Esquerda Atacaram...", class = "orange--h3"))
                 ),
                 
                 tags$br(), 
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Pontos Sofridos (total)", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Mapa de Defesas (individual)", class = "white--h3"))
                 ),
                 
                 fluidRow(
                   column(width = 6, align = "center", 
                          plotOutput("mapapontossofridosesquerda", width = 700, height = 700)),
                   column(width = 6, align = "center", 
                          plotOutput("mapadefesasesquerdaadv", width = 700, height = 700))
                   
                 )
          
        ),
        
        tabPanel("Levantada", 
                 fluidRow(
                   column(width = 12,
                          verbatimTextOutput("abrelevantada"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Levantadas por jogo", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Levantadas para Ataque", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "levantada.png", height = 150, weight = 150, 
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("levantadatotal", width = 12)),
                   column(width = 2, 
                          tags$img(src = "lampada.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("levantadaataquejogo", width = 12))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Tempo de Levantada (seg)", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Levantadas Erradas", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "tempo.png", height = 150, weight = 150, 
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("tempolevantadamedia", width = 12)),
                   column(width = 2, 
                          tags$img(src = "errolevantada.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("errolevantadajogo", width = 12))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Ataques de 2ª", class = "white--h3")),
                   column(width = 6,
                          tags$h3("De Graça de 2ª", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "de2a.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("ataque2ajogo", width = 12)),
                   column(width = 2, 
                          tags$img(src = "degraca.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("degraca2ajogo", width = 12))
                 ),
                 
        ),
        
        tabPanel("Saque/Recepção", 
                 fluidRow(
                   column(width = 12,
                          verbatimTextOutput("abresaquerecepcao"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Saques por jogo", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Recepções por jogo", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "saque.png", height = 150, weight = 150, 
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("saquesporjogo", width = 12)),
                   column(width = 2, 
                          tags$img(src = "volume2.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("recepcoesporjogo", width = 12))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Pontos de Saque (total)", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Erro de Saque (total)", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "saquecerto.png", height = 150, weight = 150, 
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("pontosaquetotal", width = 12)),
                   column(width = 2, 
                          tags$img(src = "saqueerrado.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("errosaquetotal", width = 12))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 6, 
                          tags$h3("Recepção para Levantada", class = "white--h3")),
                   column(width = 6,
                          tags$h3("Recepção Errada", class = "white--h3"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 2, 
                          tags$img(src = "recepcaocerta.png", height = 150, weight = 150, 
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("recepcaolevantadajogo", width = 12)),
                   column(width = 2, 
                          tags$img(src = "recepcaoerrada.png", height = 150, weight = 150,
                                   style="float:right")),
                   column(width = 4, align = "center", 
                          valueBoxOutput("recepcaoerradajogo", width = 12))
                 )
                 
        ),
        
        tabPanel("Rankings", 
                 fluidRow(
                   column(width = 12,
                          tags$h3("Rankings das Médias por Indicador", class = "orange--h2"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 4, 
                          tags$h3("Pontos Feitos", class = "white--h5--rankings")),
                   column(width = 4, 
                          tags$h3("Pontos Cedidos", class = "white--h5--rankings")),
                   column(width = 4, 
                          tags$h3("Volume de Ataque", class = "white--h5--rankings"))
                 ),
                 
                 
                 tags$br(),
                 fluidRow(
                   column(width = 4,
                          tableOutput("rankingpontos")),
                   column(width = 4,
                          tableOutput("rankingerros")),
                   column(width = 4,
                          tableOutput("rankingataques"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 4, 
                          tags$h3("Total de Ações", class = "white--h5--rankings")),
                   column(width = 4, 
                          tags$h3("Acerto de Ataque (%)", class = "white--h5--rankings")),
                   column(width = 4, 
                          tags$h3("Erro de Ataque (%)", class = "white--h5--rankings"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 4,
                          tableOutput("rankingacoes")),
                   column(width = 4,
                          tableOutput("rankingacertoataque")),
                   column(width = 4,
                          tableOutput("rankingerroataque"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 4, 
                          tags$h3("Ataques de 2ª", class = "white--h5--rankings")),
                   column(width = 4, 
                          tags$h3("Levantada para Ataque (%)", class = "white--h5--rankings")),
                   column(width = 4, 
                          tags$h3("Tempo de Levantada (seg)", class = "white--h5--rankings"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 4,
                          tableOutput("rankingataque2a")),
                   column(width = 4,
                          tableOutput("rankinglevantadaataque")),
                   column(width = 4,
                          tableOutput("rankingtempolevantada"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 4, 
                          tags$h3("Defesas", class = "white--h5--rankings")),
                   column(width = 4, 
                          tags$h3("Defesa para Levantada (%)", class = "white--h5--rankings")),
                   column(width = 4, 
                          tags$h3("Recepção para Levantada (%)", class = "white--h5--rankings"))
                  ),
                 
                 tags$br(),
                 fluidRow(
                 column(width = 4,
                        tableOutput("rankingdefesas")),
                 column(width = 4,
                        tableOutput("rankingdefesalevantada")),
                 column(width = 4,
                        tableOutput("rankingrecepcaolevantada"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                 column(width = 4, 
                          tags$h3("Saques Recebidos", class = "white--h5--rankings")),
                 column(width = 4, 
                        tags$h3("Saques Feitos", class = "white--h5--rankings")),
                 column(width = 4, 
                        tags$h3("Pontos de Saque (Total)", class = "white--h5--rankings"))
                 ),
                 
                 tags$br(),
                 fluidRow(
                   column(width = 4,
                          tableOutput("rankingsaquesrecebidos")),
                   column(width = 4,
                          tableOutput("rankingsaquesfeitos")),
                   column(width = 4,
                          tableOutput("rankingpontossaque"))
                 )
                 
        )
        
      )
    )
  )

server <- function(input, output) {
  
  observeEvent(input$jogadores, {

###TAB GERAL
    
#SELEÇÃO DO NOME ANALISADO
    
    Nome <- input$jogadores
    dadosGeral <- as.data.frame(medias[medias$Jogador == Nome, ])

#ABRE GERAL
    
    output$abregeral <- renderText({
      paste("Análise Individual - ", input$jogadores)
  })

#DASHBOARD GERAL
    
    output$jogos <- renderValueBox({
      valueBox(tags$p(dadosGeral$Jogos, style = "font-size: 200%;background-color: #333333",
                      fa("list", fill = "white", fill_opacity =  "0.5")), color = "black",
               subtitle = tags$p("Total", style = "font-size: 200%;"))
    })
    
    output$acoes <- renderValueBox({
      media_acoes <- mean(medias$Acoes)
      if(dadosGeral$Acoes > media_acoes){
        valueBox(tags$p(HTML(paste0(dadosGeral$Acoes)), 
                        fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black", 
                 subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
      } else {
        valueBox(tags$p(HTML(paste0(dadosGeral$Acoes)), 
                        fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black",
                 subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
      }
    })
    
    output$pontos <- renderValueBox({
      media_pontos_feitos <- mean(medias$Ponto)
      if(dadosGeral$Ponto > media_pontos_feitos){
        valueBox(tags$p(HTML(paste0(dadosGeral$Ponto)), 
                        fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black",
                 subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
      } else {
        valueBox(tags$p(HTML(paste0(dadosGeral$Ponto)), 
                        fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black",
                 subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
      }
    })
    
    output$cedidos <- renderValueBox({
      media_pontos_cedidos <- mean(medias$Erro)
      if(dadosGeral$Erro < media_pontos_cedidos){
        valueBox(tags$p(HTML(paste0(dadosGeral$Erro)), 
                        fa("arrow-circle-down", fill = "green", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black",
                 subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
      } else {
        valueBox(tags$p(HTML(paste0(dadosGeral$Erro)), 
                        fa("arrow-circle-up", fill = "red", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black",
                 subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
      }
    })

###TAB MAPA DE ATAQUES

#ABRE DASHBOARD ATAQUE
    
    output$abreataquegeral <- renderText({
        paste(input$jogadores, ": Indicadores de Ataque por Jogo")
      })
    
#WRANGLING DASHBOARD ATAQUE
    
    indicadores_ataque <- medias %>% 
      mutate("(%) Acerto" = (Ponto_Ataque * 100) / Ataque_Total,
             "(%) Erro" = (Erro_Ataque * 100) / Ataque_Total) %>% 
      rename("Ataques por jogo" = Ataque_Total,
             "De Graça" = Devolucao_3T) %>% 
      select(Jogador, `Ataques por jogo`, `(%) Acerto`,
             `(%) Erro`, `De Graça`) %>% 
      filter(Jogador == Nome) %>% 
      mutate_if(is.numeric, round, 2)

#DASHBOARD ATAQUE
    
    output$ataqueporjogo <- renderValueBox({
      media_ataques_jogo <- mean(medias$Ataque_Total)
      if(indicadores_ataque$`Ataques por jogo` > media_ataques_jogo){
        valueBox(tags$p(HTML(paste0(indicadores_ataque$`Ataques por jogo`)), 
                        fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black", 
                 subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
      } else {
        valueBox(tags$p(HTML(paste0(indicadores_ataque$`Ataques por jogo`)), 
                        fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black",
                 subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
      }
    })
    
    output$degraca3media <- renderValueBox({
      media_degraca3t_jogo <- mean(medias$Devolucao_3T)
      if(indicadores_ataque$`De Graça` < media_degraca3t_jogo){
        valueBox(tags$p(HTML(paste0(indicadores_ataque$`De Graça`)), 
                        fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black", 
                 subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
      } else {
        valueBox(tags$p(HTML(paste0(indicadores_ataque$`De Graça`)), 
                        fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black",
                 subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
      }
    })
    
    output$acertoataqueperc <- renderValueBox({
      media_acertoataqueperc <- medias %>% 
        mutate("(%) Acerto" = mean((Ponto_Ataque * 100) / Ataque_Total)) %>% 
        select(`(%) Acerto`)
        
      if(indicadores_ataque$`(%) Acerto` > media_acertoataqueperc){
        valueBox(tags$p(HTML(paste0(indicadores_ataque$`(%) Acerto`, "%")), 
                        fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black", 
                 subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
      } else {
        valueBox(tags$p(HTML(paste0(indicadores_ataque$`(%) Acerto`, "%")), 
                        fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black",
                 subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
      }
    })
    
    output$erroataqueperc <- renderValueBox({
      media_erroataqueperc <- medias %>% 
        mutate("(%) Erro" = mean((Erro_Ataque * 100) / Ataque_Total)) %>% 
        select(`(%) Erro`)
      
      if(indicadores_ataque$`(%) Erro` < media_erroataqueperc){
        valueBox(tags$p(HTML(paste0(indicadores_ataque$`(%) Erro`, "%")), 
                        fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black", 
                 subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
      } else {
        valueBox(tags$p(HTML(paste0(indicadores_ataque$`(%) Erro`, "%")), 
                        fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                        style = "font-size: 200%;"), color = "black",
                 subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
      }
    })
      
      
#CONSTRUÇÃO DO MAPA DE ATAQUES
      
      output$mapaataque <- renderPlot(color = "black", bg = "transparent",  {  
        mapa_ataques_volume <- resumo %>%
          select(Jogador, Lado, DC, PM, PA, MD, MM, MP, DL, MF, PL) %>%
          filter(Jogador == Nome) %>%
          rename(diagonalcurta = DC,
                 pingomeio = PM,
                 pingoatras = PA,
                 diagonalmeio = MD,
                 meio = MM,
                 paralelacurta = MP,
                 diagonallonga = DL,
                 meiofundo = MF,
                 paralela = PL) %>%
          melt() %>%
          rename(Lado = 2, Tipo = 3, Valor = 4) %>%
          group_by(Tipo)
        
        Quadrantes_Direita <- data.frame(Tipo = c("diagonalcurta", "pingomeio", "pingoatras",
                                                  "diagonalmeio", "meio", "paralelacurta",
                                                  "diagonallonga", "meiofundo", "paralela"),
                                         location.x = c(15, 15, 15, 45, 45, 45, 75, 75, 75),
                                         location.y = c(75, 45, 15, 75, 45, 15, 75, 45, 15))
        
        Quadrantes_Direita$xbin <- cut(Quadrantes_Direita$location.x,
                                       breaks = seq(from=0, to=90, by = 30),include.lowest=TRUE )
        Quadrantes_Direita$ybin <- cut(Quadrantes_Direita$location.y,
                                       breaks = seq(from=0, to=90, by = 30),include.lowest=TRUE)
        
        Quadrantes_Direita <- Quadrantes_Direita %>%
          group_by(Tipo, xbin, ybin)
        
        mapa_ataques_direita <- full_join(mapa_ataques_volume, Quadrantes_Direita, "Tipo")
        
        Quadrantes_Esquerda <- data.frame(Tipo = c("diagonalcurta", "pingomeio", "pingoatras",
                                                   "diagonalmeio", "meio", "paralelacurta",
                                                   "diagonallonga", "meiofundo", "paralela"),
                                          location.x = c(15, 15, 15, 45, 45, 45, 75, 75, 75),
                                          location.y = c(15, 45, 75, 15, 45, 75, 15, 45, 75))
        
        Quadrantes_Esquerda$xbin <- cut(Quadrantes_Esquerda$location.x,
                                        breaks = seq(from=0, to=90, by = 30),include.lowest=TRUE )
        Quadrantes_Esquerda$ybin <- cut(Quadrantes_Esquerda$location.y,
                                        breaks = seq(from=0, to=90, by = 30),include.lowest=TRUE)
        
        Quadrantes_Esquerda <- Quadrantes_Esquerda %>%
          group_by(Tipo, xbin, ybin)
        
        mapa_ataques_esquerda <- full_join(mapa_ataques_volume, Quadrantes_Esquerda, "Tipo")
        
        if(mapa_ataques_volume$Lado == "Direita"){
          ggplot(data= mapa_ataques_direita, aes(x = location.x,
                                                 y = location.y, fill = Valor, group = Valor)) +
            geom_bin2d(binwidth = c(30, 30), position = "identity", alpha = 0.9) +
            annotate("rect",xmin = 0, xmax = 90, ymin = 0, ymax = 90, fill = NA,
                     colour = "white", size = 0.6) +
            annotate("segment", x = 0, xend = 0, y = 0, yend = 90, colour = "steelblue1",
                     size = 2, linetype=2)+
            annotate("segment", x = 0, xend = 90, y = 30, yend = 30, colour = "white", size = 0.6)+
            annotate("segment", x = 0, xend = 90, y = 60, yend = 60, colour = "white", size = 0.6)+
            annotate("segment", x = 30, xend = 30, y = 0, yend = 90, colour = "white", size = 0.6)+
            annotate("segment", x = 60, xend = 60, y = 0, yend = 90, colour = "white", size = 0.6)+
            geom_text(aes(x = -5, y = 45, label = "Rede"), size = 4, color = "white") +
            geom_text(aes(x = 15, y = -5, label = "Ataques \n Curtos"), size = 4, color = "white") +
            geom_text(aes(x = 45, y = -5, label = "Linha \n Média"), size = 4, color = "white") +
            geom_text(aes(x = 75, y = -5, label = "Ataques \n Longos"), size = 4, color = "white") +
            theme(rect = element_blank(),
                  line = element_blank()) +
            theme(title = element_blank(),
                  plot.background = element_blank(),
                  panel.background = element_blank(),
                  panel.border = element_blank(),
                  axis.text.x=element_blank(),
                  axis.text.y=element_blank(),
                  axis.title.x = element_blank(),
                  axis.title.y = element_blank(),
                  axis.ticks=element_blank(),
                  legend.title = element_blank(),
                  legend.text=element_text(size=20,family="Source Sans Pro", color = "white"),
                  legend.key.size = unit(1.5, "cm"),
                  legend.direction = "vertical",
                  legend.position = "right",
                  legend.justification = "center") +
            scale_fill_gradientn(colors=brewer.pal(name="Reds", n=8)) +
            coord_fixed(ratio = 95/100) +
            annotation_custom(grob = linesGrob(arrow=arrow(type="open", ends="last",
                                                           length=unit(3,"mm")),
                                               gp=gpar(col="white", fill=NA, lwd=5)),
                              xmin=-10, xmax = -5, ymin = 15, ymax = 15)
        } else {
          ggplot(data= mapa_ataques_esquerda, aes(x = location.x, 
                                                  y = location.y, fill = Valor, group = Valor)) +
            geom_bin2d(binwidth = c(30, 30), position = "identity", alpha = 0.9) +
            annotate("rect",xmin = 0, xmax = 90, ymin = 0, ymax = 90, fill = NA, colour = "white",
                     size = 0.6) +
            annotate("segment", x = 0, xend = -0, y = 0, yend = 90, colour = "steelblue1",
                     size = 2, linetype=2)+
            annotate("segment", x = 0, xend = 90, y = 30, yend = 30, colour = "white", size = 0.6)+
            annotate("segment", x = 0, xend = 90, y = 60, yend = 60, colour = "white", size = 0.6)+
            annotate("segment", x = 30, xend = 30, y = 0, yend = 90, colour = "white", size = 0.6)+
            annotate("segment", x = 60, xend = 60, y = 0, yend = 90, colour = "white", size = 0.6)+
            geom_text(aes(x = -5, y = 45, label = "Rede"), size = 4, color = "white") +
            geom_text(aes(x = 15, y = -5, label = "Ataques \n Curtos"), size = 4, color = "white") +
            geom_text(aes(x = 45, y = -5, label = "Linha \n Média"), size = 4, color = "white") +
            geom_text(aes(x = 75, y = -5, label = "Ataques \n Longos"), size = 4, color = "white") +
            theme(rect = element_blank(),
                  line = element_blank()) +
            theme(title = element_blank(),
                  plot.background = element_blank(),
                  panel.background = element_blank(),
                  panel.border = element_blank(),
                  axis.text.x=element_blank(),
                  axis.text.y=element_blank(),
                  axis.title.x = element_blank(),
                  axis.title.y = element_blank(),
                  axis.ticks=element_blank(),
                  legend.title = element_blank(),
                  legend.text=element_text(size=20,family="Source Sans Pro", color = "white"),
                  legend.key.size = unit(1.5, "cm"),
                  legend.direction = "vertical",
                  legend.position = "right",
                  legend.justification = "center") +
            scale_fill_gradientn(colors=brewer.pal(name="Reds", n=8)) +
            coord_fixed(ratio = 95/100) +
            annotation_custom(grob = linesGrob(arrow=arrow(type="open", ends="last",
                                                           length=unit(3,"mm")),
                                               gp=gpar(col="white", fill=NA, lwd=5)),
                              xmin=-10, xmax = -5, ymin = 75, ymax = 75)
        }

      })

#TABELA ATAQUES      
      
      ataque_total_jogador <- resumo %>% 
        filter(Jogador == Nome) %>% 
        select(Jogador, DC, PM, PA, DL, MF, PL, MD, MM, MP, DC_ponto, PM_ponto, PA_ponto,
               DL_ponto, MF_ponto, PL_ponto, MD_ponto, MM_ponto, MP_ponto)
      
      ataque_total_jogador <- data.frame(
        "Ataque" = c("Diagonal Curta", "Pingo de Meio", "Pingo Atrás",
                     "Diagonal Longa", "Meio Fundo", "Paralela", "Linha Média"),
        "Total" = c(ataque_total_jogador$DC, ataque_total_jogador$PM, ataque_total_jogador$PA, 
                    ataque_total_jogador$DL, ataque_total_jogador$MF, ataque_total_jogador$PL,
                    (ataque_total_jogador$MD + ataque_total_jogador$MM + ataque_total_jogador$MP)),
        "Certos" = c(ataque_total_jogador$DC_ponto, ataque_total_jogador$PM_ponto, 
                     ataque_total_jogador$PA_ponto, ataque_total_jogador$DL_ponto, 
                     ataque_total_jogador$MF_ponto, ataque_total_jogador$PL_ponto,
                     (ataque_total_jogador$MD_ponto + ataque_total_jogador$MM_ponto + 
                        ataque_total_jogador$MP_ponto))) 
      
      output$tabelamapaataque <- DT::renderDataTable({
        DT::datatable(ataque_total_jogador, selection = "none", 
                      options = list(paging = FALSE, searching = FALSE),
                      class = "display", caption = NULL, escape = TRUE,
                      style = "auto", width = NULL, height = NULL, elementId = NULL,
                      fillContainer = getOption("DT.fillContainer", NULL),
                      autoHideNavigation = getOption("DT.autoHideNavigation", NULL),
                      extensions = list(), plugins = NULL, editable = FALSE)
      })
      
###TAB ATAQUES
      
#ABRE VOLUME
      
      output$abrevolumeataque <- renderText({
        paste("Volume de Ataque: ", input$jogadores, " vs. Média")
      })
      
#WRANGLING VOLUME
      
      ataque_geral <- data.frame(
        "Ataque" = c("Diagonal\nCurta", "Pingo de\nMeio", "Pingo\nAtrás",
                     "Diagonal\nLonga", "Meio\nFundo", "Paralela", "Linha\nMédia"),
        "Media" = c(mean(medias$DC), mean(medias$PM), mean(medias$PA), 
                    mean(medias$DL), mean(medias$MF), mean(medias$PL),
                    (mean(medias$MD) + mean(medias$MM) + mean(medias$MP))),
        "Certos" = c(mean(medias$DC_ponto), mean(medias$PM_ponto), mean(medias$PA_ponto), 
                     mean(medias$DL_ponto), mean(medias$MF_ponto), mean(medias$PL_ponto),
                     (mean(medias$MP_ponto) + mean(medias$MM_ponto) + mean(medias$MD_ponto))))
      
      ataque_geral <- ataque_geral %>% 
        mutate("(%) Geral" = (Certos * 100) / Media) %>% 
        rename("Volume Geral" = 2,
               "Acerto Geral" = 3) %>% 
        mutate_if(is.numeric, round, 2)
      
      ataque_individual <- medias %>% 
        filter(Jogador == Nome) %>% 
        select(Jogador, DC, PM, PA, DL, MF, PL, MD, MM, MP, DC_ponto, PM_ponto, PA_ponto,
               DL_ponto, MF_ponto, PL_ponto, MD_ponto, MM_ponto, MP_ponto)
      
      ataque_individual <- data.frame(
        "Ataque" = c("Diagonal\nCurta", "Pingo de\nMeio", "Pingo\nAtrás",
                     "Diagonal\nLonga", "Meio\nFundo", "Paralela", "Linha\nMédia"),
        "Media" = c(ataque_individual$DC, ataque_individual$PM, ataque_individual$PA, 
                    ataque_individual$DL, ataque_individual$MF, ataque_individual$PL,
                    (ataque_individual$MD + ataque_individual$MM + ataque_individual$MP)),
        "Certos" = c(ataque_individual$DC_ponto, ataque_individual$PM_ponto, 
                     ataque_individual$PA_ponto, ataque_individual$DL_ponto, 
                     ataque_individual$MF_ponto, ataque_individual$PL_ponto,
                     (ataque_individual$MD_ponto + ataque_individual$MM_ponto + 
                        ataque_individual$MP_ponto)))
      
      ataque_individual <-  ataque_individual %>% 
        mutate("(%) Jogador" = (Certos * 100) / Media) %>% 
        rename("Volume Jogador" = 2,
               "Acerto Jogador" = 3) %>% 
        mutate_if(is.numeric, round, 2)
      
      comparativo_ataque <- left_join(ataque_geral, ataque_individual)
      
      sonar_ataques_volume <- comparativo_ataque %>% select(1, 2, 5)
      
      sonar_ataques_volume_melted <- melt(sonar_ataques_volume)
      
      tabela_comparativo_volume <- sonar_ataques_volume %>% 
        mutate(cor = ifelse(`Volume Jogador` > `Volume Geral`, 1, 0),
               cor2 = ifelse(`Volume Geral` > `Volume Jogador`, 1, 0)) %>% 
        select(Ataque, `Volume Jogador`, `Volume Geral`, cor, cor2)
      
#TABELA VOLUME
      
      output$tabelavolume <- DT::renderDataTable({
        DT::datatable(tabela_comparativo_volume, selection = "none", 
                      options = list(paging = FALSE, searching = FALSE, 
                                     columnDefs = list(list(visible=FALSE, targets=c(4:5)))),
                      class = "display", caption = NULL, escape = TRUE,
                      style = "auto", width = NULL, height = NULL, elementId = NULL,
                      fillContainer = getOption("DT.fillContainer", NULL),
                      autoHideNavigation = getOption("DT.autoHideNavigation", NULL),
                      extensions = list(), plugins = NULL, editable = FALSE) %>% 
          formatStyle('Volume Jogador', 'cor',
                      backgroundColor = styleEqual(c(1, 0), c('#ff9f3a', '#ffffff'))) %>% 
          formatStyle('Volume Geral', 'cor2',
                      backgroundColor = styleEqual(c(1, 0), c('#00A7E1', '#ffffff'))
          )
      })
      
#SONAR VOLUME
      
      output$sonarvolume <- renderPlot(color = "black", bg = "transparent", {       
        ggplot(sonar_ataques_volume_melted, aes(fill=variable, y=value, 
                                                x=reorder(Ataque, value), group = value)) + 
          geom_bar(position="dodge", stat="identity") +
          theme(title = element_blank(),
                plot.background = element_blank(),
                panel.background = element_blank(),
                panel.border = element_blank(),
                panel.grid.major.x = element_line(color = "white", size = 0.1),
                panel.grid.major.y = element_line(color = "white", size = 0.1),
                axis.title.x = element_blank(),
                axis.title.y = element_blank(),
                axis.ticks=element_blank(),
                axis.text.y = element_blank(),
                axis.text.x = element_text(size = 12, color = "white"),
                legend.title = element_blank(),
                legend.position = "right",
                legend.text = element_text(size = 12, color = "white"),
                legend.direction = "vertical",
                legend.background = element_blank()) +
          scale_fill_manual(values = c("#00A7E1", "#ff9f3a")) +
          coord_polar()
      })
      
#ABRE ACERTO
      
      output$abreacertoataque <- renderText({
        paste("Acerto de Ataque (%): ", input$jogadores, " vs. Média")
      })
      
#WRANGLING ACERTO

      sonar_ataques_acerto <- comparativo_ataque %>% select(1, 4, 7)
      
      sonar_ataques_acerto_melted <- melt(sonar_ataques_acerto)
      
      tabela_comparativo_acerto <- sonar_ataques_acerto %>% 
        mutate(cor = ifelse(`(%) Jogador` > `(%) Geral`, 1, 0),
               cor2 = ifelse(`(%) Geral` > `(%) Jogador`, 1, 0)) %>% 
        select(Ataque, `(%) Jogador`, `(%) Geral`, cor, cor2)
      
#TABELA ACERTO
      
      output$tabelaacerto <- DT::renderDataTable({
        DT::datatable(tabela_comparativo_acerto, selection = "none", 
                      options = list(paging = FALSE, searching = FALSE, 
                                     columnDefs = list(list(visible=FALSE, targets=c(4:5)))),
                      class = "display", caption = NULL, escape = TRUE,
                      style = "auto", width = NULL, height = NULL, elementId = NULL,
                      fillContainer = getOption("DT.fillContainer", NULL),
                      autoHideNavigation = getOption("DT.autoHideNavigation", NULL),
                      extensions = list(), plugins = NULL, editable = FALSE) %>% 
          formatStyle('(%) Jogador', 'cor',
                      backgroundColor = styleEqual(c(1, 0), c('#ff9f3a', '#ffffff'))) %>% 
          formatStyle('(%) Geral', 'cor2',
                      backgroundColor = styleEqual(c(1, 0), c('#00A7E1', '#ffffff'))
          )
      })
      
#SONAR ACERTO
      
      output$sonaracerto <- renderPlot(color = "black", bg = "transparent", {       
        ggplot(sonar_ataques_acerto_melted, aes(fill=variable, y=value, 
                                                x=reorder(Ataque, value), group = value)) + 
          geom_bar(position="dodge", stat="identity") +
          theme(title = element_blank(),
                plot.background = element_blank(),
                panel.background = element_blank(),
                panel.border = element_blank(),
                panel.grid.major.x = element_line(color = "white", size = 0.1),
                panel.grid.major.y = element_line(color = "white", size = 0.1),
                axis.title.x = element_blank(),
                axis.title.y = element_blank(),
                axis.ticks=element_blank(),
                axis.text.y = element_blank(),
                axis.text.x = element_text(size = 12, color = "white"),
                legend.title = element_blank(),
                legend.position = "right",
                legend.text = element_text(size = 12, color = "white"),
                legend.direction = "vertical",
                legend.background = element_blank()) +
          scale_fill_manual(values = c("#00A7E1", "#ff9f3a")) +
          coord_polar()
      })

###TAB DEFESA
      
#ABRE DEFESA
      
      output$abredefesa <- renderText({
        paste("Indicadores de Defesa: ", input$jogadores)
      })
      
#WRANGLING DASHBOARD DEFESA
      
      indicadores_defesa <- medias %>% 
        mutate("(%) Erro" = (Erro_Defesa * 100) / Defesa,
               "Defesa para Levantada" = (Defesa_Levantada * 100) / Defesa) %>% 
        rename("Defesas por jogo" = Defesa,
               "Rebatidas de 1ª" = Defesa_1a) %>% 
        select(Jogador, `Defesas por jogo`, `Defesa para Levantada`,
               `Rebatidas de 1ª`, `(%) Erro`) %>% 
        filter(Jogador == Nome) %>% 
        mutate_if(is.numeric, round, 2)
      
#DASHBOARD DEFESA
      
      output$defesaporjogo <- renderValueBox({
        media_defesa_jogo <- mean(medias$Defesa)
        if(indicadores_defesa$`Defesas por jogo` > media_defesa_jogo){
          valueBox(tags$p(HTML(paste0(indicadores_defesa$`Defesas por jogo`)), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_defesa$`Defesas por jogo`)), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$defesalevantadajogo <- renderValueBox({
        media_defesa_levantada <- medias %>% 
          mutate("Defesa para Levantada" = mean((Defesa_Levantada * 100) / Defesa)) %>% 
          select(`Defesa para Levantada`)
        if(indicadores_defesa$`Defesa para Levantada` > media_defesa_levantada){
          valueBox(tags$p(HTML(paste0(indicadores_defesa$`Defesa para Levantada`, "%")), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_defesa$`Defesa para Levantada`, "%")), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$rebatidaprimeira <- renderValueBox({
        media_rebatida_primeira <- mean(medias$Defesa_1a)
        if(indicadores_defesa$`Rebatidas de 1ª` < media_rebatida_primeira){
          valueBox(tags$p(HTML(paste0(indicadores_defesa$`Rebatidas de 1ª`)), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_defesa$`Rebatidas de 1ª`)), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        }
      })
      
      output$defesaerradajogo <- renderValueBox({
        media_defesaerradajogo<- medias %>% 
          mutate("(%) Erro" = mean((Erro_Defesa * 100) / Defesa)) %>% 
          select(`(%) Erro`)
        
        if(indicadores_defesa$`(%) Erro` < media_defesaerradajogo){
          valueBox(tags$p(HTML(paste0(indicadores_defesa$`(%) Erro`, "%")), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_defesa$`(%) Erro`, "%")), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        }
      })
      
#WRANGLING - MAPA DE PONTOS SOFRIDOS DATASET BASE
      
      partidas_pontossofridos <- unique(jogos$Partida[which(jogos$jogador == Nome)])
      
      dupla_pontossofridos <- unique(jogos$Dupla[which(jogos$jogador == Nome)])
      
      adversarios_pontossofridos <- unique(jogos$jogador[which(jogos$Partida %in% partidas_pontossofridos & 
                                                  jogos$Dupla != dupla_pontossofridos)])
      
#WRANGLING - MAPA DE PONTOS SOFRIDOS - ATAQUES DE ADVERSÁRIOS DA DIREITA
      pontos_adversarios_direita <- jogos %>% 
        filter(Partida %in% partidas_pontossofridos & jogador %in% adversarios_pontossofridos & Lado == "Direita") %>% 
        summarise(diagonalcurta=sum(DC_ponto),
                  pingomeio=sum(PM_ponto),
                  pingoatras=sum(PA_ponto),
                  diagonalmeio=sum(MD_ponto),
                  meio=sum(MM_ponto),
                  paralelacurta=sum(MP_ponto),
                  diagonallonga=sum(DL_ponto),
                  meiofundo=sum(MF_ponto),
                  paralela=sum(PL_ponto)) %>%
        na.exclude() %>% 
        select(diagonalcurta, pingomeio, pingoatras, diagonalmeio, meio, 
               paralelacurta, diagonallonga, meiofundo, paralela)  %>% 
        melt() %>% 
        rename(Tipo = 1, Valor = 2) %>%
        group_by(Tipo)
      
      Quadrantes_Direita_Adversarios <- data.frame(Tipo = c("diagonalcurta", "pingomeio", "pingoatras",
                                                "diagonalmeio", "meio", "paralelacurta", 
                                                "diagonallonga", "meiofundo", "paralela"), 
                                       location.x = c(15, 15, 15, 45, 45, 45, 75, 75, 75),
                                       location.y = c(75, 45, 15, 75, 45, 15, 75, 45, 15))
      
      Quadrantes_Direita_Adversarios$xbin <- cut(Quadrantes_Direita_Adversarios$location.x, breaks = seq(from=0, to=90, by = 30),
                                     include.lowest=TRUE )
      Quadrantes_Direita_Adversarios$ybin <- cut(Quadrantes_Direita_Adversarios$location.y, breaks = seq(from=0, to=90, by = 30),
                                     include.lowest=TRUE)
      
      Quadrantes_Direita_Adversarios <- Quadrantes_Direita_Adversarios %>%
        group_by(Tipo, xbin, ybin) 
      
      mapa_pontos_adversarios_direita <- full_join(pontos_adversarios_direita, Quadrantes_Direita_Adversarios, "Tipo")
      
#MAPA DE PONTOS SOFRIDOS - ATAQUES DE ADVERSÁRIOS DA DIREITA
      
      output$mapapontossofridosdireita <- renderPlot(color = "black", bg = "transparent", { 
        ggplot(data= mapa_pontos_adversarios_direita, aes(x = location.x, y = location.y, 
                                               fill = Valor, group = Valor)) +
          geom_bin2d(binwidth = c(30, 30), position = "identity", alpha = 0.9) +
          annotate("rect",xmin = 0, xmax = 90, ymin = 0, ymax = 90, fill = NA, colour = "white", 
                   size = 0.6) +
          annotate("segment", x = 0, xend = 0, y = 0, yend = 90, colour = "steelblue1", size = 2, 
                   linetype=2)+
          annotate("segment", x = 0, xend = 90, y = 30, yend = 30, colour = "white", size = 0.6)+
          annotate("segment", x = 0, xend = 90, y = 60, yend = 60, colour = "white", size = 0.6)+
          annotate("segment", x = 30, xend = 30, y = 0, yend = 90, colour = "white", size = 0.6)+
          annotate("segment", x = 60, xend = 60, y = 0, yend = 90, colour = "white", size = 0.6)+
          geom_text(aes(x = -5, y = 45, label = "Rede"), size = 4, color = "white") +
          geom_text(aes(x = 15, y = -5, label = "Ataques \n Curtos"), size = 4, color = "white") +
          geom_text(aes(x = 45, y = -5, label = "Linha \n Média"), size = 4, color = "white") +
          geom_text(aes(x = 75, y = -5, label = "Ataques \n Longos"), size = 4, color = "white") +
          theme(rect = element_blank(),
                line = element_blank()) +
          theme(title = element_blank(),
                plot.background = element_blank(),
                panel.background = element_blank(),
                panel.border = element_blank(),
                axis.text.x=element_blank(),
                axis.text.y=element_blank(),
                axis.title.x = element_blank(),
                axis.title.y = element_blank(),
                axis.ticks=element_blank(),
                legend.title = element_blank(),
                legend.text=element_text(size=20,family="Source Sans Pro", color = "white"),
                legend.key.size = unit(1.5, "cm"),
                legend.direction = "vertical",
                legend.position = "right",
                legend.justification = "center") +
          scale_fill_gradientn(colors=brewer.pal(name="BuPu", n=9)) +
          coord_fixed(ratio = 95/100) +
          annotation_custom(grob = linesGrob(arrow=arrow(type="open", ends="last",
                                                         length=unit(3,"mm")), 
                                             gp=gpar(col="white", fill=NA, lwd=5)),
                            xmin=-10, xmax = -5, ymin = 15, ymax = 15) 
      })
      
#WRANGLING - MAPA DE DEFESAS - ATAQUES DE ADVERSÁRIOS DA DIREITA
      
      mapa_defesas_adv_dir <- resumo %>%
        select(Jogador, Lado, Defesa_DC_dir, Defesa_PM_dir, Defesa_PA_dir,
               Defesa_MD_dir, Defesa_MM_dir, Defesa_MP_dir, Defesa_DL_dir,
               Defesa_MF_dir, Defesa_PL_dir) %>% 
        filter(Jogador == Nome) %>%
        rename(diagonalcurta = Defesa_DC_dir,
               pingomeio = Defesa_PM_dir,
               pingoatras = Defesa_PA_dir,
               diagonalmeio = Defesa_MD_dir,
               meio = Defesa_MM_dir,
               paralelacurta = Defesa_MP_dir,
               diagonallonga = Defesa_DL_dir,
               meiofundo = Defesa_MF_dir,
               paralela = Defesa_PL_dir) %>% 
        melt() %>% 
        rename(Lado = 2, Tipo = 3, Valor = 4) %>%
        group_by(Tipo)
      
      Quadrantes_Direita_Defesa <- data.frame(Tipo = c("diagonalcurta", "pingomeio", "pingoatras",
                                                       "diagonalmeio", "meio", "paralelacurta", 
                                                       "diagonallonga", "meiofundo", "paralela"), 
                                              location.x = c(15, 15, 15, 45, 45, 45, 75, 75, 75),
                                              location.y = c(75, 45, 15, 75, 45, 15, 75, 45, 15))
      
      Quadrantes_Direita_Defesa$xbin <- cut(Quadrantes_Direita_Defesa$location.x, 
                                            breaks = seq(from=0, to=90, by = 30),include.lowest=TRUE )
      Quadrantes_Direita_Defesa$ybin <- cut(Quadrantes_Direita_Defesa$location.y, 
                                            breaks = seq(from=0, to=90, by = 30),include.lowest=TRUE)
      
      Quadrantes_Direita_Defesa <- Quadrantes_Direita_Defesa %>%
        group_by(Tipo, xbin, ybin) 
      
      mapa_defesas_adv_dir <- full_join(mapa_defesas_adv_dir, Quadrantes_Direita_Defesa, "Tipo")

#MAPA DE DEFESAS - ATAQUES DE ADVERSÁRIOS DA DIREITA
      
      output$mapadefesasdireitaadv <- renderPlot(color = "black", bg = "transparent", { 
        ggplot(data= mapa_defesas_adv_dir, aes(x = location.x, y = location.y, 
                                               fill = Valor, group = Valor)) +
          geom_bin2d(binwidth = c(30, 30), position = "identity", alpha = 0.9) +
          annotate("rect",xmin = 0, xmax = 90, ymin = 0, ymax = 90, fill = NA, colour = "white", 
                   size = 0.6) +
          annotate("segment", x = 0, xend = 0, y = 0, yend = 90, colour = "steelblue1", size = 2, 
                   linetype=2)+
          annotate("segment", x = 0, xend = 90, y = 30, yend = 30, colour = "white", size = 0.6)+
          annotate("segment", x = 0, xend = 90, y = 60, yend = 60, colour = "white", size = 0.6)+
          annotate("segment", x = 30, xend = 30, y = 0, yend = 90, colour = "white", size = 0.6)+
          annotate("segment", x = 60, xend = 60, y = 0, yend = 90, colour = "white", size = 0.6)+
          geom_text(aes(x = -5, y = 45, label = "Rede"), size = 4, color = "white") +
          geom_text(aes(x = 15, y = -5, label = "Ataques \n Curtos"), size = 4, color = "white") +
          geom_text(aes(x = 45, y = -5, label = "Linha \n Média"), size = 4, color = "white") +
          geom_text(aes(x = 75, y = -5, label = "Ataques \n Longos"), size = 4, color = "white") +
          theme(rect = element_blank(),
                line = element_blank()) +
          theme(title = element_blank(),
                plot.background = element_blank(),
                panel.background = element_blank(),
                panel.border = element_blank(),
                axis.text.x=element_blank(),
                axis.text.y=element_blank(),
                axis.title.x = element_blank(),
                axis.title.y = element_blank(),
                axis.ticks=element_blank(),
                legend.title = element_blank(),
                legend.text=element_text(size=20,family="Source Sans Pro", color = "white"),
                legend.key.size = unit(1.5, "cm"),
                legend.direction = "vertical",
                legend.position = "right",
                legend.justification = "center") +
          scale_fill_gradientn(colors=brewer.pal(name="Greens", n=5)) +
          coord_fixed(ratio = 95/100) +
          annotation_custom(grob = linesGrob(arrow=arrow(type="open", ends="last",
                                                         length=unit(3,"mm")), 
                                             gp=gpar(col="white", fill=NA, lwd=5)),
                            xmin=-10, xmax = -5, ymin = 15, ymax = 15) 
      })
      
#WRANGLING - MAPA DE PONTOS SOFRIDOS - ATAQUES DE ADVERSÁRIOS DA ESQUERDA
      
      pontos_adversarios_esquerda <- jogos %>% 
        filter(Partida %in% partidas_pontossofridos & jogador %in% adversarios_pontossofridos & Lado == "Esquerda") %>% 
        summarise(diagonalcurta=sum(DC_ponto),
                  pingomeio=sum(PM_ponto),
                  pingoatras=sum(PA_ponto),
                  diagonalmeio=sum(MD_ponto),
                  meio=sum(MM_ponto),
                  paralelacurta=sum(MP_ponto),
                  diagonallonga=sum(DL_ponto),
                  meiofundo=sum(MF_ponto),
                  paralela=sum(PL_ponto)) %>%
        na.exclude() %>% 
        select(diagonalcurta, pingomeio, pingoatras, diagonalmeio, meio, 
               paralelacurta, diagonallonga, meiofundo, paralela) %>% 
        melt() %>% 
        rename(Tipo = 1, Valor = 2) %>%
        group_by(Tipo)
      
      Quadrantes_Esquerda_Adversarios <- data.frame(Tipo = c("diagonalcurta", "pingomeio", "pingoatras",
                                                 "diagonalmeio", "meio", "paralelacurta", 
                                                 "diagonallonga", "meiofundo", "paralela"), 
                                        location.x = c(15, 15, 15, 45, 45, 45, 75, 75, 75),
                                        location.y = c(15, 45, 75, 15, 45, 75, 15, 45, 75))
      
      Quadrantes_Esquerda_Adversarios$xbin <- cut(Quadrantes_Esquerda_Adversarios$location.x, breaks = seq(from=0, to=90, by = 30),
                                      include.lowest=TRUE )
      Quadrantes_Esquerda_Adversarios$ybin <- cut(Quadrantes_Esquerda_Adversarios$location.y, breaks = seq(from=0, to=90, by = 30),
                                      include.lowest=TRUE)
      
      Quadrantes_Esquerda_Adversarios <- Quadrantes_Esquerda_Adversarios %>%
        group_by(Tipo, xbin, ybin) 
      
      mapa_pontos_adversarios_esquerda <- full_join(pontos_adversarios_esquerda, Quadrantes_Esquerda_Adversarios, "Tipo")
      
#MAPA DE PONTOS SOFRIDOS - ATAQUES DE ADVERSÁRIOS DA ESQUERDA
      
      output$mapapontossofridosesquerda <- renderPlot(color = "black", bg = "transparent", { 
        ggplot(data= mapa_pontos_adversarios_esquerda, aes(x = location.x, y = location.y, 
                                                          fill = Valor, group = Valor)) +
          geom_bin2d(binwidth = c(30, 30), position = "identity", alpha = 0.9) +
          annotate("rect",xmin = 0, xmax = 90, ymin = 0, ymax = 90, fill = NA, colour = "white", 
                   size = 0.6) +
          annotate("segment", x = 0, xend = 0, y = 0, yend = 90, colour = "steelblue1", size = 2, 
                   linetype=2)+
          annotate("segment", x = 0, xend = 90, y = 30, yend = 30, colour = "white", size = 0.6)+
          annotate("segment", x = 0, xend = 90, y = 60, yend = 60, colour = "white", size = 0.6)+
          annotate("segment", x = 30, xend = 30, y = 0, yend = 90, colour = "white", size = 0.6)+
          annotate("segment", x = 60, xend = 60, y = 0, yend = 90, colour = "white", size = 0.6)+
          geom_text(aes(x = -5, y = 45, label = "Rede"), size = 4, color = "white") +
          geom_text(aes(x = 15, y = -5, label = "Ataques \n Curtos"), size = 4, color = "white") +
          geom_text(aes(x = 45, y = -5, label = "Linha \n Média"), size = 4, color = "white") +
          geom_text(aes(x = 75, y = -5, label = "Ataques \n Longos"), size = 4, color = "white") +
          theme(rect = element_blank(),
                line = element_blank()) +
          theme(title = element_blank(),
                plot.background = element_blank(),
                panel.background = element_blank(),
                panel.border = element_blank(),
                axis.text.x=element_blank(),
                axis.text.y=element_blank(),
                axis.title.x = element_blank(),
                axis.title.y = element_blank(),
                axis.ticks=element_blank(),
                legend.title = element_blank(),
                legend.text=element_text(size=20,family="Source Sans Pro", color = "white"),
                legend.key.size = unit(1.5, "cm"),
                legend.direction = "vertical",
                legend.position = "right",
                legend.justification = "center") +
          scale_fill_gradientn(colors=brewer.pal(name="BuPu", n=9)) +
          coord_fixed(ratio = 95/100) +
          annotation_custom(grob = linesGrob(arrow=arrow(type="open", ends="last",
                                                         length=unit(3,"mm")), 
                                             gp=gpar(col="white", fill=NA, lwd=5)),
                            xmin=-10, xmax = -5, ymin = 75, ymax = 75) 
      })
      
#WRANGLING - MAPA DE DEFESAS - ATAQUES DE ADVERSÁRIOS DA ESQUERDA
      
      mapa_defesas_adv_esq <- resumo %>%
        select(Jogador, Lado, Defesa_DC_esq, Defesa_PM_esq,
               Defesa_PA_esq, Defesa_MD_esq, Defesa_MM_esq, Defesa_MP_esq,
               Defesa_DL_esq, Defesa_MF_esq, Defesa_PL_esq) %>% 
        filter(Jogador == Nome) %>%
        rename(diagonalcurta = Defesa_DC_esq,
               pingomeio = Defesa_PM_esq,
               pingoatras = Defesa_PA_esq,
               diagonalmeio = Defesa_MD_esq,
               meio = Defesa_MM_esq,
               paralelacurta = Defesa_MP_esq,
               diagonallonga = Defesa_DL_esq,
               meiofundo = Defesa_MF_esq,
               paralela = Defesa_PL_esq) %>% 
        melt() %>% 
        rename(Lado = 2, Tipo = 3, Valor = 4) %>%
        group_by(Tipo)
      
      Quadrantes_Esquerda_Defesa <- data.frame(Tipo = c("diagonalcurta", "pingomeio", "pingoatras",
                                                 "diagonalmeio", "meio", "paralelacurta", 
                                                 "diagonallonga", "meiofundo", "paralela"), 
                                        location.x = c(15, 15, 15, 45, 45, 45, 75, 75, 75),
                                        location.y = c(15, 45, 75, 15, 45, 75, 15, 45, 75))
      
      Quadrantes_Esquerda_Defesa$xbin <- cut(Quadrantes_Esquerda_Defesa$location.x, 
                                      breaks = seq(from=0, to=90, by = 30),include.lowest=TRUE )
      Quadrantes_Esquerda_Defesa$ybin <- cut(Quadrantes_Esquerda_Defesa$location.y, 
                                      breaks = seq(from=0, to=90, by = 30),include.lowest=TRUE)
      
      Quadrantes_Esquerda_Defesa <- Quadrantes_Esquerda_Defesa %>%
        group_by(Tipo, xbin, ybin) 
      
      mapa_defesas_adv_esq <- full_join(mapa_defesas_adv_esq, Quadrantes_Esquerda_Defesa, "Tipo")
      
#MAPA DE DEFESAS - ATAQUES DE ADVERSÁRIOS DA ESQUERDA
      
      output$mapadefesasesquerdaadv <- renderPlot(color = "black", bg = "transparent", { 
        ggplot(data= mapa_defesas_adv_esq, aes(x = location.x, y = location.y, 
                                               fill = Valor, group = Valor)) +
          geom_bin2d(binwidth = c(30, 30), position = "identity", alpha = 0.9) +
          annotate("rect",xmin = 0, xmax = 90, ymin = 0, ymax = 90, fill = NA, colour = "white", 
                   size = 0.6) +
          annotate("segment", x = 0, xend = 0, y = 0, yend = 90, colour = "steelblue1", size = 2, 
                   linetype=2)+
          annotate("segment", x = 0, xend = 90, y = 30, yend = 30, colour = "white", size = 0.6)+
          annotate("segment", x = 0, xend = 90, y = 60, yend = 60, colour = "white", size = 0.6)+
          annotate("segment", x = 30, xend = 30, y = 0, yend = 90, colour = "white", size = 0.6)+
          annotate("segment", x = 60, xend = 60, y = 0, yend = 90, colour = "white", size = 0.6)+
          geom_text(aes(x = -5, y = 45, label = "Rede"), size = 4, color = "white") +
          geom_text(aes(x = 15, y = -5, label = "Ataques \n Curtos"), size = 4, color = "white") +
          geom_text(aes(x = 45, y = -5, label = "Linha \n Média"), size = 4, color = "white") +
          geom_text(aes(x = 75, y = -5, label = "Ataques \n Longos"), size = 4, color = "white") +
          theme(rect = element_blank(),
                line = element_blank()) +
          theme(title = element_blank(),
                plot.background = element_blank(),
                panel.background = element_blank(),
                panel.border = element_blank(),
                axis.text.x=element_blank(),
                axis.text.y=element_blank(),
                axis.title.x = element_blank(),
                axis.title.y = element_blank(),
                axis.ticks=element_blank(),
                legend.title = element_blank(),
                legend.text=element_text(size=20,family="Source Sans Pro", color = "white"),
                legend.key.size = unit(1.5, "cm"),
                legend.direction = "vertical",
                legend.position = "right",
                legend.justification = "center") +
          scale_fill_gradientn(colors=brewer.pal(name="Greens", n=5)) +
          coord_fixed(ratio = 95/100) +
          annotation_custom(grob = linesGrob(arrow=arrow(type="open", ends="last",
                                                         length=unit(3,"mm")), 
                                             gp=gpar(col="white", fill=NA, lwd=5)),
                            xmin=-10, xmax = -5, ymin = 75, ymax = 75) 
      })
      
#ABRE LEVANTADA
      
      output$abrelevantada <- renderText({
        paste("Indicadores de Levantada: ", input$jogadores)
      })
      
#WRANGLING DASHBOARD LEVANTADA
      
      indicadores_levantada <- medias %>% 
        mutate("(%) Erro" = (Erro_Levantada * 100) / Levantada,
               "Levantada para Ataque" = (Levantada_Ataque * 100) / Levantada) %>% 
        rename("Levantadas por jogo" = Levantada,
               "Tempo de Levantada" = Tempo_Levantada,
               "Ataques de 2ª" = Ataque_2a,
               "De Graça de 2ª" = Devolucao_2T) %>% 
        select(Jogador, `Levantadas por jogo`, `Levantada para Ataque`,
               `Tempo de Levantada`, `Ataques de 2ª`, `De Graça de 2ª`, `(%) Erro`) %>% 
        filter(Jogador == Nome) %>% 
        mutate_if(is.numeric, round, 2) %>% 
        mutate(across(2:7, replace_na, 0))
      
#DASHBOARD LEVANTADA
      
      output$levantadatotal <- renderValueBox({
        media_levantada_jogo <- mean(medias$Levantada)
        if(indicadores_levantada$`Levantadas por jogo` > media_levantada_jogo){
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`Levantadas por jogo`)), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`Levantadas por jogo`)), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$levantadaataquejogo <- renderValueBox({
        media_levantada_ataque <- medias %>% 
          mutate("Levantada para Ataque" = mean((Levantada_Ataque * 100) / Levantada)) %>% 
          select(`Levantada para Ataque`)
        if(indicadores_levantada$`Levantada para Ataque` > media_levantada_ataque){
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`Levantada para Ataque`, "%")), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`Levantada para Ataque`, "%")), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$tempolevantadamedia <- renderValueBox({
        media_tempo_levantada <- mean(medias$Tempo_Levantada)
        if(indicadores_levantada$`Tempo de Levantada` > media_tempo_levantada){
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`Tempo de Levantada`, " s")), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`Tempo de Levantada`, " s")), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$errolevantadajogo <- renderValueBox({
        media_errolevantada <- medias %>% 
          summarise("(%) Erro" = mean((Erro_Levantada * 100) / Levantada)) %>% 
          select(`(%) Erro`)
        
        if(indicadores_levantada$`(%) Erro` < media_errolevantada){
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`(%) Erro`, "%")), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`(%) Erro`, "%")), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        }
      })
      
      output$ataque2ajogo <- renderValueBox({
        media_ataque_2a <- mean(medias$Ataque_2a)
        if(indicadores_levantada$`Ataques de 2ª` > media_ataque_2a){
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`Ataques de 2ª`)), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`Ataques de 2ª`)), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$degraca2ajogo <- renderValueBox({
        media_degraca_2a <- mean(medias$Devolucao_2T)
        if(indicadores_levantada$`De Graça de 2ª` < media_degraca_2a){
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`De Graça de 2ª`)), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_levantada$`De Graça de 2ª`)), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        }
      })
      
#ABRE SAQUE RECEPÇÃO
      
      output$abresaquerecepcao <- renderText({
        paste("Indicadores de Saque e Recepção: ", input$jogadores)
      })
      
#WRANGLING DASHBOARD SAQUE/RECEPÇÃO
      
      indicadores_saque_recepcao_total <- resumo %>% 
        rename("Pontos de Saque" = Ponto_Saque,
               "Saques Errados" = Erro_Saque) %>% 
        select(Jogador, `Pontos de Saque`, `Saques Errados`)  %>% 
        filter(Jogador == Nome) %>% 
        mutate_if(is.numeric, round, 2)
      
      indicadores_saque_recepcao_medias <- medias %>% 
        mutate("(%) Erro Recepção" = (Erro_Recepcao * 100) / Recepcao,
               "Recepção para Levantada" = (Recepcao_Levantada * 100) / Recepcao) %>% 
        rename("Saques por jogo" = Saque,
               "Recepções por jogo" = Recepcao) %>% 
        select(Jogador, `Recepções por jogo`, `Saques por jogo`, 
               `Recepção para Levantada`, `(%) Erro Recepção`) %>% 
        filter(Jogador == Nome) %>% 
        mutate_if(is.numeric, round, 2) %>% 
        mutate(across(2:5, replace_na, 0))
      
#DASHBOARD LEVANTADA SAQUE/RECEPÇÃO
      
      output$saquesporjogo <- renderValueBox({
        media_saques_jogo <- mean(medias$Saque)
        if(indicadores_saque_recepcao_medias$`Saques por jogo` > media_saques_jogo){
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_medias$`Saques por jogo`)), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_medias$`Saques por jogo`)), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$recepcoesporjogo <- renderValueBox({
        media_recepcoes_jogo <- mean(medias$Recepcao)
        if(indicadores_saque_recepcao_medias$`Recepções por jogo` > media_recepcoes_jogo){
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_medias$`Recepções por jogo`)), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_medias$`Recepções por jogo`)), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$pontosaquetotal <- renderValueBox({
        pontos_saque_total <- mean(resumo$Ponto_Saque)
        if(indicadores_saque_recepcao_total$`Pontos de Saque` > pontos_saque_total){
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_total$`Pontos de Saque`)), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_total$`Pontos de Saque`)), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$errosaquetotal <- renderValueBox({
        erros_saque_total <- mean(resumo$Erro_Saque)
        if(indicadores_saque_recepcao_total$`Saques Errados` < erros_saque_total){
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_total$`Saques Errados`)), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_total$`Saques Errados`)), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        }
      })
      
      output$recepcaolevantadajogo <- renderValueBox({
        media_recepcoes_levantada_jogo <- mean(medias$Recepcao_Levantada)
        media_recepcoes_jogo <- mean(medias$Recepcao)
        media_recepcoes_levantada_percentual <-(media_recepcoes_levantada_jogo * 100) / media_recepcoes_jogo
        media_recepcoes_levantada_percentual <- round(media_recepcoes_levantada_percentual,2)
        if(indicadores_saque_recepcao_medias$`Recepção para Levantada` > media_recepcoes_levantada_percentual){
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_medias$`Recepção para Levantada`, "%")), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_medias$`Recepção para Levantada`, "%")), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        }
      })
      
      output$recepcaoerradajogo <- renderValueBox({
        media_recepcoes_erradas_jogo <- mean(medias$Erro_Recepcao)
        media_recepcoes_jogo <- mean(medias$Recepcao)
        media_recepcoes_erradas_percentual <-(media_recepcoes_erradas_jogo * 100) / media_recepcoes_jogo
        media_recepcoes_erradas_percentual <- round(media_recepcoes_erradas_percentual,2)
        if(indicadores_saque_recepcao_medias$`(%) Erro Recepção` < media_recepcoes_erradas_percentual){
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_medias$`(%) Erro Recepção`, "%")), 
                          fa("arrow-circle-up", fill = "green", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black", 
                   subtitle = tags$p("Abaixo da média", style = "font-size: 200%;"))
        } else {
          valueBox(tags$p(HTML(paste0(indicadores_saque_recepcao_medias$`(%) Erro Recepção`, "%")), 
                          fa("arrow-circle-down", fill = "red", fill_opacity =  "0.5"),
                          style = "font-size: 200%;"), color = "black",
                   subtitle = tags$p("Acima da média", style = "font-size: 200%;"))
        }
      })
      
#RANKINGS - TABELAS
      
      output$rankingpontos <- function() {
        tabela_ranking_pontos <- medias %>% 
          select(Jogador, Ponto) %>% 
          arrange(desc(Ponto)) %>% 
          mutate(Ranking = seq(Ponto)) %>% 
          rename("Médias" = Ponto) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`)
        
        tabela_ranking_pontos %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingerros <- function() {
        tabela_ranking_pontos_cedidos <- medias %>% 
          select(Jogador, Erro) %>% 
          arrange(Erro) %>% 
          mutate(Ranking = seq(Erro)) %>% 
          rename("Médias" = Erro) %>% 
        filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`)
        
        tabela_ranking_pontos_cedidos %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
         }
      
      output$rankingataques <- function() {
        tabela_ranking_ataques <- medias %>% 
          select(Jogador, Ataque_Total) %>% 
          arrange(desc(Ataque_Total)) %>% 
          mutate(Ranking = seq(Ataque_Total)) %>% 
          rename("Médias" = Ataque_Total) %>% 
        filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`)
        
        tabela_ranking_ataques %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingacoes <- function() {
        tabela_ranking_acoes <- medias %>% 
          select(Jogador, Acoes) %>% 
          arrange(desc(Acoes)) %>% 
          mutate(Ranking = seq(Acoes)) %>% 
          rename("Médias" = Acoes) %>% 
        filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`)
        
        tabela_ranking_acoes %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingacertoataque <- function() {
        tabela_ranking_acerto_ataque <- medias %>% 
          filter(Ataque_Total > 5) %>% 
          select(Jogador, Ataque_Total, Ponto_Ataque) %>% 
          mutate("Médias" = (Ponto_Ataque * 100) / Ataque_Total) %>% 
          arrange(desc(`Médias`)) %>% 
          mutate(Ranking = seq(`Médias`)) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`) %>% 
          mutate_if(is.numeric, round, 2)
        
        tabela_ranking_acerto_ataque %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingerroataque <- function() {
        tabela_ranking_erro_ataque <- medias %>% 
          filter(Ataque_Total > 5) %>% 
          select(Jogador, Ataque_Total, Erro_Ataque) %>% 
          mutate("Médias" = (Erro_Ataque * 100) / Ataque_Total) %>% 
          arrange(`Médias`) %>% 
          mutate(Ranking = seq(`Médias`)) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`) %>% 
          mutate_if(is.numeric, round, 2)
        
        tabela_ranking_erro_ataque %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingataque2a <- function() {
        tabela_ranking_ataque2a <- medias %>% 
          filter(Ataque_Total > 5) %>% 
          select(Jogador, Ataque_2a) %>% 
          arrange(desc(Ataque_2a)) %>% 
          mutate(Ranking = seq(Ataque_2a)) %>% 
          rename("Médias" = Ataque_2a) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`)
        
        tabela_ranking_ataque2a %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankinglevantadaataque <- function() {
        tabela_ranking_levantada_ataque <- medias %>% 
          filter(Levantada > 5) %>% 
          select(Jogador, Levantada, Levantada_Ataque) %>% 
          mutate("Médias" = (Levantada_Ataque * 100) / Levantada) %>% 
          arrange(desc(`Médias`)) %>% 
          mutate(Ranking = seq(`Médias`)) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`) %>% 
          mutate_if(is.numeric, round, 2)
        
        tabela_ranking_levantada_ataque %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingtempolevantada <- function() {
        tabela_ranking_tempo_levantada <- medias %>% 
          filter(Levantada > 5) %>% 
          select(Jogador, Tempo_Levantada) %>% 
          arrange(desc(Tempo_Levantada)) %>% 
          mutate(Ranking = seq(Tempo_Levantada)) %>% 
          rename("Médias" = Tempo_Levantada) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`)
        
        tabela_ranking_tempo_levantada %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingdefesas <- function() {
        tabela_ranking_defesas <- medias %>% 
          select(Jogador, Defesa) %>% 
          arrange(desc(Defesa)) %>% 
          mutate(Ranking = seq(Defesa)) %>% 
          rename("Médias" = Defesa) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`)
        
        tabela_ranking_defesas %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingdefesalevantada <- function() {
        tabela_ranking_defesa_levantada <- medias %>% 
          filter(Defesa > 5) %>% 
          select(Jogador, Defesa, Defesa_Levantada) %>% 
          mutate("Médias" = (Defesa_Levantada * 100) / Defesa) %>% 
          arrange(desc(`Médias`)) %>% 
          mutate(Ranking = seq(`Médias`)) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`) %>% 
          mutate_if(is.numeric, round, 2)
        
        tabela_ranking_defesa_levantada %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingrecepcaolevantada <- function() {
        tabela_ranking_recepcao_levantada <- medias %>% 
          filter(Recepcao > 5) %>% 
          select(Jogador, Recepcao, Recepcao_Levantada) %>% 
          mutate("Médias" = (Recepcao_Levantada * 100) / Recepcao) %>% 
          arrange(desc(`Médias`)) %>% 
          mutate(Ranking = seq(`Médias`)) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`) %>% 
          mutate_if(is.numeric, round, 2)
        
        tabela_ranking_recepcao_levantada %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingsaquesrecebidos <- function() {
        tabela_ranking_saques_recebidos <- medias %>% 
          select(Jogador, Recepcao) %>% 
          arrange(desc(Recepcao)) %>% 
          mutate(Ranking = seq(Recepcao)) %>% 
          rename("Médias" = Recepcao) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`)
        
        tabela_ranking_saques_recebidos %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingsaquesfeitos <- function() {
        tabela_ranking_saques_feitos<- medias %>% 
          select(Jogador, Saque) %>% 
          arrange(desc(Saque)) %>% 
          mutate(Ranking = seq(Saque)) %>% 
          rename("Médias" = Saque) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Médias`)
        
        tabela_ranking_saques_feitos %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }
      
      output$rankingpontossaque <- function() {
        tabela_ranking_ponto_saque<- resumo %>% 
          select(Jogador, Ponto_Saque) %>% 
          arrange(desc(Ponto_Saque)) %>% 
          mutate(Ranking = seq(Ponto_Saque)) %>% 
          rename("Total" = Ponto_Saque) %>% 
          filter(Ranking %in% 1:3) %>% 
          select(Ranking, Jogador, `Total`)
        
        tabela_ranking_ponto_saque %>% 
          knitr::kable("html", align = 'c', padding = 2, longtable = TRUE) %>%
          kable_styling(full_width = T, position = "center", font_size = 20, row_label_position = "c",
                        html_font = "Source Sans Pro") %>%
          row_spec(row = 0, bold = T, color = "orange", background = "#444444") %>%
          row_spec(row = 1:3, color = "white", bold = T, background = "#444444")
      }


  })
  
}

shinyApp(ui, server)

