# Bioinfy 1.0
# Copyright: Giovanni Marco Dall'Olio 2006
# Licenza: Gnu General Purpose License (GPL)
# Puoi trovare una copia della GPL nel file 'COPYING'
# La licenza si applica a tutti i contenuti del file tar.gz/zip che avete scaricato (codice, set di risposte, etc) e siete incoraggiati a utilizzare, studiare, modificare e distribuire gli stessi gratuitamente nei termini della licenza.



Bioinfy - the first Bioinformatics chatterbot

This is a project I wrote for an introductory course I attended on perl.
Feel free to have a look at it.
It is not recommended to use it, because when I wrote it, I wasn't very aware of security risks.


----------------------

BEGIN OLD README


Istruzioni per l'installazione

Dipendenze
Per funzionare il bot ha bisogno dei seguenti moduli in perl:
- Chatbot::Alpha
- Net::Jabber
- almeno Bio::Seq e Bio da bioperl

Configurazione del server jabber
E` possibile chattare con il bot attraverso una semplice interfaccia a riga di comando, ma per attivarla bisogna modificare le ultime due righe del file 'bioinfy.pl', commentando la chiamata a 'jabber_interface' e decommentando quella a 'tty_interface'.
Per funzionare al meglio però il bot ha bisogno di potersi connettere ad un server jabber.
Ci sono due opzioni:
- installare un server jabber (il bot è stato testato con ejabberd su debian) sul proprio computer; a questo punto, però, sarà necessario configurare manualmente (si può usare gaim) un utente di nome 'bioinfy' e password 'bioinfy' (o diversamente, modificando il valore delle variabili $jabber_username e $jabber_password all`inizio di bioinfy.pl) e di inserirlo nei contatti di un altro utente (definito anch'esso da $jabber_user_address)
Per la configurazione del server, è consigliabile attivare la sezione 'karma' consentire solo l`accesso dall`indirizzo 127.0.0.1.
- configurare come server 'jabber.org' o un altro server disponibile. E` sufficente modificare la variabile $jabber_server all'inizio di bioinfy.pl. Probabilmente bisognerà creare manualmente un nuovo utente e aggiungerlo ai contatti. Attenzione, però: il bot esegue alcuni script sulla macchina locale che possono rivelarsi pericolosi (ho cercato di fare il possibile per evitarli).

Configurazione del client
Per chattare con il bot, se si usa l'interfaccia jabber, è sufficente configurare un qualsiasi client di messaggistica istantanea che supporti jabber, come gaim o gabber.


Istruzioni: come usare bioinfy
Dovrei rendere disponibili queste informazioni anche tramite il bot, digitando qualcosa come 'istruzioni' o 'help'.
Bioinfy è il primo bot bioinformatico. Per favore trattalo bene e non lo insultare, altrimenti potrebbe offendersi.
I dialoghi che è in grado di comprendere sono limitati, sia perchè richiede molto tempo scriverne, sia perchè lo scopo di bioinfy è di concentrarsi sulla bioiformatica.
Ci sono alcune frasi speciali che dovresti conoscere.
- digitando 'a significa b' il bot imparerà un nuovo sinonimo (dopo il riavvio).
Per esempio, dopo aver 'hola significa ciao', il bot, dopo il riavvio, risponderà per sempre all'input 'hola' come se gli fosse stato detto 'ciao'.
Il trigger a cui si riferisce il sinonimo deve esistere, altrimenti il nuovo record verrà inserito ma non funzionerà. Attenzione a utilizzare questa funzionalità, può facilmente provocare degli errori (volendo si può disabilitare modificando il valore di $apprendimento_off)
- 'seqmode' attiva la modalità sequenza (puoi scrivere anche 'voglio lavorare su sequenze', etc..). Per uscire, scrivi 'fine'
- le frasi 'quit' 'esci' e 'exit' terminano il programma. Quindi attento a non scriverle per sbaglio, altrimenti bioinfy ti saluterà!
- digitando 'papagallo' (o 'pp'), entrerai nella modalità ononima, in cui il bot ripeterà tutto quello che dici (per uscire ->'fine')
nota: per far funzionare la funzione di molecularlab, bisogna editare il file Scripts/Molecularlab.pm e cambiare l'url di base.

Documentazione sui moduli
Per imparare come è stato programmato bioinfy, consiglio di leggere questi documenti:
- Documentazione del linguaggio AIML del bot A.L.I.C.E.: ALICE è un bot che ha vinto numerosi riconoscimenti come intelligenza artificiale e l'AIML è il linguaggio in cui sono scritti i suoi dialoghi. Si tratta di un dialetto dell`XML, abbastanza semplice da programmare ma che non permette espressioni regolari ed è scomodo per le ridirezioni (al contrario del linguaggio usato da Chatbot::Alpha e bioinfy). Tuttavia, conviene conoscerlo un po` per capire come funziona la memoria, in particolare quello che significano i set SRAI e i topic. Inoltre, bioinfy1 (dovunque egli sia :( ), era scritto in aiml.
Su http://www.alicebot.org/documentation/ c`è un buon tutorial che mostra come srai (l`equivalente di @) sia utilizzato per gestire sinonimi, ripetizioni e condizionali.
- Chatbot::Alpha::Tutorial: una volta installato Chatbot::Alpha e perldoc, potete consultare questo tutorial che spiega come vengono memorizzate le risposte in bioinfy.
- Net::XMPP::Protocol: attenzione, la documentazione di Net::Jabber è spiegata meglio in questo modulo (Net::XMPP è la classe da cui Net::Jabber deriva)

