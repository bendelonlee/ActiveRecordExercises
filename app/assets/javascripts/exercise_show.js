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
