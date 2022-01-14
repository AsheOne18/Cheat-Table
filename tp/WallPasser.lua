[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
aobscanmodule(playerCoordBaseWriteAOB,DarkSoulsIII.exe,48 8B 48 18 8D 46 9C)
registersymbol(playerCoordBaseWriteAOB)

label(pPlayerCoordBase)
registersymbol(pPlayerCoordBase)

alloc(newmem,2048,playerCoordBaseWriteAOB) //"DarkSoulsIII.exe"+40887F)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here
mov rcx,[rax+18]
mov [pPlayerCoordBase],rcx

originalcode:
mov rcx,[rax+18]
lea eax,[rsi-64]

exit:
jmp returnhere

///
pPlayerCoordBase:
///

playerCoordBaseWriteAOB: //"DarkSoulsIII.exe"+40887F:
jmp newmem
nop
nop
returnhere:

///*************************************************///

aobscanmodule(inAirTimerReadAOB,DarkSoulsIII.exe,F3 0F 11 81 B0 01 00 00 48)
registersymbol(inAirTimerReadAOB)

alloc(newmem3,2048,inAirTimerReadAOB) //"DarkSoulsIII.exe"+9B6A2A)
label(returnhere3)
label(originalcode3)
label(exit3)

newmem3: //this is allocated memory, you have read,write,execute access
//place your code here
push rax
mov rax,[pPlayerCoordBase]
test rax,rax
jz originalcode3
mov rax,[rax+28]
cmp rax,rcx
jne originalcode3
xorps xmm0,xmm0

originalcode3:
pop rax
movss [rcx+000001B0],xmm0

exit3:
jmp returnhere3

///

inAirTimerReadAOB: //"DarkSoulsIII.exe"+9B6A2A:
jmp newmem3
nop
nop
nop
returnhere3:

///*************************************************///

aobscanmodule(camHRotateConstWrite2AOB,DarkSoulsIII.exe,66 0F 7F AE 40 01 00 00 E9 ** ** ** ** F3)
registersymbol(camHRotateConstWrite2AOB)

label(pCamInfo)
registersymbol(pCamInfo)

alloc(newmem4,2048,camHRotateConstWrite2AOB) //"DarkSoulsIII.exe"+510F9C)
label(returnhere4)
label(originalcode4)
label(exit4)

newmem4: //this is allocated memory, you have read,write,execute access
//place your code here
mov [pCamInfo],rsi

originalcode4:
movdqa [rsi+00000140],xmm5

exit4:
jmp returnhere4

///
pCamInfo:
///

camHRotateConstWrite2AOB: //"DarkSoulsIII.exe"+510F9C:
jmp newmem4
nop
nop
nop
returnhere4:

///*************************************************///

aobscanmodule(someKeysConstReadAOB,DarkSoulsIII.exe,F3 41 0F 11 0C 80 F3 ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** 40)
registersymbol(someKeysConstReadAOB)

label(pMovementInfo)
registersymbol(pMovementInfo)
label(iXOffset)
registersymbol(iXOffset)

alloc(newmem5,2048,someKeysConstReadAOB) //"DarkSoulsIII.exe"+1785CFD)
label(returnhere5)
label(originalcode5)
label(exit5)

newmem5: //this is allocated memory, you have read,write,execute access
//place your code here
mov [pMovementInfo],r8
test rdi,rdi
jnz originalcode5
cmp dword ptr [rsp+54],0
jne originalcode5
mov [iXOffset],rax

originalcode5:
movss [r8+rax*4],xmm1

exit5:
jmp returnhere5

///
pMovementInfo:
dq 0
iXOffset:
dq 0
///

someKeysConstReadAOB: //"DarkSoulsIII.exe"+1785CFD:
jmp newmem5
nop
returnhere5:

///*************************************************///

aobscanmodule(coordsUpdateAOB,DarkSoulsIII.exe,66 0F 7F B3 80 00 00 00 0F 57 C0)
registersymbol(coordsUpdateAOB)

label(fZDirection)
registersymbol(fZDirection)

alloc(newmem6,2048,coordsUpdateAOB) //"DarkSoulsIII.exe"+9B7570)
label(returnhere6)
label(originalcode6)
label(exit6)
label(arenaE6)

newmem6: //this is allocated memory, you have read,write,execute access
//place your code here
cmp byte ptr [bFlyMode],1
je @f
jmp originalcode6

@@:
mov rcx,[pPlayerCoordBase]
test rcx,rcx
jz originalcode6
mov rcx,[rcx+28]
cmp rcx,rbx
jne originalcode6
jne arenaE6

//is player
//freeze player
movdqa xmm6,[rbx+80]

//ready registers
push rax
push rdx

//do y
mov rcx,[pMovementInfo]
test rcx,rcx
jz @f
mov rdx,[iXOffset]
test rdx,rdx
jz @f

//get y movement
dec rdx
movss xmm15,[rcx+rdx*4]
shufps xmm15,xmm15,00 //broadcast

//apply speed
mov eax,(float)0.25
movd xmm14,eax
shufps xmm14,xmm14,00
mulps xmm15,xmm14

//apply vector
mov rax,[pCamInfo]
test rax,rax
jz @f
mulps xmm15,[rax+3a0]

//update new coord
addps xmm6,xmm15

//do x
//get x movement
inc rdx
movss xmm15,[rcx+rdx*4]
shufps xmm15,xmm15,00 //broadcast

//apply speed
mov eax,(float)0.18
movd xmm14,eax
shufps xmm14,xmm14,00
mulps xmm15,xmm14

//apply vector
mov rax,[pCamInfo]
test rax,rax
jz @f
mulps xmm15,[rax+380]

//update new coord
addps xmm6,xmm15

@@:
//do z
//get z direction
movss xmm15,[fZDirection]
shufps xmm15,xmm15,E1 //place z direction to 2nd element

//apply speed
mov eax,(float)0.14
movd xmm14,eax
shufps xmm14,xmm14,00
mulps xmm15,xmm14

//update new coord
addps xmm6,xmm15
movaps [rbx+170],xmm6

@@:
//end
//reset registers, xmms
pop rdx
pop rax
xorps xmm14,xmm14
xorps xmm15,xmm15

originalcode6:
movdqa [rbx+00000080],xmm6

exit6:
jmp returnhere6
/// FlyMode enable
arenaE6:
mov rcx,[BaseB]
mov rcx,[rcx+40]
mov [pPlayerCoordBase],rcx
jmp originalcode6

///
fZDirection:
dq 0
///

coordsUpdateAOB: //"DarkSoulsIII.exe"+9B7570:
jmp newmem6
nop
nop
nop
returnhere6:

///*************************************************///

label(bEndThread_DarkSoulsIII_keylistener_mem)
registersymbol(bEndThread_DarkSoulsIII_keylistener_mem)

alloc(DarkSoulsIII_keylistener_mem,2048,"DarkSoulsIII.exe")
registersymbol(DarkSoulsIII_keylistener_mem)
createthread(DarkSoulsIII_keylistener_mem)
label(keylistenerstart)
label(keylistenerend)
label(keylistenerexit)
label(fTempZDirection)

DarkSoulsIII_keylistener_mem:
sub rsp,28

keylistenerstart:

cmp byte ptr [bFlyMode],1
je @f
jmp keylistenerend

@@:
mov dword ptr [fTempZDirection],0

mov rcx,20 //SPACEBAR
push rcx
call GetAsyncKeyState
add rsp,08
shr ax,#15
cmp ax,1
jne @f
mov dword ptr [fTempZDirection],(float)0
jmp keylistenerend

@@:

mov rcx,02 //Right mouse button
push rcx
call GetAsyncKeyState
add rsp,08
shr ax,#15
cmp ax,1
jne @f
mov dword ptr [fTempZDirection],(float)0
jmp keylistenerend

keylistenerend:
mov ecx,[fTempZDirection]
mov [fZDirection],ecx
mov rcx,#100
call Sleep
cmp dword ptr [bEndThread_DarkSoulsIII_keylistener_mem],1
jne keylistenerstart

keylistenerexit:
add rsp,28
mov dword ptr [bEndThread_DarkSoulsIII_keylistener_mem],2
ret

///
bEndThread_DarkSoulsIII_keylistener_mem:
dd 0
fTempZDirection:
dd 0
///





[DISABLE]
//code from here till the end of the code will be used to disable the cheat
//obtained from SubBeam's ACS script - start//
{$lua}

if( syntaxcheck == false ) then --actual execution
  local starttime = getTickCount()

if readInteger( "bEndThread_DarkSoulsIII_keylistener_mem" ) == 0 then --could be 2 already
  writeInteger( "bEndThread_DarkSoulsIII_keylistener_mem", 1 ) --tell the thread to kill itself
end

while( getTickCount() < starttime + 1000 ) and ( readInteger( "bEndThread_DarkSoulsIII_keylistener_mem" ) ~=2 ) do --wait till it has finished
  sleep( 20 )
end

if( getTickCount() > starttime + 1000 ) then --could happen when the window is shown
  showMessage( 'Disabling the thread failed!' )
  error( 'Thread disabling failed!' )
end
  sleep( 1 )
end

{$asm}
//obtained from SubBeam's ACS script - end//

//bEndThread_DarkSoulsIII_keylistener_mem:
//dd 1

dealloc(newmem)
playerCoordBaseWriteAOB: //"DarkSoulsIII.exe"+40887F:
db 48 8B 48 18 8D 46 9C
//Alt: mov rcx,[rax+18]
//Alt: lea eax,[rsi-64]
unregistersymbol(playerCoordBaseWriteAOB)

unregistersymbol(pPlayerCoordBase)

///*************************************************///

dealloc(newmem3)
inAirTimerReadAOB: //"DarkSoulsIII.exe"+9B6A2A:
db F3 0F 11 81 B0 01 00 00
//Alt: movss [rcx+000001B0],xmm0
unregistersymbol(inAirTimerReadAOB)

///*************************************************///

dealloc(newmem4)
camHRotateConstWrite2AOB: //"DarkSoulsIII.exe"+510F9C:
db 66 0F 7F AE 40 01 00 00
//Alt: movdqa [rsi+00000140],xmm5
unregistersymbol(camHRotateConstWrite2AOB)

unregistersymbol(pCamInfo)

///*************************************************///

dealloc(newmem5)
someKeysConstReadAOB: //"DarkSoulsIII.exe"+1785CFD:
db F3 41 0F 11 0C 80
//Alt: movss [r8+rax*4],xmm1
unregistersymbol(someKeysConstReadAOB)

unregistersymbol(pMovementInfo)
unregistersymbol(iXOffset)

///*************************************************///

dealloc(newmem6)
coordsUpdateAOB: //"DarkSoulsIII.exe"+9B7570:
db 66 0F 7F B3 80 00 00 00
//Alt: movdqa [rbx+00000080],xmm6
unregistersymbol(coordsUpdateAOB)

unregistersymbol(fZDirection)

///*************************************************///

unregistersymbol(bEndThread_DarkSoulsIII_keylistener_mem)

dealloc(DarkSoulsIII_keylistener_mem)
unregistersymbol(DarkSoulsIII_keylistener_mem)