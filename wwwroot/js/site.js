// Write your Javascript code.
$(function(){
    $("#test").click(function(event) {
        event.preventDefault();
        alert("dsf");
        confirm("Are you sure you want to delete this NEO?");
    });
});