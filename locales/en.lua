local Translations = {
    error = {
        proccess_cancelled = 'Progressbar Cancelled',
        cheatingDetectedDrop = 'Cheating Detected, You Have Been Dropped By Store Robbery!',
        cheatingDetectedPrint = 'Cheating Detected In Store Robbery, Player Dropped!',
        invalidRegister = 'Invalid register index provided.',
        invalidSafe = 'Invalid safe index provided.',
        alreadyRobbed = 'This register has already been robbed.',
        safeRobbed = 'This safe has already been robbed.',
        wrongCode = 'The combination you entered is incorrect.',
        thermiteCooldown = 'The Thermited Hasnt Broken Through yet!',
        notThermited = 'qb-storerobbery:server:thermiteSafe Triggered But No Safe By That Index was there. Player: ',
        notEnoughPolice = 'Not Enough Police Present! You Need ',
    },
    rob = {
        register = 'Robbing The Register...',
        plantThermite = 'Planting Thermite on the Safe...',
        thermitePlant = 'Opening Up The Safe...'
    },
    police = {
        police_alert = 'Store Robbery In Progress!',
        shopRobbery = 'Store Robbery',
    },
    inputSafe = {
        header = 'Safe Combination',
        submit = 'Submit',
    },
    targets = {
        robRegister = 'Rob Register',
        robRegisterIcon = 'fas fa-hand-holding-usd',
        robRegisterDT = '[F] Rob Register',
        robSafe = 'Unlock Safe',
        robSafeIcon = 'fas fa-dungeon',
        thermiteSafe = 'Thermite Safe',
        thermiteSafeIcon = 'fas fa-fire',
        collectFromSafe = 'Collect from Safe',
        collectFromSafeIcon = 'fas fa-box-open',
        robSafeDT = '[F] Unlock Safe',
        thermiteSafeDT = '| [G] Thermite Safe',
        collectFromSafeDT = '[F] Collect from Safe',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
