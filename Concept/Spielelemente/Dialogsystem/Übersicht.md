# Dialogsystem

## Anforderungen
1. Textdarstellung:
   - Dialoge werden in Textform angezeigt, ähnlich wie in klassischen Point-and-Click-Adventures.
   - Der Name des sprechenden Charakters wird zusammen mit dem Dialogtext angezeigt.
   - Optionale Porträts oder Illustrationen der Charaktere können neben dem Text angezeigt werden.

2. Auswahlmöglichkeiten für den Spieler:
   - Dem Spieler werden mehrere Antwortmöglichkeiten präsentiert, aus denen er auswählen kann.
   - Die Auswahlmöglichkeiten spiegeln unterschiedliche Tonalitäten, Emotionen oder Absichten wider.
   - Die Anzahl der Auswahlmöglichkeiten sollte überschaubar bleiben (2-4 Optionen).

3. Auswirkungen auf die Geschichte:
   - Die Wahl des Spielers beeinflusst den weiteren Verlauf des Dialogs und möglicherweise auch die Handlung des Spiels.
   - Unterschiedliche Antworten können unterschiedliche Reaktionen oder Einstellungen der NPCs auslösen.
   - Entscheidungen im Dialog können langfristige Konsequenzen haben, wie z.B. den Zugang zu bestimmten Questlinien, Belohnungen oder Endings.

4. Verzweigungen und Zusammenführungen:
   - Das Dialogsystem ermöglicht verzweigte Gesprächspfade basierend auf den Entscheidungen des Spielers.
   - Verschiedene Gesprächspfade können sich an bestimmten Punkten wieder zusammenführen.
   - Einige Entscheidungen können optionale Dialoge oder Nebenquests auslösen.

5. Visuelle Hinweise und Rückmeldungen:
   - Das Dialogsystem bietet visuelle Hinweise, um die Auswirkungen der Entscheidungen des Spielers anzuzeigen.
   - Rückmeldungen in Form von NPC-Reaktionen oder Erzählerkommentaren können die Bedeutung der getroffenen Entscheidungen unterstreichen.

6. Barrierefreiheit und Benutzerfreundlichkeit:
   - Das Dialogsystem ist intuitiv und benutzerfreundlich gestaltet, mit klaren Anweisungen und einfacher Navigation.
   - Optionen für Untertitel, Textgrößen und Kontrasteinstellungen werden bereitgestellt.
   - Der Spieler hat die Möglichkeit, Dialoge zu überspringen oder zu beschleunigen.

## Beispieldialog

Runa: Großmutter, geht es dir gut? Du hast während der Geschichte ein paar Dinge vergessen.

Großmutter: Oh, mach dir keine Sorgen, mein Schatz. Das passiert in meinem Alter manchmal.

Dialogoptionen:
1. Bist du sicher? Es schien schlimmer als sonst zu sein.
2. Okay, solange es dir gut geht, bin ich beruhigt.
3. Ich mache mir aber Sorgen. Vielleicht solltest du zum Arzt gehen?

Wenn Option 1 gewählt wird:
Runa: Bist du sicher? Es schien schlimmer als sonst zu sein.
Großmutter: (seufzt) Du hast Recht, Liebes. In letzter Zeit ist es häufiger vorgekommen. Aber lass uns jetzt nicht darüber nachdenken. Morgen ist ein neuer Tag.

Wenn Option 2 gewählt wird:
Runa: Okay, solange es dir gut geht, bin ich beruhigt.
Großmutter: Danke für dein Verständnis, Schatz. Lass uns noch ein wenig über die schönen Teile der Geschichte sprechen, bevor wir schlafen gehen.

Wenn Option 3 gewählt wird:
Runa: Ich mache mir aber Sorgen. Vielleicht solltest du zum Arzt gehen?
Großmutter: Mach dir keine Gedanken, Liebes. Ich werde bald einen Termin vereinbaren. Lass uns heute Abend einfach die Zeit miteinander genießen.
Runa erhält +1 Fürsorge.