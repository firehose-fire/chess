$( function(){
  var selected_piece

$('.pieces').click(function(){
  selected_piece = $(this).attr('id'); 
  
})


$('#castleQueenside').click(function(){
  $.ajax({
          url: "/pieces/" + selected_piece + "/castle_queen",
          type: "GET", 
          success: function(){           
          }
         
        })
})

$('#castleKingside').click(function(){
  $.ajax({
          url: "/pieces/" + selected_piece + "/castle_king",
          type: "GET", 
          success: function(){           
          }
         
        })
})

});