#!/usr/bin/perl -w
# Bioinfy 1.0
# Copyright: Giovanni Marco Dall'Olio 2006
# Licenza: Gnu GPL (vedi readme)
#
# Terza versione del bot bioinformatico.
# Leggi perldoc Chatbot::Alpha(::Tutorial)? e Net::XMPP::Protocol per informazioni sui moduli

use encoding utf8;
use strict;
#my $install_dir = "$ENV{HOME}/Projects/Bioinfy3";
#use lib '/home/giovanni/Projects/Bioinfy3';
#chdir $install_dir;

# Carica i moduli di sistema (devono essere installati affinchè il bot funzioni)
# perl -MCPAN -e install Chatbot::Alpha Net::Jabber
use Chatbot::Alpha;
use Net::Jabber;
use Net::Jabber::Client;
use Net::Jabber::Message;

# Moduli in ./Scripts
use Scripts::Orario;
use Scripts::Apprendimento;
use Scripts::Sistema;
use Scripts::Molecularlab;

# Variabili di configurazione
my $debug = 0;
my $messaggio_benvenuto = 'ciao, sono Bioinfy, il primo bot bioinformatico!';
my $interfaccia_jabber_on = 0;	# Definisce se si vuole usare l'interfaccia jabber. Se impostato a 0, verrà usata un'interfaccia su terminale.
my $jabber_server = 'localhost';
my $jabber_username = 'bioinfy';
my $jabber_password = 'bioinfy';
my $jabber_user_address = 'giovanni@localhost'; # l'indirizzo jabber a cui dovreanno essere inviate le risposte
my $apprendimento_off = 0;		# metti questo valore a 1 se preferisci disattivare l'apprendimento dinamico
my $bioinfo_mode_off = 0;		# metti questo valore a 1 se preferisci disattivare la modalità bioinformatica
my $net_mode_off = 0;		# metti questo valore a 1 se preferisci disattivare qualsiasi attività che cerchi informazioni su Internet

# Inizializzazione variabili
my $question = '';
my @questions;

# Inizializzazione oggetto bot
my $bioinfy = Chatbot::Alpha->new(debug => $debug);
$bioinfy->loadFolder('./Replies');
$bioinfy->loadFolder('./Replies/Bio') unless ($bioinfo_mode_off);		# Sperimentale - modalità bioinformatica!
$bioinfy->loadFolder('./Replies/Apprendimento') unless ($apprendimento_off);		# Sperimentale - supporto per l'apprendimento dinamico!!!
$bioinfy->loadFolder('./Replies/Net') unless ($net_mode_off);		# Sperimentale - supporto per Internet
$bioinfy->sortReplies;


# Interfaccia su tty 2.0
sub tty_interface
{
	print "$messaggio_benvenuto \n";

	while ($question !~ m/^(esci|exit|quit)$/i)
	{
		# Leggi una domanda da stdin e ripuliscila
		print "giovanni: "; 
		chomp ($question = <>);
		
		# Calcola la risposta
		my $reply = &get_reply($question);

		# Stampa la risposta del bot
		print "bioinfy: " . $reply . "\n";

	}
}


sub get_reply{

	# splitta la domanda dell'utente in più frasi, se queste sono separate da punteggiatura.
	@questions = split(/[;.?!,]/, $question);
	my $reply = '';

	foreach (@questions)
	{
		# Pulisci la domanda da caratteri non sicuri e pulisce gli spazi
		$_ =~ tr/òàùèéì/oaueei/;
		$_ =~ s/\s+/ /g;
		$_ =~ s/^ +| +$|[^\w ]//g;

#		print 'domanda pulita: ' . $_ . "\n";

		# Ottieni la risposta dal bot.
		if ($_) {$reply .= " " . $bioinfy->reply("user", $_)};
		
	}
	$reply;

}

sub jabber_interface
{
	# Inizializza la connessione
	my $Con = Net::Jabber::Client->new;
	$Con->Connect(hostname => "$jabber_server");
	$Con->SetCallBacks(message => \&MessaggioRicevuto); # quando avviene un evento di tipo 'message', lancia la funzione MessaggioRicevuto.
	$Con->AuthSend(username => $jabber_username,
			password => $jabber_password,
			resource => "Bot");
	$Con->PresenceSend;
	$Con->MessageSend(to => $jabber_user_address, 
			body => $messaggio_benvenuto);

	while ($question !~ m/^(esci|exit|quit)$/i)
	{
		# Leggi una domanda (in realtà, metti il bot in attesa affinchè l'utente non inserisce una domanda, 
		#  la quale farà scattare &MessaggioRicevuto).
		$Con->Process;		# attendi che l'utente inserisca una domanda; vedi perldoc Net::XMPP::Protocol per i dettagli.

		# Calcola la risposta
		my $reply = &get_reply($question);

		# Stampa la risposta del bot
#		print "bioinfy: " . $reply . "\n";
		$Con->MessageSend(to => $jabber_user_address,
			body => $reply);

	}
}

sub MessaggioRicevuto{
	shift;
	my $messaggio_obj = shift;
	$question = $messaggio_obj->GetBody;
}


if ($interfaccia_jabber_on)
{
	jabber_interface;
}
else{
	tty_interface;
}
