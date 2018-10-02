

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
        // console.log($(this).data('column'), $(this).data('row'))
        console.log($piece_id)
        $.ajax({
          url: "/pieces/" + $piece_id,
          type: "PUT",
          data: {'coordinate_x': $row, 'coordinate_y': $column },
          success: function(){
            alert("Piece with id: " + $piece_id + " successfully updated coordinates")
          }
        })
      }
    });
  } );



 