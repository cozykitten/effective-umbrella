## Preparation

This will only cover the preparation and install of Windows, not possible steps such as backing up your previous installation, choosing and managing your drives.<br/>
It is assumed that you have already covered those and are ready to install windows and wiping your target drive doesn't pose any issue for you.

__source:__<br/>
https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions<br/>
https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/capture-and-apply-windows-system-and-recovery-partitions


### WinPE
1. Download and install both the Windows ADK and the Windows PE Add-on. When you install the ADK choose, at minimum, the Deployment Tools feature.<br/>
https://go.microsoft.com/fwlink/?linkid=2196127<br/>
https://go.microsoft.com/fwlink/?linkid=2196224

2. Create bootable Windows PE USB drive. (open a terminal and use those commands)
```cmd
diskpart
List disk
select disk X    (where X is your USB drive)
clean
create partition primary size=1024
active
format fs=FAT32 quick label="WinPE"
assign letter=P
create partition primary
format fs=FAT32 quick label="Images"
assign letter=I  
Exit
```
Start the Deployment and Imaging Tools Environment as an administrator. (just use windows search)
```cmd
copype amd64 C:\WinPE_amd64
Makewinpemedia /ufd C:\WinPE_amd64 P:
```


### Install script
download [dism_installer](https://raw.githubusercontent.com/cozykitten/effective-umbrella/main/dism_installer.bat) and save it on your USB's "Image" partition (probably drive letter I:).


### Folder structure
download [setupFiles.zip](https://cdn.discordapp.com/attachments/990019603780497448/1036781307818147890/setupFiles.zip) and extract all contents of the archive directly on the USB's 2. partition (I: drive), so that it looks something like this:

![](https://cdn.discordapp.com/attachments/1022177084396806154/1022185130309197854/unknown.png)

There are text files with more detailed step by step instructions inside each folder so read them first before running any files inside.<br/>
This will include some copy and pasting of commands and for that:

When marking commands to copy them stop immediately after the last character to avoid slipping into the next line.<br/>
Pasting a line break at the end of a command is equivalent to hitting enter to execute it immediately.

Try keeping all paths without whitespaces, such as the paths for the files on the USB (that's why they're named ``1_audit`` i.e.)<br/>
It also makes things easier if you choose a Username for Windows that doesn't contain whitespaces.

If there is no text file just run whatever is in the given folder normally (just double click).


### Latest runtime & C++ libraries
**VC_redist:**<br/>
https://docs.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist<br/>
first section: Visual Studio 2015, 2017, 2019, and 2022 <br/>
architecture: x86 and x64<br/>
save both: ``1_Audit\4_VC_Redist&dotNetRuntime\``

**dotNET runtimes:**<br/>
https://dotnet.microsoft.com/en-us/download<br/>
download .NET Runtime: run desktop apps<br/>
architecture: x86 and x64<br/>
save both: ``1_Audit\4_VC_Redist&dotNetRuntime\``


### Drivers
Download your AMD Chipset Drivers or Intel Chipset Software thing respectively:<br/>
https://www.amd.com/en/support<br/>
https://www.intel.com/content/www/us/en/download/19347/chipset-inf-utility.html<br/>
for AMD: Select ``Chipsets`` on the left and then your socket and chipset version.<br/>
``save: 2_Logon\2_Drivers_pt1\``

**Download NVCleanstall:**<br/>
https://www.techpowerup.com/download/techpowerup-nvcleanstall/<br/>
``save: somewhere on your computer, not the USB drive``<br/>
run it, click "next"<br/>
Additionally to the already selected "Display Driver" only select "PhysX"

It'll download the drivers from Nvidia now.<br/>
It'll only install the display driver, if you need Geforce Experience (if you use Shadow Play you need it) then update your drivers after you finish setting up windows.<br/>
This is just to get your display drivers running so setting up windows isn't a pain at 60hz.<br/>
Tho it has everything for playing and whatever you want, this is all you need if you don't use GFE / Shadow Play.

Once download finishes check the following checkboxes:<br/>
"disable installer telemetry and advertising" .. probably doesn't make a difference since you're not connected to the internet when you install them anyway.<br/>
"show expert tweaks"<br/>
"enable Message Signaled Interrupts" -> "All Processors in Machine" & "High"<br/>
"Disable HDCP"<br/>

"Next", then select "build package" and save it on your usb drive ``2_Logon\2_Drivers_pt1\``


### Sophia
Go to https://github.com/farag2/Sophia-Script-for-Windows/releases and at the bottom of most recent entry, expand the "Assets" section.<br/>
Download both ``Sophia.Script.for.Windows.11.vx.xx.x.zip`` and ``Sophia.Script.Wrapper.vx.x.x.zip ``<br/>
``save: somewhere on your computer, not the USB drive``

Open up both archives after extraction, they'll each contain one folder.<br/>
Extract each folder into ``2_Logon\3_Sophia\``, next to the 3 files already present.<br/>
If everything is right it should now look like this and inside both folders should be some subfolders and a file or two.<br/>
Move the presets (such as ``minimal.ps1``) inside the "Sophia Script" folder.

![](https://cdn.discordapp.com/attachments/1022177084396806154/1022196377482166272/unknown.png)


### OOSU10
https://www.oo-software.com/en/shutup10<br/>
Download and save to ``2_Logon\9_oosu10``

### notepad++
Go to https://notepad-plus-plus.org/downloads/ and download the zip option, unpack it ("extract to..." instead of "extract here" there are loose files inside).<br/>
You can rename it to something easier, notepad++ f.e. then just move it on your usb drive.


