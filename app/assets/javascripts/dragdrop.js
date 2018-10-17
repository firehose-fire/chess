var pieceId;
var pieceType;
var column;
var row;
var initPage = function() {
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
          checkPromo();
          initPage();
        },
        error: function() {}
      });
    }
  });
};

$(document).ready(initPage);

function checkPromo() {
  debugger
  if (
    (pieceType == "Pawn" && column == 0) ||
    (pieceType == "Pawn" && column == 7)
  ) {
    promoModal();
  }
}

function promoModal() {
  $("#promotion").modal("show");
  $(".choices button").on("click", function() {
    givePromo($(this).data("type"));
  });
}

function givePromo(promoChoice) {
  $.ajax({
    url: "/pieces/" + pieceId,
    type: "PUT",
    data: { piece: { type: promoChoice } },
    success: function() {
      initPage();
    },
    error: function() {}
  });
}
