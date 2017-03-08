# Window Explorer Text Preview in One Moment

## This describes the one_moment.1mo file

It is a text file and file type that I've made to help remember how to set the preview pane in Win7 explorer to preview files as text. I find it useful in folders full of text based code that Win7 doesn't already know about (like Logo files .lgo).

You might notice that it is also a markdown file.

## Steps

1. Make a text file and change its extension to '.1mo'. This will put it near the top of the Computer | HKEY_CLASSES_ROOT hive in the registry.
2. Open the file's properties and et it to 'Open with:' {your favourite text editor} (on Win7, mine is Notepad++)
3. Open the registry editor (Start | Run | regedit) and find the .1mo entry in the hive shown above.
4. Add two new string key/value pairs (REG_SZ): 'ContentType:text/plain' and 'PerceivedType:text' respectively.
