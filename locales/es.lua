local Translations = {
    error = {
        proccess_cancelled = 'Barra de progreso cancelada',
        cheatingDetectedDrop = '¡Trampa detectada, has sido expulsado del robo a la tienda!',
        cheatingDetectedPrint = 'Trampa detectada en el robo a la tienda, ¡jugador expulsado!',
        invalidRegister = 'Índice de caja registradora inválido.',
        invalidSafe = 'Índice de caja fuerte inválido.',
        alreadyRobbed = 'Esta caja registradora ya ha sido robada.',
        safeRobbed = 'Esta caja fuerte ya ha sido robada.',
        wrongCode = 'La combinación que ingresaste es incorrecta.',
        thermiteCooldown = '¡La termita aún no ha atravesado!',
        notThermited = 'qb-storerobbery:server:thermiteSafe activado pero no había caja fuerte con ese índice. Jugador: ',
    },
    rob = {
        register = 'Robando la caja registradora...',
        plantThermite = 'Colocando termita en la caja fuerte...',
        thermitePlant = 'Abriendo la caja fuerte...'
    },
    police = {
        police_alert = '¡Robo en tienda en progreso!',
        shopRobbery = 'Robo en tienda',
    },
    inputSafe = {
        header = 'Combinación de la caja fuerte',
        submit = 'Enviar',
    },
    targets = {
        robRegister = 'Robar caja registradora',
        robRegisterIcon = 'fas fa-hand-holding-usd',
        robRegisterDT = '[F] Robar caja registradora',
        robSafe = 'Abrir caja fuerte',
        robSafeIcon = 'fas fa-dungeon',
        thermiteSafe = 'Termita en caja fuerte',
        thermiteSafeIcon = 'fas fa-fire',
        collectFromSafe = 'Recoger de la caja fuerte',
        collectFromSafeIcon = 'fas fa-box-open',
        robSafeDT = '[F] Abrir caja fuerte',
        thermiteSafeDT = '| [G] Termita en caja fuerte',
        collectFromSafeDT = '[F] Recoger de la caja fuerte',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
