OUTPUT_FORMAT("binary")
OUTPUT("disk.img")

SECTIONS
{
  .text 0x7c00 : {
    boot.o(.text)
    kernel.o(.text)
  }
}
