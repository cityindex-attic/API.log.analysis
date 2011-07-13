<LPHEADER>
<HTML>
<LINK REL=StyleSheet HREF="style.css" TYPE="text/css">
<script src="jquery-1.6.2.min.js"></script>
<HEAD><TITLE>Summary of .svc requests</TITLE></HEAD>

<BODY>
<script>
	$(document).ready(function(){
		$('TR.datarow:odd').addClass('odd');
	});
</script>
<img src="summary.gif">

<TABLE>
<caption>Summary of .svc requests</caption>
<THEAD>
<TR>
 <TH>Service</TH>
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
 <TD>%Service%</TD>
 <TD>%Avg%</TD>
 <TD>%StDev%</TD> 
 <TD>%Min%</TD>
 <TD>%Max%</TD>
 <TD>%Hits%</TD>
</TR>
</LPBODY>

<LPFOOTER>
</TBODY>
</TABLE>
</BODY>
</HTML>
</LPFOOTER>
