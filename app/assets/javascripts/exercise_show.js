function toggleSolution() {
  let s = document.getElementById("answers-and-discussion");
  let b = document.getElementById("toggle-button");
  if (s.style.display === "none") {
    s.style.display = "block";
    b.innerHTML = "hide";
    renderReadOnly()
  } else {
    s.style.display = "none";
    b.innerHTML = "show";
  }
}

var editableCodeMirror

window.onload = function () {

  let textArea = document.getElementById('solution_solution_code')
  editableCodeMirror = CodeMirror.fromTextArea(textArea, {
      mode: "ruby",
      theme: "mdn-like",
      lineNumbers: true
  });
  editableCodeMirror.setSize(800, 100);

};

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

function addCodeToTextArea() {
  editableCodeMirror.save;
};
