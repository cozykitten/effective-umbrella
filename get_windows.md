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
    - only check windows home (or pro or whatever your license is for) -> next 
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
    - rename the AppList you prefer to "CustomAppsList.txt", and tweak it to your liking or just use it as it is.
    - right click -> edit "uup_download_windows.cmd", hit ``ctrl + f`` and search for "Extracting UUP converter" ".\files\depends_win.ps1"
    - delete the group of 2 lines containing the searched term
    - a few lines below should be a group starting with "echo Extracting UUP converter..."
    - delete the group of three lines starting with "echo Extracting UUP converter...", ending with "echo.", then close and save
    - run ``uup_download_windows.cmd`` as administrator

5. When that is done you'll have a new folder with a long name in your ``win11`` folder
    - inside that folder is a "sources" folder and inside that you'll find the ``install.wim`` file, you can just sort for size, it's the biggest one, that's windows
    - in a new explorer window, go to ``toolkit\DVD\sources`` and put the ``install.wim`` from the other window in there.
    - also look for a ``boot.wim`` file and put it in the toolkit's sources folder as well
    - then in the first sources folder (the one in ``win11``), there should be a folder called "sxs"
    - move the entire "sxs" folder inside the toolkit's sources folder as well, it should contain one or two files with "netfx3" in their names, delete any other files if there are any

**extra: if the last step worked skip this**<br/>
in case the sxs folder doesn't exist or is empty, run the ``convert-UUP.cmd`` again and pay attention to its window.<br/>
it will say something like "creating setup files"<br/>
and once that is complete it will say "creating install.wim" or "creating install image" or something<br/>
as soon as you see that hit ``ctrl + c`` like the shortcut to copy, in this case it's the key to cancel command line programs<br/>
close the window and now the sxs folder should be there and contain the netfx files<br/>

6. Toolkit time. ``toolkit\DVD\sources`` folder should contain install.wim, boot.wim, sxs folder with one or two something_netfx3_something files inside
    - in ``toolkit`` folder start the ``start.cmd`` file, it'll give you an admin prompt
    - type [a], then when on the main menu select [1] - [1]
    - Index should only be 1, then choose no for boot and winre
    - the [msmg-toolkit textfile](https://github.com/cozykitten/effective-umbrella/blob/main/msmg-toolkit.txt) contains a list of components that can be removed

    after selecting all elements, go back one -> [2] start removing windows components
    - this will take ~3 minutes. It's important to wait until it finished removing components before continuing
    - go to ``toolkit\Mount\Install``. Now you should see a folder "1". Don't open it.
    - copy the path in the explorer address bar (smth like ``C:\toolkit\Mount\Install``)
    - open a terminal as admin, then change the directory with ``pushd`` then right click to paste the path
    - It's important to wait until the toolkit finished removing the components before continuing
    - once the toolkit is done, paste (by right clicking) the following commands into the newly opened terminal, in this case it is fine to copy line breaks and you'll see what it does
        ```cmd
        dism /image:.\1 /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2
        dism /image:.\1 /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2Root
        dism /image:.\1 /Disable-Feature /FeatureName:Printing-PrintToPDFServices-Features
        echo.
        ```
    - now go back to the toolkit's window, return to it's main menu, from there choose [5] Apply -> [1] Cleanup
    - when done, from main menu choose [2] Integrate -> [3] Windows Features -> [A] .NET Framework 3.5
    - and finally [5] Apply -> [2] Apply and choose "yes" when it asks you to clean up, we're done with this so take a break if you want, it'll cleanup for about 5 minutes
    - choose the quit option from the main menu

7. Go back to the toolkit's folder and from the DVD\sources folder take the install.wim and move it into your usb's Images folder. ( ``I:\Images\install.wim``)

8. When you're done with everything, saved everything you need to safe and can say good bye to your current windows, then you can continue with the next steps.
Now might also be a good time in case you want to update your SSD's firmware, it should work just fine, they just be like "be sure you don't lose power and that you backed up your data, etc in case something goes wrong"
Since your current windows drive is about to get wiped anyway now would be the best time.
