

@echo off
title Batch RPG
:menu
cls
echo ----------
echo Batch RPG 1.0
echo ----------
echo.
echo 1) New Game
echo 2) Load
echo 3) Exit
echo.
set /p input=ENTER: 
if %input% == 1 goto new
if %input% == 2 goto load
if %input% == 3 exit

:new
cls
echo Magical Wizard: What is your name traveler?
set /p name=ENTER: 
echo Hello %name%, Press enter whenever your ready!
pause >nul
goto var

:var
set user=%name%
set xp=0
set cash=50
set weap=0
set armor=0
set pots=0
set weapdisplay=None
set armdisplay=None
set level=1
set defense=19
set attack=5
rem -- variables created
(
echo %user%
echo %xp%
echo %cash%
echo %weap%
echo %armor%
echo %pots%
echo %weapdisplay%
echo %armdisplay%
echo %level%
echo %defense%
echo %attack%
) > save.sav
rem -- saved variables
goto home

:lvlup
set /a level=%level% + 1
set /a cash=%cash% + 100
set /a attack=%attack% + 1
set /a xp=%xp% - 100
cls
echo You leveled up!
echo You are now level %level%!
echo.
echo +100$
echo DMG UP
pause >nul
goto home

:home
if %xp% GTR 99 goto lvlup
cls
echo ***************************************
echo.
echo Player: %user%        Cash: %cash%
echo Level: %level%           XP: %xp%/100
echo Armor: %armdisplay%        Weapon: %weapdisplay%
echo Potions: %pots%
echo Damage: %attack%           Defense: %defense%
echo.
echo ***************************************
echo.
echo 1) Fight
echo 2) Shop
echo 3) Save
echo 4) Exit
echo.
set /p homein=ENTER: 
if %homein% == 1 goto fight1
if %homein% == 2 goto shop
if %homein% == 3 goto save
if %homein% == 4 goto exit

:save
cls
(
echo %user%
echo %xp%
echo %cash%
echo %weap%
echo %armor%
echo %pots%
echo %weapdisplay%
echo %armdisplay%
echo %level%
echo %defense%
echo %attack%
) > save.sav
echo Saved!
pause >nul
goto home

:fight1
cls
set enhealth=75
set health=100
rem vars set
goto fight

:fight
if %enhealth% LSS 1 goto win
if %health% LSS 1 goto lose
cls
echo **********************
echo Batch RPG - Fight
echo **********************
echo.
echo Stats:
echo Your health: %health%
echo Weapon: %weapdisplay%
echo Armor: %armdisplay%
echo Potion's: %pots%
echo.
echo **********************
echo.
echo Enemy health: %enhealth%
echo.
echo What do you want to do next?
echo.
echo 1) Attack
echo 2) Drink a potion
echo 3) Flee
echo.
set /p atinput=ENTER: 
if %atinput%== 1 goto attack
if %atinput%== 2 goto potion
if %atinput% == 3 goto flee


:lose
if %health% LSS 0 set health=0
cls
echo You have been defeated!
echo.
echo Your health: %health%
echo Enemy health: %enhealth%
echo.
echo -30$
pause >nul
set /a cash=%cash% - 30
goto home

:potion
cls
echo What do you want to do with your potion?
echo Potion's: %pots%
echo.
echo 1) Drink it
echo 2) Back
echo.
set /p potin=ENTER: 
if %potin% == 2 goto fight
if %pots% LSS 1 goto nopots
if %potin% == 1 set /a pots=%pots% - 1
if %potin% == 1 goto potdrinked

:potdrinked
cls
echo You decide to drink the health potion!
echo +40 Health!
pause >nul
set health = %health% + 40
goto potion

:nopots
cls
echo You don't have any potion's to drink!
pause >nul
goto potion

:attack
cls
set /a num = %random:~-2%
if %num% GTR %attack% goto attack
if %num% LSS 0 goto attack
cls
echo You hit the enemy with your %weapdisplay%!
echo You took %num% health from the enemy!
set /a enhealth = %enhealth% - %num%
pause > nul
goto enemy

:enemy
cls
set /a num1 = %random:~-2% - 24
if %num1% GTR %defense% goto enemy
if %num1% LSS 0 goto enemy
cls
echo The enemy swings at you!
echo The enemy takes %num1% health from you!
pause >nul
set /a health = %health% - %num1%
goto fight

:win
if %enhealth% LSS 0 set enhealth=0
if %health% LSS 1 set health=1
cls
set /a xpw=%random:~-2%
set /a cashm=%random:~-2%
if %xpw% GTR 70 goto win
if %xpw% LSS 10 goto win
if %cashm% GTR %attack% goto win
if %cashm% LSS 10 goto win
cls
echo You win!
echo.
echo Your health: %health%
echo Enemy health: %enhealth%
echo.
echo +%cashm%$
echo +%xpw% XP!
echo.
pause >nul
set /a cash=%cash% + %cashm%
set /a xp=%xp% + %xpw%
goto home



:flee
cls
echo You decide to flee.
echo -40$
pause >nul
set /a cash=%cash% - 40
goto home



:shop
cls
echo *****************
echo Weapon Shop
echo Cash: %cash%
echo Level: %level%
echo.
echo 1) Dagger          $30     LVL: 1   DMG: 19
echo 2) Sword           $100    LVL: 3   DMG: 30
echo 3) Stronger Sword  $190    LVL: 8   DMG: 50
echo 4) Armor shop
echo 5) Back
echo.
set /p inp=ENTER: 
if %inp%==5 goto home
if %inp%==4 goto shop2
if %inp% == 1 (
if %weap%==1 (
cls
echo You already have this item!
pause >nul
goto shop
)
)
if %cash% LSS 30 goto nofunds
if %inp%==1 set /a cash= %cash% - 30
if %inp%==1 set weap=1
if %inp%==1 goto purchased
if %inp% == 2 (
if %weap%==2 (
cls
echo You already have this item!
pause >nul
goto shop
)
)
if %cash% LSS 70 goto nofunds
if %level% LSS 3 goto lowlevel
if %inp%==2 set /a cash= %cash% - 100
if %inp%==2 set weap=2
if %inp% == 2 goto purchased
if %inp% == 3 (
if %weap%==3 (
cls
echo You already have this item!
pause >nul
goto shop
)
)
if %cash% LSS 160 goto nofunds
if %level% LSS 8 goto lowlevel
if %inp%==3 set /a cash=%cash% - 190
if %inp%==3 set weap=3
if %inp% == 3 goto purchased

:alb
cls
echo You've already bought this item!
pause >nul
goto shop

:shop2
cls
echo *****************
echo Armor Shop
echo Cash: %cash%
echo Level: %level%
echo.
echo 1) Leather Armor    $70      LVL: 2   DEFENSE: 19
echo 2) Steel Armor      $100     LVL: 5   DEFENSE: 12
echo 3) Iron Armor       $210     LVL: 9   DEFENSE: 10
echo 4) Potion Shop
echo 5) Back
echo.
set /p arin=ENTER: 
if %arin%==5 goto home
if %arin%==4 goto shop3
if %arin% == 1 (
if %armor%==1 (
cls
echo You already have this item!
pause >nul
goto shop2
)
)
if %cash% LSS 70 goto nofunds
if %level% LSS 2 goto lowlevel
if %arin%==1 set /a cash= %cash% - 70
if %arin%==1 set armor=1
if %arin%==1 goto purchased1
if %arin% == 2 (
if %armor%==2 (
cls
echo You already have this item!
pause >nul
goto shop2
)
)
if %cash% LSS 100 goto nofunds
if %level% LSS 5 goto lowlevel
if %arin%==2 set /a cash = %cash% - 100
if %arin%==2 set armor=2
if %arin%==2 goto purchased1
if %arin% == 3 (
if %armor%==3 (
cls
echo You already have this item!
pause >nul
goto shop2
)
)
if %cash% LSS 210 goto nofunds
if %level% LSS 9 goto lowlevel
if %arin%==3 set /a cash = %cash% - 210
if %arin%==3 set armor=3
if %arin%==3 goto purchased1

:shop3
cls
echo *****************
echo Potion Shop
echo Cash: %cash%
echo Level: %level%
echo.
echo 1) Health Potion    $70
echo 2) Back
echo.
set /p poin=ENTER: 
if %poin% == 2 goto home
if %cash% LSS 70 goto nofunds
if %poin% == 1 set /a cash=%cash% - 70
if %poin% == 1 set /a pots= %pots% + 1
if %poin% == 1 goto purchased2

:purchased2
cls
echo You have bought a health potion!
echo You now have %pots% potions!
pause >nul
goto shop3


:purchased1
cls
if %armor% == 1 set armdisplay=Leather Armor
if %armor% == 2 set armdisplay=Steel Armor
if %armor% == 3 set armdisplay=Iron Armor
if %armor% == 1 set defense=15
if %armor% == 2 set defense=12
if %armor% == 3 set defense=10

echo You have purchased %armdisplay%!
pause >nul
goto shop2
:purchased
cls
if %weap% == 1 set weapdisplay=Dagger
if %weap% == 2 set weapdisplay=Sword
if %weap% == 3 set weapdisplay=Stronger Sword
if %weap% == 1 set attack=19
if %weap% == 2 set attack=30
if %weap% == 3 set attack=50

echo You have bought a %weapdisplay%!
pause >nul
goto shop

:nofunds
cls
echo You do not have enough cash to purchase this item.
pause >nul
goto shop

:lowlevel
cls
echo You are not high enough level to purchase this item.
pause >nul
goto shop

:load
if NOT EXIST save.sav (
cls
echo No save file found.
pause >nul
goto menu
)
cls
< save.sav (
set /p user=
set /p xp=
set /p cash=
set /p weap=
set /p armor=
set /p pots=
set /p weapdisplay=
set /p armdisplay=
set /p level=
set /p defense=
set /p attack=
)
echo Game Loaded!
pause >nul
goto home


:exit
cls
echo Are you certain you want to leave?
echo You may lose unsaved progress! Y/N
set /p in=ENTER: 
if %in% == Y exit
if %in% == y exit
if %in% == N goto home
if %in% == n goto home

