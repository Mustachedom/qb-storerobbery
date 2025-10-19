local Translations = {
    error = {
        proccess_cancelled = 'Voortgangsbalk geannuleerd',
        cheatingDetectedDrop = 'Valsspelen gedetecteerd, je bent verwijderd vanwege een winkeloverval!',
        cheatingDetectedPrint = 'Valsspelen gedetecteerd bij winkeloverval, speler verwijderd!',
        invalidRegister = 'Ongeldige kassa-index opgegeven.',
        invalidSafe = 'Ongeldige kluis-index opgegeven.',
        alreadyRobbed = 'Deze kassa is al beroofd.',
        safeRobbed = 'Deze kluis is al beroofd.',
        wrongCode = 'De ingevoerde combinatie is onjuist.',
        thermiteCooldown = 'De thermiet is nog niet doorgebrand!',
        notThermited = 'qb-storerobbery:server:thermiteSafe geactiveerd maar geen kluis met dat index gevonden. Speler: ',
    },
    rob = {
        register = 'Kassa aan het beroven...',
        plantThermite = 'Thermiet op de kluis aanbrengen...',
        thermitePlant = 'Kluis aan het openen...'
    },
    police = {
        police_alert = 'Winkeloverval gaande!',
        shopRobbery = 'Winkeloverval',
    },
    inputSafe = {
        header = 'Kluiscombinatie',
        submit = 'Bevestigen',
    },
    targets = {
        robRegister = 'Kassa beroven',
        robRegisterIcon = 'fas fa-hand-holding-usd',
        robRegisterDT = '[F] Kassa beroven',
        robSafe = 'Kluis openen',
        robSafeIcon = 'fas fa-dungeon',
        thermiteSafe = 'Thermiet op kluis',
        thermiteSafeIcon = 'fas fa-fire',
        collectFromSafe = 'Verzamel uit kluis',
        collectFromSafeIcon = 'fas fa-box-open',
        robSafeDT = '[F] Kluis openen',
        thermiteSafeDT = '| [G] Thermiet op kluis',
        collectFromSafeDT = '[F] Verzamel uit kluis',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
