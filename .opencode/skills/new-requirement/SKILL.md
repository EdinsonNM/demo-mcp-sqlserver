---
name: new-requirement
description: Inicializa un nuevo requerimiento — actualiza main y crea una rama feature en cada repo involucrado.
disable-model-invocation: true
---

Inicializa un nuevo requerimiento en los repos que trabajarán en él.

El skill solo hace trabajo de git. No crea archivos en `.scratch/`, ni PRDs, ni tickets — eso es tarea de otros skills.

## Pasos

1. **Recolecta la descripción y deriva el slug.**
   - Pide al usuario una `descripción` — una línea describiendo el requerimiento.
   - Propón tres candidatos de slug derivados de la descripción en kebab-case. Cada uno debe tener ≤ 50 caracteres y coincidir con `^[a-z0-9][a-z0-9-]*[a-z0-9]$`.
   - Deja que el usuario elija uno o escriba el suyo. Si escribe el suyo, valídalo contra la misma regex y longitud; si falla, pide de nuevo.

   *Hecho cuando* tengas la descripción y un slug válido.

2. **Descubre los repos y deja que el usuario elija.**
   - Escanea `apps/*` y trata cada subdirectorio como un repo candidato.
   - Añade el repo raíz del workspace como candidato extra, etiquetado como tal.
   - Presenta los candidatos como una checklist de selección múltiple.

   *Hecho cuando* el usuario haya confirmado un subconjunto no vacío.

3. **Para cada repo seleccionado, en orden, ejecuta tres comandos.** Usa `bash` con `cwd` apuntando al directorio del repo. Detente al primer fallo.

   ```bash
   git checkout main            # fail-fast si la rama no existe
   git pull --ff-only           # fail-fast si el working tree está sucio o la historia diverge
   git checkout -b feat/<slug>  # fail-fast si la rama ya existe
   ```

   En caso de fallo, imprime qué repo falló, qué comando falló y el error. No ejecutes el siguiente repo.

   *Hecho cuando* cada repo seleccionado esté en una `feat/<slug>` recién creada, ramificada desde un `main` actualizado.

4. **Imprime el cierre.**
   - Slug y descripción.
   - Repos donde se creó `feat/<slug>`.
   - Recordatorio: _Próximo paso: corre `/grilling` (o `/grill-me`) sobre este requerimiento para afinar el alcance antes de implementar._

   *Hecho cuando* el resumen esté impreso.