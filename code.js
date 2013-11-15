
jQuery.fn.visible = function() {
    return this.css('visibility', 'visible');
};

jQuery.fn.invisible = function() {
    return this.css('visibility', 'hidden');
};

jQuery.fn.emerge = function() {
    return this.addClass("emerging");
};
jQuery.fn.emergeList = function() {
    return this.addClass("emerging-list");
};


function makeitspan(li){
    if(li.childNodes){
        var ns = li.childNodes;
        var len = ns.length;
        for(var i=0;i<len;i++){
            var node = ns[i];
            if (node.nodeType==3){
                var nnode = document.createElement("span");
                li.replaceChild(nnode,node);
                $(nnode).addClass("li-content").text(node.textContent);
            }
        }
    }
}

function expandSibling(e){
    console.log("double clicked!");
    
    $(".li-highlighted").removeClass("li-highlighted");
    $(this).parent().next().emergeList().visible().children(":first-child").addClass("li-highlighted");
    $(this).parent().get(0).removeChild(this);
}

function expandChild(e){
    console.log("clicked!");
    $(".li-highlighted").removeClass("li-highlighted");
    $(this).next().emergeList().visible().children(":first-child").addClass("li-highlighted");
    $(this).parent().get(0).removeChild(this);
}

function setExpanders(){
    $("li").map(
        function(i,li){
            makeitspan(li);
        });
    $("li ~ li").invisible();
    $("li:not(:last-child)").append('<span class="sibling-expander">...</span>');
    $("li > ul").invisible().before('<span class="expander">→</span>');
    $(".expander").click(expandChild);
    $(".sibling-expander").click(expandSibling);
}

function outline(n){
    return ".outline-"+n;
}
function outlineContents(n){
    return ".outline-text-"+n+", h"+n;
}

function container(){
    return Array.prototype.reduce.call(
        arguments,
        function(prev,arg){
            return prev+"-"+arg;
        },
        "#outline-container-sec"
    );
}

function unparseSection(id){
    var re = /outline-container-sec-(.*)/;
    return (id.match(re)||[null,"1"])[1].split("-");
}


var nullp = $.isEmptyObject;
var keyManager = {};

function Slide(arg,prev){
    this.previous = prev;
    if (!nullp(arg) && arg.length!=0){
        this.current = arg;
        var matched = arg.get(0).className.match(/outline-([0-9]*)/);
        if(matched){
            this.level=(+matched[1]);
        }else{
            throw new Error("arg is not of class outline-x.");
        }
        return this;
    }else{
        throw new Error("arg is null / jquery object with no match");
    }
}

Slide.prototype = {
    current : undefined,
    previous : undefined,
    level : 1,
    // hide: function(){
    //   this.current.hide();  
    // },
    hideParents: function(){
        for(var i = 1;i<this.level;i++){
            $(outlineContents(i)).hide();
        }
    },
    hideSiblings: function(){
        $(outlineContents(this.level)).hide();
    },
    hideChildren: function(){
        for(var i=this.level+1;0<($(outline(i)).length);i++){
            $(outlineContents(i)).hide();
        }
    },
    showSelf: function(){
        this.current.children(outlineContents(this.level)).show().emerge();
    },
    show: function(){
        this.hideParents();
        this.hideSiblings();
        this.hideChildren();
        this.showSelf();
        return this;
    },
    nochild : function(){
        return nullp(this.current.children(outline(1+this.level)));
    },
    new : function(next,sustain){
        return new Slide(next,(sustain?this.previous:this));
    },
    up : function(sustain){
        return this.new(this.current.parent(),sustain);
    },
    down : function(sustain){
        return this.new(this.current.children(outline(1+this.level)).first(),sustain);
    },
    left : function(sustain){return this.new(this.current.prev(),sustain)},
    right : function(sustain){return this.new(this.current.next(),sustain)},
    next : function(){
        try{
            return this.down();
        } catch (x) {}
        try{
            return this.right();
        } catch (x) {}
        try{
            return this.up().right(true);
        } catch (x) {}
        throw new Error("next");
    },
    prev : function(){
        return (this.previous || new Error("no previous slide"));
    },
};

var slide;

window.onload = function(){
    $("#content").addClass("outline-1");
    slide = new Slide($("#content"));
    slide.show();
    setExpanders();
    $(window).keypress(
        function(e){
            (keyManager[String.fromCharCode(e.charCode)] || $.noop)(e);
        });
};

keyManager.n = function(){
    $(".title").hide();

    var exps=$(".expander:visible, .sibling-expander:visible");
    if(exps.length>0){
        exps.first().click();
    }else{
        console.log(slide.level);
        slide = slide.next();
        slide.show();
    }
};

keyManager.p = function(){
    console.log(slide.level);
    slide = slide.prev();
    slide.show();
};

keyManager.s = function(){
    sectionPrompt("Enter a section No. \nseparated by '.'");
};

function sectionPrompt(message){
    var result = window.prompt(message,
                               unparseSection(slide.current.get(0).id).join("."));
    result = result.split(".");
    try{
        console.log(container.apply(this,result));
        slide = slide.new($(container.apply(this,result)));
        slide.show();
    } catch (x) {
        sectionPrompt(container.apply(this,result) + " does not exists.");
    }
}