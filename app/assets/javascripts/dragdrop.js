$( function() {
    var $piece_id
    var $piece_type
    $( ".pieces" ).draggable({ 
      drag: function(){
       $piece_id = $(this).attr('id')
       $piece_type = $(this).attr('type')
       $piece_color = $(this).attr('color')
     }
    });
    $( ".droppable" ).droppable({
      drop: function( event, ui ) {
        var $column = $(this).data('column')
        var $row = $(this).data('row')

        
        $.ajax({
          url: "/pieces/" + $piece_id,
          type: "PUT",
          dataType: "script",
          data: { 'piece': {'coordinate_x': $row, 'coordinate_y': $column }}, 
          success: function(){
            // if (($piece_type == 'Pawn' && $column == 7 && $piece_color == 'black') || ($piece_type == 'Pawn' && $column == 0 && $piece_color == 'white')){
              $('#promotion').modal('show')
              // window.location.reload()
            }
             
          // }
        })      
      }
    });
  });









 