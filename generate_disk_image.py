disk_img = b''

with open('boot.img', mode='rb') as fp:
    disk_img += fp.read()
    
with open('kernel.img', mode='rb') as fp:
    disk_img += fp.read()

with open('disk.img', mode='wb') as fp:
    fp.write(disk_img)
    
