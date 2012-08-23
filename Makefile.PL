use ExtUtils::MakeMaker;
require 5.003;

unless ($ENV{'PERL_CORE'}) {
  $ENV{'PERL_CORE'} = 1 if grep { $_ eq 'PERL_CORE=1' } @ARGV;
}

if ($ENV{'PERL_CORE'}) {
  # Pods will be built by installman.
  @coreopts = ( MAN3PODS => {} );
}
else {
  @coreopts = ();
}

@ARGV = map { /^--with-(.*)/ && ++$opt{$1} ? () : $_ } @ARGV;

%PL_FILES = ( 'PPPort_pm.PL' => 'PPPort.pm',
              'PPPort_xs.PL' => 'PPPort.xs',
              'ppport_h.PL'  => 'ppport.h' ),

@C_FILES  = qw{ module2.c module3.c };

@clean    = qw{ $(H_FILES) PPPort.pm PPPort.c };

if ($opt{'apicheck'}) {
  $PL_FILES{'apicheck_c.PL'} = 'apicheck.c';
  push @C_FILES, qw{ apicheck.c };
  push @clean,   qw{ apicheck.c };
}

WriteMakefile(
  NAME          => 'Devel::PPPort',
  VERSION_FROM  => 'PPPort_pm.PL',
  PL_FILES      => \%PL_FILES,
  PM            => { 'PPPort.pm' => '$(INST_LIBDIR)/PPPort.pm' },
  C             => \@C_FILES,
  H             => [ qw(ppport.h) ],
  OBJECT        => '$(BASEEXT)$(OBJ_EXT) $(O_FILES)',
  XSPROTOARG    => '-noprototypes',
  clean         => { FILES => "@clean" },
  depend        => {
                     '$(OBJECT)'   => '$(H_FILES)',
                     'ppport_h.PL' => 'PPPort.pm',
                   },
  @coreopts,
);

sub MY::postamble {
  package MY;
  my $post = shift->SUPER::postamble(@_);
  $post .= <<'POSTAMBLE';

purge_all: realclean
	@$(RM_F) PPPort.pm PPPort.xs t/*.t

regen:
	$(PERL) -I$(INST_ARCHLIB) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB) PPPort_pm.PL
	$(PERL) -I$(INST_ARCHLIB) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB) PPPort_xs.PL
	$(PERL) -I$(INST_ARCHLIB) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB) mktests.PL

POSTAMBLE
  return $post;
}

