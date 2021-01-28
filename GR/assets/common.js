
function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function checkCookie() {
    var username = getCookie("userID");
    if (username != "") {
        return 1;
    } else {
        window.location.href="login.html";
    }
}

function clearForm(){
    var i;
    for(i=0; (i<document.forms.length); i++){
        document.forms[i].reset();
    }
}

function checkFields(formId){
    var error_n=true;
    $("#"+formId).find( ".required" ).each(function() {
        var error_element=$("span", $(this).parent());
        if ($(this).val()=="") {
            $(this).focus();
            error_element.removeClass("error").addClass("error_show");
            error_n = false;
        } else {
            error_element.removeClass("error_show").addClass("error");
        }
    });
    return error_n;
}
