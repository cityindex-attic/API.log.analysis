//Useful references
var CONST = chartSpace.Constants;

// Add a caption
chartSpace.HasChartSpaceTitle = true;
chartSpace.ChartSpaceTitle.Caption = "Generated by Log Parser 2.2";
chartSpace.ChartSpaceTitle.Font.Size = 6;
chartSpace.ChartSpaceTitle.Position = chartSpace.Constants.chTitlePositionBottom;

// Change the background color
chart.PlotArea.Interior.Color = CONST.chColorNone;

var scValueAxisScaling = chart.Axes(0).Scaling;

scValueAxisScaling.Type = CONST.chScaleTypeLogarithmic;

   
/*
var ebCollection = chartSpace.Charts(0).SeriesCollection(0).ErrorBarsCollection;

ebCollection.Add();
var ebSeries1 = ebCollection.Item(0);
    ebSeries1.Type = CONST.chErrorBarTypePercent;
    ebSeries1.Amount = 0.05;
*/