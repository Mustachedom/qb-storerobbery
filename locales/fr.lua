local Translations = {
    error = {
        proccess_cancelled = 'Barre de progression annulée',
        cheatingDetectedDrop = 'Triche détectée, vous avez été expulsé du braquage de magasin !',
        cheatingDetectedPrint = 'Triche détectée lors du braquage de magasin, joueur expulsé !',
        invalidRegister = 'Index de caisse invalide.',
        invalidSafe = 'Index de coffre invalide.',
        alreadyRobbed = 'Cette caisse a déjà été braquée.',
        safeRobbed = 'Ce coffre a déjà été braqué.',
        wrongCode = 'La combinaison saisie est incorrecte.',
        thermiteCooldown = 'La thermite n’a pas encore percé !',
        notThermited = 'qb-storerobbery:server:thermiteSafe déclenché mais aucun coffre trouvé avec cet index. Joueur : ',
    },
    rob = {
        register = 'Braquage de la caisse...',
        plantThermite = 'Pose de la thermite sur le coffre...',
        thermitePlant = 'Ouverture du coffre...'
    },
    police = {
        police_alert = 'Braquage de magasin en cours !',
        shopRobbery = 'Braquage de magasin',
    },
    inputSafe = {
        header = 'Combinaison du coffre',
        submit = 'Soumettre',
    },
    targets = {
        robRegister = 'Braquer la caisse',
        robRegisterIcon = 'fas fa-hand-holding-usd',
        robRegisterDT = '[F] Braquer la caisse',
        robSafe = 'Déverrouiller le coffre',
        robSafeIcon = 'fas fa-dungeon',
        thermiteSafe = 'Thermite sur le coffre',
        thermiteSafeIcon = 'fas fa-fire',
        collectFromSafe = 'Récupérer du coffre',
        collectFromSafeIcon = 'fas fa-box-open',
        robSafeDT = '[F] Déverrouiller le coffre',
        thermiteSafeDT = '| [G] Thermite sur le coffre',
        collectFromSafeDT = '[F] Récupérer du coffre',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
