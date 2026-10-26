# Runs lab command blocks (separated by a line '---') in one bash session and saves outputs as JSON.
import sys, json, subprocess, tempfile
src, dst = sys.argv[1], sys.argv[2]
M = '__LABMARK__'
blocks = [b.strip('\n') for b in open(src, encoding='utf-8').read().split('\n---\n') if b.strip()]
script = 'exec 2>&1\nexport TERM=xterm COLUMNS=110\n'
for i, b in enumerate(blocks):
    root = b.startswith('#@root')
    body = b.split('\n', 1)[1] if root else b
    run = "sudo -H bash -c " + "'" + "cd /root\n" + body.replace("'", "'\\''") + "'" if root else body
    script += f'echo "{M}S {i} $(whoami) $(hostname) $PWD"\n{run}\necho\necho "{M}E {i}"\n'
with tempfile.NamedTemporaryFile('w', suffix='.sh', delete=False) as f:
    f.write(script)
out = subprocess.run(['bash', f.name], capture_output=True, text=True, stdin=subprocess.DEVNULL).stdout
res, cur = [], None
for line in out.split('\n'):
    if line.startswith(M + 'S '):
        _, i, u, h, cwd = line.split(' ', 4); i = int(i)
        b = blocks[i]; root = b.startswith('#@root')
        cur = {'user': 'root' if root else u, 'host': h, 'cwd': '/root' if root else cwd,
               'cmd': b.split('\n', 1)[1] if root else b, 'out': []}
    elif line.startswith(M + 'E '):
        cur['out'] = '\n'.join(cur['out']).rstrip('\n'); res.append(cur); cur = None
    elif cur is not None:
        cur['out'].append(line)
json.dump(res, open(dst, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
print(f'{len(res)}/{len(blocks)} blocks done')
