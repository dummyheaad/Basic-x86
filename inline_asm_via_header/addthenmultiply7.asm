global addthenmultiply7
addthenmultiply7:
    push ebp
    mov ebp, esp

    ; prototype fungsi => func(arg1, arg2, arg3)
    mov eax, [ebp+8]        ; move nilai arg1 ke eax
    add eax, [ebp+12]       ; tambahkan nilai arg2 ke eax
    add eax, [ebp+16]       ; tambahkan nilai arg3 ke eax
    mov ecx, 7              ; move 7 ke register ecx
    imul ecx                ; eax *= ecx

    mov esp, ebp
    pop ebp
    ret
