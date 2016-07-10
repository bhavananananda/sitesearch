//  © 2000 Rational Software Corp.                                  
//  ***************************** VERSION HISTORY *****************************
//  Programmer            Date                    Comments
//  ----------            ----                    --------
//  Burak Akbulut         7/15/2000 [17:15:0]     Created
//
//

//<!--

// **************************** global variables: ****************************

var arrayImages = new Array();
var total;
var type;
var path;




// ************** FUNCTIONS ***************************************************
function jmp(formnum,menunum)
{
   //this function will take the user directly to the selected website (from the
   //pull-down menu) so that the user does not have to hit the go button.
   with (document.forms[formnum].elements[menunum])
   {
      i=selectedIndex;
      if (i>=0)
      location=options[i].value;
   }
}  // end of jmp()


//These functions are used on the products page to activate different menu layers when an arrow is clicked

function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}



function preload()
{
//determine how many images you got
total = arguments.length;
type = '.' + arguments[0];
path = arguments[1];

//assigns image paths to array indexes
for (x=2; x < total; x++)
{
	arrayImages[x-2] = path + arguments[x] + '_on' + type;
	arrayImages[(x-2)+(total-2)] = path + arguments[x] + '_off' + type;
}

// preload array image paths to memory
for (y=0; y < arrayImages.length; y++)
{
	var preload = new Image();
	preload.src = arrayImages[y];
	status='pre-loading graphic: ' + arrayImages[y];

}

status='';

//end
}

function swap()
{
	eval("document." + arguments[0] + ".src='" + path + arguments[1] + "_" + arguments[2] + type + "'");
}

// -->
