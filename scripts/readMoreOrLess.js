function readMoreOrLess(myLess, myMore, btnName) {
  var lessText = document.getElementById(myLess);
  var moreText = document.getElementById(myMore);
  var btnText = document.getElementById(btnName);

  if (lessText.style.display === "none") {
    lessText.style.display = "inline";
    moreText.style.display = "none";
    btnText.innerHTML = "More";
  } else {
    lessText.style.display = "none";
    moreText.style.display = "inline";
    btnText.innerHTML = "Less";
  }
}
