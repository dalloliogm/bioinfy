#!/usr/bin/perl -w
# Funzioni per l'apprendimento

package Sistema;
$VERSION = '0.1';
use Exporter 'import';
@EXPORT_OK = qw(bootstrap);

sub bootstrap{
	&main::bioinfy;
	$reply = 'ok';
	}
