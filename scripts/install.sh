#!/bin/bash
#   
#   Installiert den Apache Web Server
#

# Install apache, MariaDB Database Server, php, ftp, powershell, markdown to HTML
sudo apt update && sudo apt dist-upgrade && sudo apt autoremove
sudo apt install -y apache2 php libapache2-mod-php vsftpd markdown mariadb-server mariadb-client

# Home Verzeichnis unter http://<host>/data/ verfuegbar machen
mkdir -p /home/ubuntu/data/
sudo ln -s /home/ubuntu/data /var/www/html/data

cat <<%EOF% >/home/ubuntu/data/index.html
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Testseite $(hostname)</title>
</head>
<body>
<h1>Testseite $(hostname)</h1>
</body>
</html>
%EOF%

if [ -f README.md ]
then

cat <<%EOF% | sudo tee /var/www/html/index.html
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>$(hostname) Web UI</title>
<link rel="shortcut icon" href="https://kubernetes.io/images/favicon.png">
<meta charset="utf-8" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these 
        
    <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
    integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
    integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        $(markdown README.md)
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" type="text/javascript"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"
            type="text/javascript"></script>
         <script>
        // strip / bei Wechsel Port
        document.addEventListener('click', function(event) {
          var target = event.target;
          if (target.tagName.toLowerCase() == 'a')
          {
              var port = target.getAttribute('href').match(/^:(\d+)(.*)/);
              if (port)
              {
                 target.href = port[2];
                 target.port = port[1];
              }
          }
        }, false);
        </script>
    </div>
</body>
</html>
%EOF%

fi

sudo chmod -R g=u,o=u /home/ubuntu/data/
