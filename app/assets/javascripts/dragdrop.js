

$( function() {
    $( ".pieces" ).draggable();
    $( ".droppable" ).droppable({
      drop: function( event, ui ) {
        
        console.log($(this).data('column'), $(this).data('row'))
      }
    });
  } );



 