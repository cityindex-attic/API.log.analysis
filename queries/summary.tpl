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

          <div id="graph">
              
              <a class="chart" href="%UriLikeFilter%-summary.gif">
                <img src="%UriLikeFilter%-summary.gif" style="height: 400px;"/>
              </a>
              Click to zoom
          </div>
          
          <div id="data">
          <TABLE width="100%">
            <caption>Summary of .svc requests</caption>
            <THEAD>
              <TR>
                <TH>Service</TH>
                <TH>Avg (ms)</TH>
				<TH>Cumulative time taken (ms)</TH>
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
              <TD>%Service%</TD>
              <TD>%Avg%</TD>
			  <TD>%CulmulativeTimeTaken%</TD>
              <TD>%StDev%</TD>
              <TD>%Min%</TD>
              <TD>%Max%</TD>
              <TD>%Hits%</TD>
            </TR>
</LPBODY>
<LPFOOTER>
          </TBODY>
        </TABLE>
        </div>
      </BODY>
    </HTML>
</LPFOOTER>
