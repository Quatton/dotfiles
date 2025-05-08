function cdx
    cd $argv

    # if found cdx.sh, execute it
    if test -f cdx.sh
        . cdx.sh
    end

    # else if found .cdx, source it
    if test -f .cdx
        source .cdx
    end
end
