@echo off
:par
echo list disk > CreatePartitions.txt
cls
echo CreatePartitions-UEFI
diskpart /s CreatePartitions.txt
echo.
echo Please enter the number of the disk to wipe and use for windows
set /p DISK=disk number: 
if "%DISK%"=="" goto :eof

echo select disk %DISK% > CreatePartitions.txt
echo list disk >> CreatePartitions.txt
echo list partition >> CreatePartitions.txt
diskpart /s CreatePartitions.txt
echo.

echo The selected disk will get wiped, are you sure you selected the right one?
set /p CONF=Please confirm your selection (y/n): 
if not "%CONF%"=="y" goto :par
echo.

echo select disk %DISK% > CreatePartitions.txt
echo clean >> CreatePartitions.txt
echo convert gpt >> CreatePartitions.txt

echo create partition efi size=100 >> CreatePartitions.txt
echo format quick fs=fat32 label="System" >> CreatePartitions.txt
echo assign letter="S" >> CreatePartitions.txt

echo create partition msr size=16 >> CreatePartitions.txt

echo create partition primary >> CreatePartitions.txt
echo format quick fs=ntfs label="Windows" >> CreatePartitions.txt
echo assign letter="W" >> CreatePartitions.txt
echo list volume >> CreatePartitions.txt
echo exit >> CreatePartitions.txt

diskpart /s CreatePartitions.txt

echo Searching for Images
for %%a in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do @if exist %%a:\Images\ set IMAGESDRIVE=%%a
echo The Images folder is on drive: %IMAGESDRIVE%
echo.

echo Checking Image Index
Dism /Get-ImageInfo /imagefile:%IMAGESDRIVE%:\Images\install.wim
echo.

set /p INDEX=Please enter the Index number of the desired edition: 
echo The Index number set is %INDEX%
echo.

echo Applying Image to Windows partition
dism /Apply-Image /ImageFile:%IMAGESDRIVE%:\Images\install.wim /Index:%INDEX% /ApplyDir:W:\
echo.

echo Copying boot files to System partition
W:\Windows\System32\bcdboot W:\Windows /s S:
echo.

del CreatePartitions.txt
echo Installation complete. Continue to reboot.

:eof
exit