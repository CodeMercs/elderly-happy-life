library("shiny")
ui = shinyUI(
	fluidPage(
		titlePanel("OwO"),
		sidebarLayout(
			sidebarPanel(

			),
			mainPanel(
				tabsetPanel(
					tabPanel("Plot"
					)
				)
			)
		)
	)
)
server = function(input, output) {
	# tem
	tmsp = reactiveValues()
}

shinyApp(ui, server)