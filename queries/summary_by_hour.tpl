<LPHEADER>
  <HTML>
      <HEAD>
          <script src="jquery-1.6.2.min.js"></script>
          <script type="text/javascript" src="fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
          <script type="text/javascript" src="fancybox/jquery.fancybox-1.3.4.pack.js"></script>

          <link rel="stylesheet" type="text/css" href="fancybox/jquery.fancybox-1.3.4.css" media="screen" />
          <link rel="stylesheet" type="text/css" href="style.css">
      </HEAD>

      <BODY>
          <script>
            $(document).ready(function(){
              $('TR.datarow:odd').addClass('odd');
               $("a.chart").fancybox({
                'hideOnContentClick': true,
				        'autoScale': false,
				        'scrolling': 'yes'
              });
            });
          </script>
        
          <h1>%UriLikeFilter%</h1>
        
          <div id="graph">
              <a class="chart" href="%UriLikeFilter%-summary_by_hour_hits.gif">
                <img src="%UriLikeFilter%-summary_by_hour_hits.gif" style="height: 200px;"/>
              </a>
              <a class="chart" href="%UriLikeFilter%-summary_by_hour_avg.gif">
                <img src="%UriLikeFilter%-summary_by_hour_avg.gif" style="height: 200px;"/>
              </a> 
              Click to zoom
          </div>
          
          <div id="data">
          <TABLE width="100%">
            <caption>%UriLikeFilter% Summary by hour</caption>
            <THEAD>
              <TR>
                <TH>Hour</TH>
                <TH>Avg (ms)</TH>
                <TH>St Dev</TH>
                <TH>Min</TH>
                <TH>Max</TH>
                <TH>Hits</TH>
              </TR>
            </THEAD>
            <TBODY>
</LPHEADER>
<LPBODY>
            <TR class="datarow">
              <TD>%Hour%</TD>
              <TD>%Avg by hour%</TD>
              <TD>%StDev by hour%</TD>
              <TD>%Min by hour%</TD>
              <TD>%Max by hour%</TD>
              <TD>%Hits by hour%</TD>
            </TR>
</LPBODY>
<LPFOOTER>
          </TBODY>
        </TABLE>
        </div>
      </BODY>
    </HTML>
</LPFOOTER>
