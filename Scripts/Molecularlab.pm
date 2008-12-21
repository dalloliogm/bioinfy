#/usr/bin/perl -w
# Ricava i nuovi messaggi nel forum di molecularlab, leggendo l'rss.

use encoding utf8;
#use strict;

package Molecularlab;
my $VERSION = '0.1';
use Exporter 'import';
@EXPORT_OK = qw(nuovi_messaggi);

# Librerie di sistema
use XML::RSS::Feed;
use LWP::UserAgent;

# Variabili di configurazione
our $proxy = '142.103.2.1:3127';
#our $proxy = '';
our $user_agent = 'BioinfyBot_byDalloliogm/1.0';
#our $rss_url = 'http://www.molecularlab.it/forum/rss.asp?MEMBER_ID=97&ChkID=30b608d993d7';
#our $rss_url = 'http://www.molecularlab.it/forum/rss.asp';
our $rss_url = 'http://www.molecularlab.it/forum/rss.asp';


sub nuovi_messaggi{
	
	# Creazione dell'agente
	my $ua = LWP::UserAgent->new;
#	$ua->proxy('http', "http://" . $proxy);

	# Creazione oggetto RSS
	my $rss = XML::RSS::Feed->new(url => $rss_url,
			debug => 0,
			name => 'molecularlab',
#		tmpdir => './cache'
			);

	# Parsing e lettura dell'RSS
	$rss->parse($ua->get($rss->url)->content);
#	$rss->cache;
	$reply = "Sì, questi sono gli ultimi messaggi nel forum:";
	foreach ($rss->late_breaking_news){
		        $reply .= "\n- " . $_->headline;
	};
#	print 'reply = ' . $reply;
	$reply;
#	$reply = $_->headline . "\n" for $rss->late_breaking_news;
#print $rss->num_headlines;
}


sub check_uppercase
{
	# Se il titolo di uno dei topic su mb e' in uppercase, segnala una probabile infraz. di netiquette! ;)
		

}
