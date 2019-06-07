function empezarDetener(elemento) {
  var timeout = 0;
  if (timeout == 0) {
    inicio = vuelta = new Date().getTime();
    funcionando();
  } else {
    elemento.value = "Empezar";
    clearTimeout(timeout);
    timeout = 0;
  }
}

function funcionando() {
  var actual = new Date().getTime();
  var diff = new Date(actual - inicio);
  var result = LeadingZero(diff.getUTCHours()) + ":" + LeadingZero(diff.getUTCMinutes()) + ":" + LeadingZero(diff.getUTCSeconds());
  document.getElementById('crono').innerHTML = result;
  timeout = setTimeout("funcionando()", 1000);
}

function LeadingZero(Time) {
  return (Time < 10) ? "0" + Time : + Time;
}
