library(shiny)

shinyUI(fluidPage(
    h4("Exploratory analysis of accuracy of selected prediction models
                on Iris dataset"),
    sidebarPanel(
        numericInput(inputId="seed", label="Set a new seed",value = 123),
        
        radioButtons(inputId='model', label='Prediction model', choices=
                         c("Decision Tree"="rpart", "Random Forest"="rf",
                           "Generalized boosting regression"="gbm", 
                           "Naive Bayes"="nb",
                           "Linear Discriminant Analysis"="lda"))
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("Output", 
                     textOutput('status'),
                     plotOutput('predictionGraph')), 
            tabPanel("Read Me", 
                     p("This app takes the Iris dataset and generates 
                       predictions of species from the other variables. The user can observe what 
                       effect random data partitioning and prediction model can have on the outcome.
                       This is achieved through the two input fields."),
                     strong("Set the Seed"),
                     p("One input field allows 
                       the user to input a seed number. This seed is used to generate the 
                       test and train partitions of data, and may also be used during prediction.
                       Essentially this can be used to show the user what is the impact of 
                       randomness in the analysis."),
                     strong("Model Selection"),
                     p("Next is the model selection radio button. 
                       The user can select a prediction model from the list provided, and the 
                       Iris data will be re-analyzed with the model selected. The user can 
                       use this to identify which models are more successful at predicting iris 
                       species from their traits."),
                     strong("Output plot"),
                     p("Finally, the output pane contains a scatter 
                       plot. All the data in the test set are plotted and colored by which Species 
                       they belong to. BUT if the prediction model incorrectly classified the species 
                       for a particular point, that point is classified as Wrong prediction.")
                     )
        )
    )
))