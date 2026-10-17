-- Project True Life - Careers and Roles System

function PTL_RegisterProfessions()
    -- Clear vanilla professions if possible (complex in PZ, usually requires overriding UI, but we add ours)

    local civil = ProfessionFactory.addProfession("civilengineer", "Ingenieur civil / Batisseur", "ui_prof_civil", -2)
    civil:setDescription("Le seul capable de reparer les infrastructures lourdes, de relancer les generateurs de ville ou de fabriquer des materiaux de construction avances.")
    civil:addFreeTrait("Handy")
    civil:addXPBoost(Perks.Woodwork, 2, 0)

    local eco = ProfessionFactory.addProfession("ecologist", "Agriculteur / Ecologiste", "ui_prof_eco", -2)
    eco:setDescription("Specialiste de la depollution des sols, de l'irrigation complexe et de la culture de masse pour nourrir le serveur.")
    eco:addFreeTrait("Gardener")
    eco:addXPBoost(Perks.Farming, 2, 0)

    local medic = ProfessionFactory.addProfession("fieldmedic", "Medecin de terrain", "ui_prof_medic", -2)
    medic:setDescription("Gere les maladies post-apocalyptiques, les infections liees a la salete, la malnutrition et les accidents de chantier.")
    medic:addFreeTrait("FirstAid")
    medic:addXPBoost(Perks.Doctor, 3, 0)

    local mayor = ProfessionFactory.addProfession("mayor", "Maire / Coordinateur", "ui_prof_mayor", -2)
    mayor:setDescription("Peut creer des contrats, etablir des zones securisees (claims), gerer une monnaie locale pour le serveur et attribuer des parcelles de terrain.")
    mayor:addFreeTrait("Organized")
end

Events.OnGameBoot.Add(PTL_RegisterProfessions)
