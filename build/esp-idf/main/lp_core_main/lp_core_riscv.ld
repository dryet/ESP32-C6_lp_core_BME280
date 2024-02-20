       
       
       
ENTRY(reset_vector)
MEMORY
{
    vector_table(RX) : ORIGIN = 0x50000000, LENGTH = 0x80
    ram(RWX) : ORIGIN = 0x50000000 + 0x80, LENGTH = 8192 - 0x80 - 0x8
}
SECTIONS
{
    .vector.text :
    {
        __mtvec_base = .;
        KEEP (*(.init.vector .init.vector.*))
    } > vector_table
    . = ORIGIN(ram);
    .text ALIGN(4):
    {
        *(.text.vectors)
        *(.text)
        *(.text*)
    } >ram
    .rodata ALIGN(4):
    {
        *(.rodata)
        *(.rodata*)
    } > ram
    .data ALIGN(4):
    {
        *(.data)
        *(.data*)
        *(.sdata)
        *(.sdata*)
    } > ram
    .bss ALIGN(4) :
    {
        *(.bss)
        *(.bss*)
        *(.sbss)
        *(.sbss*)
        PROVIDE(end = .);
    } >ram
    __stack_top = ORIGIN(ram) + LENGTH(ram);
}
