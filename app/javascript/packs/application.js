// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------


// Delete will work on Edge

//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require bootstrap
//= require_tree

// External imports
import "bootstrap";

// Internal imports, e.g:
import { initProjectChatCable } from '../channels/project_chat_channel';
import { initChatroomCable } from '../channels/chatroom_channel';
import { initSendMessage } from './init_send_message';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  initProjectChatCable();
  initChatroomCable();
  initSendMessage();
});

// SHOW PAGE TABS

$('#ProjectsTab #about-tab').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show active')
  $('#ProjectsTab li:first-child a').tab('show') // Select first tab
})

$('#ProjectsTab #timeline-tab').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show active')
  $('#myTab li:nth-child(2) a').tab('show') // Select second tab
})

$('#ProjectsTab #media-tab').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show active')
  $('#ProjectsTab li:nth-child(3) a').tab('show') // Select third tab
})

$('#ProjectsTab #chat-tab').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show active')
  $('#ProjectsTab li:last-child a').tab('show') // Select last tab
})

// DASHBOARD TABS

$('#DashboardTab #my-projects-tab').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show active')
  $('#DashboardTab li:first-child a').tab('show')
})

$('#DashboardTab #my-collabs-tab').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show active')
  $('#DashboardTab li:nth-child(2) a').tab('show')
})

$('#DashboardTab #requests-tab').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show active')
  $('#DashboardTab li:nth-child(3) a').tab('show')
})

$('#DashboardTab #favorites-tab').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show active')
  $('#DashboardTab li:last-child a').tab('show')
})

// TOGGLE

$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  e.target // newly activated tab
  e.relatedTarget // previous active tab
})

// CLICK ON PROJECT'S PHOTO TO ENLARGE

const projectPhoto = document.querySelector('.project-photo');

// projectPhoto.addEventListener("click", (event) => {
//   arrow.classList.toggle("arrow-active")
//   projectPhoto.classList.toggle("project-photo-active");
// })

//  better Alerts

const alert = document.querySelector('#alert-flash')

setTimeout(fade_out, 8000);

function fade_out() {
  $(".alert").fadeOut().empty();
}

// Scrolling for timeline
function scroll_to(position) {
  const element_to_scroll_to = document.getElementById(position);
  element_to_scroll_to.scrollIntoView();
}

function add_links(amount) {
  console.log(amount);
  // const dot_button = document.getElementById('dot-5');
  // dot_button.addEventListener('click', function(event) {
  //   const element = '5';
  //   element.scrollIntoView();
  // })
}

