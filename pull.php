<?php

// Use in the “Post-Receive URLs” section of your GitHub repo.

if ( $_POST['payload'] ) {
shell_exec( 'cd /config/www/CyberPatriots/ && git reset -–hard HEAD && git pull' );
}

?>hi