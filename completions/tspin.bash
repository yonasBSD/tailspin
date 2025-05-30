_tspin() {
    local i cur prev opts cmd
    COMPREPLY=()
    if [[ "${BASH_VERSINFO[0]}" -ge 4 ]]; then
        cur="$2"
    else
        cur="${COMP_WORDS[COMP_CWORD]}"
    fi
    prev="$3"
    cmd=""
    opts=""

    for i in "${COMP_WORDS[@]:0:COMP_CWORD}"
    do
        case "${cmd},${i}" in
            ",$1")
                cmd="tspin"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        tspin)
            opts="-f -p -e -h -V --follow --print --config-path --exec --highlight --enable --disable --disable-builtin-keywords --pager --generate-bash-completions --generate-fish-completions --generate-zsh-completions --help --version [FILE]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --config-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exec)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -e)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --highlight)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --enable)
                    COMPREPLY=($(compgen -W "numbers urls pointers dates paths quotes key-value-pairs uuids ip-addresses processes json" -- "${cur}"))
                    return 0
                    ;;
                --disable)
                    COMPREPLY=($(compgen -W "numbers urls pointers dates paths quotes key-value-pairs uuids ip-addresses processes json" -- "${cur}"))
                    return 0
                    ;;
                --pager)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

if [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 || "${BASH_VERSINFO[0]}" -gt 4 ]]; then
    complete -F _tspin -o nosort -o bashdefault -o default tspin
else
    complete -F _tspin -o bashdefault -o default tspin
fi
