#!/usr/bin/perl -w
# Verifica la sintassi di un file cba (risposte di Chatbot::Alpha)

use Chatbot::Alpha::Syntax;
my $check = Chatbot::Alpha::Syntax;
$check->syntax('loose');

foreach $fn (@ARGV)
{
	print "- " . $fn . "\n";
	$check->check("$fn");
	print "-" x 8 . "\n";
	}
