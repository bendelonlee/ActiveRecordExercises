

var editableCodeMirror

$(document).ready ( function() {
  let textArea = document.getElementById('solution_solution_code')
  editableCodeMirror = CodeMirror.fromTextArea(textArea, {
      mode: "ruby",
      theme: "mdn-like",
      lineNumbers: true
  });

  editableCodeMirror.setSize(800, 100);

  let readOnlyTextArea = document.getElementById('answerCode')
  cm = CodeMirror.fromTextArea(readOnlyTextArea, {
    mode: "ruby",
    theme: "mdn-like",
    lineNumbers: false,
    readOnly: true
  });

  $("#toggle-button").on('click', function(event){
    $("#answers-and-discussion").toggleClass()
    $("#answerCode").val('h')
    cm.setSize(350, 'auto');
  });

  fillSurrenderText();
});



function renderReadOnly() {
  $(".readOnlyCode").each(function() {
    cm = CodeMirror.fromTextArea($(this).get(0), {
      mode: "ruby",
      theme: "mdn-like",
      lineNumbers: false,
      readOnly: true
    });
    cm.setSize(350, 'auto');
  });
};

function fillSurrenderText() {
  let arr = [
    "Just Let Go",
    "Hail Mary",
    "Pass",
    "Let The Computers Win",
    "Spare Me My Life From This Monstrosity",
    "Show Answer"
  ]
  let quip = arr[Math.floor(Math.random() * arr.length)];
  $('#surrender-button').text(quip);
}

function addCodeToTextArea() {
  editableCodeMirror.save;
};
