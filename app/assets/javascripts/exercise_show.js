function toggleSolution() {
  var s = document.getElementById("answers-and-discussion");
  var b = document.getElementById("toggle-button");
  if (s.style.display === "none") {
    s.style.display = "block";
    b.innerHTML = "hide";
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
      theme: "default",
      lineNumbers: true
  });
  editableCodeMirror.on("change", function(cm, change) {
    cm.save;
  });

};

function addCodeToTextArea() {
    debugger;
    editableCodeMirror.save
};
