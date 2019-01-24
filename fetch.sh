#!/usr/bin/env bash

display_info() {

	d_title=$USER@$HOSTNAME
	d_distro=$(uname -a | awk '{print $2}')
	d_os=$(uname -o)
	d_kname=$(cat /proc/sys/kernel/ostype)
	d_kversion=$(cat /proc/sys/kernel/osrelease)
	d_uptime=$(uptime | awk '{print $3}')" min"
	d_shell=$(basename $SHELL)
	d_res=$(xrandr | sed -n '1p' | sed 's/.*current.//g;s/,.*//g;s/ //g')
	d_deskEnv=$XDG_SESSION_DESKTOP
	d_font=$(fc-match | sed 's/\..*//g')
	d_cpu=$(cat /proc/cpuinfo | grep -o 'model name.*' | sed -n '1p' | sed 's/.*:.//g')
	d_memTotal=$(echo $(cat /proc/meminfo | sed -n '1p' | tr -d {A-Za-z:' '}) / 1000000 | bc)" GB"
	d_memFree=$(echo "scale=2;$(cat /proc/meminfo | sed -n '2p' | tr -d {A-Za-z:' '})" / 1000000 | bc)" GB"
	d_arch=$(getconf LONG_BIT)"-bits"
	d_browser=$(xdg-settings get default-web-browser | sed 's/.desktop//g')

	d_titleSize=$(expr length "$d_title"); qtd=
	for i in $(seq 1 $d_titleSize); do
		qtd="$qtd─"
	done
}

set_info() {

display_info

cat <<EOF

$d_title
$qtd
Distro: ${d_distro^}
OS: ${d_os^}
Kernel Name: $d_kname
Kernel Version: $d_kversion
Uptime: $d_uptime
Shell: ${d_shell^}
Resolution: $d_res
Desktop Enviroment: ${d_deskEnv^}
Font: $d_font
CPU: $d_cpu
Memory Total: $d_memTotal
Memory Free: $d_memFree
Architeture: $d_arch
Browser Default = $d_browser

EOF
}

logo="
MMMMXXOKXXkKxW00OKXkKOMKKKO0xKXXMMM
MMMMdkdkxkokoWxxxNOlxdOokOd0lOdMMMM
MMMOdxxxxxxxxxxxxxxxxxxxxxxxxxo0MMM
MMMlx0:cdddo:odddddddo:odddc:0xlMMM
MMMlxolkoo0MXdodNMNdodXM0ookldxlM00
KKMlxodMMMO;ckWNxoxNWkc;OMMModxlMKK
0KMlxodMMMMX,koodKdodk'XMMMModxlM0X
KNMlxodMMMMW.:MMX;NMM:.WMMMModxlM0X
00MlxodMMMM0l;loKMKol;lKMMMModxlMKK
MMMlxodWOooOWNdclolcdNWOooOModxlMKK
MMMlxd.l0MKooxNWkokWNxloKM0l.xxlMMM
MMM0lokoc'kWNxooKMKooxNWk'cokolKMMM
MMMMMWxldkl,;XWOoooOWX;,lkdlxWMMMMM
MMMMMMMMNdldxl.xMMMd.lkdldNMMMMMMMM
MMMMMMMMMMMXolxxlllxxloXMMMMMMMMMMM
MMMMMMMMMMMMMMKolxloKMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMOMMMMMMMMMMMMMMMMM
                                   
"

#printf "%s" "$logo"
#set_info

paste <(printf "%s" "$logo") <(set_info) | lolcat
