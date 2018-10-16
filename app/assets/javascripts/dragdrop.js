var pieceId;
var pieceType;
var column;
var row;

$(document).ready(function() {
  $(".pieces").draggable({
    drag: function() {
      pieceId = $(this).data("piece_id");
    }
  });

  $(".droppable").droppable({
    drop: function(event, ui) {
      column = $(this).data("column");
      row = $(this).data("row");
      pieceType = $(this).data("piece_type");

      $.ajax({
        url: "/pieces/" + pieceId,
        type: "PUT",
        data: { piece: { coordinate_x: row, coordinate_y: column } },
        success: function() {
          debugger;
          // This where we want to move/replace the html element
          checkPromo();
        },
        error: function() {
          debugger;
          // This is where we want to error 400
        }
      });
    }
  });
});

function checkPromo() {
  if (
    (pieceType == "Pawn" && column == 0) ||
    (pieceType == "Pawn" && column == 7)
  ) {
    promoModal();
  }
}

function promoModal() {
  $("#promotion").modal("show");
  $("#rookButton").on("click", function() {
    promoChoice = "Rook";
    givePromo();
  });
  $("#bishopButton").on("click", function() {
    promoChoice = "Bishop";
    givePromo();
  });
  $("#knightButton").on("click", function() {
    promoChoice = "Knight";
    givePromo();
  });
  $("#queenButton").on("click", function() {
    promoChoice = "Queen";
    givePromo();
  });
}

function givePromo() {
  $.ajax({
    url: "/pieces/" + pieceId,
    type: "PUT",
    data: { piece: { type: promoChoice } },
    success: function() {
      debugger;
      // This where we want to move/replace the html element
    },
    error: function() {
      debugger;
      // This is where we want to error 400
    }
  });
}
