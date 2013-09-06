MainView = require "./views/main"



$(document).ready () -> 
  main = new MainView()
  main.attach $ "#application"

