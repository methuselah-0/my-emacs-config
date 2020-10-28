;;; Compiled snippets and support files for `sh-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'sh-mode
		     '(("while" "while $1; do\n    $0; done" "while" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/while" nil nil)
		       ("usage" "${1:enumerate}_usage(){\ncat <<'EOF'\nExample:\n\n    <<$1-ex>>\n\nResults:\n\n    <<$1-ex()>>\n\nEOF\n}\n$0" "usage" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/usage" nil nil)
		       ("stdin" "[[ \"\\$1\" =~ (-h|--help) ]] && return 0\nlocal z\nlocal null=(z null \"\" \"Read null-separated input from stdin\" 0)\nOptions+=(\"(\\${null[*]@Q})\")\nlocal -a Operands\nsetopts \"\\$@\"\n[[ \"\\$1\" =~ (-h|--help) ]] && return 0\nlocal -a Input\nif [[ ! -t 0 ]]; then    	  \n    if [[ -n \"\\$z\" ]]; then\n        mapfile -t -d '' Input\n    else\n        mapfile -t Input; fi\nelse\n	Input=(\"\\${Operands[@]}\"); fi\n    # local -i i\n    # for ((i=1;i<=\\$#;i++)); do\n    #     eval \"narg=\\\\\\\"\\\\\\${$i}\\\\\\\"\"\n    #     if [[ \"\\${narg}\" == '--' ]]; then\n    # 	    i+=1 && Input=(\"\\${@:$i}\"); fi; done; fi\n\n[[ ! -n \"\\${Input[*]}\" ]] && { stack \"\\$@\" && return 1 ; }	    \n$0\n" "stdin" nil nil
			((yas-indent-line 'fixed)
			 (yas-wrap-around-region 'nil))
			"/home/user1/.emacs.d/snippets/sh-mode/stdin" nil nil)
		       ("mainrun" "declare -a org_args=\"\\${org_args}\"\nif [ \"\\${1:-\\${org_args[0]}}\" != \"--source-only\" ]; then\n    # $@ evaluates to all of the arguments passed to the function or script as individual strings.\n    if [[ -n \"\\$org_args\" ]]; then\n	main \"\\${org_args[@]}\"\n    else\n	main \"\\${@}\"\n    fi\nfi\n$0" "mainrun" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/mainrun" nil nil)
		       ("main" "main(){\n    $0\n}" "main" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/main" nil nil)
		       ("for" "for (($1; $2; $3)); do\n  $0; done" "for" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/for-loop" nil nil)
		       ("fdie" "|| { printf '%s' \"${1:error_msg}: \\${_STACK}\" && bcu__stack \"\\$@\" && return 1; }\n$0" "fdie" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/fdie" nil nil)
		       ("checkscm" "if ! command -v scm &>/dev/null; then\n   enable -f ~/.guix-profile/lib/bash/libguile-bash.so scm &>/dev/null || { printf '%s' \"Enabling guile-bash failed: \\${_STACK}\" && stack \"\\$@\" && return 1; }; fi\n$0" "checkscm" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/checkscm" nil nil)
		       ("aes" "\"\\${$1[*]}\"$0" "aes" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/array-star-expansion" nil nil)
		       ("aeq" "\"(\\${$1[*]@Q})\"$0" "aeq" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/array-quote-expansion" nil nil)
		       ("ae" "\"\\${$1[@]}\"$0" "ae" nil nil nil "/home/user1/.emacs.d/snippets/sh-mode/array-expansion" nil nil)))


;;; Do not edit! File generated at Wed Oct 28 09:51:54 2020
