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
        $("a#chart").fancybox({
        'hideOnContentClick': true
        });
        });
      </script>

      <div id="graph">

        <a id="chart" href="StatusCodes.gif">
          <img src="StatusCodes.gif"/>
        </a>
        Click to zoom
      </div>
      <div id="data">
        <TABLE width="100%">
          <caption>Summary of HTTP Status Codes</caption>
          <THEAD>
            <TR>
              <TH>HTTP Status Code</TH>
              <TH>Hit Count</TH>
            </TR>
          </THEAD>
          <TBODY>
</LPHEADER>
<LPBODY>
          <TR class="datarow">
            <TD>%Status%</TD>
            <TD>%Total%</TD>
          </TR>
</LPBODY>
<LPFOOTER>
        </TBODY>
        </TABLE>
        </div>
      </BODY>
    </HTML>
</LPFOOTER>
