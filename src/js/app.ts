/* eslint no-console:0 */

// Rails Unobtrusive JavaScript (UJS) is *required* for links in Lucky that use DELETE, POST and PUT.
// Though it says "Rails" it actually works with any framework.
require("@rails/ujs").start();

// Turbolinks is optional. Learn more: https://github.com/turbolinks/turbolinks/
require("turbolinks").start();

require("trix");

document.addEventListener("trix-file-accept", function (event) {
  event.preventDefault();
});

// If using Turbolinks, you can attach events to page load like this:
//
// document.addEventListener("turbolinks:load", function() {
//   ...
// })

import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";

const application = Application.start();
const context = require.context("./controllers", true, /\.ts$/);
application.load(definitionsFromContext(context));

// import Flatpickr
import Flatpickr from "stimulus-flatpickr";

// Manually register Flatpickr as a stimulus controller
application.register("flatpickr", Flatpickr);
