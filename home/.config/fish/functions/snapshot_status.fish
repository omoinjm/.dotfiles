function snapshot_status --description 'Show the last machine-snapshot run (snapshot_status -f: full log tail)'
    set -l log ~/.local/state/snapshot/snapshot.log
    set -l stamp ~/.local/state/snapshot/last-success
    test -f $log; or return 0

    if contains -- -f $argv; or contains -- --full $argv
        tail -n 50 $log
        return
    end

    # last run = everything after the final "===== <date> =====" header
    set -l start (grep -n '^=====' $log | tail -n 1 | cut -d: -f1)
    test -n "$start"; or return 0
    set -l run (tail -n +$start $log)
    set -l when (string replace -ra '=+ ?' '' -- $run[1])
    set -l result (string match -r '^result: .*' -- $run)
    set -l notes (count (string match -r '^\s+\S.*' -- $run))

    set -l age_h -1
    test -f $stamp; and set age_h (math -s0 "($(date +%s) - $(stat -c %Y $stamp)) / 3600")

    echo
    set_color --bold blue; echo -n "snapshot "; set_color normal
    set_color brblack; echo -n "$when  "; set_color normal
    if string match -q '*ok*' -- $result; and test $age_h -ge 0 -a $age_h -lt 26
        set_color green; echo "✔ ok"
    else if string match -q '*FAILED*' -- $result
        set_color red; echo "✘ $result — snapshot_status -f"
    else
        set_color yellow; echo "⚠ no successful snapshot in "(test $age_h -ge 0; and echo "$age_h h"; or echo "ever")
    end
    set_color normal

    for line in (string match -r '^==> (?:Committed|No changes|Pushed).*' -- $run)
        set_color brblack; echo "  "(string replace '==> ' '' -- $line); set_color normal
    end
    if test $notes -gt 0
        set_color yellow; echo "  $notes repo note(s) not covered by the snapshot — snapshot_status -f"; set_color normal
    end
end
