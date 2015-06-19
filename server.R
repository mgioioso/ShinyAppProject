data(iris)
library(e1071)
library(caret)
library(shiny)
library(rpart)
library(randomForest)
library(gbm)


# # Linear Discriminant analysis
# modlda <- train(Species~., data=training, method="lda")
# plda <- predict(modlda, testing)
# # Naive Bayes analysis
# modnb <- train(Species~., data=training, method="nb")
# pnb <- predict(modnb, testing)
# # ADA boosting (using additive logistic regression)
# modada <- train(Species~., data=training, method="gbm", verbose=FALSE)
# pada <- predict(modada, testing)
# # Random Forest
# modrf <- train(Species~., data=training, method="rf")
# prf <- predict(modrf, testing)
# # Decision tree
# moddt <- train(Species~., data=training, method="rpart")
# pdt <- predict(moddt, testing)

models = c("rpart"="Decision Tree", "rf"="Random Forest",
          "gbm"="Generalized boosting regression", "nb"="Naive Bayes",
          "lda"="Linear Discriminant Analysis")

shinyServer(
    function(input, output) {
        
        output$predictionGraph <- renderPlot({

            set.seed(numeric(input$seed))
            
            withProgress(message = 'Generating prediction...', value = 0, {
                incProgress(1/3, detail = "Generating train/test sets from Iris data")
                inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
                training <- iris[inTrain,]
                testing <- iris[-inTrain,]
                
                incProgress(2/3, detail = "Making prediction model")
                modFit <- train(Species~., data=training, method=input$model)
                pred <- predict(modFit, testing)
                
                incProgress(3/3, detail = "Plotting results")
                speciesRight <- testing$Species
                levels(speciesRight) <- append(levels(speciesRight), "Wrong prediction")
                speciesRight[pred!=testing$Species] <- "Wrong prediction"
                qplot(Petal.Width,Sepal.Width,colour=speciesRight,data=testing,
                      main="Species" )
            })
            
        })
        output$status <- renderText({ 
            paste("{Prediction with ",models[input$model]," model & 
                  seed = ",input$seed,"}")
        })
        
    }
)