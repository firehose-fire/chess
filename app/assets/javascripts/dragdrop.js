

$( function() {
    var $piece_id
    $( ".pieces" ).draggable({ 
      drag: function(){
       $piece_id = $(this).attr('id')

     }
    });
    $( ".droppable" ).droppable({
      drop: function( event, ui ) {
        var $column = $(this).data('column');
        var $row = $(this).data('row')
        $.ajax({
          url: "/pieces/" + $piece_id,
          type: "PUT",
          dataType: "script",
          data: { 'piece': {'coordinate_x': $row, 'coordinate_y': $column }},  
          success: function(){           
            window.location.reload()
          }
         
        })

      
      }
    });
  } );



 