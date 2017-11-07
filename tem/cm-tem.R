library("shiny")
ui = shinyUI(
	fluidPage(
		titlePanel("Elderly City"),

		tabsetPanel(
			tabPanel("天氣溫度"
			),
			tabPanel("空氣污染"
			),
			tabPanel("進修機構"
			),
			tabPanel("公共運輸"
			),
			tabPanel("醫院診所"
			)
		)

	)
)
server = function(input, output) {
	# tem
	tmsp = reactiveValues()
}

shinyApp(ui, server)