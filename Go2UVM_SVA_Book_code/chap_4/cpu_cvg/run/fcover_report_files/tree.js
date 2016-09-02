var nodes       = new Array();
var openNodes   = new Array();
var icons       = new Array(6);
function preloadIcons() {
	icons[0] = new Image();
	icons[0].src = "img/plus.gif";
	icons[1] = new Image();
	icons[1].src = "img/plusbottom.gif";
	icons[2] = new Image();
	icons[2].src = "img/minus.gif";
	icons[3] = new Image();
	icons[3].src = "img/minusbottom.gif";
}
function createTree(arrName, startNode, openNode) {
	nodes = arrName;
	if (nodes.length > 0) {
		preloadIcons();
		if (startNode == null) startNode = 0;
		if (openNode != 0 || openNode != null) setOpenNodes(openNode);
	
		if (startNode !=0) {
			var nodeValues = nodes[getArrayId(startNode)].split("|");
			document.write("<a target=\"table_frame\" href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src=\"img/node.png\" align=\"absbottom\" alt=\"\" />" + nodeValues[2] + "</a><br />");
		} else document.write("<b>Coverage Report Structure</b><br/>");
	
		var recursedNodes = new Array();
		addNode(startNode, recursedNodes);
	}
}
function getArrayId(node) {
	for (i=0; i<nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[0]==node) return i;
	}
}
function setOpenNodes(openNode) {
	for (i=0; i<nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[0]==openNode) {
			openNodes.push(nodeValues[0]);
			setOpenNodes(nodeValues[1]);
		}
	} 
}
function isNodeOpen(node) {
	for (i=0; i<openNodes.length; i++)
		if (openNodes[i]==node) return true;
	return false;
}
function hasChildNode(parentNode) {
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) return true;
	}
	return false;
}
function lastSibling (node, parentNode) {
	var lastChild = 0;
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode)
			lastChild = nodeValues[0];
	}
	if (lastChild==node) return true;
	return false;
}
function addNode(parentNode, recursedNodes) {
	for (var i = 0; i < nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) {
			
			var ls	= lastSibling(nodeValues[0], nodeValues[1]);
			var hcn	= hasChildNode(nodeValues[0]);
			var ino = isNodeOpen(nodeValues[0]);
			for (g=0; g<recursedNodes.length; g++) {
				if (recursedNodes[g] == 1) document.write("<img src=\"img/line.gif\" align=\"absbottom\" alt=\"\" />");
				else  document.write("<img src=\"img/empty.gif\" align=\"absbottom\" alt=\"\" />");
			}
			if (ls) recursedNodes.push(0);
			else recursedNodes.push(1);
			if (hcn) {
				if (ls) {
					document.write("<a href=\"javascript: oc(" + nodeValues[0] + ", 1);\"><img id=\"join" + nodeValues[0] + "\" src=\"img/");
					 	if (ino) document.write("minus");
						else document.write("plus");
					document.write("bottom.gif\" align=\"absbottom\" alt=\"Open/Close node\" /></a>");
				} else {
					document.write("<a href=\"javascript: oc(" + nodeValues[0] + ", 0);\"><img id=\"join" + nodeValues[0] + "\" src=\"img/");
						if (ino) document.write("minus");
						else document.write("plus");
					document.write(".gif\" align=\"absbottom\" alt=\"Open/Close node\" /></a>");
				}
			} else {
				if (ls) document.write("<img src=\"img/joinbottom.gif\" align=\"absbottom\" alt=\"\" />");
				else document.write("<img src=\"img/join.gif\" align=\"absbottom\" alt=\"\" />");
			}
			// Start link
			document.write("<a target=\"table_frame\" href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");		
			document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"img/" + nodeValues[4] + "\" align=\"absbottom\" alt=\"Page\" width=\"16\" height=\"16\" border=\"2\" />");			
			document.write(nodeValues[2]);
			document.write("</a><br/>");
			
			if (hcn) {
				document.write("<div id=\"div" + nodeValues[0] + "\"");
					if (!ino) document.write(" style=\"display: none;\"");
				document.write(">");
				addNode(nodeValues[0], recursedNodes);
				document.write("</div>");
			}
			
			recursedNodes.pop();
		}
	}
}
function oc(node, bottom) {
	var theDiv = document.getElementById("div" + node);
	var theJoin	= document.getElementById("join" + node);
	var theIcon = document.getElementById("icon" + node);
	
	var nodeValues = nodes[getArrayId(node)].split("|");
	
	if (theDiv.style.display == 'none') {
		if (bottom==1) theJoin.src = icons[3].src;
		else theJoin.src = icons[2].src;
		theIcon.src = "img/" + nodeValues[4];
		theDiv.style.display = '';
	} else {
		if (bottom==1) theJoin.src = icons[1].src;
		else theJoin.src = icons[0].src;
		theIcon.src = "img/" + nodeValues[4];
		theDiv.style.display = 'none';
	}
}
if(!Array.prototype.push) {
	function array_push() {
		for(var i=0;i<arguments.length;i++)
			this[this.length]=arguments[i];
		return this.length;
	}
	Array.prototype.push = array_push;
}
if(!Array.prototype.pop) {
	function array_pop(){
		lastElement = this[this.length-1];
		this.length = Math.max(this.length-1,0);
		return lastElement;
	}
	Array.prototype.pop = array_pop;
}
