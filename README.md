<style type="text/css">
    ol { list-style-type: upper-alpha; }
    ol ol { list-style-type: lower-alpha; }
</style>

1. Booting WinPE
    1. Shut down your pc and disconnect from the internet. Your usb drive should still be connected.
    2. Turn on your computer again and hold down ``F8`` until it shows a window asking you to select a boot device.

    1. You should see your usb there, actually two times. Select it's partition 1.
    2. After booting WinPE you'll see a terminal window that's pointing to ``X:\Windows\System32``
    3. change the directory to I:\ with ``pushd I:``
    4. type ``dism`` then use tab for autocompletion until it shows ``dism_installer.bat``
    5. hit enter, this will run the install script

2. Applying the image
    1. The script will ask you to select a drive to install windows on. It will show you the drives in your pc but their size is pretty much the only indicator you have to find your Windows drive.<br/>
    If you are unsure about which drive is the one you want to install windows on, now you can still go back and boot normally instead of selecting your usb drive

    3. after selecting the drive it will also show you the partitions on it. If your target drive is your old windows drive, there should be at minimum
        - one **100mb** partition labled **"System"**
        - one **16 or 128mb** partition labled **"Reserved"**
        - one partition as big as the rest of your drive labled **"Primary"**<br/><br/>
        1. there might also be a ~500mb Recovery partition
        2. however there **should not** be any further primary partitions, that would indicate that there is more than one Volume on this drive (the C: or D: ...etc drive you see in File Explorer), in that case hit ``ctrl + c`` to cancel and don't continue.
        
    6. after confirming that this is indeed the drive you want to wipe and install windows on the script will do its thing, it'll take about 1 minute
    7. It will reboot, if you didn't choose your old windows drive for windows 11 you need to hold down F8 F8 again, only for this first boot though.

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


## Get Windows

### Overview
The part of getting your Windows Image ready consists of two things.

1. The downloader for windows, which offers a lot of options, the most important one being that you can choose the apps *you* want.<br/>
A general recommended app list is included in the files provided here.

2. The "toolkit" which is a utility to remove or add components to a windows image.<br/>
A list of recommended components to remove is included as well, it's still a good idea to read that list instead of just typing it down blindly to be safe for potential changes in newer versions of the toolkit.

Those two steps will result in a cleaner and smaller image which can then be installed in the next step.


### Getting started
1. Create a new folder on your C drive:  ``C:\windows_prep``
    - create 2 folders inside, ``windows_prep\toolkit`` and ``windows_prep\win11``

2. Go to https://uupdump.net/
    - select Windows 11 - 22H2
    - click the topmost "Windows 11, version 22H2" which has x64 as architecture
    - select the language you want -> next
    - only check windows home -> next 
    - keep the middle radio button selected (download and convert to ISO)
    - uncheck all checkboxes below, including "single language" -> create download package
    - save it somewhere and extract all contents into the ``windows_prep\win11`` folder

3. Go to https://msmgtoolkit.in/downloads.html
    - click the "download toolkit" button and on the download.ru site only select the Toolkit_vx.x.x.7z and download that.
    - extract the contents into the ``windows_prep\toolkit`` folder
4. Now let's download windows
  - move the "depends_win.ps1" from inside the ``win11\files`` folder into the ``win11`` folder, then right click and "run with powershell"
  - go in the ``win11\files`` folder, open  the "uup-converter-wimlib.7z" archive and extract all contents in the ``win11`` folder
  - download [win11.zip](https://github.com/cozykitten/effective-umbrella/raw/main/win11.zip) and extract the files in the ``win11`` folder as well, let them overwrite existing files
  - right click -> edit "uup_download_windows.cmd", hit ``ctrl + f`` and search for "Extracting UUP converter" ".\files\depends_win.ps1"
  - delete the group of 2 lines containing the searched term
  - a few lines below should be a group starting with "echo Extracting UUP converter..."
  - delete the group of three lines starting with "echo Extracting UUP converter...", ending with "echo.", then close and save
  - run ``uup_download_windows.cmd`` as administrator




