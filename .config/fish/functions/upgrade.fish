# Author: Nuncvc1v0

function upgrade --description 'upgrade all'
    paru
    rustup update

    uv tool upgrade --all

    set -l versions_to_update

    for py in (uv python list | string match -r '.*\.local/share/uv.*' | awk '{print $1}')
        set -l base_ver (echo $py | string replace -r '^[a-z]+-([0-9]+\.[0-9]+).*' '$1')

        if string match -q "*freethreaded*" $py
            set base_ver "$base_ver"t
        end

        if not contains $base_ver $versions_to_update
            set -a versions_to_update $base_ver
        end
    end

    if test (count $versions_to_update) -gt 0
        uv python install $versions_to_update
    end
end
