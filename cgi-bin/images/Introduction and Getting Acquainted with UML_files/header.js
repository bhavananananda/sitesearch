//<!-- 

//this call will grab the content that goes under the menus
document.write("<SCRIPT LANGUAGE='JavaScript1.2' SRC='/global/includes/menu_content.js' TYPE='text/javascript'><\/SCRIPT>");

//declare variables
var topCount = 1;
var menuloaded = false;
var onLayer = false;
var theID;
var flag = ' <image src="/images/usflag.gif" width="14" height="9" border="0">';
var NS4_UNIX_CSS = '/global/css/rational_net4Unix.css';


function getPlatform()  // get the browser platform (OS)
  {
  if (navigator.platform == null || navigator.platform == "")
    return "other";
  else if (navigator.platform.indexOf("Mac") >= 0)
    return "mac";
  else if (navigator.platform.indexOf("Win") >= 0)
    return "win";
  else if (navigator.platform.indexOf("Unix") >= 0)
    return "unix";
  else
    return "other";
  }

function browser_check()
{
	// Check Browser Vendor and Version
	browserName = navigator.appName;
	browserVer = parseInt(navigator.appVersion);

	if (navigator.userAgent.indexOf("Mozilla/3.0") != -1)  version = "ns"; //ns3
	else if (browserName == "Netscape" && browserVer == 4) version = "ns"; //ns4
	else if (browserName == "Netscape" && browserVer >= 5) version = "ns6"; //ns6
	else if (browserName == "Microsoft Internet Explorer" && browserVer >= 3) version = "ie"; //ie4
	else version = "ns2";

return version;
}

// determine what browser user is using
var browser = browser_check();

//this will create the initial layer
function menucreater()
{
status = 'Creating menus, please wait';

	while(eval("window.ratArray" + topCount)) 
	{
	  topArray = eval("ratArray" + topCount);
	  topName = "ratMenu" + topCount;
	
	if (browser == 'ie' || browser == 'ns6') {MAINmenumaker(topArray,topName);}
	else if (browser == 'ns') {nsmenumaker(topArray,topName);}
	else {}
	
	topCount++;

	//end of while loop
	}

menuloaded = true;
var clearStatus = "status = \'\'";
setTimeout(clearStatus,500);
//end
}

function formHandler()
{
	var URL = document.form.site.options[document.form.site.selectedIndex].value;
	window.location.href = URL;
}

//Function to get object
function getObject(obj){
     var theObj;
     if(typeof obj == "string"){
          theObj = eval("document." + coll + obj + styleObj);
     }else{
          theObj = obj;
     }
     return theObj;
}     

//Function for background color
function setBGColor(obj,color){
     var theObj = getObject(obj);
     if(browser == 'ns'){
          theObj.bgColor = color;
     }else if (browser == 'ie' || browser == 'ns6') {
          theObj.backgroundColor = color;
     }
}

//Function to turn layer on
function onLayerColor(menu,NSLayer,layerName){
if(browser == 'ns') {var theLayer = eval("document."+menu+".document."+layerName+".document."+NSLayer);}
else if (browser == 'ie') {var theLayer = eval("document.all."+layerName+".style");}
else {theLayer = eval("document.getElementById(\"" +layerName+ "\").style");}

setBGColor(theLayer,"#FF9900")
}

//Function to turn layer off
function offLayerColor(menu,NSLayer,layerName){
if(browser == 'ns') {var theLayer = eval("document."+menu+".document."+layerName+".document."+NSLayer);}
else if (browser == 'ie') {var theLayer = eval("document.all."+layerName+".style");}
else {theLayer = eval("document.getElementById(\"" +layerName+ "\").style");}
setBGColor(theLayer,"#006699")
}


//creates menu suited for IE6+ and NS6+
function MAINmenumaker(Array,MenuName)
{
lwidth=Array[0];
lheight=Array[1];
lleft = Array[2];
ltop=Array[3];
show=Array[4];
flagCode = '';

var mstring = '';

//building menu
mstring += '<div id="' +MenuName+ '" style="position:absolute; width:' +lwidth+ '; height:' +lheight+ '; z-index:1000; left:' +lleft+ '; top:' +ltop+ '; visibility:' +show+ '" onMouseOver="clearTimeout(theID);onLayer=true;SetMenuVisible(\'' +MenuName+ '\',\'on\')" onMouseOut="clearTimeout(theID);onLayer=false;TimedClose(\'' +MenuName+ '\',\'off\',\'.2\')">';
mstring += '<table border="0" cellspacing="0" cellpadding="0">';
mstring += '<tr>';
mstring += '<td bgcolor="#006699" colspan="3" height="5"><img src="/images/corp_bg.gif" height="5"></td>';
mstring += '</tr>';
for (var arraycount=6; arraycount < Array.length; arraycount=arraycount+3)
{
	if (Array[arraycount + 2] == 'on') {flagCode = flag;}
	mstring += '<tr><td bgcolor="#006699" nowrap>&nbsp;</td><td bgcolor="#006699"><div id="' +MenuName+ '_' +arraycount+ '" onmouseover="onLayerColor(\''+MenuName+'\',\'\',\'' +MenuName+ '_' +arraycount+ '\')" onmouseout="offLayerColor(\''+MenuName+'\',\'\',\'' +MenuName+ '_' +arraycount+ '\')"><li class="headerbullet"><a href="' +Array[arraycount + 1]+ '" class="headermenulink">' +Array[arraycount]+ '</a>' +flagCode+ '</li></div></td><td bgcolor="#006699">&nbsp;</td></tr>';
	flagCode = '';
}
mstring += '<tr>';
mstring += '<td><img src="/images/lmenu.gif" width="10" height="11"></td>';
mstring += '<td bgcolor="#006699"><img src="/images/corp_bg.gif" height="11"></td>';
mstring += '<td><img src="/images/rmenu.gif" width="10" height="11"></td>';
mstring += '</tr>';
mstring += '</table>';
mstring += '</div>';

document.write(mstring);
}


//creates menu suited for < NS6
function nsmenumaker(Array,MenuName)
{
lwidth=Array[0];
lheight=Array[1];
lleft = Array[2];
ltop=Array[3];
show=Array[5];
flagCode = '';

var mstring = '';

//building NS menu
mstring += '<layer name="' +MenuName+ '" visibility="' +show+ '" top="' +ltop+ '" left="' +lleft+ '" width="' +lwidth+ '" height="' +lheight+ '" onMouseOver="clearTimeout(theID);onLayer=true;SetMenuVisible(\'' +MenuName+ '\',\'on\')" onMouseOut="clearTimeout(theID);onLayer=false;TimedClose(\'' +MenuName+ '\',\'off\',\'.2\')">';
mstring += '<table border="0" cellspacing="0" cellpadding="0">';
mstring += '<tr>';
mstring += '<td bgcolor="#006699" colspan="3" height="5"><img src="/images/corp_bg.gif" height="5"></td>';
mstring += '</tr>';
for (var arraycount=6; arraycount < Array.length; arraycount=arraycount+3)
{
	if (Array[arraycount + 2] == 'on') {flagCode = flag;}
	mstring += '<tr><td bgcolor="#006699" nowrap>&nbsp;</td><td bgcolor="#006699"><ilayer name="' +MenuName+ '_' +arraycount+ '"><layer name="inner_' +MenuName+ '_' +arraycount+ '" onmouseover="onLayerColor(\''+MenuName+'\',\'inner_' +MenuName+ '_' +arraycount+ '\',\'' +MenuName+ '_' +arraycount+ '\')" onmouseout="offLayerColor(\''+MenuName+'\',\'inner_' +MenuName+ '_' +arraycount+ '\',\'' +MenuName+ '_' +arraycount+ '\')"><li class="headerbullet"><a href="' +Array[arraycount + 1]+ '" class="headermenulink">' +Array[arraycount]+ '&nbsp;&nbsp;</a>' +flagCode+ '</li></layer></ilayer></td><td bgcolor="#006699">&nbsp;</td></tr>';
	flagCode = '';
}
mstring += '<tr>';
mstring += '<td><img src="/images/lmenu.gif" width="10" height="11"></td>';
mstring += '<td bgcolor="#006699"><img src="/images/corp_bg.gif" height="11"></td>';
mstring += '<td><img src="/images/rmenu.gif" width="10" height="11"></td>';
mstring += '</tr>';
mstring += '</table>';
mstring += '</layer>';

document.write(mstring);
}



function SetCSS(NS_CSS,IE_CSS)
{

	// Assign a style sheet based on Browser
	if(browser == 'ie' || browser == 'ns6')
		document.writeln("<LINK REL=\"stylesheet\" type=\"text/css\" href=\""+IE_CSS+"\">\n");
	if(browser == 'ns')
	{
		if ((getPlatform() == 'unix') || (getPlatform() == 'other'))
		{
			document.writeln("<LINK REL=\"stylesheet\" type=\"text/css\" href=\""+NS4_UNIX_CSS+"\">\n");
		}
		else
		{
			document.writeln("<LINK REL=\"stylesheet\" type=\"text/css\" href=\""+NS_CSS+"\">\n");
		}
	}
//testing functions
menucreater();

}

function SetMenuVisible(mName,state)
{

if (browser == 'ie')
{
	ieObj = document.all[mName].style;
	
}
else if (browser == 'ns')
{
	nsObj = document.layers[mName];
}
else
{
	ns6Obj = document.getElementById(mName).style;
}


if (state == 'on')
{
	if (browser == 'ie') {ieObj.visibility = "visible";}
	else if (browser == 'ns') {nsObj.visibility = "show";}
	else {ns6Obj.visibility = "visible";}
	
}
else
{
	if (browser == 'ie') {ieObj.visibility = "hidden";}
	else if (browser == 'ns') {nsObj.visibility = "hide";}
	else {ns6Obj.visibility = "hidden";}
}

}

//timer that closes menu
function TimedClose(name,toggle,seconds)
{
if (!onLayer)
{
	var Call = "SetMenuVisible('" +name+ "','" +toggle+ "')";
	theID = setTimeout(Call,1000*seconds);
}
else {alert('error with onLayer status');}

}

//-->
