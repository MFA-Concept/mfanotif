class notif {
    constructor(msg,type,icon,color,time){
        this.msg = msg
        this.type = type
        this.icon = icon
        this.color = color
        this.time = time
    }

    show(){
        if (this.type === "warning") {
            this.icon = {value : "fa-solid fa-triangle-exclamation",color :"yellow"}
            this.color = "yellow"
            this.time = 3000
        }else if (this.type === "succes"){
            this.icon = {value :"fa-solid fa-circle-check",color : "green"}
            this.color = "green"
            this.time = 3000
        }else if (this.type === "error") {
            this.icon = {value : "fa-solid fa-circle-exclamation",color : "red"}
            this.color = "red"
            this.time = 3000
        }

        var notif = $(` <div class="notif">
                    <i class="${this.icon.value}"style="color: ${this.icon.color}" ></i>
                        <div class="content-txt">
                             <p>${this.msg}</p>
                        </div>
                        <span class="progress"></span>
                     </div>`)
     
        $('.container-notif').append(notif)
        if (this.color){
            notif.find(".progress").css({"background":`${this.color}`})
        }else{
            notif.find(".progress").css({"background": "white"})
        }

        const me = this
        setTimeout(function (){
            notif.addClass("active")
            var time = me.time / 1000
            notif.css({"border-left":"2px solid "+me.color})
            notif.find(".progress").css("transition",`all ${me.time / 1000}s  ease-in-out`)
            notif.find(".progress").animate({ width:'0%'},{duration : `${me.time}`})
            notif.animate({right:"10px"},{duration:"0.2s"})
        },2)
        setTimeout(function (){
            me.delete()
        },me.time + 500)
     
    }
    delete(){
        $(".container-notif").children().first().remove()
    }
}


var isVisible = false
class helpNotif {
    constructor(msg){
        this.msg = msg
    }
    
    show(msg){
        this.msg = msg

            let helpText = $(`<div class="help-content">
                                ${this.msg}
                             </div>`)
            $(".container-help").append(helpText)
            $(".container-help").show()
        
       
    }
    hide(){
            $(".containter-help").hide()
            $(".containter-help").empty()
    }
}





$(window).on("message", function(e) {
    var data = e.originalEvent.data;
    if (data.type === "notify") {
        if (data.info.type === "custom") {
            const notifs = new notif(data.info.message,data.info.type,{value : data.info.icons.value,color : data.info.icons.color},data.info.color,data.info.time)
            notifs.show()
        }else {
            const notifs = new notif(data.info.message,data.info.type)
            notifs.show()
        }
        
    }else if(data.type === "helpNotif") {
        const helpNotifs = new helpNotif()
        helpNotifs.show(data.info.message)
   
       
        
    }else if(data.type === "hideHelpNotif") {
        $(".container-help").hide()
        $(".container-help").empty()
    }
});

// $(".btn").click(function(){
//     console.log("test");

//     const notifs = new helpNotif("Appuyer sur <span class='key'>E</span> accéder a l'armurerie")
//     notifs.show()
// })