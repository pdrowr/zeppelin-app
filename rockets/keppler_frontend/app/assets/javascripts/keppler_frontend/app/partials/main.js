$('.menu-toggle').click(function () {
  $('aside').toggleClass('active-menu');
})

$(window).on("load", function (e) {
  setTimeout(function () {
    $('#preloader').fadeOut(500, function () {
      $(this).remove();
    });
    $('.body').css('overflow-y', 'auto');
  }, 1000);
});
