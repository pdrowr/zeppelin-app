$('.menu-toggle').click(function () {
  $('aside').toggleClass('active-menu');
})


// Loader

$(window).on("load", function (e) {
  setTimeout(function () {
    $('#preloader').fadeOut(500, function () {
      $(this).remove();
    });
    $('.body').css('overflow-y', 'auto');
  });
});


// $(function () {
//   if ((window).width() <= 767) {
//     $('.js-card-wrapper').click(function () {
//       $('.sidebar').toggleClass('active-sidebar');
//     })
//   } else {

//   }
// });