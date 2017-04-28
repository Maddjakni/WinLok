#Creating Orgabuzation units
New-ADOrganizationalUnit -Name "Reykjavik"
New-ADGroup -Name "Reykjavik" -Path "OU=Reykjavik, DC=Reykjavik-kaup, DC=is" -GroupScope Global 
New-ADOrganizationalUnit -Name "IT" -Path "OU=Reykjavik, DC=Reykjavik-kaup, DC=is"
New-ADGroup -Name "IT" -Path "OU=IT, OU=Reykjavik, DC=Reykjavik-kaup, DC=is" -GroupScope Global 
New-ADOrganizationalUnit -Name "Management" -Path "OU=Reykjavik, DC=Reykjavik-kaup, DC=is"
New-ADGroup -Name "Management" -Path "OU=Management, OU=Reykjavik, DC=Reykjavik-kaup, DC=is" -GroupScope Global 
New-ADOrganizationalUnit -Name "Engineering" -Path "OU=Reykjavik, DC=Reykjavik-kaup, DC=is"
New-ADGroup -Name "Engineering" -Path "OU=Engineering,  OU=Reykjavik, DC=Reykjavik-kaup, DC=is" -GroupScope Global
New-ADOrganizationalUnit -Name "Finance" -Path "OU=Reykjavik, DC=Reykjavik-kaup, DC=is"
New-ADGroup -Name "Finance" -Path "OU=Finance,  OU=Reykjavik, DC=Reykjavik-kaup, DC=is" -GroupScope Global 
New-ADOrganizationalUnit -Name "Manufacturing" -Path "OU=Reykjavik, DC=Reykjavik-kaup, DC=is"
New-ADGroup -Name "Manufacturing" -Path "OU=Manufacturing,  OU=Reykjavik, DC=Reykjavik-kaup, DC=is" -GroupScope Global 
#Importing users from csv
$Users = Import-Csv c:\users.csv

foreach ($User in $Users) 
{
    $ID = $User.ID
    $Title = $User.Starfsheiti
    $Town = $User.Sveitarfelag
    $PhoneNumber = $User.Heimasimi
    $WorkPhone = $User.Vinnusimi
    $Cellphone = $User.Farsimi
    $Displayname = $User.Nafn
    $UserFirstname = $User.Fornafn
    $UserLastname = $User.Eftirnafn
    $OU = "OU=" + $User.Deild + ", OU=Reykjavik, DC=Reykjavik-kaup, DC=is"
    $SAM = $User.Notendanafn
    $Password = "Pass.123"
    New-ADUser -EmployeeID "$ID" -City "$Town" -Title "$Title" -HomePhone "$PhoneNumber" -OfficePhone "$WorkPhone" -MobilePhone "$Cellphone" -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName $SAM -GivenName "$UserFirstname" -Surname "$UserLastname" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false -PasswordNeverExpires $true
}