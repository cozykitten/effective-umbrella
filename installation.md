## Installation

### Overview
Be sure to be offline for all following steps, disabling your wifi card and unplugging your ethernet cable would be the easiest way.

First were going to boot WinPE and run the install script.
It'll go super fast and install windows in like a minute, thanks to skipping the unnecessary stuff.

When windows starts we skip the welcome screen and first run a script in a sort of "outside the system mode".
Then actually go through the windows first start procedure.

Once in Windows we can install drivers and basic components set some privacy stuff and then finally go online run Windows update and install our apps.
and of course windows will want to reboot a few times after its driver installations and updates.


### Warning
If you are unsure about the layout of your drives you should take a look in disk management now, check which drive you want to wipe and use for windows, what partitions are on there, if you have any other volumes besides C: on this drive, etc.

Generally I'd recommend to install Windows on a entirely separate / new drive or one that is completely empty so you still have your current Windows drive and can access it from the new installation and copy files and settings.<br/>
For the next steps it is assumed that you have completed all necessary preparations, such as backed up your data, settings, logins, etc.<br/>
This applies to the entire drive you're going to install Windows on, other drives are't affected, however all partition on that drive are, so f.e. if you have a C: and D: partition both on your Windows drive, they would both be affected.

### Getting Started
1. Booting WinPE
    1. Shut down your pc and disconnect from the internet. Your usb drive should still be connected.
    2. Turn on your computer again and hold down ``F8`` until it shows a window asking you to select a boot device.
    3. You should see your usb there, actually two times. Select it's partition 1.
    4. After booting WinPE you'll see a terminal window that's pointing to ``X:\Windows\System32``
    5. Change the directory to I:\ with ``pushd I:``
    6. Type ``dism`` then use tab for autocompletion until it shows ``dism_installer.bat``
    7. Hit enter, this will run the install script.

2. Applying the image
    1. The script will ask you to select a drive to install windows on. It will show you the drives in your pc but their size is pretty much the only indicator you have to find your Windows drive.<br/>
    If you are unsure about which drive is the one you want to install windows on, now you can still go back and boot normally instead of selecting your usb drive.

    3. after selecting the drive it will also show you the partitions on it. If your target drive is your old windows drive, there should be at minimum
        - one **100mb** partition labled **"System"**
        - one **16 or 128mb** partition labled **"Reserved"**
        - one partition as big as the rest of your drive labled **"Primary"**<br/><br/>

        1. there might also be a ~500mb Recovery partition
        2. however there **should not** be any further primary partitions, that would indicate that there is more than one Volume on this drive (the C: or D: ...etc drive you see in File Explorer), in that case hit ``ctrl + c`` to cancel and don't continue.

    6. After confirming that this is indeed the drive you want to wipe and install windows on, the script will do its thing, it'll take about 1 minute.
    7. It will reboot. If you didn't choose your old windows drive for windows 11 you need to hold down F8 again and select your new Windows drive from the list, only for this first boot though.

3. Windows OOBE and Audit
    1. After the first reboot out of WinPE it might reboot another 1-2 times, you don't need to press anything tho, after that you will see the first start windows thing (Out Of the Box Experience), but ignore that for now.
    2. Press ``ctrl + shift + F3``
    3. It'll reboot and throw you into windows as a sort of "Out of system" mode (Audit mode) 
    4. Leave the "Sysprep" window sitting on your desktop as is and open File Explorer to your usb drive
    5. From here on its just going through the folders on the usb drive in order, starting with the readme file in ``1_Audit\1_Decrapifier_pt1``

4. In Windows (**2_Logon** Folder)
    1. After rebooting from Audit mode you're back in OOBE, click through it until it asks you to create your user account.
    2. When it shows no connection and only a "retry" button, click that (~5 times) until it offers you to create a local account instead of a microsoft account.
    3. Then you might see a black screen for a while, that's just Windows setting up your user account, it'll take ~3 mins
    4. Now you're actually in Windows, open File Explorer to Folder 2 (2_Logon) and start with those in order.

- Notepad++
    - You can move the notepad++ folder somewhere on your computer, your desktop f.e. to make it more accessible later.
    - When you need to read / check some .bat or .ps1 script files, open notepad++.exe from that folder and drag the files in the editor, it makes them a lot more readable.
