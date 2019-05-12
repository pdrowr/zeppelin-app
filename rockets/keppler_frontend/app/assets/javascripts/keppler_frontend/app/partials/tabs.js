$(document).ready(function () {

  //** NavMenu */
  $('ul.tabs li').click(function () {
    var tab_id = $(this).attr('data-tab');

    $('ul.tabs li').removeClass('current');
    $('.tab-content').removeClass('current');

    $(this).addClass('current');
    $("#" + tab_id).addClass('current');
  })

  /** Spaces **/
  $('ul#sub-tabs li').click(function () {
    var sub_tab_id = $(this).attr('data-tab');

    $('ul#sub-tabs li').removeClass('current');
    $('.tab-content-sub').removeClass('current');

    $(this).addClass('current');
    $("#" + sub_tab_id).addClass('current');
  })


  /* Tables*/
  $('.card-wrapper').not('.disabled').click(function () {
    var index = $(this).attr('data-tab');

    $(this).addClass('current');
    $('.order-wrapper').removeClass('current')
    $("#" + index).addClass('current');

  })

  /** close order**/
  $('.close-order').click(function () {
    $('.order-wrapper').removeClass('current')
  })


  /**Categories */
  $('ul#categories li').click(function () {
    var category_id = $(this).attr('data-tab');

    $('ul#categories li').removeClass('current');
    $('.category-content').removeClass('current');

    $(this).addClass('current');
    $("#" + category_id).addClass('current');
  })
})