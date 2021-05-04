# README

### Ruby und Rails Installation
Für die Installation kann folgender Guide genutzt werden.
https://gorails.com/setup/osx/10.15-catalina
Dort kann das Betriebssystem ausgewählt werden und anschließend Ruby und Rails installiert werden. Des Weitern muss Postgres Sql auf dem Gerät installiert werden.

##### Ruby Version
ruby 2.6.4p104

##### Rails Version
rails 6.0.3.6

### Datenbank erstellen
`$ rails db:create db:migrate db:seed` oder `rails db:create db:setup` Durch das seeden wird ein Admin Account erstellt, damit die Seite genutzt werden kann

####Admin Daten:
admin@klimabox.com
admin1234

### Starten
Vor dem ersten Starten Bundlen `$ bundle install` und `$ yarn install` aufführen.
Zum starten des Servers `$ rails s` ausführen.

### Rails Console
Zum starten der Console `$ rails c` ausführen.

### Webpack-dev-server
Zum starten des Webpack-dev-servers `$ bin/webpack-dev-server`

### Debugging
Zum debuggen in dem Code vor der Zeile die gedebuggt werden soll  `debugger` schreiben. In der nächsten Zeile hilft es wenn man noch einen Command schreibt `puts("foo")`
einfach eine Ausgabe, weil der debugger häufig eine Zeile zu weit springt. Also
```
  debugger
  puts("foo")
  # Zeile die gedebuggt werden soll
```

Im Server Output springt man dann in den debugger

### Mails
Die Mails werden im  Development Modus über letter_opener_web versendet. https://github.com/fgrehm/letter_opener_web. Die versendeten Mails findet man unter
localhost:3000/letter_opener

### Git Regeln
Neuer Branch von Main abzweigen. Name des Branches: `feature/$name`. Pull/Merge Request stellen und dann wieder in Main mergen.



