// pull in desired CSS/SASS files
require( 'bulma/bulma.sass' );
require( '../static/styles/main.scss' );
// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
Elm.Main.embed( document.getElementById( 'main' ) );
