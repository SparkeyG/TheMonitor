#!/usr/bin/env perl
#
use strict;
use warnings;
use 5.022;
use Memoize;
use XML::LibXML;
use Data::Printer { max_depth => 2 };
use List::AllUtils qw(any);
memoize('process_menu');
memoize('find_sub_menu');
our $VERSION = 0.0001;

my @processed_list;
my @sub_list;
my $dom = XML::LibXML->load_xml( location => './test.gvm' );

sub main {

    my %data_layout;
    foreach my $menu ( $dom->findnodes('//menu') ) {
        my @menu_items = process_menu($menu);
        my $menu_name = $menu->getAttribute('name') // 'empty';
        next if any { $_ eq $menu_name } @processed_list;
        push @processed_list, $menu_name;
        my $category = $menu->getAttribute('category') // 'Root Types';
        $data_layout{$category}{$menu_name} = \@menu_items;
    }
    foreach my $category ( keys %data_layout ) {
        delete $data_layout{$category}{$_} foreach @sub_list;
    }
    say np(%data_layout);
    return 1;
}

sub process_menu {
    my ($menu_node) = @_;
    my @menu_items =
        map { $_->to_literal() } $menu_node->findnodes('./item/@name');
    foreach my $submenu ( $menu_node->findnodes('./submenu') ) {
        my $source_node = $submenu->getAttribute('link')
            || $submenu->getAttribute('name');
        push @processed_list, $source_node;
        push @sub_list,       $source_node;
        push @menu_items, { $source_node => [ find_sub_menu($source_node) ] };
    }
    foreach my $include ( $menu_node->findnodes('./include') ) {
        my $source_node = $include->getAttribute('link')
            || $include->getAttribute('name');
        push @processed_list, $source_node;
        push @sub_list,       $source_node;
        push @menu_items,     find_sub_menu($source_node);

        #$triggered = 1;

    }
    return @menu_items;
}

sub find_sub_menu {
    my ($node_name) = @_;
    my $nodes = $dom->findnodes("//menu[\@name=\"$node_name\"]");
    my @sub_menu_items = map { process_menu($_) } @{$nodes};
    return @sub_menu_items;
}

main();
