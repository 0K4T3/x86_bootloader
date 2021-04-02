OUTPUT_FORMAT("binary")
ENTRY("init")
SECTIONS
{
	.text :
	{
		*(.text)
	}
}
