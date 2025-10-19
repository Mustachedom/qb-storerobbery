local Translations = {
    error = {
        proccess_cancelled = 'Barra de progresso cancelada',
        cheatingDetectedDrop = 'Trapaça detectada, você foi expulso do roubo à loja!',
        cheatingDetectedPrint = 'Trapaça detectada no roubo à loja, jogador expulso!',
        invalidRegister = 'Índice de caixa registradora inválido.',
        invalidSafe = 'Índice de cofre inválido.',
        alreadyRobbed = 'Esta caixa registradora já foi roubada.',
        safeRobbed = 'Este cofre já foi roubado.',
        wrongCode = 'A combinação inserida está incorreta.',
        thermiteCooldown = 'A termita ainda não atravessou!',
        notThermited = 'qb-storerobbery:server:thermiteSafe acionado, mas nenhum cofre encontrado com esse índice. Jogador: ',
    },
    rob = {
        register = 'Roubando a caixa registradora...',
        plantThermite = 'Colocando termita no cofre...',
        thermitePlant = 'Abrindo o cofre...'
    },
    police = {
        police_alert = 'Roubo a loja em andamento!',
        shopRobbery = 'Roubo a loja',
    },
    inputSafe = {
        header = 'Combinação do cofre',
        submit = 'Enviar',
    },
    targets = {
        robRegister = 'Roubar caixa registradora',
        robRegisterIcon = 'fas fa-hand-holding-usd',
        robRegisterDT = '[F] Roubar caixa registradora',
        robSafe = 'Destravar cofre',
        robSafeIcon = 'fas fa-dungeon',
        thermiteSafe = 'Usar termita no cofre',
        thermiteSafeIcon = 'fas fa-fire',
        collectFromSafe = 'Coletar do cofre',
        collectFromSafeIcon = 'fas fa-box-open',
        robSafeDT = '[F] Destravar cofre',
        thermiteSafeDT = '| [G] Usar termita no cofre',
        collectFromSafeDT = '[F] Coletar do cofre',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
