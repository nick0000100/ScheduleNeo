// Prevents the deletion of the NEO if they did not confirm.
$(".delete").click(function(event) {
    let check = confirm("Are you sure you want to delete this NEO?");
    if(!check)
    {
        event.preventDefault();
    }
});

// Prevents the deletion of an employee if they did not confirm.
$(".deleteEE").click(function(event) {
    let check = confirm("Are you sure you want to delete this employee?");
    if(!check)
    {
        event.preventDefault();
    }
});

// Moves employee to and from pre invite list.
$(function() {
    
    function preInvite(from, to) {
        $(to).append(function() {
            return $(from + " option:selected").each(function() {
                this.outerHTML;
            }).remove();
        });
    }
    
    $("#invite").off("click").on("click", function() {
        preInvite("#AllVolunteers", "#PreInvited");
    });
    
    $("#uninvite").off("click").on("click", function() {
        preInvite("#PreInvited", "#AllVolunteers");
    });
    
});