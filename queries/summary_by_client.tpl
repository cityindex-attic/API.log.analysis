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
              <a class="chart" href="%UriLikeFilter%-summary_by_client_hits.gif">
                <img src="%UriLikeFilter%-summary_by_client_hits.gif" style="height: 200px;"/>
              </a>
              Click to zoom
          </div>
          
          <div id="data">
          <TABLE width="100%">
            <caption>%UriLikeFilter% Summary by client</caption>
            <THEAD>
              <TR>
                <TH>Minute</TH>
				<TH>Client IP</TH>
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
              <TD>%Minute%</TD>
			  <TD><a href="http://www.ipchecking.com/?ip=%Client%&check=Lookup" target=_"blank">%Client%</a></TD>
              <TD>%Avg by minute%</TD>
              <TD>%StDev by minute%</TD>
              <TD>%Min by minute%</TD>
              <TD>%Max by minute%</TD>
              <TD>%Hits by minute%</TD>
            </TR>
</LPBODY>
<LPFOOTER>
          </TBODY>
        </TABLE>
        </div>
      </BODY>
    </HTML>
</LPFOOTER>
