#!/usr/bin/perl -w
# Utilities sull'orario, restituisce che ore sono, etc..

package Orario;
$VERSION = '0.1';
use Exporter 'import';
@EXPORT_OK = qw(stampa_ora_corrente);

use DateTime;
#use strict;

#my $reply;

sub stampa_ora_corrente{
	my $now = DateTime->now();
	$now->add(hours => 2);
	$reply = $now->hms;
	}

stampa_ora_corrente;
