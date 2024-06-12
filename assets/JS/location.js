var addr_list = ["https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d829.2618310285651!2d121.24014760662376!3d24.95707635539268!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3468221447a0f021%3A0x2b86d2650bb8bcff!2sChung%20Yuan%20Christian%20University!5e0!3m2!1sen!2skr!4v1718062093769!5m2!1sen!2skr",
                "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d904.3227980764486!2d121.24115408712302!3d24.956205561475254!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34682215a5f7e955%3A0x1ca0501c71d7f47d!2z55yf55-l5pWZ5a245aSn5qiT!5e0!3m2!1sen!2stw!4v1718062542398!5m2!1sen!2stw",
                "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3617.2911929992615!2d121.23921618815963!3d24.956205537872385!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x346822143c046009%3A0x63e3ef21e3beebac!2z6LOH6KiK566h55CG5a2457O7!5e0!3m2!1sen!2stw!4v1718062737664!5m2!1sen!2stw"
                ]

function loadMap(index){
    mapSrc = `${addr_list[index]}`;
    document.querySelector('#addrID').setAttribute('src', mapSrc);
    console.log(addr_list[index]);
}

function mapToggle(){
    var div = document.querySelector(".address-container");
    var button = document.querySelector(".fixbutton");
    var mediaQuery = window.matchMedia("(max-width: 1000px)");
    console.log(div);
    if (mediaQuery.matches){
        if (!div.classList.contains("hidden")) {
            div.classList.add("hidden");
            button.classList.remove("hidden");
        }
        else {
            div.classList.remove("hidden");
            button.classList.add("hidden");
        }
    }
}