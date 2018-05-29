import "phoenix_html"
import "bootstrap/dist/js/bootstrap.min.js"
import { triggerTab } from "./helpers"
// import React from "react"
// import ReactDOM from "react-dom"

// Styles
import "bootstrap/dist/css/bootstrap.css"
import "../css/phoenix.css"
import "../css/app.css"

// onload
triggerTab()

//
function goto(link) {
  document.location.href=link
}
window.goto = goto

// const HelloReact = props => <div />

// ReactDOM.render(<HelloReact />, document.getElementById("my-react-app"))
