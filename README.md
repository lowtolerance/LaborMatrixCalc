Labor Matrix Calc
=================

ABOUT
-----

Labor Matrix Calc is a small program built with AutoHotKey that is designed to make
calculated labor prices based off a labor matrix dead simple. No more lookups, just
configure your shop's labor rate, then launch it. Now, whenever you enter your labor
time for a job in Mitchell, just hit **ALT+SHIFT+L** to invoke Labor Matrix Calc, which
will then automatically fill in the proper labor price.

INSTALLATION
------------

Open the file `config.ini` using Notepad.exe (or your plaintext editor of choice), and
update the "LaborRate=" value to your shop's labor rate. You'll probably want to leave the
"Factor" value alone unless you know what you're doing. Once done editing, save the file. 

You can now launch Labor Matrix Calc by opening the file `labor_matrix_calc.exe`. 

It's recommended that you have this program launch automatically at startup, however. To do this, simply
copy the file `labor_matrix_calc.exe`. This is usually located at:

    C:\Users\<your user name>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\

The first time you run the file, it will unpack a default `config.ini` file and `active.png`.

USAGE
-----

Immediately after entering "Charged Hrs" in Mitchell, press the following keys: **ALT+SHIFT+L**. 
Labor Matrix Calc will then automatically enter the appropriate total dollar amount for the labor.

CUSTOMIZING
-----------

Also included in this archive is the file `labor_matrix_calc.ahk`. This is the AutoHotKey script used
to generate the executable. It is possible to edit this script to your liking, but you would need a
standalone installation of AutoHotKey (available at http://autohotkey.com) to make use of the edited
script.

***EXPERIMENTAL***
------------------

Labor Matrix Calc includes an *experimental* "auto" mode. You can turn it on and off by pressing **ALT+SHIFT+A**.
When auto mode is enabled, you don't have to invoke Labor Matrix Calc with the **ALT+SHIFT+L** key combination every
time, Labor Matrix Calc just updates the price accordingly.

You can also configure auto mode to always be on by editing the `config.ini`. To do this, change 'Disabled' field 
under the [AutoCalc] section to read `Disabled=0` (without the quotes).
