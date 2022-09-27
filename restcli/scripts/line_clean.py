import os

path = os.getenv("SOURCE", '')

LINE_SEPARATOR = '\n\n\n'


def clean_file(filepath):
    with open(filepath, 'r') as f:
        src = f.read()
    src = src + LINE_SEPARATOR if not src.endswith(LINE_SEPARATOR) else src
    with open(filepath, 'w') as f:
        f.write(src)


if not os.path.exists(path):
    raise ValueError(f"Invalid path: {path}")
if os.path.isfile(path):
    clean_file(path)
elif os.path.isdir(path):
    for f in os.listdir(path):
        fullpath = os.path.join(path, f)
        if os.path.isfile(fullpath) and fullpath.endswith('.http'):
            clean_file(fullpath)
else:
    raise ValueError(f"Invalid path: {path}. Neither a dir nor a file!")
