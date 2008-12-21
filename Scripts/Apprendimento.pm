#!/usr/bin/perl -w
# Funzioni per l'apprendimento

package Apprendimento;
$VERSION = '0.1';
use Exporter 'import';
@EXPORT_OK = qw(incomprensione aggiungi_riferimento verifica_voce);

#use strict;

#our $ultima_incomprensione;
#our $reply;


sub incomprensione{
	# Gestisce un'incomprensione aggiungendola al file ./Apprendimento/incomprensioni.txt

#	$ultima_incomprensione = $1;
	open(FILE_INCOMPRENSIONI, '>> ./Apprendimento/incomprensioni.txt');
	print FILE_INCOMPRENSIONI "$1 \n";
	close(FILE_INCOMPRENSIONI);

	$reply = "Ho inserito la frase '$1' nel database delle frasi non comprese.";
	}

sub aggiungi_riferimento{
# Quando l'utente inserisce il significato di una frase incompresa (attraverso la sintassi '* significa *'), questa funzione aggiunge una voce nel file ./Risposte/Apprendimento/nuove.cba. 
# Questa funzione va migliorata, affinchè verifichi che non vengano provocate recursioni inserendo la nuova voce.
	$ultima_incomprensione = $1;
	$significato = $2;


	open(FILE_NUOVI_RIFERIMENTI, '>> ./Replies/Apprendimento/nuove.cba');
#	print FILE_NUOVI_RIFERIMENTI "dsadsa";
	print FILE_NUOVI_RIFERIMENTI "+ $ultima_incomprensione\n@ $significato\n\n";
	close(FILE_NUOVI_RIFERIMENTI);

	$reply = "Hai detto che '$ultima_incomprensione' significa '$significato'; grazie per l'informazione, me ne ricorderò.";
	}

sub verifica_voce{
# Verifica che una voce non sia già inclusa nel database delle risposte. E' un po' lento perchè crea un nuovo oggetto Chatterbot e ricarica da capo tutte le risposte esistenti, ma così può controllare anche quelle appena inserite. Da migliorare...
	$voce_da_verificare = $_;

#	$bioinfy_test = Chatbot::Alpha->new;
#	$bioinfy_test->loadFolder('./Replies');
#	$bioinfy_test->loadFolder('./Replies/Bio');
#	$bioinfy_test->loadFolder('./Replies/Apprendimento');
#
#	$check = $bioinfy_test->search($voce_da_verificare);
	
	$reply = 'funzione inattivata, per ora';
#	print "il valore di check è $check\n";

}


#verifica_voce('ciao');
