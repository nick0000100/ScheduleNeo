// Prevents the deletion of the NEO if they did not confirm.
$(".delete").click(function(event) {
    let check = confirm("Are you sure you want to delete this NEO?");
    if(!check)
    {
        event.preventDefault();
    }
});