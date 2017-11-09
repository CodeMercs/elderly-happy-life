

library("shiny")
library("XML")
library("DT")

ui = shinyUI(
	fluidPage(
		titlePanel("Elderly City"),

		tabsetPanel(
			tabPanel("空氣污染",
				h2( "空氣污染" ),
				sidebarLayout(
					sidebarPanel(
						h5( "CSV" ),
						downloadButton('ecairdlcsv', 'Download', width = "100%")
						# ,
						# submitButton("Refresh", icon("refresh"), width = "100%")
						),
					mainPanel(
						tabsetPanel(
							tabPanel("Table",
								DT::dataTableOutput("airtable")
								),
							tabPanel("Plot"
								),
							tabPanel("每日提醒"
								)
							)
						)

					)
			),
			tabPanel("天氣溫度"
			),
			tabPanel("進修機構"
			),
			tabPanel("公共運輸"
			),
			tabPanel("醫院診所"
			),
			tabPanel("視覺化分析"
			)
		)

	)
)
server = function(input, output) {
	# tem
	tmsp = reactiveValues()

		output$airtable = DT::renderDataTable({
				# XML 檔案網址
		tmsp$url <- "http://opendata2.epa.gov.tw/AQX.xml"

		# 下載並解析 XML 檔案
		tmsp$xml.doc <- xmlParse(tmsp$url)
		# 取出 XML 的根節點
		tmsp$xml.top <- xmlRoot(tmsp$xml.doc)

		# 依照名稱取出節點
		(tmsp$xml.leaf <- tmsp$xml.top[[1]][["PSI"]])
		# 取出節點內的資料
		(tmsp$xml.leaf.value <- xmlValue(tmsp$xml.leaf))
		# 
		# XML 轉為 Data Frame
		# 
		tmsp$xml.df <- xmlToDataFrame(tmsp$xml.top)

		DT::datatable(tmsp$xml.df , options = list(pageLength = 25))
		})

		output$ecairdlcsv = downloadHandler(
		filename = function() { 
			paste( "ecair", '.csv', sep = '') 
			tmsp$sdc = as.character(Sys.time())
			tmsp$sdc1t = gsub( ":", " ", tmsp$sdc)
			tmsp$sdc2t = gsub( "-", " ", tmsp$sdc1t)
			tmsp$sdc3t = paste(strsplit( tmsp$sdc2t ,split = " ", fixed = T)[[1]],collapse="")
			paste( "ecair_", tmsp$sdc3t, ".csv", sep = '') 

		},
		content = function(file) {
			# XML 檔案網址
			tmsp$url <- "http://opendata2.epa.gov.tw/AQX.xml"

			# 下載並解析 XML 檔案
			tmsp$xml.doc <- xmlParse(tmsp$url)
			# 取出 XML 的根節點
			tmsp$xml.top <- xmlRoot(tmsp$xml.doc)

			# 依照名稱取出節點
			(tmsp$xml.leaf <- tmsp$xml.top[[1]][["PSI"]])
			# 取出節點內的資料
			(tmsp$xml.leaf.value <- xmlValue(tmsp$xml.leaf))
			# 
			# XML 轉為 Data Frame
			# 
			tmsp$xml.df <- xmlToDataFrame(tmsp$xml.top)
			write.csv( tmsp$xml.df, file = file, quote = FALSE, sep = ",", row.names = FALSE)
		})

}

shinyApp(ui, server)