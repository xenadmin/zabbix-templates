#!/usr/bin/perl

$base = $ARGV[0];

opendir(DIR, $base) || die "cannot open directory: $!";
@subdirs = grep { /^[^.]/ && -d "$base/$_" } readdir(DIR);
closedir(DIR);

$first = 1;

print "{\n";
print "\t\"data\":[\n";

for (@subdirs)
{
    print ",\n" if !$first;
    print "\t\t{\"{#DIRNAME}\":\"$_\"}";
    $first = 0;
}

print "\n\t]\n";
print "}\n";
