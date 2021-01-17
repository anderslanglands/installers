function title_block() {
    local width=$(tput cols)
    local line=`printf "#%.0s" $(seq 1 $width)`
    printf '%s\n\n' "$line"
    printf "%*s\n\n" $(((${#1}+$width)/2)) "$1"
    printf '%s\n' "$line"
}

