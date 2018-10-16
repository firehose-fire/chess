$( function(){
  var selected_piece

function castleQueen(){
  alert('');
}

$('.pieces').click(function(){
  selected_piece = $(this).attr('id'); 
  alert(selected_piece);
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