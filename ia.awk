BEGIN{
    mod_dir = "ke-docs/modules"
print "start"
}
/^\/\/ *ianew:?/ {
    ia = "found"
    close(ofile)
    
    new_m = ""
    new_f = ""
    old_f = FILENAME
    old_f = gensub(/.*\//, "", "g", old_f)
    # print old_f
    # print $0
    new_m = gensub(/^\/\/ *ianew:? *(.+)\/(.+)/, "\\1", "g")
    new_f = gensub(/^\/\/ *ianew:? *(.+)\/(.+)/, "\\2", "g")
    print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    print old_f
    printf "%s\n", new_m
    printf "%s\n", new_f
    ofile = mod_dir "/" new_m "/" new_f
    print ofile
    next
}
# label (ID)
# print old filename and label (ID)
/^\[\[.+\]\]/ {
    #str = $1
    str = gensub(/^\[\[(.+)\]\]/, "\\1", "g", $1)
    printf "%s %s\n",  old_f, str
    next
}
# detect level
/^=+ / {
    print $1
    l = length ($1)
    printf "%d\n", l
}
# print contents of chapter or section
{
    print $0
    # print $0 > ofile
}

END{
    # print old_f
}
