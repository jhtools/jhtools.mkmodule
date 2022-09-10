# jhtools.mkmodule

Create a powershell script module. The idea for the module was taken from here: https://github.com/AtlassianPS/JiraPS

## Usage

Go to the directory where you want to create the module and then call the script mkmodule.ps1.

The script will create two files, a psm1 and a psd1 file for the module. It will also create the directories `Public` and `Private`

Place all your public functions in the Public directory. The file must be named like the function, i.e. the (public) function `Get-Dummy` must be placed in a file named `Get-Dummy.ps1`.

## Arguments

`-Destination`

The location of the new module. Defaults to the current directory.

`-Module <name>`

The name of the new module. Defaults to the name of the destination directory.

`-CompanyName <name>`

The name of the company. Defaults to "Company Name"

`-Author <name>`

The name of the Author. Defaults to the company name

